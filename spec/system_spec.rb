RSpec.describe BitbucketPr do
  it "loads home path" do
    expect(BitbucketPr.home).not_to be nil
  end

  it "resolves a file" do
    expect(BitbucketPr.file).to include(BitbucketPr.home)
    expect(BitbucketPr.file).to include(BitbucketPr::FILE_NAME)
  end

  it "writes a configuration file" do
    testIO = StringIO.new
    allow(File).to receive(:open).with(BitbucketPr.file, "w").and_yield(testIO)
    BitbucketPr.write(username: "test1", password: "test2", repository: "test3")
    expect(testIO.string.inspect).to include("test1")
    expect(testIO.string.inspect).to include("%=&5S=#(`")
    expect(testIO.string.inspect).to include("test3")
  end

  it "reads a configuration file" do
    allow(File).to receive(:read).and_return("---\n:username: test1\n:password: \"%=&5S=#(`\\n\"\n:repository: test3\n")
    out = BitbucketPr.read
    expect(out[:username]).to eq("test1")
    expect(out[:password]).to eq("test2")
    expect(out[:repository]).to eq("test3")
  end
end
