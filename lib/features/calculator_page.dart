import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalkulatorzakat/features/developer_page.dart';
import 'package:kalkulatorzakat/utils/constants.dart' as Constants;
import 'package:kalkulatorzakat/utils/flutter_masked_text.dart';
import 'package:kalkulatorzakat/features/exit_dialog.dart' as ExitDialog;

class CalculatorPage extends StatefulWidget {
  CalculatorPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Group of VARIABLE
  int monthlySalary = 0;
  int otherIncome = 0;
  int totalIncome = 0;
  int monthlyInstallment = 0;
  int monthlyAlm = 0;

  // Group of CONTROLLER
  final tfSalaryController = MoneyMaskedTextController();
  final tfOtherIncomeController = MoneyMaskedTextController();
  final tfInstallmentController = MoneyMaskedTextController();
  final tfAlmController = MoneyMaskedTextController();

  @override
  void initState() {
    BackButtonInterceptor.add(backInterceptor);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(backInterceptor);
    tfSalaryController.dispose();
    tfOtherIncomeController.dispose();
    tfInstallmentController.dispose();
    tfAlmController.dispose();
    super.dispose();
  }

  // Group of UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeveloperPage()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            TextField(
              controller: tfSalaryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "Gaji Per Bulan",
                  hintText: "0",
                  prefixText: Constants.CURRENCY),
            ),
            SizedBox(height: 20),
            TextField(
              controller: tfOtherIncomeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "Pendapatan lain",
                  hintText: "0",
                  prefixText: Constants.CURRENCY),
            ),
            SizedBox(height: 20),
            TextField(
              controller: tfInstallmentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "Hutang / Cicilan",
                  hintText: "0",
                  prefixText: Constants.CURRENCY),
            ),
            SizedBox(height: 20),
            TextField(
              controller: tfAlmController,
              readOnly: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Zakat Anda",
                  hintText: "0",
                  prefixText: Constants.CURRENCY),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: _countMonthlyAlms,
                color: Constants.PRIMARY_COLOR,
                child: Text(
                  "Hitung Zakat".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Group of EVENT METHOD
  void _countMonthlyAlms() {
    setState(() {
      monthlySalary =
          int.tryParse(tfSalaryController.text.replaceAll(".", "")) ?? 0;
      otherIncome =
          int.tryParse(tfOtherIncomeController.text.replaceAll(".", "")) ?? 0;
      monthlyInstallment =
          int.tryParse(tfInstallmentController.text.replaceAll(".", "")) ?? 0;
      double alms = 0.025 * (monthlySalary + otherIncome - monthlyInstallment);
      monthlyAlm = alms.round();
      tfAlmController.text = monthlyAlm.toString();
    });
  }

  bool backInterceptor(bool stopDefaultButtonEvent) {
    ExitDialog.showExitDialog(context);
    return true;
  }
}
