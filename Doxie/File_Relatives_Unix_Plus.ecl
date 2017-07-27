relrec := record
  string12 person1;
  string12 person2;
  string6  recent_cohabit;
  string1  same_lname;
  string3  number_cohabits;
  unsigned integer8 __filepos { virtual(fileposition)};
end;

export File_Relatives_Unix_Plus := dataset('out::relatives', relrec, flat);