import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kalkulatorzakat/utils/constants.dart' as Constants;

class DeveloperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
              Constants.currentPage = Constants.CALCULATOR_PAGE,
              Navigator.of(context).pop()
            },
          ),
          title: Text("Developer"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 120,
                    child: Image.network(
                      'https://2.bp.blogspot.com/-WrDIrSd8rXE/UoWrx1lMlCI/AAAAAAAAAB4/Jrw0w4MJCsE/s1600/Kaito_Kuroba_Avatar_by_Phantom_Akiko.jpg',
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Maulana Firdaus"),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: _launchURL,
                    color: Colors.black45,
                    child: Text(
                      "Github".toUpperCase(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
          ),
        ));
  }
}

// Group of EVENT / Method
_launchURL() async {
  const url = 'https://github.com/firdausmaulan?tab=repositories';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
