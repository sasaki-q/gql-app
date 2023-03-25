import 'package:flutter/material.dart';
import 'package:gqlapp/query.dart';
import 'package:gqlapp/widget/pagination_list_view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: null);
  static const String path = "/";

  static final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        centerTitle: true,
      ),
      body: Query(
        options: QueryOptions(
          variables: const {'nfrom': 0},
          document: gql(getItemsWithPagination),
        ),
        builder: (
          QueryResult result, {
          VoidCallback? refetch,
          FetchMore? fetchMore,
        }) =>
            CharacterListView(
          mygql: MyGql(
            result: result,
            fetchMore: fetchMore,
          ),
        ),
      ),
    );
  }
}
