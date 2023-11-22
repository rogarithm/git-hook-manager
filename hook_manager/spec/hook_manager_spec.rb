require_relative '../hook_manager'

describe "Hook Manager", "operations" do

  before(:each) do
    @hook_manager=HookManager.new
    @trigger_point='pre-push'
    @hook_name='is_remote_updated'

    @install_full_dir='/tmp/test_install_git_hook/.git/hooks/pre-push'
    @install_full_dir2='/tmp/test_install_git_hook2/.git/hooks/pre-push'
  end

  after(:each) do
    @hook_manager.uninstall_hook(
      @hook_manager.make_install_infos(
        './hook_manager/spec/data/install_list'
      )
    )
  end


  #it "설정 정보를 갖는 파일을 로드할 수 있다" do
  #  @hook_manager.load_config
  #end
  it "훅 설정 정보를 가져올 수 있다" do
    @hook_manager.read_configs('./hook_manager/spec/data/install_list').should == [['/tmp/test_install_git_hook', @trigger_point, @hook_name], ['/tmp/test_install_git_hook2', @trigger_point, @hook_name]]
  end


  it "설정 파일 내용으로부터 훅을 설치하는 데 필요한 정보를 계산할 수 있다" do
    @hook_manager.make_install_infos(
      './hook_manager/spec/data/install_list2'
    ).should == [[File.expand_path(@install_full_dir), @trigger_point, @hook_name]]
  end
  it "설정 파일 내용으로부터 여러 개의 훅을 설치하는 데 필요한 정보를 계산할 수 있다" do
    @hook_manager.make_install_infos(
      './hook_manager/spec/data/install_list'
    ).should ==
    [
      [File.expand_path(@install_full_dir), @trigger_point, @hook_name],
      [File.expand_path(@install_full_dir2), @trigger_point, @hook_name]
    ]
  end


  it "동일한 발동 조건에 여러 훅이 있을 경우 훅 소스 위치를 계산할 때 훅 이름을 지정할 수 있다" do
    @hook_manager.find_hook_location(
      @trigger_point,
      'is_remote_updated'
    ).should == File.expand_path('~/tools/git-hooks/pre_push/bin/is_remote_updated')
  end


  it "훅을 설치할 위치와 발동 조건을 입력하면 훅을 설치한다" do
    @hook_manager.install_hook(
      @hook_manager.make_install_infos(
        './hook_manager/spec/data/install_list2'
      )
    )
    File.symlink?(@install_full_dir).should == true
  end
  it "한 번에 두 곳에 훅을 설치할 수 있다" do
    @hook_manager.install_hook(
      @hook_manager.make_install_infos(
        './hook_manager/spec/data/install_list'
      )
    )
    File.symlink?(@install_full_dir).should == true
    File.symlink?(@install_full_dir2).should == true
  end


  it "훅이 설치되었는지 확인할 수 있다" do
    @hook_manager.check_hooks_installed('./hook_manager/spec/data/install_list')
  end
end
