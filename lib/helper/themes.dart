  import 'package:flutter/material.dart';

  // COLOR
  const Color primaryColor = Color(0xFF1D1D1D);
  const Color primarySecondColor = Color(0xFFFFFFFF);
  const Color primaryTextColor = Color(0xF2EAF9);
  const Color accentColor = Color(0xFF00BFFF);
  const Color textColor = Color(0xFFB0BEC5);
  const Color errorColor = Color(0xFFE53935);
  const Color starColor = Colors.yellow;

  const double defaultPadding = 16.0;

  // FONT STYLES INITIAL

  TextStyle buttonStyle({required final Color color}) {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );
  }

  TextStyle defaultText = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,
    color: textColor,
  );

  TextStyle titleText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: primarySecondColor,
  );

  TextStyle titleText2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );


  TextStyle subtitleText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  TextStyle subtitleTextGrey = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  TextStyle subtitleText2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    color: primarySecondColor,
  );

  TextStyle textField = TextStyle(
    fontFamily: 'Roboto',
    color: primarySecondColor,
  );

  TextStyle textFieldGrey = TextStyle(
    fontFamily: 'Roboto',
    color: textColor,
  );
