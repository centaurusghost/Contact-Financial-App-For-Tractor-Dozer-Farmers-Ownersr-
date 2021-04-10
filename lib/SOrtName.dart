import 'package:clean_app/DataPage.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/Contact.dart';
import 'package:clean_app/DatabaseHelper.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'drawerMenu.dart';

class SortName extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SortName> {
  TextEditingController searchController = TextEditingController();
  String userSearchInput = "";
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Contact> contacts;
  int cout = 0;
  FocusNode myFocusNode;
  List<Contact> listContact;
  List<Contact> filteredContact;
  List<Contact> unpaidList = [];
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
    setState(() {});
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
        filteredContact.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

        for (int i = 0; i <= filteredContact.length - 1; i++) {
          //  if (filteredContact[i].remaining != '0.0') {
          unpaidList.add(filteredContact.elementAt(i));
          // }
        }
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
      filteredContact = unpaidList
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
                    Navigator.push(context, PageTransition(type: PageTransitionType.fade, alignment: Alignment.center, child: SortName()));
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
    return SafeArea(child: Scaffold(
      appBar: AppBar(
          toolbarHeight: 50,
          brightness: Brightness.dark,
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text(
              'Sorted By Name  ' + unpaidList.length.toString() + '   People',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              fontFamily: 'VisbyRound'
            ),)),

      body: Column(
        children: [
          searchBar(),
          contactsViewWidget(unpaidList, isSearching),
        ],
      ),
      drawer: DrawerMenu(),
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

  Widget contactsViewWidget(unpaidList, isSearching) {
    return Expanded(
        child: ListView.builder(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount:
          isSearching == true ? filteredContact.length : unpaidList.length,
      // isSearching ==true? contactsFiltered.length :
      // itemCount: unpaidList.length,
      itemBuilder: (BuildContext context, int position) {
        // var contact =unpaidList[position];
        var contact = isSearching == true
            ? filteredContact[position]
            : unpaidList[position];
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              //child: Icon(Icons.perm_contact_cal),
              backgroundColor: Colors.deepPurple,
              child: Text(
                contact.name[0].toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
              ),
            ),
            title: Text(
              contact.name.toUpperCase(),
              style: TextStyle(fontSize: 16,fontFamily: 'VisbyRound', fontWeight: FontWeight.w600),),
            subtitle: Text(contact.remaining,
              style: TextStyle(fontSize: 16,fontFamily: 'VisbyRound', fontWeight: FontWeight.w500),),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                showDeleteDialog(context, contact);
              },
            ),
            //i dont know how to pass that editmode = true or false value
            onTap: () {
              //Datapage void _save() it contains edit mode check look once
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, alignment: Alignment.bottomCenter, child: DataPage(contact: contact)));

            },
          ),
        );
      },
    ));
  }
}
