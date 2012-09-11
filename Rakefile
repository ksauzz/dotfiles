#!/usr/bin/env rake

DOT_FILES = FileList.new %w(*rc zshenv vim rst2pdf my.cnf ctags tmux.conf)
dirname = File.expand_path File.dirname(__FILE__)

desc "make symbolic links of dotfile."
task :make_symbolic_link do
  DOT_FILES.each do |file|
    link = "#{ENV['HOME']}/.#{file}"
    if File.exists? link
      puts "#{link} already exists."
      next
    end
    sh %(ln -vs #{dirname}/#{file} #{link})
  end
end

desc "update git submodules."
task :update_git_submodule do
  sh %(git submodule update --init)
end

desc "install vim plugins."
task :install_vim_plugins do
  sh %(vim +BundleInstall +:q +:q)
end

desc "configure .gitignore"
GITIGNORE = "#{ENV['HOME']}/.gitignore"
task :configure_gitignore do
  if `grep -c "doc/tags" #{GITIGNORE}`.to_i > 0
    puts ".gitignore already configured."
    next
  end
  sh %(echo doc/tags >> #{GITIGNORE})
  sh %(echo doc/tags-ja >> #{GITIGNORE})
end

VIM_PROC_DIR = 'vim/bundle/vimproc'
desc "make vimproc"
task :make_vimproc do
  ostype = RbConfig::CONFIG['host_os']
  if ostype.match /^free|^darwin/
    makefile = "make_mac.mak"
    libfile = "vimproc_mac.so"
  elsif ostype.match /^linux/
    makefile = "make_unix.mak"
    libfile = "vimproc_unix.so"
  end

  if makefile.nil?
    puts "unknown OSTYPE(#{ostype})"
    next
  end
  if File.exists? "#{VIM_PROC_DIR}/autoload/#{libfile}"
    puts "#{libfile} already exists."
    next
  end

  sh %(
        cd #{VIM_PROC_DIR}
        make -f #{makefile}
      )
end

desc "run all tasks."
task :all  => %w(
                update_git_submodule
                install_vim_plugins
                make_symbolic_link
                make_vimproc
                configure_gitignore
              )

task :default =>[:all]
