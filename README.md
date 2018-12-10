# github_issues_list

Fetch opened issues for a repo or an organization. Outputs issue ID and title.

## Installation

Requires a GitHub API token to run. In order to generate a token, head up to
https://github.com/settings/tokens/new and select the `repo` scope. Set a name
for your token and set the code in a environment variable name `GITHUB_ISSUES_LIST_TOKEN`.

## Usage

Call github_issues_list either with `-o/--org=` or `-r/--repo=` flag to fetch
issues respectivly from organization or repo.

github_issues_list expects a `GITHUB_ISSUES_LIST_TOKEN` envvar to be set with
required token content. If you already have a github api token in another envvar,
you can specify its variable name with `-t/--token-name` flag.

    Usage: github_issues_list [arguments]

      -t, --token-name=NAME            Set token ENVVAR name to fetch api with
      -o, --org=ORG                    Set organisation
      -r, --repo=REPO                  Set repo (expects 'user/repo' format)
      -h, --help                       Show this help

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/bobmaerten/github_issues_list/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Bob Maerten](https://github.com/bobmaerten) - creator and maintainer
