class OpenAPIOasis::Antipattern
  attr_reader :offender, :type

  def initialize(offender:, type:)
    @offender = offender
    @type = type
  end

  def ==(other)
    offender == other&.offender && type == other&.type
  end
end
