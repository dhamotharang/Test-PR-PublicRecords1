r := record
  Layout_Trade;
  unsigned integer8 __filepos { virtual(fileposition)};
  end;
export File_Trade_Plus := dataset('~thor_data400::BASE::Credit_Trade',r,flat);