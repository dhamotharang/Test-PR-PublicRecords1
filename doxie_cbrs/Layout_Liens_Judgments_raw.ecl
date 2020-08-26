IMPORT bankrupt;

EXPORT Layout_Liens_Judgments_raw := RECORD
  bankrupt.Layout_Liens;
  STRING18 county_name := '';
END;
