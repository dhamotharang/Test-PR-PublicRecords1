// Output(Seed_Files.RiskViewReport_keys.creditinquiry);

#CONSTANT('DataLocationCC', 'NONAME');  
import Seed_Files;
key_in := Seed_Files.RiskViewReport_keys.creditinquiry;

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
  string4 year;
  string2 month;
  string2 day;
  string32 _type;
  string32 industry;
  unsigned8 __internal_fpos__;
 END;


 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_Seed_Files_RiskViewReport_keys_creditinquiry := project(key_in,makelayout(left));