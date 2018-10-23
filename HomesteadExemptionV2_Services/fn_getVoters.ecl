IMPORT doxie, VotersV2_Services;

EXPORT fn_getVoters(DATASET(HomesteadExemptionV2_Services.Layouts.propIdRec) ds_srch_recs) := FUNCTION

	HomesteadExemptionV2_Services.Layouts.voterRec setAddrMatch(HomesteadExemptionV2_Services.Layouts.voterRec L,HomesteadExemptionV2_Services.Layouts.addrMin propAddr) := TRANSFORM
		vtrAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.p_city_name,L.st,L.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		SELF.hasAddrMatch:=HomesteadExemptionV2_Services.Functions.compare2Addresses(vtrAddr,propAddr);
		SELF:=L;
	END;

	HomesteadExemptionV2_Services.Layouts.propVoterRec voterRecords(ds_srch_recs L,DATASET(HomesteadExemptionV2_Services.Layouts.voterRec) R) := TRANSFORM
		propAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.p_city_name,L.st,L.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		SELF.voters:=PROJECT(R,setAddrMatch(LEFT,propAddr));
		SELF:=L;
	END;

	dids:=PROJECT(ds_srch_recs,TRANSFORM(doxie.layout_references,SELF:=LEFT));
	voter_raw_recs:=VotersV2_Services.raw.Report_View.by_did(dids);
	voter_records:=PROJECT(voter_raw_recs(active_status='A'),TRANSFORM(HomesteadExemptionV2_Services.Layouts.voterRec,
		SELF.did:=(UNSIGNED)LEFT.did,
		SELF.name_first :=LEFT.name.fname,
		SELF.name_middle:=LEFT.name.mname,
		SELF.name_last  :=LEFT.name.lname,
		SELF.name_suffix:=LEFT.name.name_suffix,
		SELF.prim_range :=LEFT.res.prim_range,
		SELF.predir     :=LEFT.res.predir,
		SELF.prim_name  :=LEFT.res.prim_name,
		SELF.addr_suffix:=LEFT.res.addr_suffix,
		SELF.postdir    :=LEFT.res.postdir,
		SELF.unit_desig :=LEFT.res.unit_desig,
		SELF.sec_range  :=LEFT.res.sec_range,
		SELF.p_city_name:=LEFT.res.p_city_name,
		SELF.st  :=LEFT.res.st,
		SELF.z5  :=LEFT.res.zip5,
		SELF.zip4:=LEFT.res.zip4,
		SELF:=LEFT));

	// OUTPUT(voter_raw_recs,NAMED('voter_raw_recs'));

	RETURN DENORMALIZE(ds_srch_recs,voter_records,LEFT.did=RIGHT.did,GROUP,voterRecords(LEFT,ROWS(RIGHT)));
END;
