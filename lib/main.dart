import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // everything in flutter is a widget including this MyApp class; and every widget has a build() method; widgets are in a form of methods and these widgets gets nested. Typical functional programming;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // ChangeNotifier is a: state management
  // property
  var current = WordPair.random();

  // method
  void getNext() {
    current = WordPair.random();
    notifyListeners(); // state management thanks to ChangeNotifier
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context
        .watch<MyAppState>(); // watches reference of the MyAppState Class
    var pair = appState.current; // section 5 new add;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('A random idea: randomly ngek ngek'),
            // Text(appState.current.asLowerCase),
            // Text(pair
            //     .asLowerCase), // section 5 new add; pair. references the appstate declared above;
            BigCard(pair: pair),
            ElevatedButton(
                onPressed: () {
                  // print("This button has been pressedasadasdasd");
                  appState
                      .getNext(); // section 4: check MyAappState class method;
                },
                child: Text("NEXT!"))
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      // section 5: "!" or exclamation operator indicates for null safety operator
      color: theme.colorScheme.onPrimary,
    );

    // return Text(pair.asLowerCase);
    return Card(
      color: theme.colorScheme
          .primary, // section 5: uses the primary color of this application
      child: Padding(
          padding: const EdgeInsets.all(20),
          // child: Text(pair.asLowerCase),
          // child: Text(pair.asLowerCase, style: style),
          child: Text(
            pair.asLowerCase,
            style: style,
            semanticsLabel: '${pair.first} ${pair.second}',
          )),
    );
  }
}
