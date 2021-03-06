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
              Constants.currentPage = Constants.DEVELOPER_PAGE;
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
              maxLength: 15,
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
              maxLength: 15,
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
              maxLength: 15,
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
              maxLength: 15,
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
      monthlySalary = getIntValue(tfSalaryController);
      otherIncome = getIntValue(tfOtherIncomeController);
      monthlyInstallment = getIntValue(tfInstallmentController);
      double alms = 0.025 * (monthlySalary + otherIncome - monthlyInstallment);
      monthlyAlm = alms.round();
      tfAlmController.text = monthlyAlm.toString();
    });
  }

  int getIntValue(MoneyMaskedTextController controller) {
    return int.tryParse(controller.text.replaceAll(".", "")) ?? 0;
  }

  bool backInterceptor(bool stopDefaultButtonEvent) {
    if (Constants.currentPage == Constants.CALCULATOR_PAGE &&
        !ExitDialog.isDialogShowing) {
      ExitDialog.isDialogShowing = true;
      ExitDialog.showExitDialog(context);
    } else {
      Constants.currentPage = Constants.CALCULATOR_PAGE;
      ExitDialog.isDialogShowing = false;
      Navigator.pop(context);
    }
    return true;
  }
}
