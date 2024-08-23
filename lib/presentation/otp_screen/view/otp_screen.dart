import 'package:ecommerce_task/core/constants/color_constants.dart';
import 'package:ecommerce_task/core/constants/text_style_constatnts.dart';
import 'package:ecommerce_task/presentation/home_screen/view/home_screen.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  //final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: ColorTheme.backgroundclr,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
          ),
          Text(
            "WELCOME TO BAG NEST",
            style: GlTextStyles.robotoStyl(),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            'Enter your OTP ',
            style: GlTextStyles.robotoStyl(size: 20),
          ),
          SizedBox(
            height: size.height * 0.09,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.width * .1, right: size.width * .1),
            child: TextFormField(
              //controller: namecontroller,
              textInputAction: TextInputAction.next,
              validator: (name) {
                if (name!.isEmpty) {
                  return "Enter a valid Username";
                } else {
                  return null;
                }
              },
              style: TextStyle(color: ColorTheme.backgroundclr),
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorTheme.text,
                hintText: 'Enter OTP',
                hintStyle: GlTextStyles.hintstyle(size: 15),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.09,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Container(
              height: size.height * 0.06,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                  color: ColorTheme.text,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  "VERIFY",
                  style: GlTextStyles.hintstyle(
                      size: 15,
                      color: ColorTheme.backgroundclr,
                      weight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
