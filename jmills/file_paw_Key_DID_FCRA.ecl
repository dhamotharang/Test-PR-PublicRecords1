// Output(paw.Key_DID_FCRA);

// Output(doxie_files.key_aircraft_did_FCRA);

// Output(Doxie.key_death_masterV2_ssa_DID_fcra);

#CONSTANT('DataLocationCC', 'NONAME');  
import paw;
key_in := paw.Key_DID_FCRA;

layout_out := RECORD
  unsigned6 did;
  unsigned6 contact_id;
  unsigned6 bdid;
  string9 ssn;
  string3 score;
  string120 company_name;
  string10 company_prim_range;
  string2 company_predir;
  string28 company_prim_name;
  string4 company_addr_suffix;
  string2 company_postdir;
  string5 company_unit_desig;
  string8 company_sec_range;
  string25 company_city;
  string2 company_state;
  string5 company_zip;
  string4 company_zip4;
  string35 company_title;
  string35 company_department;
  string10 company_phone;
  string9 company_fein;
  string5 title;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 addr_suffix;
  string2 postdir;
  string5 unit_desig;
  string8 sec_range;
  string25 city;
  string2 state;
  string5 zip;
  string4 zip4;
  string3 county;
  string4 msa;
  string10 geo_lat;
  string11 geo_long;
  string10 phone;
  string60 email_address;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string1 record_type;
  string1 active_phone_flag;
  string1 glb;
  string2 source;
  string2 dppa_state;
  string3 old_score;
  unsigned6 source_count;
  unsigned1 dead_flag;
  string10 company_status;
  string from_hdr;
  string vendor_id;
  unsigned8 rawaid;
  unsigned8 company_rawaid;
 END;

 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_paw_Key_DID_FCRA := project(key_in,makelayout(left));