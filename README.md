Fluffy chat: https://github.com/krille-chan/fluffychat/releases/tag/v1.21.2

h2. Chat embedding guide
* Clone this repo
* cd p2p_chat_app
* run ./bootstrap-mac.sh script (or ./bootstrap-win.ps1)
** It will install all necessary dependencies
** At the end - it will print a flutter disgnostic report
* Install Android Studio
** Install 34 sdk using SDK Manager (Android 14.0)
** Install NDK, SDK command line tools, Android Emulator, Android SDK Platform-tools
** Create a virtual device using Device Manager
*** Assign 34 API 
** Start the device using Devices Manager
* call flutter run