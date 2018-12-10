require "./github_issues_list/*"

options = GithubIssuesList::Options.new
issues = GithubIssuesList::Fetcher.new(options.query_path, options.token).call
issues.each { |e| puts "#{e[:id]} - #{e[:title]}" }
