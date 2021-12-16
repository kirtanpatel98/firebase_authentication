import 'package:firebase_authentication/data/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  final String title;
  final double height;
  final double width;
  final VoidCallback onTap;
  final bool isLoading;
  final double textSize;
  const CartButton({
    Key key,
    @required this.title,
    @required this.height,
    @required this.width,
    @required this.onTap,
    @required this.isLoading,
    this.textSize = 22.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: isLoading ? 60.0 : height,
      width: isLoading ? 60.0 : width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppTheme.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
        ),
        onPressed: onTap,
        child: isLoading
            ? const Center(
                child: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(),
                ),
              )
            : Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: textSize,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}
