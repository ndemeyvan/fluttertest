extension extString on String {
  bool get isValidUsername {
    final nameRegExp =
        new RegExp(r"^(?!.*\.\.)(?!.*?ejara)(?!.*\.$)[^\W][\w.]{3,30}$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(
        r"((?:\+|00)[17](?: |\-)?|(?:\+|00)[1-9]\d{0,2}(?: |\-)?|(?:\+|00)1\-\d{3}(?: |\-)?)?(0\d|\([0-9]{3}\)|[1-9]{0,3})(?:((?: |\-)[0-9]{2}){4}|((?:[0-9]{2}){4})|((?: |\-)[0-9]{3}(?: |\-)[0-9]{4})|([0-9]{7}))");
    return phoneRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }
}
