// Output(Seed_Files.RiskViewReport_keys.filing);

#CONSTANT('DataLocationCC', 'NONAME');  
import Seed_Files;
key_in := Seed_Files.RiskViewReport_keys.filing;

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
  string16 recordtype;
  string32 description;
  string16 status;
  string4 filing_year;
  string2 filing_month;
  string2 filing_day;
  string4 lastaction_year;
  string2 lastaction_month;
  string2 lastaction_day;
  unsigned8 __internal_fpos__;
 END;


 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_Seed_Files_RiskViewReport_keys_filing := project(key_in,makelayout(left));