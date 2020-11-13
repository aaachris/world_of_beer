String validateEmail(String value) {
  if (value.isEmpty) {
    return 'Email field cannot be empty!';
  }
  // Regex for email validation
  String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" + "\\@" + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" + "(" + "\\." + "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" + ")+";
  RegExp regExp = new RegExp(p);
  if (regExp.hasMatch(value)) {
    return null;
  }
  return 'Email provided isn\'t valid.Try another email address';
}

String validatePassword(String value) {
  if (value.isEmpty) {
    return 'Password field cannot be empty';
  }

  if (value.length < 6) {
    return 'Password length must be greater than 6';
  }
  return null;
}
