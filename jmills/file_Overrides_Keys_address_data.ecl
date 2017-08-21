// Output(Overrides.Keys.address_data);

#CONSTANT('DataLocationCC', 'NONAME');  
import Overrides;
key_in := Overrides.Keys.address_data;

layout_out := RECORD
  string20 flag_file_id;
  unsigned6 did;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  integer8 avm_1_yr;
  integer8 avm_5_yrs;
  integer8 current_adls_per_address;
  integer8 current_ssns_per_address;
  integer8 current_phones_per_address;
 END;



 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_Overrides_Keys_address_data := project(key_in,makelayout(left));