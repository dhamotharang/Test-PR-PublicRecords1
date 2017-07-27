IMPORT standard;

EXPORT layout_autokeys := RECORD
	unsigned6 fdid; // "real" did, not fake in [autokeys] sense
  string20 lastname;
  string15 firstname;
  string15 middlename;
  string15 nickname;
  string10 phonenumber;
  standard.L_Address.baseCanada;
  unsigned1 zero  := 0;
	string1   blank := '';
END;