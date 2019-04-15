// shared for a lot of different keys:
prepped := $.layout_prep_for_keys;
head := $.layout_header;

EXPORT layouts := MODULE

  EXPORT i_rid := RECORD
    unsigned6 rid;
    unsigned6 did;
    unsigned6 first_seen;
      //why unsigned6?
    unsigned3 dt_nonglb_last_seen;
  END;

  EXPORT i_source := RECORD
    unsigned6 uid;
    string2 src;
  END;

  EXPORT i_rid_src := RECORD
    unsigned6 rid;
    i_source;
  END;

  // wild_FnameSmall
  EXPORT i_wild_FnameSmall := RECORD
    string20 fname;
    string2 st;
    integer4 zip;
    string28 prim_name;
    prepped.dob;
    prepped.states;
    prepped.lname1;
    prepped.lname2;
    prepped.lname3;
    prepped.city1;
    prepped.city2;
    prepped.city3;
    prepped.rel_fname1;
    prepped.rel_fname2;
    prepped.rel_fname3;
    prepped.lookups;
    prepped.did;
    integer fname_count := 1;
  END;

  EXPORT i_wild_StreetZipName := RECORD
    string28 prim_name;
    integer4 zip;
    string10 prim_range;
    string20 lname;
    string20 fname;
    prepped.dob;
    prepped.states;
    prepped.lname1;
    prepped.lname2;
    prepped.lname3;
    prepped.city1;
    prepped.city2;
    prepped.city3;
    prepped.rel_fname1;
    prepped.rel_fname2;
    prepped.rel_fname3;
    prepped.lookups;
    prepped.did;
  END;


  EXPORT i_hhid := RECORD
    unsigned4 first_current;
    unsigned4 last_current;
    unsigned6 did;
    unsigned6 rid;
    data10 addr_id;
    qstring20 lname;
    unsigned4 oc_size;
    unsigned4 lname_weight;
    unsigned6 hhid;
    unsigned6 hhid_indiv;
    unsigned6 hhid_relat;
    unsigned1 ver; 
  END;

  // formely in doxie/keytype_zip_did.ecl
  EXPORT i_zip_did := record
    qstring20 lname;
    string1 fi;
    qstring20 fname;
    unsigned3 zip;
    unsigned4 dt_last_seen;  
    unsigned4 cnt;
    unsigned6 b_did;
    unsigned6 l_did;
  END;

  EXPORT i_zip_did_full := record
    string20 p_lname;
    string20 p_fname;
    unsigned3 zip;
    string20 lname;
    string20 fname;
    string20  mname;
    string1 mi;
    string5  name_suffix;
    unsigned4 dt_last_seen;  
    unsigned4 cnt;
    unsigned6 b_did;
    unsigned6 l_did;
  END;

  EXPORT i_DA := RECORD
    string4 l4;
    prepped.st;
    unsigned4 city_code;
    string3 f3;
    prepped.lname;
    prepped.fname;
    prepped.yob;
    prepped.states;
    prepped.lname1;
    prepped.lname2;
    prepped.lname3;
    prepped.city1;
    prepped.city2;
    prepped.city3;
    prepped.rel_fname1;
    prepped.rel_fname2;
    prepped.rel_fname3;
    prepped.lookups;
    prepped.did;
  END;

  EXPORT i_StreetZipName := RECORD
    string28 prim_name;
    integer4 zip;
    string6 dph_lname;
    string20 pfname;
    string10 prim_range;
    string20 lname;
    string20 fname;
    prepped.dob;
    prepped.states;
    prepped.lname1;
    prepped.lname2;
    prepped.lname3;
    prepped.city1;
    prepped.city2;
    prepped.city3;
    prepped.rel_fname1;
    prepped.rel_fname2;
    prepped.rel_fname3;
    prepped.lookups;
    prepped.did;
  END;



shared rec_lookup := record
  unsigned6 did;
  unsigned2 sex_cnt;
  unsigned2 crim_cnt;
  unsigned2 ccw_cnt;
  unsigned2 head_cnt;
  unsigned2 veh_cnt;
  unsigned2 dl_cnt;
  unsigned2 rel_count;
  unsigned2 fire_count;
  unsigned2 faa_count;
  unsigned2 vess_count;
  unsigned2 prof_count;
  unsigned2 bus_count;
  unsigned2 prop_count;
  unsigned2 bk_count;
  unsigned2 prop_asses_count;
  unsigned2 prop_deeds_count;
  unsigned2 paw_count;
  unsigned2 bc_count;
end;

  EXPORT i_lookups := RECORD //resrec in doxie/key_DID_lookups
    rec_lookup; 
    unsigned6 hhid;
    string1   gender;
    unsigned2 house_size;
    unsigned2 sg_within_7;
    unsigned2 dg_within_7;
    unsigned2 ug_within_7;
    unsigned2 sg_y_8_15;
    unsigned2 dg_y_8_15;
    unsigned2 ug_y_8_15;
    unsigned2 sg_y_16_30;
    unsigned2 dg_y_16_30;
    unsigned2 ug_y_16_30;
    unsigned2 sg_o_8_15;
    unsigned2 dg_o_8_15;
    unsigned2 ug_o_8_15;
    unsigned2 sg_o_16_30;
    unsigned2 dg_o_16_30;
    unsigned2 ug_o_16_30;
    unsigned2 sg_o_30;
    unsigned2 dg_o_30;
    unsigned2 ug_o_30;
    unsigned2 sg_y_30;
    unsigned2 dg_y_30;
    unsigned2 ug_y_30;
    unsigned2 sg;
    unsigned2 dg;
    unsigned2 ug;
    unsigned2 kids;
    unsigned2 parents;
  END;

  EXPORT i_nbr_address := RECORD 
    head.prim_name;
    head.prim_range;
    head.sec_range;
    head.zip;
    head.zip4;
    head.suffix;
    head.did;
    head.dt_first_seen;
    head.dt_last_seen;
    head.RawAID;
    qstring2 z2; //will be defined in the data_ attribute.
  END;

  // used to be defined through "df := doxie.nbr_headers;"; the file is derived from header main layout
  EXPORT i_nbr_headers := RECORD
    head.zip;
    head.prim_name;
    head.suffix;
    head.predir;
    head.postdir;
    head.prim_range;
    head.sec_range;
    head.RawAID;
    unsigned6 uid := 0;    
  END;

  EXPORT i_nbr_uid := RECORD //~doxie.nbr_headers
    head.zip;
    head.prim_name;
    head.suffix;
    head.predir;
    head.postdir;
    head.did;
    head.prim_range;
    head.sec_range;
    head.dt_first_seen;
    head.dt_last_seen;
    head.rid;
    head.pflag3;
    head.ssn;
    head.tnt;
    head.dt_nonglb_last_seen;
    head.src;
    head.valid_SSN;
    head.phone;
    head.title;
    head.fname;
    head.mname;
    head.lname;
    head.name_suffix;
    head.unit_desig;
    head.city_name;
    head.st;
    head.zip4;
    head.county;
    head.geo_blk;
    head.dob;
    string18 county_name;
    head.RawAID;
    unsigned6 uid;
  END;


  EXPORT i_did_rid := record //doxie/KeyType_Rid_Did (TODO: can be deleted?)
    unsigned6 rid;
    unsigned6 did;
    boolean stable;
  END;

  // TODO: i_did_rid with a blank stable can be reused.
  EXPORT i_did_rid2 := i_did_rid - stable;

  EXPORT i_address_research := RECORD
    head.prim_range;
    head.prim_name;
    head.zip;
    head.predir;
    head.suffix;
    unsigned8 first_seen;
    unsigned8 last_seen;
    string3 addr_type,
    string2 stusab;
    string3 county;
    string6 tract;
    string1 blkgrp;
  END;

  EXPORT i_aptbuildings := RECORD // res_type in header/ApartmentBuildings, ultimately from Header/File_Headers
    head.prim_range;
    head.predir;
    head.prim_name;
    head.zip;
    head.suffix;
    integer4 apt_cnt;
    integer4 did_cnt;
  END;

  EXPORT i_did_ssn_date := RECORD //slim_rec in key_DID_SSN_Date 
    unsigned6 did;
    qstring9 ssn;
    unsigned3 best_date;
  END;

  EXPORT i_county := RECORD //slim in key_header_county
    string20 lname;
    string18 county_name;
    string2 st;
    string20 fname;
    string20 mname;
    unsigned6 did;
  END;

  EXPORT i_fnamesmall := RECORD //fnamerec in key_header_FnameSmall
    string20 pfname;
    string2 st;
    integer4 zip;
    string28 prim_name;
    prepped.dob;
    prepped.states;
    prepped.lname1;
    prepped.lname2;
    prepped.lname3;
    prepped.city1;
    prepped.city2;
    prepped.city3;
    prepped.rel_fname1;
    prepped.rel_fname2;
    prepped.rel_fname3;
    prepped.lookups;
    prepped.did;
    integer fname_count;
  END;

  EXPORT i_phonetic_lname := RECORD //header/layout_phonetic_lname TODO: delete?
    string6 dph_lname;     // phonetization (phonetic key) of a given last name
    string20 lname;        // suppozed to be unique
    unsigned6 name_count := 1;  // last name frequency
    unsigned6 did_count  := 1;  // number of distinguished dids for every name
    unsigned6 pkey_count := 1;  // phonetic key frequency
  END;

  EXPORT i_header_address := RECORD //slim_f
    head.did;
    head.src;
    head.dt_first_seen;
    head.dt_last_seen;
    head.phone;
    head.ssn;
    head.dob;
    head.fname;
    head.lname;
    head.prim_range;
    head.predir;
    head.prim_name;
    head.suffix;
    head.postdir;
    head.unit_desig;
    head.sec_range;
    head.city_name;
    head.st;
    head.zip;
    head.zip4;
    head.county;
    head.geo_blk;
  END;

  EXPORT i_dts_address := RECORD //out_rec in key_header_DTS_address.ecl
    string28 prim_name;
    string10 prim_range;
    string2 st;
    unsigned4 city_code; 
    string5 zip;
    unsigned3 dt_last_seen;  
    string8 sec_range;
    string6 dph_lname;
    string20 lname;
    string20 pfname;
    string20 fname;
    unsigned3 dt_first_seen;
    unsigned8 states;
    unsigned4 lname1;
    unsigned4 lname2;
    unsigned4 lname3;
    unsigned4 lookups;
    unsigned6 did;  
  END;

  EXPORT i_dts_FnameSmall := RECORD //out_rec in data_key_DTS_FnameSmall
    string20 pfname;
    string2 st;
    integer4 zip;
    unsigned3 dt_last_seen;
    string28 prim_name;  
    unsigned3 dt_first_seen;  
    integer4 dob;
    unsigned8 states;
    unsigned4 lname1;
    unsigned4 lname2;
    unsigned4 lname3;
    unsigned4 city1;
    unsigned4 city2;
    unsigned4 city3;
    unsigned4 rel_fname1;
    unsigned4 rel_fname2;
    unsigned4 rel_fname3;
    unsigned4 lookups;
    unsigned6 did;
    integer fname_count;
  END;

  EXPORT i_dts_StreetZipName := RECORD //out_rec in key_header_DTS_StreetZipName
    string28 prim_name;
    integer4 zip;
    unsigned3 dt_last_seen;  
    string6 dph_lname;
    string20 pfname;
    string10 prim_range;
    string20 lname;
    string20 fname;
    unsigned3 dt_first_seen;
    integer4 dob;
    unsigned8 states;
    unsigned4 lname1;
    unsigned4 lname2;
    unsigned4 lname3;
    unsigned4 city1;
    unsigned4 city2;
    unsigned4 city3;
    unsigned4 rel_fname1;
    unsigned4 rel_fname2;
    unsigned4 rel_fname3;
    unsigned4 lookups;
    unsigned6 did;
  END;

  EXPORT i_ssn4 := RECORD //layout_ssn_last4 in key_header_SSN4
    string4 ssn4;
    string20 lname;
    string20 fname;
    unsigned6 did;
  END;

  EXPORT i_ssn4_v2 := RECORD //layout_ssn_last4 in key_header_SSN4_V2
    string4 ssn4;
    string6 dph_lname;
    string20 lname;
    string20 pfname;
    string20 fname;
    unsigned6 did;
  END;

  EXPORT i_ssn5 := RECORD // layout_ssn_last5 in key_header_SSN4
    string5 ssn5;
    string20 lname;
    string20 fname;
    unsigned6 did;
  END;  

  EXPORT i_minors := RECORD // layout_ssn_last5 in key_header_SSN4
    unsigned4 hash32_did := 0; // to avoid redundant assignment in data_key_minors
    head.did;
    head.dob;
  END;  


  EXPORT i_DOBName := RECORD // layout_dob_key in key_header_DOBName, ultimately from prepped_for_keys
    //TODO: can be replaced with prepped.x ...
    unsigned2 yob;
    string6 dph_lname;
    string20 lname;
    string20 pfname;
    string20 fname;
    unsigned1 mob;
    unsigned1 day;
    string2 st;
    string5 zip;
    integer4 dob;
    unsigned6 did;
  END;

  EXPORT i_max_date := RECORD
    //head.dt_last_seen;
    unsigned3 max_date_last_seen;
  END;

  EXPORT i_dob_fname := RECORD //layout_slim in doxie.file_header_dob_fname
    // TODO: can be defined as prepped.
    string2 f2; // key_dob_fname
    string2 pf2; // key_dob_pfname
    unsigned6 did;
    integer4 dob;
    string20 fname;
    string20 pfname;
    string2 st;
    string5 zip;
  END;

  EXPORT i_legacy_ssn := RECORD
    head.ssn;
    head.did;
  END;  

  EXPORT i_tuch_dob := RECORD
    head.did;
    head.rid;
    head.src;
    head.dob;
    head.dt_first_seen;
    head.dt_last_seen;
  END;

  EXPORT i_addr_hist := RECORD //hierarchy_layout in header/proc_address_hist
    unsigned s_did;
    STRING10 prim_range;
    STRING2  predir;
    STRING28 prim_name;
    STRING4  suffix;
    STRING2  postdir;
    STRING10 unit_desig;
    STRING8  sec_range;
    STRING5  zip;
    Unsigned3 date_first_seen;
    Unsigned3 date_last_seen;
    Integer address_history_seq;
    unsigned2 source_count;
    unsigned2 insurance_source_count;
    string5 addressstatus;
    string3 addresstype;
    unsigned2 bureau_source_count;
    unsigned2 property_source_count;
    unsigned2 utility_source_count;
    unsigned2 vehicle_source_count;
    unsigned2 dl_source_count;
    unsigned2 voter_source_count;
    unsigned8 RawAid;
  END;

  //implicitely defined in Header\fn_DMV_restricted.ecl as {pull (doxie.Key_Header) + boolean exclusivedmvsourced}

  EXPORT i_DMV_restricted := RECORD 
    $.layout_key_header - s_did;
    boolean exclusivedmvsourced;
    //unsigned8 __internal_fpos__; //TODO: remove?
  END;  

  EXPORT i_ParentLnames := RECORD
    head.lname;
    head.did;
    integer8 cnt;
  END;

END;
  
