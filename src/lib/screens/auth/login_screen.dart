import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:src/provider/auth_provider.dart';
import 'package:src/screens/home/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  String? _error;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
        _error = null;
      });

      try {
        final userId = await Provider.of<AuthProvider>(context, listen: false)
            .getUserId(_emailController.text, _passwordController.text);

        debugPrint("Logged in user ID: $userId");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>const DashboardScreen()),
        );
        
      } catch (e) {
        setState(() => _error = e.toString().replaceAll('Exception: ', ''));
      }

      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Login",
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  if (_error != null)
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => value!.isEmpty ? 'Enter email' : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter password' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loading ? null : _handleLogin,
                    child: _loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
