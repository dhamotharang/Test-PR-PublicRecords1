// Output(Seed_Files.key_MVRInsurance);

#CONSTANT('DataLocationCC', 'NONAME');  
import Seed_Files;
key_in := Seed_Files.key_MVRInsurance;

layout_out := RECORD
  data16 hashvalue;
  string20 table_name;
  string10 model_name;
  string20 last;
  string20 first;
  string9 ssn;
  string5 zip5;
  real8 score;
  unsigned8 __internal_fpos__;
 END;


 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_Seed_Files_key_MVRInsurance := project(key_in,makelayout(left));