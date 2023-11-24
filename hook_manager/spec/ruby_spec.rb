describe "Regex", "operations" do
  it "문자열이 비었는지 확인할 수 있다" do
    s = ''
    s.empty?.should == true
    e = nil
    e.nil?.should == true
    (s.nil? or s.empty?).should == true
    (e.nil? or e.empty?).should == true
  end

  it "블록을 이용해 배열의 각 요소에 메서드를 적용할 수 있다" do
    a = [' a', 'b ', ' c ']
    trimmed = []
    a.each do |item|
      trimmed << item.strip
    end
    trimmed.should == ['a', 'b', 'c']
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

  it "" do
    result = []
    File.open('hook_manager/spec/data/install_list', "r") do |f|
      f.each_line do |line|
        result << "#{line.split(',')[0].strip}"
      end
    end
    result.should == ['/tmp/test_install_git_hook', '/tmp/test_install_git_hook2']
  end

  it "push array to array" do
    result = []
    install_info = []
    File.open('hook_manager/spec/data/install_list', "r") do |f|
      f.each_line do |line|
        result.push([
            line.split(',')[0].strip,
            line.split(',')[1].strip
        ])
      end
    end

    result.should == [["/tmp/test_install_git_hook", "pre-push"], ["/tmp/test_install_git_hook2", "pre-push"]]
  end

  it "" do
    result = []
    [['a', 'b'], ['c', 'd']].each do |item|
      result.push(item[0])
    end
    result.should == ['a', 'c']
  end
end
