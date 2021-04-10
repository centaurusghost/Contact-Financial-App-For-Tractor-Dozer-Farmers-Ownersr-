import 'package:clean_app/DataPage.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/Contact.dart';
import 'package:clean_app/DatabaseHelper.dart';
import 'package:flutter/services.dart';
import 'drawerMenu.dart';
import 'package:page_transition/page_transition.dart';
class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<MainMenu> {
  TextEditingController searchController = TextEditingController();
  String userSearchInput = "";
  int index;
  int _cIndex = 0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Contact> contacts;
  int cout = 0;
  FocusNode myFocusNode;
  List<Contact> listContact;

  List<Contact> filteredContact;
  bool isSearching = false;

  void surelyDelete(BuildContext context, Contact contact) async {
    int result;
    result = await databaseHelper.deleteContact(contact.id);
    if (result != 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Notice!!"),
              backgroundColor: Colors.white,
              content: Text('Contact केहि समय मा delete हुनेछ !!'),
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
              content: Text(
                  'There was a problem while Deleting. Please Restart the App & try again'),
            );
          });
    }
    setState(() {
      //   contactsViewWidget(contacts, isSearching);
    });
  }

  //
  getContactList() async {
    var databaseFetch = await databaseHelper.fetchContact();
    return databaseFetch;
  }

  void initState() {
    getContactList().then((data) {
      setState(() {
        filteredContact = data;
        contacts = data;
      });
    });
    if (myFocusNode == null) {
      myFocusNode = FocusNode();
    }
    super.initState();
  }

  void filterContact(value) {
    //print(listContact.where((xxx) => xxx.name=='tilak').toList(););
    setState(() {
      filteredContact = contacts
          .where((contact) =>
              contact.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      // filteredContact = listContact.where((xxx) => xxx.name=='tilak khatri').toList();
    });
  }

  void dispose() {
    //  searchController.removeListener(onSearchChanged);
    searchController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  onSearchChanged() {
    print(searchController.text);
  }

  String displayTotal() {
    double displayTotall = 0;
    for (int i = 0; i <= contacts.length - 1; i++) {
      displayTotall = displayTotall + double.parse(filteredContact[i].total);
    }
    String displayTotals;
    displayTotals = displayTotall.toString();
    return displayTotals;
  }

  String displayRemaining() {
    double displayTotall = 0;
    for (int i = 0; i <= contacts.length - 1; i++) {
      displayTotall =
          displayTotall + double.parse(filteredContact[i].remaining);
      // print(displayTotall);
    }
    String displayTotals;
    displayTotals = displayTotall.toString();
    return displayTotals;
  }

  String displayPaid() {
    double displayTotall = 0;
    for (int i = 0; i <= contacts.length - 1; i++) {
      displayTotall = displayTotall + double.parse(contacts[i].paidamount);
      // print(displayTotall);
    }
    String displayTotals;
    displayTotals = displayTotall.toString();
    return displayTotals;
  }

  void menuDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("See Details!!"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Total Customers= ' + contacts.length.toString(),
                  style: TextStyle(
                      fontFamily: 'VisbyRound', fontWeight: FontWeight.w600),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  //displayTotal();
                },
                child: Text(
                  'Total Money=  Rs.' + displayTotal(),
                  style: TextStyle(
                      fontFamily: 'VisbyRound', fontWeight: FontWeight.w600),
                ),
                // child: Text('Total Money=  Rs.'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('तपाईंले पाएको रकम  =  Rs.' + displayPaid()),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('बाकी उठाउँनु पर्ने =  Rs.' + displayRemaining()),
              ),
            ],
          );
        });
  }

  //shows dialog before deleting
  void showDeleteDialog(BuildContext context, Contact contact) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
            width: (MediaQuery.of(context).size.width - 200) / 2,
            child: AlertDialog(
              title: new Text("Alert!!"),
              backgroundColor: Colors.white,
              content: new Text("Do you really Want to Delete?"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Yes"),
                  textColor: Colors.white,
                  //minWidth: 100,
                  color: Colors.red,
                  onPressed: () {
                    surelyDelete(context, contact);
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, alignment: Alignment.center,  child: MainMenu()));
                  },
                ),
                Container(width: 120),
                new FlatButton(
                  child: new Text("No"),
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

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    double Width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
      appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          brightness: Brightness.dark,
          backgroundColor: Colors.deepPurple,
          title: Text('नाम खोजी गर्नुहोस ')),
      body: Column(
        children: [
          searchBar(),
          FutureBuilder<List<Contact>>(
            future: databaseHelper.fetchContact(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
              if (!snapshot.hasData) return Container();
              List<Contact> contacts = snapshot.data;
              print(contacts);
              return contactsViewWidget(contacts, isSearching);
            },
          ),
        ],
      ),
      drawer: DrawerMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, PageTransition(type: PageTransitionType.fade, alignment: Alignment.center, child: DataPage()));

        },
        child: Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
           // color: Colors.white54,
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(width: 40),

                FlatButton.icon(
                    onPressed: () {
                      myFocusNode.requestFocus();
                    },
                    icon: Icon(Icons.search),
                    label: Text(
                      'Search',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'VisbyRound'),
                    )),

                Container(width: 150),
                FlatButton.icon(
                    onPressed: () {
   // if(contacts.length!=0 || contacts.length!=null){
                      if(contacts.length!=0|| contacts.length!=null){
                        menuDialog();
                      }



                    },
                    icon: Icon(Icons.menu),
                    label: Text(
                      'Menu',
                      style:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: 'VisbyRound'),
                    )),
                //  Icon(Icons.menu,size: 30, color: Colors.black,),
              ],
            ),
          )

          ),
    ));
  }

  Widget contactsViewWidget(contacts, isSearching) {
    return Expanded(
        child: ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: isSearching == true ? filteredContact.length : contacts.length,
      // isSearching ==true? contactsFiltered.length :
      //itemCount: filteredContact.length,
      itemBuilder: (BuildContext context, int position) {
        // var contact =filteredContact[position];
        var contact = isSearching == true
            ? filteredContact[position]
            : contacts[position];
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              //child: Icon(Icons.perm_contact_cal),
              backgroundColor: Colors.deepPurple,
              child: Text(
                contact.name[0].toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
            ),
            title: Text(
              contact.name.toUpperCase(),
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'VisbyRound',
                  fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              contact.remaining,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'VisbyRound',
                  fontWeight: FontWeight.w500),
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                showDeleteDialog(context, contact);
              },
            ),
            //i dont know how to pass that editmode = true or false value
            onTap: () {
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, alignment: Alignment.bottomCenter, child: DataPage(contact: contact)));

            },
          ),
        );
      },
    ));
  }

  Widget searchBar() {
    return Container(
      height: 60,
      padding: EdgeInsets.all(8),
      child: TextField(
        autofocus: false,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[A-Z,a-z, ]')),
          LengthLimitingTextInputFormatter(20),
        ],
        controller: searchController,
        focusNode: myFocusNode,
        onChanged: (value) {
          filterContact(value);
        },
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          // color: Colors.white,
        ),
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
            suffixIcon: GestureDetector(
              child: Icon(
                Icons.cancel,
              ),
              onTap: () {
                //searchController.text='';
                searchController.clear();
                myFocusNode.unfocus();
                //myFocusNode.dispose();
              },
            ),
            // fillColor: Colors.white, filled: true,
            labelText: 'Search'),
      ),
    );
  }
}
