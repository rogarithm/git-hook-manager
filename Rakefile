require_relative 'hook_manager/hook_manager'

task :install do
  puts "install hooks!"
  hook_manager = HookManager.new
  hook_manager.install_hook(
    hook_manager.make_install_infos(
      hook_manager.prepare_paths_to_install('./hook_manager/install_list')
    )
  )
  hook_manager.check_hooks_installed('./hook_manager/install_list')
end

task :uninstall do
  puts "uninstall hooks!"
  hook_manager = HookManager.new
  hook_manager.uninstall_hook(
    hook_manager.make_install_infos(
      hook_manager.prepare_paths_to_install('./hook_manager/install_list')
    )
  )
  hook_manager.check_hooks_installed('./hook_manager/install_list')
end
