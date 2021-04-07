import 'package:clean_app/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/UnpaidContacts.dart';
import 'ascendingNotPaid.dart';
import 'CompletePaid.dart';



class DrawerMenu extends StatelessWidget {





  @override
  Widget build(BuildContext context) {
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
              'Home Or Main List',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            trailing: Image.asset('assets/moneyicon.png',scale: 5,),
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            trailing: Image.asset('assets/moneyicon.png',scale: 5,),
// tileColor: Colors.grey,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text(
              'पुरा तिरेका ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            trailing: Image.asset('assets/moneyicon.png',scale: 5,),
// tileColor: Colors.grey,
            onTap: () {
              Navigator.pop(context);
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
