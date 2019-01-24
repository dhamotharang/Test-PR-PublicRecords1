// formely: Business_Risk/Key_SSN_Address
IMPORT $;

rec := $.layout_header;

keyed_fields := RECORD
  rec.ssn;
  rec.prim_name;
END;

payload := RECORD
  rec.lname;
  rec.fname;
  rec.mname;
  rec.prim_range;
  rec.sec_range;
  rec.zip;
END;

EXPORT Key_SSN_Address (integer data_category = 0) := 
         INDEX (keyed_fields, payload, $.names().i_ssn_address);
