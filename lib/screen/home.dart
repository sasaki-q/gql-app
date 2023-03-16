import 'package:flutter/material.dart';
import 'package:gqlapp/model/item/item.dart';
import 'package:gqlapp/query.dart';
import 'package:gqlapp/widget/center_wrapper.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: null);
  static const String path = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        centerTitle: true,
      ),
      body: Query(
        options: QueryOptions(document: gql(getItems)),
        builder: (
          QueryResult result, {
          VoidCallback? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.isLoading) {
            return const CenterWrapper(children: CircularProgressIndicator());
          }

          if (result.hasException) {
            return CenterWrapper(children: Text(result.exception.toString()));
          }

          if (result.data == null) {
            return const CenterWrapper(children: Text("Data is empty"));
          }

          List<Item> items = result.data?["getItems"]
              .map<Item>((res) => Item.fromJson(res))
              .toList();

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, i) => ListTile(
              title: Text(items[i].text),
              subtitle: Text(items[i].id),
            ),
          );
        },
      ),
    );
  }
}
