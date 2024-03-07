import 'package:flutter/material.dart';

class LabeledField extends StatelessWidget {
  const LabeledField({
    this.icon,
    required this.labelText,
    this.widthModifier,
    this.heightModifier,
    this.shouldWrapInCard = true,
    this.isRequired = false,
    required this.child,
  });

  final Widget? icon;
  final String? labelText;
  final double? widthModifier;
  final double? heightModifier;
  final bool isRequired;
  final bool shouldWrapInCard;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthModifier != null
          ? MediaQuery.of(context).size.width * widthModifier!
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (labelText != null)
            Row(
              children: [
                icon ?? const SizedBox(),
                SizedBox(width: icon == null ? 0 : 8),
                RichText(
                  text: TextSpan(
                    text: labelText,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                    children: isRequired
                        ? [
                            const TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red),
                            ),
                          ]
                        : [],
                  ),
                ),
              ],
            ),
          _buildChildWidget(context),
        ],
      ),
    );
  }

  Widget _buildChildWidget(BuildContext context) {
    final Widget wrappedChild = shouldWrapInCard
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(top: labelText == null ? 0 : 8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: child,
            ),
          )
        : child;

    return SizedBox(
      height: heightModifier != null
          ? MediaQuery.of(context).size.height * heightModifier!
          : null,
      child: wrappedChild,
    );
  }
}
