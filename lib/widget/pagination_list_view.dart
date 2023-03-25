import 'package:flutter/material.dart';
import 'package:gqlapp/model/item/item.dart';
import 'package:gqlapp/widget/center_wrapper.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef CreateFetchMoreOptions = FetchMoreOptions Function({required int from});

class MyGql {
  MyGql({
    this.fetchMore,
    required this.result,
  });
  final QueryResult result;
  final FetchMore? fetchMore;
}

class CharacterListView extends StatefulWidget {
  const CharacterListView({super.key, required this.mygql});
  final MyGql mygql;

  @override
  CharacterListViewState createState() => CharacterListViewState();
}

class CharacterListViewState extends State<CharacterListView> {
  late MyGql myGql;
  final PagingController<int, Item> pagingController =
      PagingController(firstPageKey: 0);

  FetchMoreOptions createFetchMoreOptions({required int from}) {
    return FetchMoreOptions(
      variables: {'nfrom': from},
      updateQuery: (_, res) {
        List<Item> items =
            parseListItems(rawDataList: res?["getItemWithPagination"]["items"]);
        pagingController.appendPage(items, items.last.id);

        return;
      },
    );
  }

  @override
  void initState() {
    myGql = widget.mygql;
    pagingController.addPageRequestListener(
      (pageKey) => myGql.fetchMore!(createFetchMoreOptions(from: pageKey)),
    );

    super.initState();
  }

  List<Item> parseListItems({required List<dynamic> rawDataList}) {
    return rawDataList.map<Item>((res) => Item.fromJson(res)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final QueryResult<Object?> result = myGql.result;

    if (result.isLoading && pagingController.itemList == null) {
      return const CenterWrapper(children: CircularProgressIndicator());
    }

    if (result.isLoading && pagingController.itemList == null) {
      return const CenterWrapper(children: CircularProgressIndicator());
    }

    if (result.hasException) {
      return CenterWrapper(children: Text(result.exception.toString()));
    }

    if (result.data == null) {
      return const CenterWrapper(children: Text("Data is empty"));
    }

    List<Item> items = parseListItems(
        rawDataList: result.data?["getItemWithPagination"]["items"]);

    if (pagingController.itemList == null) {
      pagingController.appendPage(items, items.last.id);
    }

    return PagedListView<int, Item>(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<Item>(
        itemBuilder: (context, item, index) => ListTile(
          title: Text(item.text),
          subtitle: Text(item.id.toString()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
