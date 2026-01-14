const smsBizTypeValues = [
  'C_REG_EMAIL',
  'FORGET_LOGINPWD',
  'BIND_TRADEPWD',
  'MODIFY_EMAIL',
  'OPEN_GOOGLE',
  'CLOSE_GOOGLE',
  'WITHDRAW',
];

enum SmsBizType {
  register, // C_REG_EMAIL
  forgetPwd, // FORGET_LOGINPWD
  resetLoginPwd, //Change login pwd
  bindTradePwd, // BIND_TRADEPWD
  modifyEmail, // MODIFY_EMAIL
  openGoogle, // OPEN_GOOGLE
  closeGoogle, // CLOSE_GOOGLE
  withdraw, // WITHDRAW
}

extension SmsBizTypeExtension on SmsBizType {
  String get value {
    switch (this) {
      case SmsBizType.register:
        return 'C_REG_EMAIL';
      case SmsBizType.forgetPwd:
        return 'FORGET_LOGINPWD';
      case SmsBizType.bindTradePwd:
        return 'BIND_TRADEPWD';
      case SmsBizType.modifyEmail:
        return 'MODIFY_EMAIL';
      case SmsBizType.openGoogle:
        return 'OPEN_GOOGLE';
      case SmsBizType.closeGoogle:
        return 'CLOSE_GOOGLE';
      case SmsBizType.withdraw:
        return 'WITHDRAW';
      case SmsBizType.resetLoginPwd:
        return 'RESET_LOGIN_PWD';
    }
  }
}

SmsBizType? smsBizTypeFromValue(String value) {
  switch (value) {
    case 'C_REG_EMAIL':
      return SmsBizType.register;
    case 'FORGET_LOGINPWD':
      return SmsBizType.forgetPwd;
    case 'BIND_TRADEPWD':
      return SmsBizType.bindTradePwd;
    case 'MODIFY_EMAIL':
      return SmsBizType.modifyEmail;
    case 'OPEN_GOOGLE':
      return SmsBizType.openGoogle;
    case 'CLOSE_GOOGLE':
      return SmsBizType.closeGoogle;
    case 'WITHDRAW':
      return SmsBizType.withdraw;
    default:
      return null;
  }
}
