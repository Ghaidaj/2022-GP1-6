class UserProfileEntity {
  String? firstName, lastName, phoneNumber, gender, birthday, height, weight;
  bool? deafMute;

  UserProfileEntity();
  // UserProfile.create({
  //   this.firstName,
  //   this.lastName,
  //   this.phoneNumber,
  //   this.gender,
  //   this.birthday,
  //   this.height,
  //   this.weight,
  //   this.deafMute,
  // });

  UserProfileEntity.update({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? gender,
    String? birthday,
    String? height,
    String? weight,
    bool? deafMute,
  }) {
    this.firstName = firstName ?? this.firstName;
    this.lastName = lastName ?? this.lastName;
    this.phoneNumber = phoneNumber ?? this.phoneNumber;
    this.gender = gender ?? this.gender;
    this.birthday = birthday ?? this.birthday;
    this.height = height ?? this.height;
    this.weight = weight ?? this.weight;
    this.deafMute = deafMute ?? this.deafMute;
  }
}
