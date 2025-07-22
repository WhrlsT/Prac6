import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //Local Variables
  double _loanAmount = 0.0;
  double _netIncome = 0.0;
  double _interestRate = 0.0;
  int _loanPeriod = 1;
  bool _hasGuarantor = false;
  int _carType = 1; // 1 new , 2 = used
  double _repaymentAmount = 0.0;
  String _repaymentOutput = '';
  final _years = [1,2,3,4,5,6,7,8,9];

  //Controllers
  final loanAmountCtrl = TextEditingController();
  final netIncomeCtrl = TextEditingController();
  final interestRateCtrl = TextEditingController();

  //Set Focus
  final _myFocusNode = FocusNode();

  //Format Output
  final myCurrency = intl.NumberFormat('#,##0.00', 'ms_MY');

  //Form Controller
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Form(
        key:_formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),

            ],
          ),
        ),
      ),
    );
  }

  void myAlertDialog() {
    AlertDialog eligibilityAlertDialog = AlertDialog(
      title: const Text('Eligibility'),
      content: const Text('You are not lgbt for this loan'
          'Get a guarantor to proceed'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'))
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return eligibilityAlertDialog;
        }
    );
  }

  void _calculateRepayment() {
    _loanAmount = double.tryParse(loanAmountCtrl.text)!;
    _netIncome = double.tryParse(netIncomeCtrl.text)!;
    _interestRate = double.tryParse(interestRateCtrl.text)!;

    var interest = _loanAmount * _loanPeriod * (_interestRate / 100);
    _repaymentAmount = (_loanAmount + interest) / (_loanPeriod * 12 );

    bool eligible = _netIncome * 0.3 >= _repaymentAmount;

    if (eligible || _hasGuarantor) {
      // WHENEVER UI CHANGE, PUT IN SET STATE
      setState(() {
        _repaymentAmount = 'Repayment Amount : '
                           '${myCurrency.currencySymbol}'
                           '${myCurrency.format(_repaymentAmount)}'
                           '\n'
                           'Eligibility : ${eligible? 'Eligible' : 'Not Eligible'}' as double;
      });
    }

  }
}
