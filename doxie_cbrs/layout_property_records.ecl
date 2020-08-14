IMPORT doxie_crs;
EXPORT layout_property_records := RECORD
  UNSIGNED6 bdid := 0;
  BOOLEAN byBDID; //because some recs may be by both
  BOOLEAN byAddress;
  doxie_crs.layout_property_ln;
END;
  
