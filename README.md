## Server

* matrix: docker.io/matrixdotorg/synapse:latest
* db: docker.io/postgres:12-alpine
* web client: vectorim/element-web

## Mobile Client

* Fluffy chat: https://github.com/krille-chan/fluffychat/releases/tag/v1.21.2

## Implementation

Matrix is deployed inside a docker alongside element web client and postgres DB.
Mobile app is an empty Flutter app that imports FluffyChat that was adjusted to be a flutter module.
FluffyChat also has a hardcoded default local homeserver.

## Setup
* Clone this repo
* `cd p2p_chat_server`
* `docker-compose up`
* `cd ../p2p_chat_app`
* (optional) run ./bootstrap-mac.sh (or for windows ./bootstrap-win.ps1)
* (optional) install Android Studio, SDK/NKD and Android 34 API
   * Launch Android Emulator using Device Manager
* (optional) check the setup using `flutter doctor`
* `flutter run`
