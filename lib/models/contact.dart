class Contact {
  late String id;
  late String firstName;
  late String lastName;
  late String email;
  late String phoneNumber;

  Contact(this.id, this.firstName, this.lastName, this.email, this.phoneNumber);

  Contact.fromMap(dynamic obj) {
    id = obj.id;
    firstName = obj["firstName"];
    lastName = obj["lastName"];
    email = obj["email"];
    phoneNumber = obj["phoneNumber"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    return map;
  }
}
