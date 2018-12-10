require "json"
require "http/client"

require "./issue"

module GithubIssuesList
  class Fetcher
    GITHUB_HOST = "api.github.com"

    @client : HTTP::Client

    def initialize(@query_path : String, @token : String)
      @client = http_client
      @issues = [] of Issue
    end

    def call
      fetch_issues
      @issues
    end

    private def fetch_issues
      while @query_path
        response = @client.get @query_path
        return if response.status_code != 200

        append_batch JSON.parse(response.body).as_a
        @query_path = next_query_path response.headers["Link"]
      end
      @client.close
    end

    private def http_client
      HTTP::Client.new(GITHUB_HOST, 443, true).tap do |client|
        client.before_request do |request|
          request.headers["Authorization"] = "token #{@token}"
          request.headers["Accept"] = "application/vnd.github.v3+json"
        end
      end
    end

    private def append_batch(issues_batch : Array)
      issues_batch.each do |issue|
        next if issue["pull_request"]?

        @issues << Issue{:id         => issue["number"].as_i,
                         :title      => issue["title"].as_s,
                         :created_at => parse_date(issue["created_at"].as_s)}
      end
    end

    private def parse_date(text : String) : Time
      Time.parse(text, "%Y-%m-%dT%H:%M:%S%z", Time::Location.load("UTC"))
    end

    private def next_query_path(link : String | Nil)
      if link
        if md = link.match(/<https:\/\/#{GITHUB_HOST}([^>]+)>; rel="next"/)
          @query_path = md[1]
        else
          @query_path = ""
        end
      else
        @query_path = ""
      end
    end
  end
end
