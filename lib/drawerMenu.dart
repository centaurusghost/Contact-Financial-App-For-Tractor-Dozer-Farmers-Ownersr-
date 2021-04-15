import 'package:clean_app/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/UnpaidContacts.dart';
import 'package:page_transition/page_transition.dart';
import 'ascendingNotPaid.dart';
import 'CompletePaid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clean_app/SOrtName.dart';

class DrawerMenu extends StatelessWidget {
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  void _showDialog(BuildContext context, double wide) {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: (wide - 200) / 2,
            child: AlertDialog(
              title: new Text("Details!!"),
              backgroundColor: Colors.white,
              content: new Text(
                "Developed by: Ozone Wagle \nContact:",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'VisbyRound',
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              actions: <Widget>[
                Row(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/myself.png",
                        scale: 5,
                      ),
                    ),
                    GestureDetector(
                      child: Image.asset(
                        "assets/facebook.png",
                        scale: 8,
                      ),
                      onTap: () {
                        //facebook
                        const url = 'https://facebook.com/ozone.wagle';
                        customLaunch(url);
                      },
                    ),
                    //SizedBox(width: 50),

                    GestureDetector(
                      child: Image.asset(
                        "assets/gmail.png",
                        scale: 10,
                      ),
                      onTap: () {
                        //facebook
                        customLaunch(
                            'mailto:ozonewagle998@gmail.com?subject=About_App%20subject&body=app%20body');
                      },
                    ),
                    Container(
                      width: (wide - 275) / 2,
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.deepPurple,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      // width: 100,
                      height: 130,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        image: DecorationImage(
                          image: ExactAssetImage(
                            "assets/mama.png",
                          ),
                          // alignment: Alignment.centerRight,
                          //fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Text(
                      "Prem Narayan Khanal",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'VisbyRound',
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "                       9816252504  ",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'VisbyRound',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.dialer_sip_sharp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "    premkhanal1000@gmail.com    ",
                          style: TextStyle(
                            fontFamily: 'VisbyRound',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.email_outlined, color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.deepPurple,),
              trailing: Icon(
                Icons.list_alt,
                size: 30,
              ),
              title: Text(
                'Home | Main List',
                style: TextStyle(fontSize: 16,fontFamily: 'VisbyRound', fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, alignment: Alignment.center, child: MainMenu()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.deepPurple,),
              title: Text(
                'कत्ती पनि नतिरेका',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              trailing: Image.asset(
                'assets/moneyicon.png',
                scale: 7,
              ),
// tileColor: Colors.grey,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, alignment: Alignment.center, child: UnpaidContacts()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.deepPurple,),
              title: Text(
                'धेरै तिर्न बाकी',
                style: TextStyle(fontSize: 17,fontFamily: 'VisbyRound', fontWeight: FontWeight.w600),
              ),
              trailing: Image.asset(
                'assets/moneyicon.png',
                scale: 7,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, alignment: Alignment.center, child: ascendingNotpaid()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.deepPurple,),
              title: Text(
                'पुरा तिरेका ',
                style: TextStyle(fontSize: 17, fontFamily: 'VisbyRound',fontWeight: FontWeight.w600),
              ),
              trailing: Image.asset(
                'assets/moneyicon.png',
                scale: 7,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, alignment: Alignment.center, child: CompletePaid()));

              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.deepPurple,),
              title: Text(
                'Sort By Name',
                style: TextStyle(fontSize: 16, fontFamily: 'VisbyRound', fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.people,
                size: 30,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, alignment: Alignment.center, child: SortName()));

              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.deepPurple,),
              title: Text(
                'About Application',
                style: TextStyle(fontSize: 16,fontFamily: 'VisbyRound', fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.quick_contacts_dialer_sharp,),
              onTap: () {
                _showDialog(context, Width);
              },
            ),
          ],
        ),
      ),
    );
  }
}
