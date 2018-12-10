module GithubIssuesList
  class Issue
    alias IssueDetails = Hash(Symbol, Int32 | String | Time)

    def initialize
      @issue = IssueDetails.new
    end

    def []=(key, value)
      @issue[key] = value
    end

    def [](key)
      @issue[key]
    end
  end
end
