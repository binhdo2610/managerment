import 'package:flutter/material.dart';
import 'package:managerment/LoginPage/login_page.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});
  @override
  State<ForgotPassPage> createState() => _ForgotpassScreenState();
}

class _ForgotpassScreenState extends State<ForgotPassPage> {
  static const Color _selectedColor = Colors.black;
  static const Color _unSelectedColor = Colors.grey;

  Color _emailTFColor = _unSelectedColor;
  final TextEditingController _emailTFController = TextEditingController();
  final FocusNode _emailTFFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailTFFocusNode.addListener(_onEmailTFFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _emailTFFocusNode.removeListener(_onEmailTFFocusChange);
    _emailTFFocusNode.dispose();
  }

  void _onEmailTFFocusChange() {
    setState(() {
      _emailTFFocusNode.hasFocus
          ? _emailTFColor = _selectedColor
          : _emailTFColor = _unSelectedColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 36),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/title3.jpg',
                  width: 400,
                  height: 170,
                ),
                const SizedBox(
                  height: 14,
                ),
                Image.asset(
                  'images/logo3.jpg',
                  width: 130,
                  height: 130,
                ),
                const SizedBox(
                  height: 14,
                ),
                Image.asset(
                  'images/forgotpass.jpg',
                  width: 150,
                  height: 25,
                ),
                const SizedBox(
                  height: 44,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: _emailTFColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _emailTFController,
                    focusNode: _emailTFFocusNode,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: _emailTFColor),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 50, 153, 236),
                      ),
                    ),
                    child: const Text('Start'),
                  ),
                ),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
