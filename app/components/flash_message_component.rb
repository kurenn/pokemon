class FlashMessageComponent < ViewComponent::Base
  CSS_CLASSES = {
    danger: 'bg-[#FFF1F0] border-[#FFCCC7]',
    success: 'bg-[#F6FFED] border-[#B7EB8F]',
    notice: 'bg-[#E6F7FF] border-[#91D5FF]'
  }.with_indifferent_access

  def initialize(message: nil, type: nil)
    @message = message
    @type = type.to_sym
  end

  def notice?
    @type == :notice
  end

  def success?
    @type == :success
  end

  def danger?
    @type == :danger
  end

  def css_classes
    CSS_CLASSES[@type] || CSS_CLASSES['notice']
  end
end
