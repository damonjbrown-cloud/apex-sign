# frozen_string_literal: true

RSpec.describe 'Send document' do
  let(:account) { create(:account) }
  let(:user) { create(:user, account:) }
  let(:template) { create(:template, account:, author: user, attachment_count: 0, submitter_count: 3) }

  before do
    sign_in(user)
  end

  it 'shows one row per signer role with a subject and message' do
    visit new_template_submission_path(template)

    expect(page).to have_content('First Party')
    expect(page).to have_content('Second Party')
    expect(page).to have_content('Third Party')
    expect(page).to have_css('.bg-blue-500')
    expect(page).to have_css('.bg-green-500')
    expect(page).to have_css('.bg-orange-500')
    expect(page).to have_css('input[placeholder="Name"]', count: 3)
    expect(page).to have_css('input[type="email"]', count: 3)
    expect(page).to have_field('Email Subject')
    expect(page).to have_field('Email Message')
    expect(page).to have_button('Send')
    expect(page).to have_no_css('input[type="tel"]')
  end

  it 'puts the message into the invitation email' do
    visit new_template_submission_path(template)

    name_fields = all('input[name="submission[1][submitters][][name]"]')
    email_fields = all('input[name="submission[1][submitters][][email]"]')

    name_fields[0].set('Ada Buyer')
    email_fields[0].set('buyer@example.com')
    name_fields[1].set('Grace Co')
    email_fields[1].set('cobuyer@example.com')
    name_fields[2].set('Dealer Desk')
    email_fields[2].set('dealer@example.com')

    fill_in 'Email Subject', with: 'Please sign: payoff letter'
    fill_in 'Email Message', with: "This document is the payoff letter.\n\n[Review and Sign]({submitter.link})"

    click_button 'Send'

    expect(page).to have_content('New recipients have been added')

    submitter = Submitter.find_by!(email: 'buyer@example.com')
    message = EmailMessage.find_by!(uuid: submitter.preferences['email_message_uuid'])

    expect(message.subject).to eq('Please sign: payoff letter')
    expect(message.body).to include('payoff letter')

    mail = SubmitterMailer.invitation_email(submitter)

    expect(mail.subject).to eq('Please sign: payoff letter')
    expect(mail.body.encoded).to include('payoff letter')
    expect(mail.body.encoded).to include('Sent with Apex Sign')
    expect(mail.body.encoded).not_to include('Powered by')

    HtmlToPlainTextInterceptor.process(mail)

    expect(mail.text_part.decoded).to include('Sent with Apex Sign')
    expect(mail.text_part.decoded).not_to include('Powered by')
    expect(mail.text_part.decoded).not_to include('DocuSeal')
  end
end
