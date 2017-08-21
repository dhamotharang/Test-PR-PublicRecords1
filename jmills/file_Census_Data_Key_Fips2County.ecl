// Output(COUNT(Census_Data.Key_Fips2County));
// Output(Census_Data.Key_Fips2County);

#CONSTANT('DataLocationCC', 'NONAME');  
import Census_Data;
key_in := Census_Data.Key_Fips2County;

layout_out := RECORD
  string2 state_code;
  string3 county_fips;
  string18 county_name;
  unsigned8 __internal_fpos__;
 END;
 
 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_Census_Data_Key_Fips2County := project(key_in,makelayout(left));