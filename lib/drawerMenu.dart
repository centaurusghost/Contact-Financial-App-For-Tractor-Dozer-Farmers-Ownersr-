import 'package:clean_app/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/UnpaidContacts.dart';
import 'ascendingNotPaid.dart';
import 'CompletePaid.dart';
import 'package:url_launcher/url_launcher.dart';


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
              content: new Text("Developed by:- Ozone Wagle \nContact:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              ),
              actions: <Widget>[
            Row(
            children:[
                // Container(
                //   width: (wide-300)/2,
                // ),
              Container( child:
              Image.asset("assets/myself.png",scale: 5,),),
               GestureDetector(child:Image.asset("assets/facebook.png",scale: 8,),
               onTap: (){
                 //facebook
                 customLaunch("https://www.facebook.com/ozone.wagle");
               },
               ),
                //SizedBox(width: 50),


                GestureDetector(child:Image.asset("assets/gmail.png",scale: 10,),
                  onTap: (){
                    //facebook
                    customLaunch('mailto:ozonewagle998@gmail.com?subject=About_App%20subject&body=app%20body');
                  },
                ),
                Container(
                  width: (wide-275)/2,
                ),
],
            ),],
            ));
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blue,
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
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "                       9816252504  ",
                        style: TextStyle(
                          fontSize: 15,
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
                        "      premkhanal1000@gmail.com    ",
                        style: TextStyle(
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
          // Container(
          //   height: 2,
          //   color: Colors.redAccent,
          // ),
          ListTile(
            leading: Icon(Icons.account_balance),
            trailing: Icon(Icons.list_alt, size: 30,),
            title: Text(
              'Home | Main List',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            //trailing: Image.asset('assets/moneyicon.png'),
// tileColor: Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainMenu()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text(
              'कत्ती पनि नतिरेका',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            trailing: Image.asset('assets/moneyicon.png',scale: 7,),
// tileColor: Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UnpaidContacts()),
              );
              //Navigator.pop(context);
            },
          ),
          // Container(
          //   height: 2,
          //   color: Colors.redAccent,
          // ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text(
              'धेरै तिर्न बाकी',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            trailing: Image.asset('assets/moneyicon.png',scale: 7,),
// tileColor: Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ascendingNotpaid()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text(
              'पुरा तिरेका ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            trailing: Image.asset('assets/moneyicon.png',scale: 7,),
// tileColor: Colors.grey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompletePaid()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text(
              'About Application',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            trailing: Icon(Icons.quick_contacts_dialer_sharp),
// tileColor: Colors.grey,
            onTap: () {
              _showDialog(context, Width);


            },
          ),
          // Container(
          //   height: 2,
          //   color: Colors.redAccent,
          // ),
        ],
      ),
    );
  }
}
