module IosHelpers
  def iOS?
    !(request.user_agent =~ /Mobile(.+) Safari|iPad|Android/).nil?
  end
  
  def desktop?
    !iOS?
  end
end