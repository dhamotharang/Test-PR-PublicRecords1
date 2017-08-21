//EXPORT Layout_liensv2_fcra_liens_autokeypayload := 'todo';

export Layout_liensv2_fcra_liens_autokeypayload:=

record
/* addr := RECORD
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
*/
  unsigned6 fakeid;
  string name_type;
  unsigned4 party_bits;
  unsigned1 zero;
  string50 tmsid;
  string50 rmsid;
  unsigned6 intdid;
  unsigned6 intbdid;
  string cname;
  string9 ssn;
  string9 tax_id;
  //addr company_addr;
	string10 company_addr_prim_range;
   string2 company_addr_predir;
   string28 company_addr_prim_name;
   string4 company_addr_addr_suffix;
   string2 company_addr_postdir;
   string10 company_addr_unit_desig;
   string8 company_addr_sec_range;
   string25 company_addr_v_city_name;
   string2 company_addr_st;
   string5 company_addr_zip5;
   string4 company_addr_zip4;
   string2 company_addr_addr_rec_type;
   string2 company_addr_fips_state;
   string3 company_addr_fips_county;
   string10 company_addr_geo_lat;
   string11 company_addr_geo_long;
   string4 company_addr_cbsa;
   string7 company_addr_geo_blk;
   string1 company_addr_geo_match;
   string4 company_addr_err_stat;
  //addr person_addr;
	string10 person_addr_prim_range;
   string2 person_addr_predir;
   string28 person_addr_prim_name;
   string4 person_addr_addr_suffix;
   string2 person_addr_postdir;
   string10 person_addr_unit_desig;
   string8 person_addr_sec_range;
   string25 person_addr_v_city_name;
   string2 person_addr_st;
   string5 person_addr_zip5;
   string4 person_addr_zip4;
   string2 person_addr_addr_rec_type;
   string2 person_addr_fips_state;
   string3 person_addr_fips_county;
   string10 person_addr_geo_lat;
   string11 person_addr_geo_long;
   string4 person_addr_cbsa;
   string7 person_addr_geo_blk;
   string1 person_addr_geo_match;
   string4 person_addr_err_stat;

	
  //name person_name;
	
	 string5 person_name_title;
   string20 person_name_fname;
   string20 person_name_mname;
   string20 person_name_lname;
   string5 Person_name_name_suffix;
   string3 person_name_name_score;
  //unsigned8 __internal_fpos__;
 END;
