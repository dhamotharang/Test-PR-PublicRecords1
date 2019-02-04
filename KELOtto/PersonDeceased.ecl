﻿IMPORT KELOtto;
PersonDeceasedLayout := RECORD
  string30 acctno;
  string30 matchcode;
  boolean isdeepdive;
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
  string5 zip;
  string4 zip4;
  string18 county_name;
  string76 address;
  string77 county_residence;
  string23 county_death;
  string12 did;
  unsigned1 did_score;
  string8 filedate;
  string1 rec_type;
  string1 rec_type_orig;
  string9 ssn;
  string20 lname;
  string4 name_suffix;
  string15 fname;
  string15 mname;
  string1 vorp_code;
  string8 dod8;
  string8 dob8;
  string2 st_country_code;
  string5 zip_lastres;
  string5 zip_lastpayment;
  string2 state;
  string3 fipscounty;
  string1 state_death_flag;
  string3 death_rec_src;
  string16 state_death_id;
  string errorcode;
  unsigned8 record_id;
  unsigned6 fdn_file_info_id;
 END;


rPersonDeceasedLayout := RECORD
  string30 acctno;
  string30 matchcode;
  boolean isdeepdive;
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
  string5 zip;
  string4 zip4;
  string18 county_name;
  string76 address;
  string77 county_residence;
  string23 county_death;
  UNSIGNED8 did;
  unsigned1 did_score;
  string8 filedate;
  string1 rec_type;
  string1 rec_type_orig;
  string9 ssn;
  string20 lname;
  string4 name_suffix;
  string15 fname;
  string15 mname;
  string1 vorp_code;
  string8 dod8;
  string8 dob8;
  string2 st_country_code;
  string5 zip_lastres;
  string5 zip_lastpayment;
  string2 state;
  string3 fipscounty;
  string1 state_death_flag;
  string3 death_rec_src;
  string16 state_death_id;
  string errorcode;
  unsigned8 record_id;
  unsigned6 fdn_file_info_id;
 END;

 
PersonDeceasedFile := PROJECT(PULL(DATASET(KELOtto.Constants.fileLocation+'base::qa::death', PersonDeceasedLayout, THOR)), TRANSFORM(rPersonDeceasedLayout, SELF.did := (UNSIGNED)LEFT.did, SELF := LEFT));

EXPORT PersonDeceased := JOIN(KELOtto.CustomerLexId, PersonDeceasedFile, LEFT.did=(INTEGER)RIGHT.did, TRANSFORM({LEFT.AssociatedCustomerFileInfo, RECORDOF(RIGHT)}, SELF := RIGHT, SELF := LEFT), HASH,KEEP(1));