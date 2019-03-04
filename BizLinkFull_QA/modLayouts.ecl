EXPORT modLayouts := MODULE
   
  EXPORT lSrcLayout := RECORD
	  STRING120 company_name,
	  STRING10 prim_range,
	  STRING28 prim_name,
	  STRING8 sec_range,
	  STRING25 city,
	  STRING2 state,
	  STRING5 zip5,
	  UNSIGNED3 zip_radius_miles := 0;
	  STRING10 phone10,
	  STRING9 fein,
	  STRING80 url,
	  STRING60 email,
	  STRING20 contact_fname,
	  STRING20 contact_mname,
	  STRING20 contact_lname,
	  STRING9 contact_ssn,
	  UNSIGNED6 contact_did,
	  STRING8 sic_code,
	  STRING2 source,
	  UNSIGNED8 source_record_id,
	  UNSIGNED6 proxid,
	  UNSIGNED6 seleid
 END;
  
  EXPORT profileRec := RECORD
    STRING srcCategory;
    STRING srcFilter;
    UNSIGNED2 weight := 0;
    UNSIGNED2 distance := 0;
    UNSIGNED2 score := 0;
    UNSIGNED2 macroCall := 0;
  END;
  
END;
