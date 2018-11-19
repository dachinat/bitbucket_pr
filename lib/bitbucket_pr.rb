require "bitbucket_pr/system"
require "bitbucket_pr/version"
require "faraday"
require "json"
require "growl"

module BitbucketPr
  def self.create(source, destination, options)
    auth_match = options.auth.match(":")
    conn = Faraday.new(url: "https://bitbucket.org")
    conn.basic_auth(auth_match.pre_match, auth_match.post_match)

    res = conn.post do |req|
      req.url "/api/2.0/repositories/#{options.repository}/pullrequests"
      req.headers["Content-Type"] = "application/json"
      req.body = {
          source: {
              branch: {
                  name: source
              }
          },
          destination: {
              branch: {
                  name: destination
              }
          },
          repository: {
              full_name: options.repository
          },
          title: options.title
      }

      req.body.merge!(close_source_branch: options.close) if options.close

      if options.reviewers
        reviewers = []
        options.reviewers.each { |r| reviewers << { username: r } }
        req.body.merge!(reviewers: reviewers)
      end

      req.body[:description] = options.description if options.description

      req.body = req.body.to_json
    end

    say res.reason_phrase

    if res.reason_phrase == "Created"
      notify_ok "PR Created"
    else
      notify_error "PR not created"
    end

    begin
      body = JSON.parse(res.body)
      color("Failed: " + body["error"]["message"], :red) if (body["type"] == "error")
    rescue
    end
  end
end
