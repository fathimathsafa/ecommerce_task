import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlTextStyles {
  // static interStyl({double? size, FontWeight? weight, Color? color}) {
  //   return GoogleFonts.inter(
  //     fontSize: size ?? 20,
  //     fontWeight: weight ?? FontWeight.w400,
  //     color: color ?? ColorTheme.black,
  //   );
  // }

  static robotoStyl({double? size, FontWeight? weight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: size ?? 20,
      fontWeight: weight ?? FontWeight.w400,
      color: color ?? ColorTheme.text,
    );
  }

  // static oswald({double? size, FontWeight? weight, Color? color}) {
  //   return GoogleFonts.oswald(
  //     fontSize: size ?? 20,
  //     fontWeight: weight ?? FontWeight.bold,
  //     color: color ?? ColorTheme.lightGreen,
  //   );
  //
  //}
}
