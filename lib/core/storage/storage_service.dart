import 'package:shared_preferences/shared_preferences.dart';

const String userToken = 'user_token';
const String userName = 'user_name';
const String userAccountNumber = 'account_number';
const String currency = '_currency';
const String symbol = '_symbol';

class StorageService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  //set user token
  static Future<bool> saveToken(String token) async {
    if (_prefs == null) await init();
    print("SAVING TOKEN : $token ");
    return await _prefs!.setString(userToken, token);
  }

  //get user token
  static Future<String?> getToken() async {
    if (_prefs == null) await init();
    final token = _prefs!.getString(userToken);
    print("GETTING TOKEN : $token ");
    return token;
  }

  static Future<void> removeToken() async {
    if (_prefs == null) await init();
    await _prefs!.remove(userToken);
  }

  //set user name
  static Future<bool> saveUserName(String name) async {
    if (_prefs == null) await init();
    return await _prefs!.setString(userName, name);
  }

  //get user name
  static Future<String?> getUserName() async {
    if (_prefs == null) await init();
    return _prefs!.getString(userName);
  }

  static Future<bool> saveAccountNumber(String accNum) async {
    if (_prefs == null) await init();
    return await _prefs!.setString(userAccountNumber, accNum);
  }

  static Future<String?> getAccountNumber() async {
    if (_prefs == null) await init();
    return _prefs!.getString(userAccountNumber);
  }

  // set currency
  static Future<bool> setCurrency(String _currency) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(currency, _currency);
  }

  /// Get currency
  static Future<String> getCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString(currency);
    return value ?? 'NGN'; // Default to NGN if not set
  }

  /// Set symbol
  static Future<bool> setSymbol(String _symbol) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(symbol, _symbol);
  }

  /// Get symbol
  static Future<String> getSymbol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString(symbol);
    return value ?? 'USDT'; // Default to USDT
  }

  //Temporary Storage for Withdrawal Flow ---
  static const String tempWithdrawAddr = 'temp_withdraw_addr';
  static const String tempWithdrawAmount = 'temp_withdraw_amount';
  static const String tempWithdrawPwd = 'temp_withdraw_pwd';

  static Future<void> saveTempWithdrawData(String addr, String amount, String pwd) async {
    if (_prefs == null) await init();
    await _prefs!.setString(tempWithdrawAddr, addr);
    await _prefs!.setString(tempWithdrawAmount, amount);
    await _prefs!.setString(tempWithdrawPwd, pwd);
  }

  static Future<Map<String, String?>> getTempWithdrawData() async {
    if (_prefs == null) await init();
    return {
      'addr': _prefs!.getString(tempWithdrawAddr),
      'amount': _prefs!.getString(tempWithdrawAmount),
      'pwd': _prefs!.getString(tempWithdrawPwd),
    };
  }

  static Future<void> clearTempWithdrawData() async {
    if (_prefs == null) await init();
    await _prefs!.remove(tempWithdrawAddr);
    await _prefs!.remove(tempWithdrawAmount);
    await _prefs!.remove(tempWithdrawPwd);
  }
}
