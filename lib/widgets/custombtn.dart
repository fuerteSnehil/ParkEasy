import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:parkeasy/Utils/constants.dart';
import 'package:parkeasy/widgets/loading.dart';
import 'package:parkeasy/widgets/screen.dart';

class CustomButton extends StatelessWidget {
  final double? borderRadius;
  final VoidCallback onTap;
  final String label;
  final IconData? icon;
  final Color? backgroundColor, foregroundColor;
  final bool isLoading;
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.isLoading,
    this.borderRadius,
    required this.label,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Screen s = Screen(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedSwitcher(
        reverseDuration: const Duration(milliseconds: 250),
        duration: const Duration(milliseconds: 250),
        child: isLoading
            ? CPI(30 * s.customWidth)
            : Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? 40 * s.customWidth,
                  ),
                ),
                margin: EdgeInsets.zero,
                // color: backgroundColor ?? theme,
                color: backgroundColor ?? black,
                child: Container(
                  width: s.infinity,
                  padding: EdgeInsets.all(15 * s.customWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: foregroundColor ?? white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17 * s.customWidth,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(width: 20 * s.customWidth),
                      Icon(
                        icon ?? MdiIcons.send,
                        color: foregroundColor ?? white,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;

//   const CustomButton({super.key, required this.text, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ButtonStyle(
//         foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
//         backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
//         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25.0),
//           ),
//         ),
//       ),
//       child: Text(text, style: const TextStyle(fontSize: 16)),
//     );
//   }
// }
