export Layout_File_Out_plus := RECORD
  header.File_OUT;
  unsigned integer8 __filepos { virtual(fileposition)};
END;