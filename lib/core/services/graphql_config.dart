import "package:flutter/material.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class GraphQLConfiguration {
  static Link? link;
  static HttpLink httpLink = HttpLink("pass link to your graphql server here");

  void setToken(String token) {
    AuthLink alink = AuthLink(getToken: () async => 'Bearer ' + token);
    GraphQLConfiguration.link = alink.concat(GraphQLConfiguration.httpLink);
  }

  void removeToken() {
    GraphQLConfiguration.link = null;
  }

  static Link getLink() {
    if (GraphQLConfiguration.link != null) {
      return GraphQLConfiguration.link!;
    } else {
      return GraphQLConfiguration.httpLink;
    }
  }

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: getLink(),
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(),
      link: getLink(),
    );
  }
}
