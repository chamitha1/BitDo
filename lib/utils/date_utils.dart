/// Utilities for parsing and formatting expiry dates
/// Supports:
/// - DD/MM/YYYY
/// - MM/YYYY (legacy)
/// - Rejects placeholders like 00/00/0000, 00/0000
class ExpiryDateUtils {
  ExpiryDateUtils._(); // 🔒 prevents instantiation

  static DateTime? parse(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final v = value.trim();

    // ❌ reject known placeholders
    if (v == '00/00/0000' || v == '00/0000') return null;

    final parts = v.split('/');

    try {
      if (parts.length == 3) {
        // ✅ DD/MM/YYYY
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);

        if (day <= 0 || month <= 0 || year <= 0) return null;

        return DateTime(year, month, day);
      }

      if (parts.length == 2) {
        // ⚠️ MM/YYYY (legacy)
        final month = int.parse(parts[0]);
        final year = int.parse(parts[1]);

        if (month <= 0 || year <= 0) return null;

        // 🧠 assume first day of month
        return DateTime(year, month, 1);
      }
    } catch (_) {
      return null; // 🛡️ malformed string protection
    }

    return null;
  }

  /// Formats a date as DD/MM/YYYY
  /// Returns 00/00/0000 if null
  static String format(DateTime? date) {
    if (date == null) return '00/00/0000';

    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
