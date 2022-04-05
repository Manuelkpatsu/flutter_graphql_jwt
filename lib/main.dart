import 'package:flutter/material.dart';
import 'package:flutter_jwt_example/core/services/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'core/locator.dart';
import 'core/view_models/auth_vm.dart';
import 'router.dart';
import 'view/screens/home_screen.dart';
import 'view/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setUpLocator();

  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GraphQLConfiguration graphQLConfig = GraphQLConfiguration();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthVM>(create: (_) => AuthVM()),
      ],
      child: Consumer<AuthVM>(builder: (context, AuthVM authVM, Widget? child) {
        return GraphQLProvider(
          client: graphQLConfig.client,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: FutureBuilder(
              future: authVM.isLoggedIn,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == false) {
                    return const LoginScreen();
                  } else {
                    return const HomeScreen();
                  }
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                return const LoginScreen();
              },
            ),
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
      }),
    );
  }
}
