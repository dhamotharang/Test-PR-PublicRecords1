import $, AID_BUILD;

layouts.AID_LAYOUT	xformAID(files.Search L) := transform
	
  // self.aceaid		:= L.cleanaid;
  // self.st				:= L.state;
	self.addr_suffix  := L.suffix;
  self.dbpc					:= L.dpbc;
  self.county				:= L.ace_fips_st + L.ace_fips_county;
	self := L;
  self := [];
END;
	
dWatercraft_AID					:= project(files.Search(rawaid > 0), xformAID(left));
dWatercraft_dedup		:= dedup(sort(distribute(dWatercraft_AID, hash64(rawaid)), rawaid, local), record);

EXPORT as_aid := dWatercraft_dedup;