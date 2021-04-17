import 'package:clean_app/MainMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clean_app/Contact.dart';
import 'package:clean_app/DatabaseHelper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';

class DataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
  Contact contact;

  DataPage({this.contact});
}

class _State extends State<DataPage> {
  DatabaseHelper helper = DatabaseHelper();
  Contact contact;
  int raw = 0, total = 0, remaining = 0, numOne = 0;
  int numTwo = 1, rawTotal = 2;
  String totalOne = 'a', totalTwo = 'b';
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
    contact = widget.contact ?? Contact();

    nameController.text = contact.name;
    phoneController.text = contact.phone;
    myController.text = contact.time;
    timeController.text = contact.costperhour;
    paidController.text = contact.paidamount;
    totalController.text = contact.total;
    remainingController.text = contact.remaining;
  }

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
  }

  String onChanged() {
    //solution for invalid double
    if (timeController.text == '') {
      timeController.text = '0';
    }
    if (phoneController.text == '') {
      phoneController.text = '0';
    }
    if (myController.text == '') {
      myController.text = '0';
    }
    if (paidController.text == '') {
      paidController.text = '0';
    }

    numOne = int.parse(myController.text);
    raw = int.parse(timeController.text);
    numTwo = numOne.toInt();
    total = numTwo * raw;
    totalOne = total.toString();
    return totalOne;
  }

  void clearEverything() {
    //make textfield empty
    totalController.text = '';
    timeController.text = '';
    myController.text = '';
    nameController.text = '';
    remainingController.text = '';
    paidController.text = '';
    phoneController.text = '';
  }

  void calculateData() {
    //to calcyulate the data
    String newOne;
    int raw, remain;
    newOne = onChanged();
    totalController.text = newOne;
    raw = int.parse(paidController.text);
    remain = int.parse(newOne) - raw;
    remainingController.text = '$remain';
  }

  void fillChanged() {
    //to instantly calculate the data
    setState(() {
      calculateData();
    });
  }
  calculateMinutes(){
    int totalMinutes=0; String newMinutes;
    newMinutes =myController.text;
    var newVal = newMinutes.split(",");
     print(newVal);

    for(int i=0; i<=newVal.length-1; i++){
      totalMinutes = totalMinutes+ int.parse(newVal[i]);

    }
    myController.text = totalMinutes.toString();
    print(totalMinutes);

  }
 void calculatePaid(){
    int totalMinutes=0; String newMinutes;
    newMinutes =paidController.text;
    var newVal = newMinutes.split(",");

    for(int i=0; i<=newVal.length-1; i++){
      totalMinutes = totalMinutes+ int.parse(newVal[i]);

    }
    paidController.text = totalMinutes.toString();

  }

// void showDialogForSavedOrNot(BuildContext context, int i){
//     showDialog(context: context, builder: builder)
// }
  void _showDialog(BuildContext context, double wide) {
// flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: (wide - 200) / 2,
            child: AlertDialog(
              title: new Text("Alert!!"),
              backgroundColor: Colors.white,
              content: new Text("Do you really Want to Clear?",
                style: TextStyle(fontSize: 16,fontFamily: 'VisbyRound', fontWeight: FontWeight.w600),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Yes",
                    style: TextStyle(fontSize: 16,fontFamily: 'VisbyRound', fontWeight: FontWeight.w600),),
                  textColor: Colors.white,
                  // minWidth: 80 ,
                  color: Colors.red,
                  onPressed: () {
                    clearEverything();
                    Navigator.of(context).pop();
                  },
                ),
                //SizedBox(width: 50),
                Container(
                  width: 120,
                ),
                new FlatButton(
                  child: new Text("No",
                    style: TextStyle(fontSize: 16,fontFamily: 'VisbyRound', fontWeight: FontWeight.w600),),
                  textColor: Colors.white,
                  // minWidth: 80,
                  color: Colors.red,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      },
    );
  }

  //this function to copy  textfield values to contact
  void saveData() {
    contact.name = nameController.text;
    contact.phone = phoneController.text;
    contact.time = myController.text;
    contact.costperhour = timeController.text;
    contact.paidamount = paidController.text;
    contact.total = totalController.text;
    contact.remaining = remainingController.text;
    _save();

    Navigator.of(context).pop();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MainMenu()),
    // );
     Navigator.push(context, PageTransition(type: PageTransitionType.fade, alignment: Alignment.center, child: MainMenu()));

    clearEverything();
  }

  void _save() async {
    //check edit mode here
    int result;
    if (contact.id != null) {
      result = await helper.updateContact(contact);
    } else {
      // print("contact"+contact);
      result = await helper.insertContact(contact);
    }

    // result = await helper.insertContact(contact);
    if (result != 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Notice!!"),
              backgroundColor: Colors.white,
              content: Text('Saved Sucessfully'),
            );
          });
    }
    if (result == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Notice!!"),
              backgroundColor: Colors.white,
              content: Text('There was Problem while Saving'),
            );
          });
    }
  }


//this function to show save data dialog before saving to database
  void _showDialogForSaving(BuildContext context, double wide) {
// flutter defined function
    if (nameController.text == '' ||
        timeController.text == '' ||
        myController.text == '0' ||
        timeController.text == '0' ||
        myController.text == '0') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: new Text("Notice!!"),
                backgroundColor: Colors.white,
                content: new Text("Cannot save incomplete Data!",

                  style: TextStyle(
                    fontFamily: 'VisbyRound',
                    fontWeight: FontWeight.bold,

                  ),));
          });
    } else {
      calculateData();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return (AlertDialog(
            title: new Text("Notice!!"),
            backgroundColor: Colors.white,
            content: new Text("Do you really Want to Save?",
              style: TextStyle(fontSize: 16,fontFamily: 'VisbyRound', fontWeight: FontWeight.w600),),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Yes",
                  style: TextStyle(fontSize: 16,fontFamily: 'VisbyRound', fontWeight: FontWeight.w600),),
                textColor: Colors.white,
                // minWidth: 80,
                color: Colors.red,
                onPressed: () {
                  saveData(); //this line is giving error
                },
              ),
              Container(
                width: 120,
              ),
              new FlatButton(
                child: new Text("No",
                  style: TextStyle(fontSize: 16,fontFamily: 'VisbyRound', fontWeight: FontWeight.w600),),
                textColor: Colors.white,
                // minWidth: 100,
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
        },
      );
    }
  }

  TextEditingController totalController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController myController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController remainingController = TextEditingController();
  TextEditingController paidController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    double Width = MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          brightness: Brightness.dark,
           title: Text('नाम र पैसा  दर्ता गर्नुहोस ',
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: new Container(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(children: <Widget>[
                  Container(
                    height: 10,
                  ),
                  Container(
                    height: 58,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Z,a-z, ]')),
                        LengthLimitingTextInputFormatter(20),
                      ],
                      textCapitalization: TextCapitalization.words,
                      controller: nameController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        // color: Colors.white,
                      ),
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // fillColor: Colors.white, filled: true,
                          labelText: 'नाम'),
                    ),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: phoneController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        // fillColor: Colors.white, filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'फोन नम्बर ',
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: TextField(
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      onSubmitted: (value){
                        setState(() {
                          calculateMinutes();
                        });

                      },
                      controller: myController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                        LengthLimitingTextInputFormatter(5),
                      ],
                      // obscureText: true,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'काम गरेको मिनेट ',
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: TextField(
                      controller: timeController,
                      onSubmitted: (String) {
                        setState(() {
                          calculateData();
                        });
                      },
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(4),
                      ],
                      // obscureText: true,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'प्रती मिनेट को',
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: TextField(
                      controller: paidController,
                      onSubmitted: (value) {
                        setState(() {
                          calculatePaid();
                          calculateData();
                        });
                      },
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9,,]')),
                      ],
                      // obscureText: true,
                      //controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'तिरेको रकम रु',
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: TextField(
                      controller: totalController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'तिर्नु पर्ने रकम रु',
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: TextField(
                      controller: remainingController,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      // obscureText: true,
                      //controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'बाकी रकम रु',
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          minWidth: (Width - 80) / 2,
                          height: 50,
                          textColor: Colors.white,
                          color: Colors.deepPurple,
                          child: Text('Calculate & Save',
                            style: TextStyle(
                              fontFamily: 'VisbyRound',
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                          onPressed: () {
                            _showDialogForSaving(context, Width);
                            //calculateData();
                            //  new Future.delayed(const Duration(seconds : 5));
                            //fill data
                          },
                        ),
                        Container(
                          width: 50,
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          minWidth: (Width - 80) / 2,
                          height: 50,
                          textColor: Colors.white,
                          color: Colors.amber,
                          child: Text('Clear',
                            style: TextStyle(
                            fontFamily: 'VisbyRound',
                            fontWeight: FontWeight.bold,
                              color: Colors.black,

                          ),),
                          onPressed: () {
                            _showDialog(context, Width);
                          },
                        ),
                      ],
                      // padding: EdgeInsets.symmetric(horizontal:12, vertical: 12),
                    ),
                  ),
                 Container( child: Column(
    children:[
                  GestureDetector(
                    child: Container(
                      height: 30,
                      child: Column( children:[ Icon(
                        Icons.dialer_sip_rounded,
                        color: Colors.green,
                        size: 30,
                      ),

                      ]),
                    ),
                    onDoubleTap: () {
                      if (phoneController.text != '' &&
                          phoneController.text.length == 10) {
                        String newDialer = phoneController.text;
                        customLaunch('tel:$newDialer');
                        // customLaunch('https://www.youtube.com/');
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: new Text("Notice!!"),
                                  backgroundColor: Colors.white,
                                  content: new Text("Phone No. is not valid!",
                                    style: TextStyle(
                                      fontFamily: 'VisbyRound',
                                      fontWeight: FontWeight.bold,

                                    ),));
                            });
                      }
                    },
                  ),
      Text("Double Tap To Call",
      style: TextStyle(
        fontFamily: "VisbyRound"
      ),
      ),
                  ],
                 ),


                 )])))));
  }
}
