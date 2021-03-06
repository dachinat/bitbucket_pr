require "openssl"
require "yaml"

module BitbucketPr
  HOMES = ["HOME", "HOMEPATH"]
  FILE_NAME = ".bitbucket_pr"

  class << self
    def home; ENV[HOMES.find { |h| ENV[h] != nil }]; end

    def file; File.join(home, FILE_NAME); end

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
        nil
      end
    end
  end
end
