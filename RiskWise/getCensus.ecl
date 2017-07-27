import census_data;

export getCensus(string2 state, string3 county_code, string7 geo_blk) := function
								
census_rec := Census_Data.Key_Smart_Jury(keyed(stusab=state), keyed(county=county_code), keyed(tract=geo_blk[1..6]), keyed(blkgrp=geo_blk[7]));

return census_rec;

end;
