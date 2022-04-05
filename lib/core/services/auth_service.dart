import 'package:flutter_jwt_example/core/query/queries.dart';
import 'package:flutter_jwt_example/core/services/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../locator.dart';

class AuthService {
  final GraphQLConfiguration _graphQLConfig = sl<GraphQLConfiguration>();
  final QueriesMutations _queryMutation = sl<QueriesMutations>();

  // Login
  Future<String> login(String username, String password) async {
    try {
      GraphQLClient _client = _graphQLConfig.clientToQuery();
      QueryResult result = await _client.mutate(
        MutationOptions(
          document: gql(
            _queryMutation.loginMutation,
          ),
          variables: {
            "password": password,
            "username": username,
          },
        ),
      );

      if (result.hasException) {
        throw 'Sorry, an error occured. Please try again!';
      } else {
        String? authToken = result.context
            .entry<HttpLinkResponseContext>()!
            .headers['set-cookie'];
        var splitString = authToken!.split('=');
        _graphQLConfig.setToken(splitString[1].split(';;')[0]);
        return splitString[1].split(';;')[0];
      }
    } catch (e) {
      rethrow;
    }
  }
}
