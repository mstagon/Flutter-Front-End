import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

final emulatorIP = '10.0.2.2:3000'; // localhost emulator 기준
final simulatorIP = '127.0.0.1:3000'; // localhost simulator 기준
final ip = Platform.isIOS ? simulatorIP : emulatorIP;

final String clientId = 'ab40038f834387b28b4217d1a28c6d1e';
final String redirectUri = 'https://3822-121-185-72-189.ngrok-free.app/login/oauth2/code/kakao';
final String kaKaoAuthUrl = 'https://kauth.kakao.com/oauth/authorize';