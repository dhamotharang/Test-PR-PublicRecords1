EXPORT Layout_Parse_Raw := RECORD
    UNSIGNED8 __ParseNo := 0; // Will uniquely identify each parse record
    UNSIGNED4 __pos;
    UNSIGNED4 __len;
    SALT38.UIDType id;
    SET OF INTEGER2 PossF;
    StrType Txt;
  END;
