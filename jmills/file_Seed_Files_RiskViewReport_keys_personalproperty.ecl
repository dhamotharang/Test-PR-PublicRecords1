// Output(Seed_Files.RiskViewReport_keys.personalproperty);

#CONSTANT('DataLocationCC', 'NONAME');  
import Seed_Files;
key_in := Seed_Files.RiskViewReport_keys.personalproperty;

layout_out := RECORD
  string20 dataset_name;
  data16 hashvalue;
  string30 acctno;
  string15 fname;
  string20 lname;
  string9 zip;
  string9 in_ssn;
  string10 hphone;
  string2 seq;
  string16 _type;
  string32 description;
  string16 id;
  string4 reg_year;
  string2 reg_month;
  string2 reg_day;
  string2 registrationstate;
  unsigned8 __internal_fpos__;
 END;


 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_Seed_Files_RiskViewReport_keys_personalproperty := project(key_in,makelayout(left));