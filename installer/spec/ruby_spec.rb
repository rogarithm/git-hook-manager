describe "Regex", "operations" do
  it "콤마 기준으로 앞쪽 문자열만 가져올 수 있다" do
    str = "/tmp/test_install_git_hook, pre-push"
    str.split(',').each_with_index do |item, index|
      puts "#{index}: #{item}"
    end
  end

  it "문자열 앞뒤의 공백을 지울 수 있다" do
    str = "/tmp/test_install_git_hook, pre-push"
    str.split(',').each_with_index do |item, index|
      puts "#{index}: >#{item.strip}<"
    end
  end

  it "" do
    File.open('./spec/data/install_list', "r") do |f|
      f.each_line do |line|
        puts ">#{line.split(',')[0].strip}<"
      end
    end
  end

  it "push array to array" do
    install_info = []
    File.open('./spec/data/install_list', "r") do |f|
      f.each_line do |line|
        install_info.push([
            line.split(',')[0].strip,
            line.split(',')[1].strip
        ])
      end
    end
    install_info.each_with_index do |info, index|
      puts "#{index}: #{info.inspect}"
    end
  end

  it "" do
    result = []
    [['a', 'b'], ['c', 'd']].each do |item|
      result.push(item[0])
    end
    puts "#{result.inspect}"
  end
end
