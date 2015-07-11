class AssignedIssue < SimpleDelegator
  attr_reader :assigned_to_user
  
  def initialize(issue, user)
    super issue
    @assigned_to_user = user
  end
  
end
