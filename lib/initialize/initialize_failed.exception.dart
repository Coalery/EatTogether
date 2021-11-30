enum InitializeFailType {
  locationServiceDisable,
  locationPermissionDeny,
  locationPermissionDenyForever
}

extension InitializeFailTypeMessage on InitializeFailType {
  String get message {
    switch(this) {
    case InitializeFailType.locationServiceDisable:
      return '위치 서비스가 꺼져있습니다.\n위치 서비스를 켜주세요.';
    case InitializeFailType.locationPermissionDeny:
      return '위치 권한이 없으면 앱을 사용할 수 없습니다.\n위치 권한을 허용해주세요.';
    case InitializeFailType.locationPermissionDenyForever:
      return '위치 권한을 영원히 거절하셨으므로 앱을 사용할 수 없습니다.\n앱 설정을 바꿔주세요.';
    }
  }
}

class InitializeFailedException implements Exception {
  final InitializeFailType type;
  InitializeFailedException(this.type);
}