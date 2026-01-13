import 'package:flutter/material.dart';
import 'package:BitOwi/api/common_api.dart';
import 'package:BitOwi/models/dict.dart';

class FilterBottomSheet extends StatefulWidget {
  final String? initialAmount;
  final String? initialCurrency;

  const FilterBottomSheet({
    super.key,
    this.initialAmount,
    this.initialCurrency,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String _selectedMultiplier = "10X";
  final List<String> _multipliers = const ["1X", "5X", "10X", "20X", "50X", "100X"];

  List<Dict> _currencyList = [];
  Dict? _selectedCurrency;
  bool _loadingCurrencies = true;

  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.initialAmount ?? "");
    _fetchCurrencies();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _fetchCurrencies() async {
    try {
      final list = await CommonApi.getDictList(parentKey: 'ads_trade_currency');
      if (!mounted) return;

      Dict? selected;

      // prefer initial currency
      final initKey = (widget.initialCurrency ?? "").trim();
      if (initKey.isNotEmpty) {
        try {
          selected = list.firstWhere((e) => e.key == initKey);
        } catch (_) {}
      }

      // else default NGN, else first
      selected ??= list.isNotEmpty
          ? list.firstWhere((e) => e.key == 'NGN', orElse: () => list.first)
          : null;

      setState(() {
        _currencyList = list;
        _selectedCurrency = selected;
        _loadingCurrencies = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _currencyList = [];
        _selectedCurrency = null;
        _loadingCurrencies = false;
      });
      debugPrint("Error fetching currencies: $e");
    }
  }

  void _onReset() {
    Navigator.pop(context, {'type': 'reset'});
  }

  void _onFilter() {
    Navigator.pop(context, {
      'type': 'filter',
      'amount': _amountController.text.trim(),
      'currency': _selectedCurrency?.key,
      // if later needed:
      // 'multiplier': _selectedMultiplier,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),

              _buildLabel("Amount"),
              const SizedBox(height: 8),
              _buildAmountInput(),
              const SizedBox(height: 16),

              _buildMultiplierRow(),
              const SizedBox(height: 18),

              _buildLabel("Currency"),
              const SizedBox(height: 8),
              _buildCurrencySection(),
              const SizedBox(height: 24),

              _buildFooterButtons(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Filter",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, color: Colors.black, size: 24),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF2E3D5B),
      ),
    );
  }

  Widget _buildAmountInput() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFF151E2F),
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDAE0EE), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1D5DE5), width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDAE0EE), width: 1),
        ),
      ),
    );
  }

  Widget _buildMultiplierRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _multipliers.map((m) {
          final isSelected = _selectedMultiplier == m;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedMultiplier = m),
              child: _buildMultiplierChip(m, isSelected),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMultiplierChip(String text, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF151E2F) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: isActive ? null : Border.all(color: const Color(0xFFECEFF5), width: 1),
        boxShadow: [
          if (!isActive)
            BoxShadow(
              color: const Color(0xFF2E3D5B).withOpacity(0.07),
              offset: const Offset(0, 4),
              blurRadius: 3,
            ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isActive ? Colors.white : const Color(0xFF717F9A),
        ),
      ),
    );
  }
  
  Widget _buildCurrencySection() {
    if (_loadingCurrencies) {
      return Container(
        height: 48,
        alignment: Alignment.centerLeft,
        child: const SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    // ✅ If API fails / empty list, fallback to NGN + USD buttons
    final List<String> keys = (_currencyList.isEmpty)
        ? const ["NGN", "USD"]
        : _currencyList
            .map((e) => e.key)
            .where((k) => k == "NGN" || k == "USD")
            .toList();

    // ✅ Ensure only NGN + USD shown, and always in correct order
    final List<String> currencies = [
      if (keys.contains("NGN")) "NGN",
      if (keys.contains("USD")) "USD",
    ];

    // default selection if none
    final selectedKey = _selectedCurrency?.key;
    final activeKey =
        (selectedKey == "NGN" || selectedKey == "USD") ? selectedKey : "NGN";

    return Row(
      children: currencies.map((c) {
        final isActive = activeKey == c;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: c != currencies.last ? 12 : 0),
            child: GestureDetector(
              onTap: () {
                // ✅ set selected currency as Dict for return payload
                setState(() {
                  _selectedCurrency = Dict(key: c, value: c);
                });
              },
              child: _buildCurrencyButtonSmall(c, isActive),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCurrencyButtonSmall(String text, bool isActive) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF151E2F) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFECEFF5), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.11),
            offset: const Offset(0, 4),
            blurRadius: isActive ? 7 : 4,
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : const Color(0xFF717F9A),
        ),
      ),
    );
  }
  
  // BIG icon button (for NGN + USD)
  Widget _buildCurrencyIconButton(String key, bool isActive) {
    final String emoji = key == 'USD' ? '🇺🇸' : '🇳🇬';
    final String subtitle = key == 'USD' ? 'US Dollar' : 'Naira';

    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF151E2F) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isActive ? const Color(0xFF151E2F) : const Color(0xFFECEFF5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.10),
            offset: const Offset(0, 4),
            blurRadius: isActive ? 10 : 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isActive ? Colors.white.withOpacity(0.12) : const Color(0xFFF6F9FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  key,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isActive ? Colors.white : const Color(0xFF151E2F),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: isActive ? Colors.white70 : const Color(0xFF717F9A),
                  ),
                ),
              ],
            ),
          ),
          if (isActive)
            const Icon(Icons.check_circle, color: Color(0xFF40A372), size: 20),
        ],
      ),
    );
  }

  // Small button (screenshot style)
  Widget _buildSmallCurrencyButton(String text, bool isActive) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF151E2F) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFECEFF5), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.11),
            offset: const Offset(0, 4),
            blurRadius: isActive ? 7 : 4,
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : const Color(0xFF717F9A),
        ),
      ),
    );
  }

  Widget _buildFooterButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: OutlinedButton(
              onPressed: _onReset,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF1D5DE5), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "Reset",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1D5DE5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1D5DE5), Color(0xFF28A6FF)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton(
              onPressed: _onFilter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Filter",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
