<p align=center>
  <img src="https://github.com/malvere/HerokuAdmin/blob/main/HerokuAdmin-icon.png" width=50%>
</p>
 
[![Platform](https://img.shields.io/badge/Platform-iOS-green)](https://www.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.5-important)](https://www.apple.com/swift/)
[![Heroku](https://img.shields.io/badge/-Heroku-blueviolet)](https://www.heroku.com/)
[![BuiltWithLove](https://img.shields.io/badge/Built%20with-Love-ff69b4)](https://github.com/malvere/)  
HerokuAdmin is a simple and lightweight app that uses Heroku api for easy control over your dynos. 
## Features
- List all your Heroku apps 
- Remote control of every dyno in your app and live status tracking
- KeyChain integration for secure token storage
- Biometrics for fast and secure access to the token
## Technologies Used
- Pure Swift with no 3rd party Pods
- MVC Architecture
- Native KeyChain implementation for user secrets
- Biometrics (TouchID or FaceID, depending on user's device)
- JSON handling is separated from ViewControllers
## Improvements I'd make
- Passcode implementation for devices which are not able to use biometrics due to various reasons
- UX/UI improvements like animations for refresh button or App's Dyno View overhaul
- More control over dynos (Deploy settings, plug-in management)
- Enhanced Error handling and feedback for the user, so that it will be clear if the issue is with either the internet connection, incorrectly inputed token and etc.
## Notes 
In order to refresh app list, HerokuAdmin should be restarted (by unloading through multitasking)  
Currently there is no way to access token setting on a device that does not have FaceID or TouchID
