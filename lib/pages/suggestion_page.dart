import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedbackDialog extends StatefulWidget {
  static const routeName = 'suggestion';
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إقترحات وشكاوي'),
        backgroundColor: Colors.teal,
      ),
      // alignment: ,
      body: AlertDialog(
        alignment: Alignment.topCenter,
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: 'ادخل إقتراحك هنا',
              // filled: true,
            ),
            maxLines: 5,
            maxLength: 4096,
            textInputAction: TextInputAction.done,
            validator: (String? text) {
              if (text == null || text.isEmpty) {
                return 'من فضلك ادخل اقتراحك';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            child: const Text('اغلاق',
              style: TextStyle(color: Colors.teal),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('ارسال',
              style: TextStyle(color: Colors.teal),
            ),

            onPressed: () async {
              // Only if the input form is valid (the user has entered text)
              if (_formKey.currentState!.validate()) {
                // We will use this var to show the result
                // of this operation to the user
                String message;

                try {
                  // Get a reference to the `feedback` collection
                  final collection =
                  FirebaseFirestore.instance.collection('feedback');

                  // Write the server's timestamp and the user's feedback
                  await collection.doc().set({
                    'timestamp': FieldValue.serverTimestamp(),
                    'feedback': _controller.text,
                  });

                  message = 'Feedback sent successfully';
                } catch (e) {
                  message = 'Error when sending feedback';
                }

                // Show a snackbar with the result
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}


