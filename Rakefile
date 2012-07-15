#!/usr/bin/env rake

DOT_FILES = FileList.new %w(*rc zshenv vim rst2pdf my.cnf ctags)

desc "make symbolic links of dotfile."
task :make_symbolic_link do
  DOT_FILES.each do |file|
    link = "#{ENV['HOME']}/.#{file}"
    if File.exists? link
      puts "#{link} already exists."
      next
    end
    sh %(ln -vs #{file} #{link})
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
  sh %(echo doc/tags >> $GITIGNORE)
  sh %(echo doc/tags-ja >> $GITIGNORE)
end

VIM_PROC_DIR = 'vim/bundle/vimproc'
desc "make vimproc"
task :make_vimproc do
  ostype = `echo $OSTYPE`
  if ostype.match /^free|^darwin/
    makefile = "#{VIM_PROC_DIR}/make_mac_mak"
    libfile = "#{VIM_PROC_DIR}/autoload/vimproc_mac.so"
  elsif ostype.match /^linux/
    makefile = "#{VIM_PROC_DIR}/make_unix_mak"
    libfile = "#{VIM_PROC_DIR}/autoload/vimproc_unix.so"
  end

  if makefile.nil?
    puts "unknown OSTYPE(#{ostype})"
    next
  end
  if File.exists? libfile
    puts "#{libfile} already exists."
    next
  end

  sh %(make -f #{makefile})
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
