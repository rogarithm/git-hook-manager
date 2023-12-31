class HookManager

  def initialize
    @source_root = '~/tools/git-hooks/'
  end

  def make_targets_info(source)
    targets_info = []
    File.open(source, "r") do |configs|
      configs.each_line do |config|
        target_info = []
        config.split(',').each do |item|
          target_info << item.strip
        end
        root_dir = target_info[0]
        trigger_point = target_info[1]
        if target_info[2].nil?
          hook_name = ''
        else
          hook_name =  target_info[2]
        end
        targets_info.push(
          [
            find_target_location(root_dir, trigger_point),
            trigger_point,
            hook_name
          ]
        )
      end
    end
    targets_info
  end

  def find_target_location(root_dir, trigger_point)
    File.join(
      File.expand_path(root_dir),
      '.git/hooks',
      trigger_point
    )
  end

  def install_hook(targets_info)
    targets_info.each do |target_info|
      target_location = target_info[0]
      trigger_point = target_info[1]
      hook_name = target_info[2]
      if (File.symlink?(target_location) == false)
        File.symlink(
          find_hook_location(trigger_point, hook_name),
          target_location
        )
      end
    end
  end

  def only_one_hook?(hook_name)
    hook_name == ''
  end

  def find_hook_location(trigger_point, hook_name='')
    hook_dir=File.join(
      File.expand_path('~/tools/git-hooks/'),
      trigger_point.sub(/-/, '_'),
      'bin'
    )

    if only_one_hook?(hook_name)
      hook_file=`ls #{hook_dir}`.sub(/\n/, '')
      return "#{hook_dir}/#{hook_file}"
    end
    hook_file=`ls #{hook_dir} | grep '#{hook_name}'`.sub(/\n/, '')
    return "#{hook_dir}/#{hook_file}"
  end

  def uninstall_hook(uninstall_infos)
    uninstall_infos.each do |uninstall_info|
      expanded_target = uninstall_info[0]
      if (File.symlink?(expanded_target))
        File.delete(expanded_target)
      end
    end
  end

  def check_hooks_installed(install_path_list)
    install_infos = make_targets_info(
      install_path_list
    )
    install_infos.each do |install_info|
      expanded_target = install_info[0]
      trigger_point = install_info[1]
      if (File.symlink?(expanded_target))
        puts "#{trigger_point} hook installed on #{expanded_target}"
        puts `ls -al #{expanded_target}`
      else
        puts "#{trigger_point} hook not installed on #{expanded_target}"
      end
    end
  end

  private :find_target_location
end
