describe "File", "operations" do
  def find_hook_location(trigger_point, hook_name='')
    hook_dir=File.join(
      File.expand_path('~/tools/git-hooks/'),
      trigger_point.sub(/-/, '_'),
      'bin'
    )

    if hook_name == ''
      hook_file=`ls #{hook_dir}`.sub(/\n/, '')
    end
    if hook_name != ''
      hook_file=`ls #{hook_dir} | grep #{hook_name}`.sub(/\n/, '')
    end

    "#{hook_dir}/#{hook_file}"
  end

  it "훅 이름을 명시하지 않으면 디렉토리에 있는 모든 훅 파일 이름을 가져온다" do
    find_hook_location('pre-push').should == "/Users/sehunkim/tools/git-hooks/pre_push/bin/forbid_pushis_remote_updated
validate_commits
"
  end

  it "훅 이름을 명시하면 해당 훅 파일 이름을 가져온다" do
    find_hook_location('pre-push', 'forbid_push').should == "/Users/sehunkim/tools/git-hooks/pre_push/bin/forbid_push"
  end
end
