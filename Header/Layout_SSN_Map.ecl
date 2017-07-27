// export Layout_SSN_Map := record
// string5                                   ssn5;
// string6                                   start_date;
// string6                                   end_date;
// string32                                  state_name;
// string1                                   status_code;
// string1                                   eol;
// unsigned integer8 __filepos { virtual(fileposition)};
// end;

// this is a layout for a new SSN data
export Layout_SSN_Map := record
  string5 ssn5;
  string4 end_serial;
  string4 start_serial;
  string8 start_date;
  string8 end_date;
  string50 state;
end;
