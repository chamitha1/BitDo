import 'dart:async';

class DebounceUtils {
  static Function debounce(Function func, int milliseconds) {
    Timer? timer;
    return () {
      timer?.cancel();
      timer = Timer(Duration(milliseconds: milliseconds), () {
        func();
      });
    };
  }
}
