﻿IMPORT KELOtto;

r:= RECORD
  string12 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string120 in_streetaddress;
  string25 in_city;
  string2 in_state;
  string5 in_zipcode;
  string25 in_country;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 st;
  string5 z5;
  string4 zip4;
  string10 lat;
  string11 long;
  string3 county;
  string7 geo_blk;
  string1 addr_type;
  string4 addr_status;
  string25 country;
  string9 ssn;
  string8 dob;
  string3 age;
  string20 dl_number;
  string2 dl_state;
  string50 email_address;
  string45 ip_address;
  string10 phone10;
  string10 wphone10;
  string100 employer_name;
  string20 lname_prev;
  string12 transaction_id;
  string20 verfirst;
  string20 verlast;
  string65 veraddr;
  string25 vercity;
  string2 verstate;
  string5 verzip;
  string4 verzip4;
  string9 verssn;
  string8 verdob;
  string10 verhphone;
  string1 verify_addr;
  string1 verify_dob;
  string1 valid_ssn;
  string3 nas_summary;
  string3 nap_summary;
  string3 cvi;
  string4 hri_1;
  string100 hri_desc_1;
  string4 hri_2;
  string100 hri_desc_2;
  string4 hri_3;
  string100 hri_desc_3;
  string4 hri_4;
  string100 hri_desc_4;
  string4 hri_5;
  string100 hri_desc_5;
  string4 hri_6;
  string100 hri_desc_6;
  string20 corrected_lname;
  string8 corrected_dob;
  string10 corrected_phone;
  string9 corrected_ssn;
  string65 corrected_address;
  string3 area_code_split;
  string8 area_code_split_date;
  string20 phone_fname;
  string20 phone_lname;
  string65 phone_address;
  string25 phone_city;
  string2 phone_st;
  string5 phone_zip;
  string10 name_addr_phone;
  string6 ssa_date_first;
  string6 ssa_date_last;
  string2 ssa_state;
  string20 ssa_state_name;
  string20 current_fname;
  string20 current_lname;
  string65 chron_address_1;
  string25 chron_city_1;
  string2 chron_st_1;
  string5 chron_zip_1;
  string4 chron_zip4_1;
  string50 chron_phone_1;
  string6 chron_dt_first_seen_1;
  string6 chron_dt_last_seen_1;
  string65 chron_address_2;
  string25 chron_city_2;
  string2 chron_st_2;
  string5 chron_zip_2;
  string4 chron_zip4_2;
  string50 chron_phone_2;
  string6 chron_dt_first_seen_2;
  string6 chron_dt_last_seen_2;
  string65 chron_address_3;
  string25 chron_city_3;
  string2 chron_st_3;
  string5 chron_zip_3;
  string4 chron_zip4_3;
  string50 chron_phone_3;
  string6 chron_dt_first_seen_3;
  string6 chron_dt_last_seen_3;
  string20 additional_fname_1;
  string20 additional_lname_1;
  string8 additional_lname_date_last_1;
  string20 additional_fname_2;
  string20 additional_lname_2;
  string8 additional_lname_date_last_2;
  string20 additional_fname_3;
  string20 additional_lname_3;
  string8 additional_lname_date_last_3;
  string1 high_risk_address;
  string2 high_risk_address_rc1;
  string2 high_risk_address_rc2;
  string2 high_risk_address_rc3;
  string2 high_risk_address_rc4;
  string20 vercounty;
  string1 chron_addr_1_isbest;
  string1 chron_addr_2_isbest;
  string1 chron_addr_3_isbest;
  string3 subjectssncount;
  string20 verdl;
  string8 deceaseddate;
  string8 deceaseddob;
  string15 deceasedfirst;
  string20 deceasedlast;
  string1 dobmatchlevel;
  string4 hri_7;
  string100 hri_desc_7;
  string4 hri_8;
  string100 hri_desc_8;
  string4 hri_9;
  string100 hri_desc_9;
  string4 hri_10;
  string100 hri_desc_10;
  string4 hri_11;
  string100 hri_desc_11;
  string4 hri_12;
  string100 hri_desc_12;
  string4 hri_13;
  string100 hri_desc_13;
  string4 hri_14;
  string100 hri_desc_14;
  string4 hri_15;
  string100 hri_desc_15;
  string4 hri_16;
  string100 hri_desc_16;
  string4 hri_17;
  string100 hri_desc_17;
  string4 hri_18;
  string100 hri_desc_18;
  string4 hri_19;
  string100 hri_desc_19;
  string4 hri_20;
  string100 hri_desc_20;
  string1 stolenidentityindex;
  string1 syntheticidentityindex;
  string1 manipulatedidentityindex;
  string1 vulnerablevictimindex;
  string1 friendlyfraudindex;
  string1 suspiciousactivityindex;
  boolean ssnfoundforlexid;
  boolean addresspobox;
  boolean addresscmra;
  string3 cvicustomscore;
  string1 instantidversion;
  string errorcode;
  unsigned8 record_id;
  unsigned6 fdn_file_info_id;
 END;

newr := RECORD
  UNSIGNED8 did;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 suffix;
  string120 in_streetaddress;
  string25 in_city;
  string2 in_state;
  string5 in_zipcode;
  string25 in_country;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string2 st;
  string5 z5;
  string4 zip4;
  string10 lat;
  string11 long;
  string3 county;
  string7 geo_blk;
  string1 addr_type;
  string4 addr_status;
  string25 country;
  string9 ssn;
  string8 dob;
  string3 age;
  string20 dl_number;
  string2 dl_state;
  string50 email_address;
  string45 ip_address;
  string10 phone10;
  string10 wphone10;
  string100 employer_name;
  string20 lname_prev;
  string12 transaction_id;
  string20 verfirst;
  string20 verlast;
  string65 veraddr;
  string25 vercity;
  string2 verstate;
  string5 verzip;
  string4 verzip4;
  string9 verssn;
  string8 verdob;
  string10 verhphone;
  string1 verify_addr;
  string1 verify_dob;
  string1 valid_ssn;
  string3 nas_summary;
  string3 nap_summary;
  string3 cvi;
  string4 hri_1;
  string100 hri_desc_1;
  string4 hri_2;
  string100 hri_desc_2;
  string4 hri_3;
  string100 hri_desc_3;
  string4 hri_4;
  string100 hri_desc_4;
  string4 hri_5;
  string100 hri_desc_5;
  string4 hri_6;
  string100 hri_desc_6;
  string20 corrected_lname;
  string8 corrected_dob;
  string10 corrected_phone;
  string9 corrected_ssn;
  string65 corrected_address;
  string3 area_code_split;
  string8 area_code_split_date;
  string20 phone_fname;
  string20 phone_lname;
  string65 phone_address;
  string25 phone_city;
  string2 phone_st;
  string5 phone_zip;
  string10 name_addr_phone;
  string6 ssa_date_first;
  string6 ssa_date_last;
  string2 ssa_state;
  string20 ssa_state_name;
  string20 current_fname;
  string20 current_lname;
  string65 chron_address_1;
  string25 chron_city_1;
  string2 chron_st_1;
  string5 chron_zip_1;
  string4 chron_zip4_1;
  string50 chron_phone_1;
  string6 chron_dt_first_seen_1;
  string6 chron_dt_last_seen_1;
  string65 chron_address_2;
  string25 chron_city_2;
  string2 chron_st_2;
  string5 chron_zip_2;
  string4 chron_zip4_2;
  string50 chron_phone_2;
  string6 chron_dt_first_seen_2;
  string6 chron_dt_last_seen_2;
  string65 chron_address_3;
  string25 chron_city_3;
  string2 chron_st_3;
  string5 chron_zip_3;
  string4 chron_zip4_3;
  string50 chron_phone_3;
  string6 chron_dt_first_seen_3;
  string6 chron_dt_last_seen_3;
  string20 additional_fname_1;
  string20 additional_lname_1;
  string8 additional_lname_date_last_1;
  string20 additional_fname_2;
  string20 additional_lname_2;
  string8 additional_lname_date_last_2;
  string20 additional_fname_3;
  string20 additional_lname_3;
  string8 additional_lname_date_last_3;
  string1 high_risk_address;
  string2 high_risk_address_rc1;
  string2 high_risk_address_rc2;
  string2 high_risk_address_rc3;
  string2 high_risk_address_rc4;
  string20 vercounty;
  string1 chron_addr_1_isbest;
  string1 chron_addr_2_isbest;
  string1 chron_addr_3_isbest;
  string3 subjectssncount;
  string20 verdl;
  string8 deceaseddate;
  string8 deceaseddob;
  string15 deceasedfirst;
  string20 deceasedlast;
  string1 dobmatchlevel;
  string4 hri_7;
  string100 hri_desc_7;
  string4 hri_8;
  string100 hri_desc_8;
  string4 hri_9;
  string100 hri_desc_9;
  string4 hri_10;
  string100 hri_desc_10;
  string4 hri_11;
  string100 hri_desc_11;
  string4 hri_12;
  string100 hri_desc_12;
  string4 hri_13;
  string100 hri_desc_13;
  string4 hri_14;
  string100 hri_desc_14;
  string4 hri_15;
  string100 hri_desc_15;
  string4 hri_16;
  string100 hri_desc_16;
  string4 hri_17;
  string100 hri_desc_17;
  string4 hri_18;
  string100 hri_desc_18;
  string4 hri_19;
  string100 hri_desc_19;
  string4 hri_20;
  string100 hri_desc_20;
  string1 stolenidentityindex;
  string1 syntheticidentityindex;
  string1 manipulatedidentityindex;
  string1 vulnerablevictimindex;
  string1 friendlyfraudindex;
  string1 suspiciousactivityindex;
  boolean ssnfoundforlexid;
  boolean addresspobox;
  boolean addresscmra;
  string3 cvicustomscore;
  string1 instantidversion;
  string errorcode;
  unsigned8 record_id;
  unsigned6 fdn_file_info_id;
  STRING Hri;
 END;

BankAccountDLRiskTestSet := [899999998929,899999998994,899999998641,899999998535,899999998020,899999998131,899999999639,899999999174,899999999256,899999999449,899999999221,899999998936,899999998390,899999998866,899999998686,899999999011,899999999326,899999998561,899999998905,899999999111,899999999925,899999999914,899999998064,899999998214,899999998074,899999998069,899999999053,899999999223,899999998058,899999999585,899999998924,899999998455,899999999176,899999998386,899999998776,899999999693,899999998471,899999999560,899999999795,899999998157,899999999675,899999999306,899999999160,899999999560,899999999560,899999999291,899999999313,899999998938,899999998783,899999998140];

PersonCIIDAttr1 := PROJECT(PULL(dataset(KELOtto.Constants.fileLocation+'base::qa::ciid',r,flat)), 
//PersonCIIDAttr1 := PROJECT(PULL(dataset('~foreign::10.173.44.105::thor_data400::base::fraudgov::qa::ciid',r,flat)), 
              TRANSFORM(newr, self.did := (UNSIGNED8)left.did, 
							SELF.Hri := TRIM(LEFT.hri_1) + '|' + TRIM(LEFT.hri_2) + '|' + TRIM(LEFT.hri_3) + '|' + TRIM(LEFT.hri_4) + '|' + TRIM(LEFT.hri_5) + '|' + TRIM(LEFT.hri_6) + '|' + TRIM(LEFT.hri_7) + '|' + TRIM(LEFT.hri_8) + '|' + TRIM(LEFT.hri_9) + '|' + TRIM(LEFT.hri_10) + '|' + TRIM(LEFT.hri_11) + '|' + TRIM(LEFT.hri_12) + '|' + TRIM(LEFT.hri_13) + '|' + TRIM(LEFT.hri_14) + '|' + TRIM(LEFT.hri_15) + '|' + TRIM(LEFT.hri_16) + '|' + TRIM(LEFT.hri_17) + '|' + TRIM(LEFT.hri_18) + '|' + TRIM(LEFT.hri_19) + '|' + TRIM(LEFT.hri_20);
              // take this out after testing this is just for force known risk for dl for testing!!!
              //MAP((INTEGER)LEFT.did in BankAccountDLRiskTestSet => '|DF|45',''),
							SELF := LEFT));

PersonCIIDAttr := JOIN(PersonCIIDAttr1, KELOtto.fraudgov, left.record_id=right.record_id, 
              TRANSFORM({RECORDOF(LEFT), UNSIGNED8 OttoAddressId}, 
              SELF.OttoAddressId := HASH32(RIGHT.address_1, RIGHT.address_2),
              SELF := LEFT), KEEP(1), HASH);

EXPORT PersonCIID := JOIN(KELOtto.CustomerLexId, PersonCIIDAttr, LEFT.did=(INTEGER)RIGHT.did, TRANSFORM({LEFT.AssociatedCustomerFileInfo, RECORDOF(RIGHT)}, SELF := RIGHT, SELF := LEFT), HASH, KEEP(1));

