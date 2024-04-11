import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t_store/utils/formatters/formatter.dart';

class UserModel {
  

  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;
  String role;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.role,
  });

  

  //get fullname
  String get fullName => "$firstName $lastName";

  //foormat phonenumber
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  //Split full name
  static List<String> nameParts(fullName) => fullName.split(" ");

  //generate username
  static String generateUserName(fullname) {
    List<String> nameParts = fullname.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName = "$firstName$lastName";
    String userNameWithData = "tstore_$camelCaseUserName";
    return userNameWithData;
  }

  //create empty username
  static UserModel empty() => UserModel(
      id: "",
      firstName: "",
      lastName: "",
      userName: "",
      email: "",
      phoneNumber: "",
      profilePicture: "",
      role: "");

  //Convert model to json
  Map<String, dynamic> toJson() {
    return {
      // id: "",
      "FirstName": firstName,
      "LastName": lastName,
      "UserName": userName,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "ProfilePicture": profilePicture,
      "Role": role
    };
  }

  //factory method to create a usermodel from a firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data["FirstName"] ?? "",
        lastName: data["LastName"] ?? "",
        userName: data["UserName"] ?? "",
        email: data["Email"] ?? "",
        phoneNumber: data["PhoneNumber"] ?? "",
        profilePicture: data["ProfilePicture"] ?? "",
        role: data["Role"] ?? "",
      );
    } else {
      return UserModel.empty();
    }
  }
}
