##NSpec code katas without Visual Studio

This is a WarmuP template for doing code katas using NSpec. This readme also contains instructions for using VIM for these code katas.  It's purpose is to really put an emphasis on the kata and test driven development in a lean development environment.  

##Getting your VIM environment setup on Windows

The setup is still pretty manual.  As this evolves, ideally there will be a chocolatey package that will get your entire environment up and running.  For now this read me will have to do...

- install [msysgit](https://code.google.com/p/msysgit/downloads/list)
  This is what will add vim to your system.  Keep in mind that this is vim and not gVim.

- install [ruby 1.9.3](http://rubyinstaller.org/downloads/)
  Be sure to add it to your PATH, ruby is used for rake (build automation), warmup (solution/project generation) and nokogiri (xml file/csproj manipulation)

- install [ctags for Windows](http://sourceforge.net/projects/ctags/files/ctags/) extract to a directory and add that directory to your PATH
  Ctags is used for auto completion and go to definition in vim.

