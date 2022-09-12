enum UserRegistrationFieldErrorType {
  areEmpty,
  emailNotValid,
  phoneNotValid,
  passwordNotValid,
  passwordNotMatched,
  alreadyExists
}

extension UserRegistrationFieldErrorTypeAddition
    on UserRegistrationFieldErrorType {
  String dialogMessage() {
    switch (this) {
      case UserRegistrationFieldErrorType.areEmpty:
        return 'Please fill all fields';
      case UserRegistrationFieldErrorType.emailNotValid:
        return 'Email not valid';
      case UserRegistrationFieldErrorType.phoneNotValid:
        return 'Phone not valid';
      case UserRegistrationFieldErrorType.passwordNotValid:
        return 'Password not valid';
      case UserRegistrationFieldErrorType.passwordNotMatched:
        return 'Password and Confirm password not matched';
      case UserRegistrationFieldErrorType.alreadyExists:
        return 'This username already exists';
    }
  }
}
