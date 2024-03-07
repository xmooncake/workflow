import 'package:flutter/material.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({
    required this.width,
    required this.icon,
    required this.label,
    this.onPressed,
    super.key,
  });

  final double width;
  final IconData icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final color = onPressed != null ? Colors.white : Colors.grey;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.greenAccent[700],
          ),
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Icon(
                    icon,
                    size: 30,
                    color: color,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
