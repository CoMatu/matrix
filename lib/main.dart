import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/presentation/pages/home_page.dart';
import 'package:neumorphic_design_app/presentation/pages/home_page_2.dart';
import 'package:neumorphic_design_app/presentation/providers/size_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SizeProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: StartPage());
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int dimension = 1;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(hintText: 'Введите размерность сетки'),
                    onChanged: (value) {
                      dimension = int.parse(value);
                    },
                  ),
                ),
                RaisedButton(
                  onPressed: () => pressButton(context, dimension),
                  child: Text('OK'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pressButton(BuildContext context, int dimension) {
    Provider.of<SizeProvider>(context, listen: false)
        .setCardSize(MediaQuery.of(context).size, dimension);
    Provider.of<SizeProvider>(context, listen: false)
        .setCardSizeHorizontal(MediaQuery.of(context).size, dimension);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage2(dimension),
        ));
  }
}
