import 'package:flutter/material.dart';
import 'package:mobile_hw2/models/contact.dart';
import 'package:mobile_hw2/pages/contact_details.dart';
import 'package:mobile_hw2/shared/firestore_helper.dart';
import 'package:uuid/uuid.dart';

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ContactList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final List<String> result = await createAlertDialog(context);
          if (result[0] == '' ||
              result[1] == '' ||
              result[2] == '' ||
              result[3] == '') {
          } else {
            Contact newContact = Contact(
                Uuid().v1(), result[0], result[1], result[2], result[3]);
            FirestoreHelper.addNewContact(newContact);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<List<String>> createAlertDialog(BuildContext context) async {
    List<String> result = [];
    List<TextEditingController> _controllers =
        List.generate(4, (_) => TextEditingController());
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("New Contact"),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _controllers[0],
                  decoration: const InputDecoration(hintText: "First Name"),
                ),
                TextField(
                  controller: _controllers[1],
                  decoration: const InputDecoration(hintText: "Last Name"),
                ),
                TextField(
                  controller: _controllers[2],
                  decoration: const InputDecoration(hintText: "Email Address"),
                ),
                TextField(
                  controller: _controllers[3],
                  decoration: const InputDecoration(hintText: "Phone Number"),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(result);
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _controllers.forEach((element) {
                      result.add(element.text);
                    });
                    if (result[0] == '' ||
                        result[1] == '' ||
                        result[2] == '' ||
                        result[3] == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please fill out all the fields")),
                      );
                      result = [];
                    } else {
                      Navigator.of(context).pop(result);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class ContactList extends StatefulWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Contact> contacts = [];

  @override
  void initState() {
    if (mounted) {
      FirestoreHelper.getContact().then((data) {
        setState(() {
          contacts = data;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return contacts.isEmpty == false
        ? ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, position) {
              Contact currentContact = contacts[position];
              String firstName = currentContact.firstName;
              String lastName = currentContact.lastName;
              String email = currentContact.email;
              String phoneNumber = currentContact.phoneNumber;
              String subTitle = '$firstName $lastName';
              return Dismissible(
                key: Key(currentContact.id),
                child: Card(
                  child: ListTile(
                    title: Text(subTitle),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactDetails(
                                firstName: firstName,
                                lastName: lastName,
                                email: email,
                                phoneNumber: phoneNumber),
                          ));
                    },
                  ),
                ),
              );
            })
        : const Center(
            child: Text(
              "No Contacts",
              style: TextStyle(fontSize: 20),
            ),
          );
  }
}
