import 'package:flutter/material.dart';
import 'package:flutter_jwt_example/core/view_models/auth_vm.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        elevation: 0,
        actions: [logoutButton()],
      ),
      body: Center(
        child: authVM.getIsLoading
            ? const CircularProgressIndicator()
            : const Text('Welcome Home'),
      ),
    );
  }

  Widget logoutButton() {
    return IconButton(
      onPressed: () => Provider.of<AuthVM>(context, listen: false).logout(),
      icon: const Icon(Icons.logout_outlined),
      splashRadius: 20,
    );
  }
}
