Import Data_Services, autokeyb2,doxie;

addr := RECORD
   string10 prim_range;
   string2 predir;
   string28 prim_name;
   string4 addr_suffix;
   string2 postdir;
   string10 unit_desig;
   string8 sec_range;
   string25 v_city_name;
   string2 st;
   string5 zip5;
   string4 zip4;
   string2 addr_rec_type;
   string2 fips_state;
   string3 fips_county;
   string10 geo_lat;
   string11 geo_long;
   string4 cbsa;
   string7 geo_blk;
   string1 geo_match;
   string4 err_stat;
  END;

name := RECORD
   string5 title;
   string20 fname;
   string20 mname;
   string20 lname;
   string5 name_suffix;
   string3 name_score;
  END;

rec := RECORD
  unsigned6 fakeid;
  unsigned6 did;
  unsigned6 bdid;
  unsigned6 aid;
  unsigned4 lookups;
  string10 batch;
  string8 incident_num;
  string7 party_num;
  // string100 name_party;
  string50 name_first;
  string50 name_last;
  string50 name_middle;
  string10 suffix;
  string150 party_firm;
  string45 address;
  string45 city;
  string2 state;
  string9 zip;
  addr addr;
	name name;
  string100 company;
  string8 dob;
  string10 phone;
  string9 ssn_tin;
  string11 ssn;
  string10 tin;
  string5 srce_cd;
	string1 dbcode;
  unsigned1 zero;
  string1 blank;
	//CCPA-97 Per requirement, all in scope data needs to have a date when the data was collected
	STRING8 date_vendor_first_reported;
	STRING8 date_vendor_last_reported;
	//CCPA-97 Add 2 new fields for CCPA
	unsigned4 global_sid;
	unsigned8 record_sid;
  UNSIGNED4 dt_effective_first;
  UNSIGNED4 dt_effective_last;
  UNSIGNED1 delta_ind;
  // unsigned8 __internal_fpos__;
 END;


d := dataset([],rec);

KeyName 			:= 'thor_data400::key::sanctn::np::autokey::';

export key_autokey_payload := index(dedup(d,record,all)
                                          ,{fakeid}
										  ,{d}
										  ,Data_Services.Data_location.Prefix('sanctn')+ KeyName + doxie.Version_SuperKey + '::payload');