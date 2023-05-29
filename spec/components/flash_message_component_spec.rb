require "rails_helper"

RSpec.describe FlashMessageComponent, type: :component do
    it 'displays the message' do
    render_inline(described_class.new(message: 'Hello world', type: 'success'))

    expect(page).to have_css('p', text: 'Hello world')
  end

  it 'displays the close button' do
    render_inline(described_class.new(message: 'Hello world', type: 'success'))

    expect(page).to have_xpath("//button[@data-action='click->flash#dismiss']")
  end

  context 'when the type is danger' do
    it 'returns true for danger messages' do
      component = described_class.new(message: 'Hello world', type: :danger)

      expect(component).to be_danger
    end
  end
end
