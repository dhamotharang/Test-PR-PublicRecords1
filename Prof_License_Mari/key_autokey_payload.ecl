import doxie, Data_Services, dx_common;

// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_search_delta_rid
// ---------------------------------------------------------------

rec := RECORD
  unsigned6 fakeid;
  unsigned6 mari_rid;
  string19 create_dte;
  string19 last_upd_dte;
  string19 stamp_dte;
  string8 date_first_seen;
  string8 date_last_seen;
  string8 date_vendor_first_reported;
  string8 date_vendor_last_reported;
  unsigned6 did;
  unsigned6 bdid;
  string3 std_prof_cd;
  string5 std_source_upd;
  string2 type_cd;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string1 addr_ind;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string30 p_city_name;
  string25 city_name;
  string2 st;
  string6 zip5;
  string4 zip4;
  string254 company;
  string1 tax_type;
  string9 ssn_taxid;
  string8 party_birth;
  string10 party_phone;
  string30 license_nbr;
  string30 off_license_nbr;
  string30 brkr_license_nbr;
  string2 license_state;
  unsigned8 mltreckey;
  unsigned8 cmc_slpk;
  unsigned8 pcmc_slpk;
  unsigned8 persistent_record_id;
  string30 cln_license_nbr;
  unsigned8 license_id;
  unsigned8 nmls_id;
  unsigned8 foreign_nmls_id;
  string150 regulator;
  string150 federal_regulator;
  //DF-28229 Add Delta build fields
  dx_common.layout_metadata;
 END;

d := dataset([],rec);
// filter_recs := d(addr_ind != '' and company != '' and (fname != '' and mname != '' and lname != ''));
KeyName 			:= 'thor_data400::key::proflic_mari::autokey::';

export key_autokey_payload := index(d,
                                 {fakeid}
                                 ,{d}
                                 ,Data_Services.Data_location.Prefix('mari')+ KeyName + doxie.Version_SuperKey + '::payload');
                                 
                                 
                                 
                                 
