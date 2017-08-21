r := record
  Layout_Indic;
  unsigned integer8 __filepos { virtual(fileposition)};
  end;
export File_Indic_Plus := dataset('~thor_data400::BASE::Credit_Person',r,flat);