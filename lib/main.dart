import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:gqlapp/screen/home.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env.dev");
  await initHiveForFlutter();

  // await hc();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: null);

  static final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: HttpLink('${dotenv.env['API_URL']}/query'),
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          HomeScreen.path: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
