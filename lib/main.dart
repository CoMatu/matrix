import 'package:flutter/material.dart';
import 'package:neumorphic_design_app/presentation/pages/home_page_2.dart';
import 'package:neumorphic_design_app/presentation/providers/size_provider.dart';
import 'package:neumorphic_design_app/scrollTypeOne/page_transition.dart';
import 'package:neumorphic_design_app/scrollTypeOne/scroll_type_one.dart';
import 'package:neumorphic_design_app/scrollTypeOne/sizes.dart';
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

  int dimension = 5;
  double paddings = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SwitchListTile(
              //   value: isLine,
              //   onChanged: (bool newValue) {
              //     setState(() {
              //       isLine = newValue;
              //     });
              //   },
              //   title: Text('Листать одну строку'),
              // ),
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
                          setState(() {
                            dimension = int.parse(value);
                          });
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
                        decoration:
                            InputDecoration(hintText: 'Отступ в пикселях'),
                        onChanged: (value) {
                          setState(() {
                            paddings = double.parse(value);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // RaisedButton(
              //   onPressed: () =>
              //       pressButton(context, dimension, paddings, isLine),
              //   child: Text('OK'),
              // ),
              RaisedButton(
                onPressed: () {
                  Sizes().init(context);
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ScrollTypeOne(
                        dimension: dimension,
                        padding: paddings,
                      ),
                    ),
                  );
                },
                child: Text('OK'),
              ),
              // RaisedButton(
              //   onPressed: () {
              //     Sizes().init(context);
              //     Navigator.push(
              //       context,
              //       PageTransition(
              //         type: PageTransitionType.rightToLeft,
              //         child: HomePage4(
              //           dimensionWidth: 2,
              //           dimensionHeight: 5,
              //           padding: 4,
              //         ),
              //       ),
              //     );
              //   },
              //   child: Text('HomePage4'),
              // ),
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
