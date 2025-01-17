import 'package:flutter/material.dart';

class ReusableBannerButton extends StatelessWidget {
  final Widget buttonCard;
  final VoidCallback onPress;
  final double heightAdjust;

  const ReusableBannerButton({
    required this.buttonCard,
    required this.onPress,
    required this.heightAdjust,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      constraints: BoxConstraints(minHeight: 60 * heightAdjust),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: buttonCard,
    );
  }
}
