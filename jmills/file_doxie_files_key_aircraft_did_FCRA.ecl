// Output(doxie_files.key_aircraft_did_FCRA);

// Output(Doxie.key_death_masterV2_ssa_DID_fcra);

#CONSTANT('DataLocationCC', 'NONAME');  
import doxie_files;
key_in := doxie_files.key_aircraft_did_FCRA;

layout_out := RECORD
  unsigned6 did;
  string3 d_score;
  string9 best_ssn;
  string12 did_out;
  string12 bdid_out;
  string8 date_first_seen;
  string8 date_last_seen;
  string1 current_flag;
  string8 n_number;
  string30 serial_number;
  string12 mfr_mdl_code;
  string11 eng_mfr_mdl;
  string8 year_mfr;
  string15 type_registrant;
  string50 name;
  string33 street;
  string33 street2;
  string18 city;
  string5 state;
  string10 zip_code;
  string6 region;
  string6 orig_county;
  string7 country;
  string16 last_action_date;
  string15 cert_issue_date;
  string13 certification;
  string13 type_aircraft;
  string11 type_engine;
  string11 status_code;
  string11 mode_s_code;
  string11 fract_owner;
  string30 aircraft_mfr_name;
  string20 model_name;
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
  string4 z4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dpbc;
  string1 chk_digit;
  string2 rec_type;
  string2 ace_fips_st;
  string3 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  string4 err_stat;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string50 compname;
  string1 lf;
  unsigned8 __fpos;
 END;

 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_doxie_files_key_aircraft_did_FCRA := project(key_in,makelayout(left));