Import Data_Services, autokeyb2,doxie;

rec := RECORD
  unsigned6 fakeid;
  string8 batch_number;
  string8 incident_number;
  string8 party_number;
  string8 ag_code;
  string8 incident_date;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string3 name_score;
  string45 cname;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip5;
  string4 zip4;
  string2 fips_state;
  string3 fips_county;
  string2 addr_rec_type;
  string10 geo_lat;
  string11 geo_long;
  string4 cbsa;
  string7 geo_blk;
  string1 geo_match;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string4 err_stat;
 	unsigned6 did; 
	unsigned3 did_score;
	unsigned6 bdid;
  unsigned3 bdid_score;
	string11 	ssnumber;
	string9   ssn_appended;
  integer8 zero;
  string0 blk;
	//CCPA-283 Adding CCPA new fields
	UNSIGNED4 global_sid:=0;
	UNSIGNED8 record_sid:=0;
    UNSIGNED4 dt_effective_first:=0;
    UNSIGNED4 dt_effective_last:=0;
    UNSIGNED1 delta_ind := 0;
END;

// fakepf := SANCTN.file_out_party_cleaned;

// autokeyb2.MAC_FID_Payload(fakepf,'','','','','','','','','',0,0,Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::sanctn::autokey::payload',plk,'');

// export Key_SANCTN_autokey_payload := plk;

d := dataset([],rec);

KeyName 			:= 'thor_data400::key::sanctn::';

export Key_SANCTN_autokey_payload := index(dedup(d,record,all)
                                          ,{fakeid}
										  ,{d}
										  ,Data_Services.Data_location.Prefix('sanctn')+ KeyName + doxie.Version_SuperKey + '::autokey::payload');




