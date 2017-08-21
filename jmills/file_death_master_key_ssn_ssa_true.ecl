//Output(death_master.key_ssn_ssa(true));

#CONSTANT('DataLocationCC', 'NONAME');  
import death_master;
key_in := death_master.key_ssn_ssa(true);

layout_out := RECORD
  string9 ssn;
  string12 did;
  unsigned1 did_score;
  string8 filedate;
  string1 rec_type;
  string1 rec_type_orig;
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
  string2 crlf;
  string1 state_death_flag;
  string3 death_rec_src;
  string16 state_death_id;
  string2 src;
  string1 glb_flag;
  unsigned8 __internal_fpos__;
 END;
 
 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_death_master_key_ssn_ssa_true := project(key_in,makelayout(left));
