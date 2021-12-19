import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/medules/cache_helper.dart';
import 'package:shop_app/medules/login_screen.dart';

void goTo(context,widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
void goAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget), (route) => false);

Widget defultEditText({
  required TextEditingController controller,
  Function(String)? onChange,
  Function(String)? onSubmitted,
  VoidCallback? onTap,
  TextInputType keyboardType = TextInputType.emailAddress,
  bool obscureText = false,
  required String lable,
  required IconData prefixIcon,
  required String? Function(String?) validator,
  IconButton? suffixIcon,
})=>TextFormField(
  controller: controller,
  onChanged: onChange,
  onFieldSubmitted: onSubmitted,
  validator: validator,
  onTap: onTap,
  keyboardType: keyboardType,
  obscureText: obscureText,
  decoration: InputDecoration(
      label: Text(lable),
      disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)
      ),
      border: const OutlineInputBorder(),
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon
  ),
);

void toast({
  required String message,
  Color backColor = Colors.white ,
  Color textColor = const Color(0xFFF3b739),
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backColor ,
      textColor: textColor,
      fontSize: 16.0
  );
}
void submit({required context}){
  CacheHelper.putData(key: 'onBoarding', value: true).then((value) {
    if(value)
    {
      goAndFinish(context, LoginScreen());
      print('$value');
    }
  });
}
