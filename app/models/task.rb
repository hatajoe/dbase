class Task
  attr_reader :checked, :blank, :all

  CHECKED = /- \[x\]/
  BLANK = /- \[ \]/

  #
  # @param [String] body
  #
  def initialize(body)
    @body = body
    @checked = body.scan(CHECKED).size
    @blank = body.scan(BLANK).size
    @all = @checked + @blank
  end

  #
  # @return [TrueClass or FalseClass]
  #
  def has_tasks?
    @all > 0
  end

  #
  # @return [TrueClass or FalseClass]
  #
  def done?
    return false unless has_tasks?
    @all == @checked
  end

  #
  # @return [TrueClass or FalseClass]
  #
  def in_progress?
    return false unless has_tasks?
    progress > 0
  end

  #
  # @return [Float]
  #
  def progress
    ((@checked.to_f / @all) * 100).round
  end

  #
  # @return [Array<Line>]
  #
  def task_lines
    lines = @body.lines.map do |line|
      if line.scan(CHECKED).size > 0
        TaskLine.new(line.gsub(CHECKED, ''), true)
      elsif line.scan(BLANK).size > 0
        TaskLine.new(line.gsub(BLANK, ''), false)
      end
    end
    lines.select(&:present?)
  end
end