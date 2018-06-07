class TaskLine
  attr_reader :line, :checked

  def initialize(line, checked)
    @line = line
    @checked = checked
  end
end