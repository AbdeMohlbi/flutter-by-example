import 'package:flutter/material.dart';

void main() {
  runApp(TextFieldExampleApp());
}

class TextFieldExampleApp extends StatelessWidget {
  const TextFieldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Multi-Line Text Field Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Text Fields')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleLineTextFieldWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiLineTextFieldAndButtonWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleLineTextFieldWidget extends StatelessWidget {
  const SingleLineTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: TextField(
        autocorrect: false,
        decoration: InputDecoration(hintText: 'Enter text; return submits'),
        onChanged: (str) => print('Single-line text change: $str'),
        onSubmitted: (str) => _showInSnackBar(context, str),
      ),
    );
  }
}

/// Displays text in a snackbar
void _showInSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

/// Multi-line text field widget with a submit button
class MultiLineTextFieldAndButtonWidget extends StatefulWidget {
  const MultiLineTextFieldAndButtonWidget({super.key});

  @override
  createState() => _TextFieldAndButtonState();
}

class _TextFieldAndButtonState
    extends State<MultiLineTextFieldAndButtonWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Enter text; return doesn\'t submit',
            ),
            onChanged: (str) => print('Multi-line text change: $str'),
            onSubmitted: (str) =>
                print('This will not get called when return is pressed'),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () => _showInSnackBar(context, _controller.text),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
