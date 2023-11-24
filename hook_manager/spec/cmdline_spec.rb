describe "Command Line", "operations" do
  it "ls 명령 적용 결과는 문자열이다" do
    (`ls #{File.expand_path('~/tools/git-hooks/')}`.instance_of? String).should == true
  end

  it "파일이 여러 개인 디렉토리에 ls 명령을 적용하면 파일 이름마다 뒤에 줄바꿈 문자가 붙는다" do
    `ls #{File.expand_path('~/tools/git-hooks/')}`.scan(/\n/).count().should == 3
  end
end
