class QueriesMutations {
  String loginMutation = """
      mutation login(\$password : String!, \$username : String!) {
          login(password : \$password, username : \$username){
            username
            profile {
              id
              firstName
              lastName
              fullName
            }
          }
      }    
     """;
}
