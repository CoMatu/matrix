import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/home3/home_page_3.dart';
import 'package:neumorphic_design_app/home3/home_page_4.dart';
import 'package:neumorphic_design_app/home3/page_transition.dart';
import 'package:neumorphic_design_app/home3/size_provider2.dart';
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

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  bool isLine = false;

  @override
  Widget build(BuildContext context) {
    int dimension = 1;
    double paddings = 0.03;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SwitchListTile(
                value: isLine,
                onChanged: (bool newValue) {
                  setState(() {
                    isLine = newValue;
                  });
                },
                title: Text('Листать одну строку'),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Введите размерность сетки'),
                        onChanged: (value) {
                          dimension = int.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Отступы от 0.01 до 0.15'),
                        onChanged: (value) {
                          paddings = double.parse(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () =>
                    pressButton(context, dimension, paddings, isLine),
                child: Text('OK'),
              ),
              RaisedButton(
                onPressed: () {
                  SizeProvider2().init(context);
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: HomePage3(
                        dimensionWidth: 4,
                        padding: 4,
                      ),
                    ),
                  );
                },
                child: Text('HomePage3'),
              ),
              RaisedButton(
                onPressed: () {
                  SizeProvider2().init(context);
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: HomePage4(
                        dimensionWidth: 2,
                        dimensionHeight: 5,
                        padding: 4,
                      ),
                    ),
                  );
                },
                child: Text('HomePage4'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pressButton(
      BuildContext context, int dimension, double paddings, bool isLine) {
    Provider.of<SizeProvider>(context, listen: false)
        .setCardSize(MediaQuery.of(context).size, dimension, paddings);
    Provider.of<SizeProvider>(context, listen: false).setCardSizeHorizontal(
        MediaQuery.of(context).size, dimension, paddings);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage2(dimension, isLine),
        ));
  }
}
