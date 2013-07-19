##NSpec code katas without Visual Studio

This is a WarmuP template for doing code katas using NSpec. This readme also contains instructions for using VIM for these code katas.  It's purpose is to really put an emphasis on the kata and test driven development in a lean development environment.  After you get the hang of it, you may find that you're as productive in vim when compared to Visual Studio.

##Why would you want to do .Net dev outside of Visual Studio?

Visual Studio doesn't provide the plugins I need for web development in a timely manner. Plugins such as coffeescript convertion and syntax highlighting, zen coding, git integration, jslint, etc just lag behind (some of these plugins take many months to make it over to Visual Studio). As of this point, Visual Studio plugin authors simply can't keep up to the "not .Net" development ecosystem. Also (for example), there is a **competitive advantage** that you get when you can use coffeescript **a year** before Visual Studio gains that capability. Same goes for SCSS/SASS integration and zen coding...I don't want to wait to for Visual Studio to catch up to use these incredibly productive tools (yes, coffeescript, scss/sass plugins exist now...finally...but too little too late).

Here is a short list of things that vim gives you (and takes away). Feel free to send me a pull request if you come up with any others:

The good

- full customization of the text editor, a means to create plugins that can be applied to development outside of .Net
- fast startup and runtime
- faster access to plugins
- free
- better window management and file navigation
- stupid fast text manipulation
- can be used for development outside of .Net accross OS'es and languages
- you'll be "that bad ass mofo" that uses vim and code circles around everyone else (yes, getting proficient with vim key bindings will make you that good)
- a good vim story will bring developers from other stacks to try/use .Net
- you're build, test, and general SDLC will revolve around the command line, positioning yourself for automation of "all things"

The bad

- steep, steep learning curve (2-3 month commitment, but well worth it)
- no built in debugger (it's a text editor not an IDE, heavy emphasis on testing and Console.WriteLine)
- heavy use of the command line
- .Net's project and solution files make it a painful to change files (rake solves this)
- you're starting from scratch, stitching together your vim environment (especially for .Net development)
- poor autocompletiong for .Net BCL (not your own classes however)
- refactoring can be a pain (on the plus side, you'll find that your api's are more consistent and you'll refactor more often)
- you'll be "that guy/gal that uses vim for everything"
- you may lose childhood memories as you become more proficient with vim trying remember all the shortcut's you've created

##Getting your VIM environment setup on Windows

The setup is still pretty manual. As this evolves, ideally there will be a chocolatey package that will get your entire environment up and running. For now this read me will have to do...

- install [msysgit](https://code.google.com/p/msysgit/downloads/list)

This is what will add vim to your system.  Keep in mind that this is vim and not gVim.

- install [ruby 1.9.3](http://rubyinstaller.org/downloads/)

Be sure to add it to your PATH, ruby is used for rake (build automation), warmup (solution/project generation) and nokogiri (xml file/csproj manipulation)

- install [ctags for Windows](http://sourceforge.net/projects/ctags/files/ctags/) extract to a directory and add that directory to your PATH

Ctags is used for auto completion and "go to definition" in vim.

- install [Growl for Windows](http://www.growlforwindows.com/gfw/)

This will give you notifications of when builds and tests fail. Open up Growl once so that the C:\Users\%USER%\AppData\Local\Growl\2.0.0.0\Displays\ directory gets created, then...

- install [Translucent Dark](http://softwarebakery.com/frozencow/translucentdark.html), extact the theme to C:\Users\%USER%\AppData\Local\Growl\2.0.0.0\Displays\TranslucentDark

This is a really nice theme for Growl for Windows. [Here are the settings I use](http://i.imgur.com/buWyf.png).

- install [ConEmu](http://sourceforge.net/projects/conemu/)

This is an incredibly awesome tabbed and split console window manager. We'll customize everything in the next section.

- install [Strawberry Perl](http://strawberryperl.com/)

This is needed to for a package called ack (and of course opens you up to using packages built in perl). Ack provides a very nice way to search texts in a directory.
