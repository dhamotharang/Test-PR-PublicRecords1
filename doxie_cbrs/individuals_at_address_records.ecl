IMPORT doxie, doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

thebest := doxie_cbrs.best_records;

doxie.layout_AddressSearch prep(thebest l) := TRANSFORM
  SELF.seq := 0;
  SELF.zip := (STRING5)l.zip;
  SELF := l;
  SELF := [];
END;

ba := DEDUP(PROJECT(thebest, prep(LEFT)),ALL);
subadd := ba(Include_AssociatedPeople_val);

//get other dids at this address
otherdids :=doxie.did_from_address(subadd, TRUE);

//get info for those dids
doxie.mac_best_records(otherdids,did,outfile, dppa_ok, glb_ok,,doxie.DataRestriction.fixed_DRM);

EXPORT individuals_at_address_records := outfile;
