import ut;

EXPORT File_In_Attorney := dataset('~thor400_20::in::bankruptcy::attorney_20140311', Layout_In_Attorney, CSV(SEPARATOR('\t'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4096)));