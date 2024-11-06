// NOTE: API 호출 URL
const String _baseUrl = 'https://daelim-server.fleecy.dev/functions/v1';
const String getTokenUrl = '$_baseUrl/auth/get-token';
const String getUserDataUrl = '$_baseUrl/auth/my-data';
const String setProfileImageUrl = '$_baseUrl/auth/set-profile-image';

const String _storagePublicUrl = 'https://daelim-server.fleecy.dev/storage/v1/object/public';

// NOTE: 아이콘 URL
const String icGoogle = '$_storagePublicUrl/icons/google.png';
const String icApple = '$_storagePublicUrl/icons/apple.png';
const String icGithub = '$_storagePublicUrl/icons/github.png';

// NOTE: 이미지 URL
const String defaultProfileImageUrl = '$_storagePublicUrl/icons/user.png';
