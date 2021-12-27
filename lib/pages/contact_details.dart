import 'package:flutter/material.dart';

class ContactDetails extends StatefulWidget {
  const ContactDetails(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber})
      : super(key: key);

  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.firstName + ' ' + widget.lastName),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.kindpng.com/picc/m/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png"),
                  radius: 100,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  "Phone Number: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                Text(widget.phoneNumber),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  "Email Address: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                ),
                Text(widget.email),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
