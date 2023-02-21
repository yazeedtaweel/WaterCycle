import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:water_cycle_android/providers/regions_provider.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class UserForm extends StatelessWidget {
  static final routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('توزيع المياه على مناطق السموع'),
        backgroundColor: Colors.teal,
      ),
      body: Consumer<RegionsProvider>(
        builder: (context, provider, x) {
          return Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(30),
                  child: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
              ),
              CustomrTextFeild('الايميل', provider.emailController),
              CustomrTextFeild('كلمة المرور', provider.passwordController),
              CustomButton('تسجيل الدخول', provider.login),

            ],
          );
        },
      ),
    );
  }
}