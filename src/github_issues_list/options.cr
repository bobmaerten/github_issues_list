require "option_parser"

module GithubIssuesList
  class Options
    @query_path : String
    @token : String
    getter :query_path, :token

    def initialize
      @query_path = ""
      @token = ENV.fetch("GITHUB_ISSUES_LIST_TOKEN", "")
      parse_options

      if @query_path.empty?
        STDERR.puts "ERROR: github_issues_list requires to be called either with --org or --repo flag."
      end
      if @token.empty?
        STDERR.puts "ERROR: github_issues_list requires a GitHub API token to fetch issues."
      end
    end

    private def parse_options
      OptionParser.parse! do |parser|
        parser.banner = "Usage: github_issues_list [arguments]\n  Fetch opened issues for a repo or an organization"

        parser.on("-t", "--token-name=NAME", "Set token ENVVAR name to fetch api with") do |value|
          @token = ENV.fetch(value, "")
        end

        parser.on("-o", "--org=ORG", "Set organisation") do |value|
          @query_path = "/orgs/#{value}/issues" unless value.includes?("/")
        end

        parser.on("-r", "--repo=REPO", "Set repo (expects 'user/repo' format)") do |value|
          if md = value.match(/^([a-zA-z-_]+)\/([a-zA-z-_]+)/)
            @query_path = "/repos/#{md[1]}/#{md[2]}/issues"
          else
            STDERR.puts "ERROR: repo does not respect expected format."
            STDERR.puts parser
            exit 1
          end
        end

        parser.on("-h", "--help", "Show this help") { puts parser; exit 1 }

        parser.missing_option do |option|
          STDERR.puts "ERROR: #{option} requires a valid option."
          STDERR.puts parser
          exit 1
        end
        parser.invalid_option do |option|
          STDERR.puts "ERROR: #{option} is not a valid option."
          STDERR.puts parser
          exit 1
        end
      end
    end
  end
end
