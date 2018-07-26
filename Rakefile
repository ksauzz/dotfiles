#!/usr/bin/env rake

DOT_FILES = FileList.new %w(*rc zprofile zshenv vim rst2pdf my.cnf ctags tmux.conf xmodmap)
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
  sh %(vim +PluginInstall +:q +:q)
end

desc "configure .gitignore"
GITIGNORE = "#{ENV['HOME']}/.gitignore"
task :configure_gitignore do
  if `grep -c "doc/tags" #{GITIGNORE}`.to_i > 0
    puts ".gitignore already configured."
    next
  end
  sh %(git config --global core.excludesfile '~/.gitignore')
  sh %(echo doc/tags >> #{GITIGNORE})
  sh %(echo doc/tags-ja >> #{GITIGNORE})
  sh %(echo .netrwhist >> #{GITIGNORE}) # quickhack
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
  if File.exists? "#{VIM_PROC_DIR}/lib/#{libfile}"
    puts "#{libfile} already exists."
    next
  end

  sh %(
        cd #{VIM_PROC_DIR}
        make -f #{makefile}
      )
end

desc "setup tmux"
task :setup_tmux do
  ostype = RbConfig::CONFIG['host_os']
  if ostype.match /^darwin/
    sh %(brew install tmux)
    sh %(brew install reattach-to-user-namespace)
  end
end

desc "setup rbenv"
task :setup_rbenv do
  unless Dir.exist? "#{ENV["HOME"]}/.rbenv" then
    sh %(git clone https://github.com/sstephenson/rbenv.git ~/.rbenv)
  end
  sh %(mkdir -p ~/.rbenv/plugins)
  unless Dir.exist? "#{ENV["HOME"]}/.rbenv/plugins/ruby-build" then
    sh %(git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build)
  end
  ostype = RbConfig::CONFIG['host_os']
  if ostype.match /^darwin/
    sh %(brew install readline)
    sh %(brew link readline)
  end
end

desc "run all tasks."
task :all  => %w(
                update_git_submodule
                install_vim_plugins
                make_symbolic_link
                make_vimproc
                configure_gitignore
                setup_tmux
                setup_rbenv
              )

task :default =>[:all]
