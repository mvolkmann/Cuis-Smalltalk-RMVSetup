# Cuis-Smalltalk-RMVSetup

This is a package for Cuis Smalltalk that I use to setup fresh images.
To use this, clone this repository into the same directory where `Cuis-Smalltalk-Dev` was cloned.
Then start an image, open a Workspace, and evaluate `Feature require: #RMVSetup`.

Currently this installs the following packages:

- Cuis-Smalltalk-LogAs
- Cuis-Smalltalk-FindByExample
- Cuis-Smalltalk-SearchBrowser
- Cuis-Smalltalk-Switch
- Cuis-Smalltalk-Vim
- Cuis-Smalltalk-WindowManager

In addition, this:

- sets the background image to the balloon image at
  [Visual Paradox](https://visualparadox.com/wallpapers/altitude1600.htm)
  and tiles it.
- modifies the logic for determining where windows
  opened from the World menu "Open" submenu appear
  so they their upper-left corner is at the location
  that was clicked to open the World menu
  (adjusted if that results in the window
  extending past the right or bottom edge)
