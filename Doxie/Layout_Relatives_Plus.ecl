import header;
export Layout_Relatives_Plus := record
  header.File_Relatives;
  unsigned integer8 __filepos { virtual(fileposition)};
  end;