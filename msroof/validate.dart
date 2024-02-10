validInput(String val, int max, int min, bool isemail) {
  bool isEmail(valu) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(valu);
  }

  if (isemail & (!isEmail(val))) {
    return "هذا الايميل غير صحيح";
  }
  if (val.length > max) {
    return " لا يمكن ان يكون اكبر من هذا الحد : $max";
  }
  if (val.isEmpty) {
    return "لا يمكن ان يكون فارغ";
  }
  if (val.length < min) {
    return " لا يمكن ان يكون اصغر من هذا الحد : $min";
  }
}
