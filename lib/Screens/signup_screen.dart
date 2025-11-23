import 'package:flutter/material.dart';
import '../widgets/custom_input_decoration.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = "/signup";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  String username = "";
  String email = "";
  String password = "";
  String birthdate = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.blue,
      ),

      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [

            // IMAGE DU HAUT
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Image.asset("assets/insat.png", width: 200),
              ),
            ),

            // USERNAME
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "UserName",
                  "Enter your UserName",
                  const Icon(Icons.person_outline),
                ).customInputDecoration(),

                onSaved: (value) => username = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "UserName should not be empty";
                  }
                  return null;
                },
              ),
            ),

            // EMAIL
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "Email",
                  "Enter your Email",
                  const Icon(Icons.email_outlined),
                ).customInputDecoration(),

                onSaved: (value) => email = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!value.contains("@")) {
                    return "Invalid email format";
                  }
                  return null;
                },
              ),
            ),

            // PASSWORD
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                obscureText: true,
                decoration: CustomInputDecoration(
                  "Password",
                  "Enter your Password",
                  const Icon(Icons.lock_outline),
                ).customInputDecoration(),

                onSaved: (value) => password = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                  return null;
                },
              ),
            ),

            // BIRTHDATE
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "Birthdate",
                  "dd/mm/yyyy",
                  const Icon(Icons.calendar_month),
                ).customInputDecoration(),

                onSaved: (value) => birthdate = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Birthdate is required";
                  }
                  return null;
                },
              ),
            ),

            // ADDRESS
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextFormField(
                decoration: CustomInputDecoration(
                  "Address",
                  "Enter your Address",
                  const Icon(Icons.home_outlined),
                ).customInputDecoration(),

                onSaved: (value) => address = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Address is required";
                  }
                  return null;
                },
              ),
            ),

            // SUBMIT BUTTON
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("SignUp"),
                      content: const Text(
                          "User added successfully! Check your inbox"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, '/bottomNavBar');
                          },
                          child: const Text("Continue to Books"),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
