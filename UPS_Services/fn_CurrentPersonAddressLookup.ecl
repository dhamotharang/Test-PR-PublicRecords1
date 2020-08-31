IMPORT dx_header, ut, std, UPS_Services;

EXPORT fn_CurrentPersonAddressLookup(DATASET(UPS_Services.layout_Common)dsPreCurrent) := FUNCTION
/* The 31st bit of lookups field in key_address indicates if the person is a current resident of the address or not*/
  dsWithCurrent := 
    JOIN(dsPreCurrent, dx_header.key_address(),
    KEYED(
      ut.StripOrdinal(LEFT.prim_name) = RIGHT.prim_name AND
      LEFT.prim_range = RIGHT.prim_range AND
      LEFT.state = RIGHT.st AND
      hash(LEFT.city_name) = RIGHT.city_code AND
      LEFT.zip = RIGHT.zip AND
      LEFT.sec_range = RIGHT.sec_range)
      AND
      (
        (
          LEFT.rollup_key <> 0 AND
          LEFT.rollup_key_type = UPS_Services.Constants.TAG_ROLLUP_KEY_DID AND
          LEFT.rollup_key = RIGHT.did
          )
        OR
        (
          (
            LEFT.lname = RIGHT.lname OR
            std.Metaphone.Primary(LEFT.lname) = RIGHT.dph_lname
          )
          AND
          (
            LEFT.fname = RIGHT.pfname OR
            LEFT.fname = RIGHT.fname
            )
        )
      )
      ,
    TRANSFORM
      (UPS_Services.layout_Common,
        SELF.Current := IF(ut.bit_test(RIGHT.lookups,31),'Y',LEFT.Current);
        SELF := LEFT ),
    LEFT OUTER, KEEP(1),LIMIT(0));

  
RETURN dsWithCurrent;

END;
