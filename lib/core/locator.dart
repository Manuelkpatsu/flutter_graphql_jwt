import 'package:flutter_jwt_example/core/query/queries.dart';
import 'package:get_it/get_it.dart';

import 'services/auth_service.dart';
import 'services/graphql_config.dart';
import 'storage/fs_storage.dart';
import 'storage/secure_storage.dart';
import 'view_models/auth_vm.dart';

GetIt sl = GetIt.instance;

void setUpLocator() {
  sl.registerLazySingleton<SecureStorage>(() => FSStorage());
  sl.registerLazySingleton(() => GraphQLConfiguration());
  sl.registerLazySingleton(() => QueriesMutations());
  sl.registerLazySingleton(() => AuthService());
  sl.registerLazySingleton(() => AuthVM());
}
