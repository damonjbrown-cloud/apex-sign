# frozen_string_literal: true

RSpec.describe 'Signer chips' do
  let(:account) { create(:account) }
  let(:user) { create(:user, account:) }
  let(:buyer_uuid) { SecureRandom.uuid }
  let(:cobuyer_uuid) { SecureRandom.uuid }
  let(:template) { create(:template, account:, author: user, attachment_count: 0) }

  before do
    sign_in(user)

    buyer = { 'name' => 'Buyer', 'uuid' => buyer_uuid }
    cobuyer = { 'name' => 'Co-buyer', 'uuid' => cobuyer_uuid }
    template.update!(submitters: [buyer, cobuyer])

    document = ActiveStorage::Attachment.create!(
      blob: ActiveStorage::Blob.create_and_upload!(
        io: Rails.root.join('spec/fixtures/sample-image.png').open,
        filename: 'page.png',
        content_type: 'image/png'
      ),
      name: :documents,
      record: template
    )
    ActiveStorage::Attachment.create!(
      blob: ActiveStorage::Blob.create_and_upload!(
        io: Rails.root.join('spec/fixtures/sample-image.png').open,
        filename: '0.png',
        content_type: 'image/png',
        metadata: { 'width' => 1400, 'height' => 1812 }
      ),
      name: :preview_images,
      record: document
    )

    template.update!(
      schema: [{ 'attachment_uuid' => document.uuid, 'name' => 'Page 1' }],
      fields: [
        {
          'uuid' => SecureRandom.uuid,
          'submitter_uuid' => buyer_uuid,
          'name' => 'Signature',
          'type' => 'signature',
          'required' => true,
          'areas' => [
            {
              'x' => 0.2,
              'y' => 0.2,
              'w' => 0.28,
              'h' => 0.08,
              'attachment_uuid' => document.uuid,
              'page' => 0
            }
          ]
        }
      ]
    )
  end

  it 'keeps a placed Buyer field when Co-buyer is clicked, and reassigns it only from the field menu' do
    visit edit_template_path(template)

    expect(page).to have_css('.field-area.bg-blue-100')

    find('.field-area-container').click

    expect(page).to have_css('.field-area-controls')

    find('.apexsign-signer-chips button', text: 'Co-buyer').click

    expect(page).to have_css('.apexsign-signer-chips button.bg-green-500', text: 'Co-buyer')
    expect(page).to have_no_css('.field-area-controls')
    expect(page).to have_css('.field-area.bg-blue-100')
    expect(page).to have_no_css('.field-area.bg-green-100')
    expect(template.reload.fields.first['submitter_uuid']).to eq(buyer_uuid)

    find('.field-area-container').right_click
    find('.field-settings-signer', text: 'Signer').hover
    find('.field-settings-signer-option', text: 'Co-buyer').click

    expect(page).to have_css('.field-area.bg-green-100')
    expect(page).to have_no_css('.field-area.bg-blue-100')

    page.driver.wait_for_network_idle

    expect(template.reload.fields.first['submitter_uuid']).to eq(cobuyer_uuid)
  end
end
