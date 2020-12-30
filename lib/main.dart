import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(title: '計算機'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String processText = '0';
  String resultText = '0';
  String inputOp = '';
  int inputNum = 0;
  double tmpInputNum = 0.0;
  double outputNum = 0.0;
  bool isFloat = false;

  /// 螢幕寬度
  double phoneWidth = 600;

  /// 螢幕高度
  double phoneHeight = 400;

  List<Widget> RowRWD_9_3(Widget widgetLeft, Widget widgetRight) {
    List<Widget> gameCells = [
      Container(width: phoneWidth / 12 * 9, child: widgetLeft),
      Container(width: phoneWidth / 12 * 3, child: widgetRight),
    ];
    return gameCells;
  }

  /// 空按鈕
  Widget emptyBtn() {
    return SizedBox(
      width: phoneWidth * 0.25,
      height: phoneHeight * 0.1,
      child: OutlineButton(onPressed: () {}),
    );
  }

  /// 數字按鈕
  Widget numBtn(int inputNum) {
    return SizedBox(
      width: phoneWidth * 0.25,
      height: phoneHeight * 0.1,
      child: OutlineButton(
          borderSide: BorderSide(width: 1.0),
          child: Text(inputNum.toString()),
          onPressed: (() {
            setState(() {
              if (tmpInputNum == null) {
                tmpInputNum = 0;
                resultText = '';
              }

              if (isFloat) {
                tmpInputNum = tmpInputNum + inputNum * 0.1;
              } else {
                tmpInputNum = tmpInputNum * 10 + inputNum;
              }

              if (resultText == '0') {
                resultText = '' + inputNum.toString();
              } else {
                resultText = resultText + inputNum.toString();
              }
            });
          })),
    );
  }

  /// 邏輯按鈕
  Widget operatorBtn(String op) {
    return SizedBox(
      width: phoneWidth * 0.25,
      height: phoneHeight * 0.1,
      child: OutlineButton(
          borderSide: BorderSide(width: 1.0),
          child: Text(op),
          onPressed: (() {
            setState(() {
              if (inputOp == null || inputOp.trim() == '') {
                inputOp = op;
              }
              if (tmpInputNum == null) {
                ;
              } else if (inputOp == '+') {
                outputNum += tmpInputNum;
              } else if (inputOp == '-') {
                outputNum -= tmpInputNum;
              } else if (inputOp == '*') {
                outputNum *= tmpInputNum;
              } else if (inputOp == '/') {
                outputNum /= tmpInputNum;
              } else if (inputOp == '=') {
                ;
              }
              resultText = (isFloat
                  ? outputNum.toString()
                  : outputNum.toInt().toString());

              inputOp = op;
              if (inputOp == '=') {
                processText = '';
                inputOp = '';
                tmpInputNum = null;
                outputNum = 0.0;
                isFloat = false;
                return;
              }

              if (tmpInputNum == null) {
                processText =
                    processText.substring(0, processText.length - 1) + inputOp;
              } else {
                if (processText == '0') {
                  processText = '' +
                      (isFloat
                          ? tmpInputNum.toString()
                          : tmpInputNum.toInt().toString()) +
                      inputOp;
                } else {
                  processText = processText +
                      (isFloat
                          ? tmpInputNum.toString()
                          : tmpInputNum.toInt().toString()) +
                      inputOp;
                }
              }
              tmpInputNum = null;
            });
          })),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    phoneWidth = width;
    phoneHeight = height;
    print(phoneHeight * 0.25);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: phoneHeight * 0.25,
            child: Text(
              '$processText',
              style: TextStyle(color: Colors.grey, fontSize: 30),
            ),
          ),
          SizedBox(
            height: phoneHeight * 0.1,
            child: Text(
              '$resultText',
              style: TextStyle(color: Colors.grey, fontSize: 30),
            ),
          ),
          Row(
            children: RowRWD_9_3(
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      emptyBtn(),
                      emptyBtn(),
                      emptyBtn(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      numBtn(7),
                      numBtn(8),
                      numBtn(9),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      numBtn(4),
                      numBtn(5),
                      numBtn(6),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      numBtn(1),
                      numBtn(2),
                      numBtn(3),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      emptyBtn(),
                      numBtn(0),
                      emptyBtn(),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      operatorBtn('/'),
                      operatorBtn('*'),
                      operatorBtn('-'),
                      operatorBtn('+'),
                      operatorBtn('='),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
