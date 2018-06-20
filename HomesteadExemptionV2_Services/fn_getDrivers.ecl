IMPORT doxie, DriversV2_Services, Std;

EXPORT fn_getDrivers(DATASET(HomesteadExemptionV2_Services.Layouts.propIdRec) ds_srch_recs) := FUNCTION

	HomesteadExemptionV2_Services.Layouts.driverRec setAddrMatch(HomesteadExemptionV2_Services.Layouts.driverRec L,HomesteadExemptionV2_Services.Layouts.addrMin propAddr) := TRANSFORM
		dvrAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.p_city_name,L.st,L.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		hasAddrMatch:=HomesteadExemptionV2_Services.Functions.compare2Addresses(dvrAddr,propAddr);
		SELF.hasCurrAddrMatch:=L.isCurrent AND NOT L.isExpired AND hasAddrMatch;
		SELF.hasPrevAddrMatch:=NOT L.isCurrent AND hasAddrMatch;
		SELF:=L;
	END;

	HomesteadExemptionV2_Services.Layouts.propDriverRec driverRecords(ds_srch_recs L,DATASET(HomesteadExemptionV2_Services.Layouts.driverRec) R) := TRANSFORM
		propAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.p_city_name,L.st,L.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		SELF.drivers:=PROJECT(R,setAddrMatch(LEFT,propAddr));
		SELF:=L;
	END;

	dids:=PROJECT(ds_srch_recs,TRANSFORM(doxie.layout_references,SELF:=LEFT));
	driver_raw_recs:=DriversV2_Services.DLRaw.narrow_view.by_did(dids);
	driver_recs:=PROJECT(driver_raw_recs,TRANSFORM(HomesteadExemptionV2_Services.Layouts.driverRec,
		SELF.isCurrent:=LEFT.history='',
		SELF.isExpired:=LEFT.expiration_date<=Std.Date.Today(),
		SELF.name_first:=LEFT.fname,
		SELF.name_middle:=LEFT.mname,
		SELF.name_last:=LEFT.lname,
		SELF.z5:=LEFT.zip5,
		SELF:=LEFT));

	// OUTPUT(dids);
	// OUTPUT(driver_raw_recs);
	// OUTPUT(driver_recs);

	RETURN DENORMALIZE(ds_srch_recs,driver_recs,LEFT.did=RIGHT.did,GROUP,driverRecords(LEFT,ROWS(RIGHT)));
END;
