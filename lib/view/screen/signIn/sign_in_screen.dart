import 'dart:convert';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../res/assets_res.dart';
import '../../../utill/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool isFormValidated = false;
  final _shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Center(child: Image.asset(AssetsRes.E_LOGO)),
            const SizedBox(height: 62),
            const Text('Sign in',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const SizedBox(height: 24),
            const Text('Phone Number',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            const SizedBox(height: 8),
            // Number Field.
            Container(
              decoration: BoxDecoration(
                  color: AppColors.kInput,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  CountryPicker(
                    callBackFunction:
                        (String name, String dialCode, String flag) {},
                  ),
                  Container(
                    height: 20,
                    width: 2,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: AuthField(
                          controller: _phoneController,
                          onChanged: (value) {
                            if (value!.isNotEmpty) {
                              setState(() {});
                              isFormValidated = true;
                              return value;
                            } else {
                              setState(() {});
                              isFormValidated = false;
                              return value;
                            }
                          },
                          hintText: 'Phone Number',
                          keyboardType: TextInputType.number,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.deny(RegExp(r'^0[0-9]* $'))
                          ],
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ShakeWidget(
              key: _shakeKey,
              shakeOffset: 10.0,
              shakeDuration: const Duration(milliseconds: 500),
              child: PrimaryButton(
                onTap: () {
                  if (isFormValidated) {
                  } else {
                    _shakeKey.currentState?.shake();
                  }
                },
                text: 'Sign in',
                color: isFormValidated ? null : AppColors.kInput,
              ),
            ),
            const SizedBox(height: 63),
            const Center(
                child: Text('Sign in with',
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSocialButton(onTap: () {}, icon: AssetsRes.APPLE),
                const SizedBox(width: 35),
                CustomSocialButton(onTap: () {}, icon: AssetsRes.FACEBOOK),
                const SizedBox(width: 35),
                CustomSocialButton(onTap: () {}, icon: AssetsRes.GOOGLE),
              ],
            ),
            const SizedBox(height: 65),
            Center(
              child: PrimaryButton(
                onTap: () {},
                text: 'Continue as a Guest',
                color: AppColors.kInput,
                width: 240,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Create a New Account?',
                    style: TextStyle(fontSize: 13, color: Color(0xFF9A9FA5))),
                CustomTextButton(
                  onPressed: () {},
                  text: 'Sign Up',
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


abstract class ShakeAnimation<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  ShakeAnimation(this.animationDuration);
  final Duration animationDuration;
  late final animationController =
  AnimationController(vsync: this, duration: animationDuration);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    required this.child,
    required this.shakeOffset,
    Key? key,
    this.shakeCount = 3,
    this.shakeDuration = const Duration(milliseconds: 400),
  }) : super(key: key);
  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  @override
  // ignore: no_logic_in_create_state
  ShakeWidgetState createState() => ShakeWidgetState(shakeDuration);
}

class ShakeWidgetState extends ShakeAnimation<ShakeWidget> {
  ShakeWidgetState(Duration duration) : super(duration);

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (context, child) {
        final sineValue =
        sin(widget.shakeCount * 2 * pi * animationController.value);
        return Transform.translate(
          offset: Offset(sineValue * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }
}

class CustomSocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  const CustomSocialButton(
      {super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 55,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.kNeutral01,
          border: Border.all(color: AppColors.kNeutral03, width: 2),
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  final bool isBorder;
  const PrimaryButton({
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.isBorder = false,
    this.fontSize,
    this.color,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      alignment: Alignment.center,
      width: width ?? double.maxFinite,
      decoration: BoxDecoration(
          color: color ?? AppColors.kPrimary,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          border: isBorder ? Border.all(color: AppColors.kHint) : null),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: fontSize ?? 15,
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomTextButton({
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: AppColors.kPrimary, fontSize: 12),
      ),
    );
  }
}

// Country Picker Model.
class CountryModel {
  const CountryModel(
      {required this.name,
        required this.dialCode,
        required this.code,
        required this.flag});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    final flag = CountryModel.getEmojiFlag(json['code'] as String);
    return CountryModel(
        name: json['name'] as String,
        dialCode: json['dial_code'] as String,
        code: json['code'] as String,
        flag: flag);
  }

  final String name, dialCode, code, flag;

  static String getEmojiFlag(String emojiString) {
    const flagOffset = 0x1F1E6;
    const asciiOffset = 0x41;
    final firstChar = emojiString.codeUnitAt(0) - asciiOffset + flagOffset;
    final secondChar = emojiString.codeUnitAt(1) - asciiOffset + flagOffset;
    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }
}

// Country Picker Widget.
// ignore: must_be_immutable
class CountryPicker extends StatefulWidget {
  final Function callBackFunction;
  bool isInit = true;
  CountryPicker({
    Key? key,
    required this.callBackFunction,
    this.isInit = true,
  }) : super(key: key);

  @override
  _CountryPickerState createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  List<CountryModel> countryList = [];
  CountryModel? selectedCountryData;

  @override
  void didChangeDependencies() async {
    if (widget.isInit) {
      widget.isInit = false;
      final data = await DefaultAssetBundle.of(context)
          .loadString('assets/countrycode.json');
      setState(() {
        countryList = parseJson(data);
        selectedCountryData = countryList[0];
      });
      widget.callBackFunction(selectedCountryData!.name,
          selectedCountryData!.dialCode, selectedCountryData!.flag);
    }
    super.didChangeDependencies();
  }

  List<CountryModel> parseJson(String response) {
    // ignore: unnecessary_null_comparison
    if (response == null) {
      return [];
    }
    final parsed =
    json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed
        .map<CountryModel>(
            (json) => CountryModel.fromJson(json as Map<String, dynamic>))
        .toList() as List<CountryModel>;
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        showDialogue(context);
      },
      child: SizedBox(
        width: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              selectedCountryData != null ? selectedCountryData!.flag : '',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(width: 5),
            Text(
              selectedCountryData != null ? selectedCountryData!.dialCode : '',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Future<void> showDialogue(BuildContext context) async {
    final countryData = await showDialog(
      context: context,
      builder: (BuildContext context) => CountryPickerDialog(
        searchList: countryList,
        callBackFunction: widget.callBackFunction,
      ),
    );
    if (countryData != null) {
      selectedCountryData = countryData as CountryModel;
    }
    setState(() {});
  }
}

class CountryPickerDialog extends StatefulWidget {
  final List<CountryModel> searchList;
  final Function callBackFunction;

  const CountryPickerDialog({
    super.key,
    required this.searchList,
    required this.callBackFunction,
  });

  @override
  _CountryPickerDialogState createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  List<CountryModel> tmpList = [];

  Widget dialogContent(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: AppColors.kPrimary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Select Country',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkResponse(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                  hintText: 'Search Country',
                  filled: false,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18.0,
                    color: Colors.black38,
                  )),
              onChanged: filterData,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...tmpList.map(
                        (item) => GestureDetector(
                      onTap: () {
                        Navigator.pop(context, item);
                        widget.callBackFunction(
                            item.name, item.dialCode, item.flag);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.flag,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              item.dialCode,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void filterData(String text) {
    tmpList = [];
    if (text == '') {
      tmpList.addAll(widget.searchList);
    } else {
      for (var userDetail in widget.searchList) {
        if (userDetail.name.toLowerCase().contains(text.toLowerCase())) {
          tmpList.add(userDetail);
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    tmpList = widget.searchList;
  }

  // build method
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? padding;
  const AuthField(
      {super.key,
        required this.controller,
        required this.hintText,
        this.keyboardType,
        this.onChanged,
        this.padding,
        this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          filled: false,
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.kHint),
          contentPadding: padding),
      keyboardType: keyboardType,
    );
  }
}