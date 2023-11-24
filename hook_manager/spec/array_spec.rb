describe "Array", "operations" do
  it "블록을 이용해 배열의 각 요소에 메서드를 적용할 수 있다" do
    a = [' a', 'b ', ' c ']
    trimmed = []
    a.each do |item|
      trimmed << item.strip
    end
    trimmed.should == ['a', 'b', 'c']
  end

  it "요소를 가공한 뒤에 배열에 넣을 수 있다" do
    result = []
    File.open('hook_manager/spec/data/install_list', "r") do |f|
      f.each_line do |line|
        result << "#{line.split(',')[0].strip}"
      end
    end
    result.should == ['/tmp/test_install_git_hook', '/tmp/test_install_git_hook2']
  end

  it "배열을 요소로 하는 배열을 만들 수 있다" do
    result = []
    File.open('hook_manager/spec/data/install_list', "r") do |lines|
      lines.each_line do |line|
        result.push([
          line.split(',')[0].strip,
          line.split(',')[1].strip
        ])
      end
    end
    result.should == [
      ["/tmp/test_install_git_hook", "pre-push"],
      ["/tmp/test_install_git_hook2", "pre-push"]
    ]
  end

  it "각 배열의 첫 요소만 가져와 배열로 모을 수 있다" do
    result = []
    [['a', 'b'], ['c', 'd']].each do |item|
      result.push(item[0])
    end
    result.should == ['a', 'c']
  end
end
