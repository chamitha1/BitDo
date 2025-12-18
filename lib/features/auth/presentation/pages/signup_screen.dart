import 'package:BitDo/core/widgets/gradient_button.dart';
import 'package:BitDo/features/auth/presentation/pages/login_screen.dart';
import 'package:BitDo/features/auth/presentation/pages/otp_bottom_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController? _emailController;

  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _inviteController = TextEditingController();

  FocusNode? _autocompleteFocusNode;

  bool _agreedToTerms = false;
  bool _isPasswordVisible = false;
  bool _isEmailPopulated = false;
  bool _isEmailVerified = false;

  static const List<String> _emailDomains = <String>[
    'gmail.com',
    'hotmail.com',
    'outlook.com',
    'yahoo.com',
    'icloud.com',
    'live.com',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passController.dispose();
    _confirmPassController.dispose();
    _inviteController.dispose();
    super.dispose();
  }

  void _openOtpSheet() {
    if (!_isEmailPopulated || _emailController == null) return;

    _autocompleteFocusNode?.unfocus();
    FocusScope.of(context).unfocus();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,

      barrierColor: const Color(0xFFECEFF5).withOpacity(0.7),

      builder: (context) => OtpBottomSheet(
        email: _emailController!.text.trim(),
        onVerified: () {
          Navigator.pop(context);
          setState(() => _isEmailVerified = true);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email Verified Successfully!")),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFF6F9FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Let's Get You Started",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF151E2F),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Set up your profile with strong protection for safe crypto trading and storage.",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF454F63),
                ),
              ),
              const SizedBox(height: 28),

              _textLabel("Email"),
              _emailAutocompleteField(
                hint: "Enter your email",
                iconPath: "assets/icons/sign_up/sms.png",
                suffixWidget: Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: _verifyButton(
                    text: _isEmailVerified ? "Verified" : "Verify",
                    isEnabled: _isEmailPopulated,
                    isVerified: _isEmailVerified,
                    onPressed: _openOtpSheet,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              _textLabel("Password"),
              TextField(
                controller: _passController,
                enabled: _isEmailVerified,
                obscureText: !_isPasswordVisible,
                decoration: _inputDecoration(
                  hint: "Enter Password",
                  iconPath: "assets/icons/sign_up/lock.png",
                  suffixIconPath: "assets/icons/sign_up/eye.png",
                  isPassword: true,
                  enabled: _isEmailVerified,
                ),
              ),
              const SizedBox(height: 30),

              _textLabel("Confirm Password"),
              TextField(
                controller: _confirmPassController,
                enabled: _isEmailVerified,
                obscureText: !_isPasswordVisible,
                decoration: _inputDecoration(
                  hint: "Re-Enter Password",
                  iconPath: "assets/icons/sign_up/lock.png",
                  suffixIconPath: "assets/icons/sign_up/eye.png",
                  isPassword: true,
                  enabled: _isEmailVerified,
                ),
              ),
              const SizedBox(height: 30),

              _textLabel("Invitation Code (optional)"),
              TextField(
                controller: _inviteController,
                enabled: _isEmailVerified,
                decoration: _inputDecoration(
                  hint: "Please Enter Your Code",
                  iconPath: "assets/icons/sign_up/hashtag.png",
                  enabled: _isEmailVerified,
                ),
              ),
              const SizedBox(height: 22),

              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: _agreedToTerms,
                      onChanged: _isEmailVerified
                          ? (v) => setState(() => _agreedToTerms = v ?? false)
                          : null,
                      activeColor: const Color(0xFF2F5599),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "I agree to the ",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0XFF454F63),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                        children: const [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF28A6FF),
                            ),
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF454F63),
                            ),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0XFF28A6FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              GradientButton(
                text: "Sign Up",
                onPressed: _isEmailVerified && _agreedToTerms
                    ? () {
                        // Sign up logic
                      }
                    : () {},
              ),

              const SizedBox(height: 24),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(
                      color: Color(0XFF151E2F),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign in",
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Color(0XFF1D5DE5),
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // widgets

  Widget _textLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0XFF2E3D5B),
        ),
      ),
    );
  }

  Widget _emailAutocompleteField({
    required String hint,
    required String iconPath,
    required Widget suffixWidget,
  }) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue value) {
        final raw = value.text;
        final input = raw.trim();

        if (input.isEmpty) return const Iterable<String>.empty();

        if (_emailDomains.any(
          (d) => input.toLowerCase() == '${_localPart(input).toLowerCase()}@$d',
        )) {
          return const Iterable<String>.empty();
        }

        final atIndex = input.indexOf('@');
        if (atIndex < 0) {
          return _emailDomains.map((d) => '$input@$d');
        }

        final local = input.substring(0, atIndex);
        final typedDomain = input.substring(atIndex + 1).toLowerCase();

        if (local.isEmpty) return const Iterable<String>.empty();

        final matches = _emailDomains.where(
          (d) => d.toLowerCase().startsWith(typedDomain),
        );
        return matches.map((d) => '$local@$d');
      },
      onSelected: (String selection) {
        _emailController?.text = selection;
        _emailController?.selection = TextSelection.fromPosition(
          TextPosition(offset: selection.length),
        );
        setState(() {
          _isEmailPopulated = true;
        });
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        if (_emailController != controller) {
          _emailController = controller;
          _autocompleteFocusNode = focusNode;

          _emailController!.addListener(() {
            final isPopulated = _emailController!.text.isNotEmpty;
            if (_isEmailPopulated != isPopulated) {
              setState(() {
                _isEmailPopulated = isPopulated;
              });
            }
          });
        }
        return TextField(
          controller: controller,
          focusNode:
              focusNode, 
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: _inputDecoration(
            hint: hint,
            iconPath: iconPath,
            suffixWidget: suffixWidget,
          ),
          onSubmitted: (_) => onFieldSubmitted(),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            color: const Color(0XFFF6F9FF),
            borderRadius: BorderRadius.circular(12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220, maxWidth: 340),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, _) => const SizedBox.shrink(),
                itemBuilder: (context, i) {
                  final opt = options.elementAt(i);
                  return InkWell(
                    onTap: () => onSelected(opt),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        opt,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Color(0XFF151E2F),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  String _localPart(String emailLike) {
    final idx = emailLike.indexOf('@');
    if (idx < 0) return emailLike;
    return emailLike.substring(0, idx);
  }

  InputDecoration _inputDecoration({
    required String hint,
    required String iconPath,
    Widget? suffixWidget,
    bool isPassword = false,
    bool enabled = true,
    String? suffixIconPath,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0XFF717F9A),
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(iconPath, width: 20, height: 20),
      ),
      suffixIcon: isPassword && suffixIconPath != null
          ? Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: IconButton(
                onPressed: enabled
                    ? () => setState(
                        () => _isPasswordVisible = !_isPasswordVisible,
                      )
                    : null,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    suffixIconPath,
                    width: 20,
                    height: 20,
                    color: _isPasswordVisible
                        ? const Color.fromARGB(255, 15, 40, 59)
                        : null,
                  ),
                ),
              ),
            )
          : suffixWidget,
      filled: true,
      fillColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return const Color(0xFFECEFF5);
        }
        return Colors.white;
      }),
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDAE0EE), width: 1.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDAE0EE), width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 112, 152, 221),
          width: 1.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDAE0EE), width: 1.0),
      ),
    );
  }

  Widget _verifyButton({
    required String text,
    required VoidCallback onPressed,
    required bool isEnabled,
    bool isVerified = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      height: 30,
      decoration: BoxDecoration(
        color: isVerified
            ? const Color(0xff2ECC71)
            : (isEnabled ? null : const Color(0XFFB9C6E2)),
        gradient: (isEnabled && !isVerified)
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1D5DE5), Color(0xFF174AB7)],
              )
            : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          disabledBackgroundColor: Colors.transparent,
          disabledForegroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: isVerified ? 12 : 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: (isEnabled && !isVerified) ? onPressed : null,
        child: isVerified
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/sign_up/check_circle.png",
                    width: 14,
                    height: 14,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
