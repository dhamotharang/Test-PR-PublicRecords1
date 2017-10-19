dRawData:=BIPV2_Testing.files.xlink;
dRawData;
lBatchInput:=RECORD
  UNSIGNED   uniquid;
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
  STRING8    company_sic_code;
  STRING80   company_url;
  STRING9    contact_ssn;
  STRING60   contact_email;
END;
lBatchOutput:=RECORD
  BizLinkFull.lBatchInput;
  UNSIGNED6 proxid;
  UNSIGNED6 seleid;
  UNSIGNED6 orgid;
  UNSIGNED6 ultid;
  UNSIGNED2 weight;
  UNSIGNED2 score;
END;
dBatchInput:=PROJECT(dRawData,TRANSFORM(BizLinkFull.lBatchInput,
  SELF.uniqueid          := LEFT.rid;
  SELF.company_name      := LEFT.company_name;
  SELF.prim_range        := LEFT.company_prim_range;
  SELF.prim_name         := LEFT.company_prim_name;
  SELF.sec_range         := LEFT.company_sec_range;
  SELF.city              := LEFT.company_city;
  SELF.st                := LEFT.company_state;
  SELF.zip               := LEFT.company_zip;
  SELF.fname             := LEFT.fname;
  SELF.mname             := LEFT.mname;
  SELF.lname             := LEFT.lname;
  SELF.source            := LEFT.src;
  SELF.source_record_id  := (UNSIGNED)LEFT.src_rcid;
  SELF.company_phone     := LEFT.company_phone;
  SELF.company_fein      := LEFT.company_fein;
  SELF.company_sic_code1 := '';
  SELF.company_url       := '';
  SELF.contact_ssn       := '';
  SELF.contact_email     := LEFT.email_address;
));
PIPE(
  DISTRIBUTE(dBatchInput,RANDOM()%100),
  'roxiepipe -iw '+SIZEOF(lBatchInput)+' -t 1 -ow '+SIZEOF(lBatchOutput)+' -b 100 -mr 2 -h 10.239.190.1:9876 -vip -r Results '+
  '-q "<svcbatch format=\'raw\'><input_data id=\'id\' format=\'raw\'></input_data></svcbatch>"',
  lBatchOutput
);

