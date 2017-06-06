class Response
  attr_accessor :message, :status_code, :data

  def initialize(message, status_code)
    @message=message
    @status_code=status_code
  end

  def set_message(message)
    @message=message
  end

  def set_status_code(status_code)
    @status_code=status_code
  end

  def set_data(data)
    @data=data
  end
end