This is a template for menu bar applications with custom windows and custom menu bar icon. It was partially taken from an existing application developed by another developer. I've added support for moving the window and animations support.

It allows the creation of a menu bar app with custom icon and a custom window attached (see [this app](http://itunes.apple.com/us/app/facetab/id421358730?mt=12) for an example).

To use it, you need to:

- add a boolean YES in the info.plist with key "Application is agent" to hide the dock icon.
- Open the existing MainMenu.xib (or whatever you're using in your project), add an instance to ApplicationController, delete the existing window, then add your view and connect the view outlets.
- Build and run.

Example:

![preview](http://cocoadevblog.s3.amazonaws.com/023/menubar.png)