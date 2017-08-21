r := record
  Layout_Pubrec;
  unsigned integer8 __filepos { virtual(fileposition)};
  end;

export File_Pubrec_Plus := dataset('~thor_data400::BASE::Credit_pubrec',r,flat);