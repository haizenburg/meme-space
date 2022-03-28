import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memespace/resources/auth_methods.dart';
import 'package:memespace/responsive/mobileLayout.dart';
import 'package:memespace/responsive/responsive_layout_screen.dart';
import 'package:memespace/responsive/webLayout.dart';
import 'package:memespace/screens/login_screen.dart';
import 'package:memespace/utils/colors.dart';
import 'package:memespace/utils/utils.dart';
import 'package:memespace/widgets/text_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void _selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        password: _passwordController.text,
        file: _image!);

    setState(() {
      _isLoading = false;
    });

    if (res != 'successful') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const ResponsiveLayout(
          mobileScreenLayout: MobileLayout(),
          webScreenLayout: WebLayout(),
        );
      }));
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //app logo (svg)
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),

            const SizedBox(
              height: 24,
            ),
            //circular widget accepting selected file
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://i.kym-cdn.com/entries/icons/facebook/000/017/618/pepefroggie.jpg'),
                      ),
                Positioned(
                    left: 80,
                    bottom: -10,
                    child: IconButton(
                      onPressed: () => _selectImage(),
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: blueColor,
                      ),
                    ))
              ],
            ),

            const SizedBox(
              height: 24,
            ),

            //uname text field
            TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Interweebs username',
                textInputType: TextInputType.text),

            const SizedBox(
              height: 24,
            ),

            //text field input for email
            TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter email',
                textInputType: TextInputType.emailAddress),

            const SizedBox(
              height: 24,
            ),
            //passw text field

            TextFieldInput(
              textEditingController: _passwordController,
              hintText: 'Enter password',
              textInputType: TextInputType.text,
              isPass: true,
            ),

            const SizedBox(
              height: 24,
            ),
//bio text field
            TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Tell the interweebs people about yeeself ...',
                textInputType: TextInputType.text),

            const SizedBox(
              height: 25,
            ),

            //login butoon
            InkWell(
              onTap: () => _signUp(),
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Sign Up'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    color: blueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)))),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //transition to sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Already have an account "),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    child: const Text(
                      "Log in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
