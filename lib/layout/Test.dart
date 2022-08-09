import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/components/components.dart';

class Test extends StatelessWidget {
  late dynamic emaileController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
      ),
      body: Column(
        children: [
          defaultButton(
            background: Colors.amber,
            function: () {},
            text: "sign up",
            width: 202.0,
          ),
          defaultFormField(
            prefix: Icons.email,
            text: "EMAIL",
            type: TextInputType.emailAddress,
            validate: (value) {
              if (value.isEmpty) {
                return 'email must be empty';
              }
              return null;
            },
            onChange: () {},
            onSubmit: () {},
            ontap: () {},
          ),
        ],
      ),
    );
  }
}
