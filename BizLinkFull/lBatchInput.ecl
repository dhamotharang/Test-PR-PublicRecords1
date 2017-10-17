EXPORT lBatchInput:=RECORD
  UNSIGNED   acctno;
  STRING120  company_name;
  STRING10   prim_range;
  STRING28   prim_name;
  STRING8    sec_range;
  STRING25   city;
  STRING2    st;
  STRING5    zip;
  STRING20   fname;
  STRING20   mname;
  STRING20   lname;
  STRING2    source;
  UNSIGNED   source_record_id;
  STRING10   company_phone;
  STRING9    company_fein;
  STRING8    company_sic_code1;
  STRING80   company_url;
  STRING9    contact_ssn;
  STRING60   contact_email;
  UNSIGNED6  entered_proxid;
END;

