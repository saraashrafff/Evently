import 'package:evently/app_theme.dart';
import 'package:evently/providers/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DefaultTextFormField extends StatefulWidget {
  String hintText;
  TextEditingController? controller;
  void Function(String)? onChanged;
  String? prefixIconImageName;
  String? Function(String?)? validator;
  bool isPassword;

  DefaultTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.prefixIconImageName,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return TextFormField(
      obscureText: isObscure,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      style: Theme.of(context).textTheme.titleMedium,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIconImageName == null
            ? null
            : SvgPicture.asset(
                'assets/icons/${widget.prefixIconImageName}.svg',
                height: 24,
                width: 24,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(
                  widget.prefixIconImageName == 'search'
                      ? AppTheme.primary
                      : settingsProvider.isDark
                      ? AppTheme.white
                      : AppTheme.grey,
                  BlendMode.srcIn,
                ),
              ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: settingsProvider.isDark
                      ? AppTheme.white
                      : AppTheme.grey,
                ),
              )
            : null,
      ),
    );
  }
}
