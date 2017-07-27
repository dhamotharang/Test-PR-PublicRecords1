import doxie, doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

thebest := doxie_cbrs.best_records;

doxie.layout_AddressSearch prep(thebest l) := transform
	self.seq := 0;
	self.zip := (string5)l.zip;
	self := l;
	self := [];
end;

ba := dedup(project(thebest, prep(left)),all);
subadd := ba(Include_AssociatedPeople_val);

//get other dids at this address
otherdids :=doxie.did_from_address(subadd, true);

//get info for those dids
doxie.mac_best_records(otherdids,did,outfile, dppa_ok, glb_ok,,doxie.DataRestriction.fixed_DRM);

export individuals_at_address_records := outfile;