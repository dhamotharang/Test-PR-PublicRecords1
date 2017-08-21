#CONSTANT('DataLocationCC', 'NONAME');  
import FCRA;
key_in := FCRA.Key_Override_AVM_Medians_ffid.avm_medians;

layout_out := RECORD
  string20 flag_file_id;
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
  string12 geolink;
  unsigned8 median_county_value;
  unsigned8 median_tract_value;
  unsigned8 median_block_value;
 END;

 
 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_FCRA_Key_Override_AVM_Medians_ffid := project(key_in,makelayout(left));