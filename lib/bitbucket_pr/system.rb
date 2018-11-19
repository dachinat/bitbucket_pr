require "openssl"
require "yaml"

module BitbucketPr
  HOMES = ["HOME", "HOMEPATH"]

  class << self
    def home; ENV[HOMES.find { |h| ENV[h] != nil }]; end

    def file; File.join(home, ".bitbucket_pr"); end

    def write(credentials)
      credentials[:password] = [credentials[:password]].pack("u")
      File.open(file, "w") { |file| file.write(credentials.to_yaml) }
    end

    def read
      begin
        credentials = YAML.safe_load(File.read(file), [Symbol])
        credentials[:password] = credentials[:password].unpack("u")[0]
        credentials
      rescue => e
        color("Internal error: " + e.message, :red)
        nil
      end
    end
  end
end
