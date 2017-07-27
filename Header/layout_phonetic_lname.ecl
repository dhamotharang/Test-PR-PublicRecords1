export layout_phonetic_lname := RECORD
  string6 dph_lname;  //phonetization (phonetic key) of a given last name
  string20 lname;            //suppozed to be unique

  unsigned6 name_count := 1;  // last name frequency
  unsigned6 did_count := 1;   // number of distinguished dids for every name
  unsigned6 pkey_count := 1;  // phonetic key frequency
END;
