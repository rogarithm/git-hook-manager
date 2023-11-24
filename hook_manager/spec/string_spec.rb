describe "String", "operations" do
  it "문자열이 비었는지 확인할 수 있다" do
    s = ''
    s.empty?.should == true
    e = nil
    e.nil?.should == true
    (s.nil? or s.empty?).should == true
    (e.nil? or e.empty?).should == true
  end

  it "콤마 기준으로 앞쪽 문자열만 가져올 수 있다" do
    result = []
    str = "/tmp/test_install_git_hook, pre-push"
    str.split(',').each_with_index do |item, index|
      result << "#{item.strip}"
    end

    result.should == ['/tmp/test_install_git_hook', 'pre-push']
  end

  it "문자열 앞뒤의 공백을 지울 수 있다" do
    result = []
    str = "/tmp/test_install_git_hook, pre-push"
    str.split(',').each_with_index do |item, index|
      result << "#{item.strip}"
    end

    result.should == ['/tmp/test_install_git_hook', 'pre-push']
  end
end
