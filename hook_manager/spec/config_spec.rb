require 'psych'

describe "Config with yaml", "operations" do
  it "yaml 파일 내용을 가져올 수 있다" do
    yaml = Psych.load_file(File.expand_path('./hook_manager/spec/data/config.yaml'))
    yaml['key'].should == 'value!'
  end
end
