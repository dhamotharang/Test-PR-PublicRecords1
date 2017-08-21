// Output(FCRA.Key_Override_PCR_UID);

#CONSTANT('DataLocationCC', 'NONAME');  
import FCRA;
key_in := FCRA.Key_Override_PCR_UID;

layout_out := RECORD
  string13 uid;
  string8 date_created;
  string8 dt_first_seen;
  string8 dt_last_seen;
  string12 did;
  string1 consumer_statement_flag;
  string20 fname;
  string20 mname;
  string20 lname;
  string5 name_suffix;
  string9 ssn;
  string8 dob;
  string1 dispute_flag;
  string1 security_freeze;
  string6 security_freeze_pin;
  string1 security_alert;
  string1 negative_alert;
  string1 id_theft_flag;
  string1 insuff_inqry_data;
  string3 did_score;
  unsigned8 __internal_fpos__;
 END;

 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_FCRA_Key_Override_PCR_UID := project(key_in,makelayout(left));