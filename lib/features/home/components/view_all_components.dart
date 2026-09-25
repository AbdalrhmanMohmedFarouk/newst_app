import 'package:flutter/material.dart';

class ViewAllComponents extends StatelessWidget {
  const ViewAllComponents({super.key, required this.title, this.titleColor, required this.onTap});
final String title ;
 final Color? titleColor;
 final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color:titleColor ?? Color(0xFFFFFCFC) ,
            ),
          ),
          SizedBox(height: 6),
          InkWell(
            onTap: onTap,
              child: Text(
                "View all",
                style: TextStyle(
                  fontSize: 14,
                  color: titleColor ?? Color(0xFFFFFCFC),
                  decoration: TextDecoration.underline,
                  decorationColor: titleColor ?? Color(0xFFFFFCFC),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
