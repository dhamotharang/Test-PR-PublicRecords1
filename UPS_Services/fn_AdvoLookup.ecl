IMPORT Advo, UPS_Services;

EXPORT fn_AdvoLookup(DATASET(UPS_Services.layout_Common) preRecords ) := FUNCTION

  finalRecords := JOIN(preRecords, Advo.Key_Addr1,
    KEYED(LEFT.zip = RIGHT.zip) AND
    KEYED(LEFT.prim_range = RIGHT.prim_range) AND
    KEYED(LEFT.prim_name = RIGHT.prim_name) AND
    KEYED(LEFT.suffix = RIGHT.addr_suffix) AND
    KEYED(LEFT.predir = RIGHT.predir) AND
    KEYED(LEFT.postdir = RIGHT.postdir) AND
    KEYED(LEFT.sec_range = RIGHT.sec_range),
    TRANSFORM(UPS_Services.layout_Common,
      SELF.AddressType := RIGHT.residential_or_business_ind,
      SELF := LEFT),
    LEFT OUTER , KEEP(1),LIMIT(0));

  RETURN(finalRecords);
END;
