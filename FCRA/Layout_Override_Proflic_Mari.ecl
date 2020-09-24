//CCPA-1047 - Layout definition of Override ProfLic MARI key
EXPORT Layout_Override_Proflic_Mari := RECORD
    $.Layout_Override_Proflic_Mari_In - [flag_file_id,__internal_fpos__];
  UNSIGNED4 global_sid := 0;
  UNSIGNED8 record_sid := 0;
  STRING20  flag_file_id;
END;