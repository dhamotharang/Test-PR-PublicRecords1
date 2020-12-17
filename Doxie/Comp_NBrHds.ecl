import doxie, doxie_crs, census_data;
doxie.MAC_Selection_Declare()

a := doxie.Comp_Addresses(Include_CensusData_val);

r := record
  string2 st := a.st;
  string3 county := a.county;
  string6 tract := a.geo_blk[1..6];
  string1 blkgrp := a.geo_blk[7];
  end;
  
t := dedup( table( a, r ), all );

rec := doxie_crs.layout_Comp_NBrHds;
rec take(census_data.Key_Smart_Jury le) := transform
  self := le;
  end;

j := join(t,census_data.Key_Smart_Jury,left.st = right.stusab and 
																			 left.county = right.county and
																			 left.tract = right.tract and 
																			 left.blkgrp=right.blkgrp,
							    take(right), KEEP (1));
  
export Comp_NBrHds := j;