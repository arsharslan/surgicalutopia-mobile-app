class CustomUser {
  String? id;
  String? firebaseId;
  String? firstName;
  String? lastName;
  String? profilePic;
  String? phoneNumber;
  String? email;

  CustomUser(
      {this.id,
      this.firebaseId,
      this.firstName,
      this.lastName,
      this.profilePic,
      this.phoneNumber,
      this.email});

  factory CustomUser.fromJson(Map<String, dynamic> json) => CustomUser(
      id: json['_id'],
      firebaseId: json['firebaseId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profilePic: json['profilePic'],
      phoneNumber: json['phoneNumber'],
      email: json['email']);

  Map<String, String> toJson() {
    return {
      if(firebaseId != null) "firebaseId": firebaseId!,
      if (firstName != null) "firstName": firstName!,
      if (lastName != null) "lastName": lastName!,
      if (profilePic != null) "profilePic": profilePic!,
    };
  }
}
