import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalkulatorzakat/utils/constants.dart' as Constants;
import 'package:kalkulatorzakat/utils/images.dart' as Images;

bool isDialogShowing = false;

void showExitDialog(context) {
  double width = MediaQuery.of(context).size.width;
  double buttonWidth = width / 3;
  showModalBottomSheet<dynamic>(
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
    ),
    context: context,
    builder: (context) => Wrap(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Image.asset(Images.ic_question),
              SizedBox(height: 10),
              Text("Apakah Anda yakin untuk keluar?"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: buttonWidth,
                    child: OutlineButton(
                        onPressed: () async {
                          isDialogShowing = false;
                          Navigator.pop(context);
                        },
                        borderSide: BorderSide(color: Constants.PRIMARY_COLOR),
                        child: Text(
                          "Tidak".toUpperCase(),
                          style: TextStyle(
                              color: Constants.PRIMARY_COLOR,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                      width: buttonWidth,
                      child: RaisedButton(
                          onPressed: () async {
                            SystemNavigator.pop();
                          },
                          color: Constants.PRIMARY_COLOR,
                          child: Text(
                            "Ya".toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )))
                ],
              )
            ],
          ),
        ),
      ],
    ));
}
