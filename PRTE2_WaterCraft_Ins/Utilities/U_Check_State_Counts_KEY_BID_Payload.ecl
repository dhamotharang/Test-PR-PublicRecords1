/* *******************************************************************************************
Template to read keys.
to fill in 
KeyFileName - whatever key file name with/without foreign
Layout_In_EclWatch   - in ECL watch look up the key, hit contents then ECL tab - copy layout here.
IndexFields - on the contents ECL watch spot the fields with "i" flag, move them from above down to here
******************************************************************************************* */
IMPORT data_services;

KeyFileName := data_services.foreign_prod+'thor_data400::key::watercraft::autokey::bid::payload_qa';

Layout_In_EclWatch := RECORD
  string30 watercraft_key;
  string30 sequence_key;
  string2 state_origin;
  string20 fname;
  string20 lname;
  string20 mname;
  string8 dob;
  string28 prim_name;
  string10 prim_range;
  string2 st;
  string5 zip5;
  string8 sec_range;
  string60 company_name;
  unsigned6 ldid;
  unsigned6 lbdid;
  string10 phone;
  unsigned1 zero;
  string25 city;
  string2 bstate;
  string25 bcity;
  string10 bphone;
  string10 bprim_range;
  string28 bprim_name;
  string8 bsec_range;
  string5 bzip5;
  string9 fein_use;
  string9 ssn_use;
  unsigned8 __internal_fpos__;
END;
IndexFields := RECORD
  unsigned6 fakeid;
END;

prct_data_key := INDEX({IndexFields}, Layout_In_EclWatch, keyFileName);

DataIn := prct_data_key;
OUTPUT(COUNT(dataIn));

report0 := RECORD
	recTypeSrc	 := DataIn.State_Origin;
	GroupCount := COUNT(GROUP);
END;

RepTable0 := TABLE(DataIn,report0,State_Origin);
OUTPUT(SORT(RepTable0,recTypeSrc));




