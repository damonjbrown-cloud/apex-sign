# frozen_string_literal: true

RSpec.describe SignerColors do
  it 'indexes the shared palette by submitter, with fields following the chip colors' do
    expect(described_class.dots.first(3)).to eq(%w[bg-blue-500 bg-green-500 bg-orange-500])
    expect(described_class.backgrounds.first(3)).to eq(%w[bg-blue-100 bg-green-100 bg-orange-100])
    expect(described_class.borders.first(3)).to eq(%w[border-blue-500/80 border-green-500/80 border-orange-500/80])
    expect(described_class.events.first(3)).to eq(%w[bg-blue-200 bg-green-200 bg-orange-200])
    expect(described_class.at(0)[:dot]).to eq('bg-blue-500')
    expect(described_class.at(10)[:bg]).to eq('bg-blue-100')
    expect(described_class.at(-1)[:dot]).to eq('bg-blue-500')
    expect(described_class.entries.length).to eq(10)
  end
end
