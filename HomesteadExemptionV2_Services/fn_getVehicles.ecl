IMPORT Address, Std, VehicleV2_Services;

EXPORT fn_getVehicles(DATASET(HomesteadExemptionV2_Services.Layouts.propIdRec) ds_srch_recs,
				HomesteadExemptionV2_Services.IParams.Params in_mod) := FUNCTION

	veh_mod:=VehicleV2_Services.IParam.getSearchModule();

	fetchVehicles(HomesteadExemptionV2_Services.Layouts.propIdRec L, UNSIGNED1 max_vehicles) := FUNCTION

		// GET LOCAL RECORDS BY DID
		did_mod:=MODULE(PROJECT(veh_mod,VehicleV2_Services.IParam.searchParams,OPT))
			EXPORT STRING14 didValue:=(STRING)L.did;
			EXPORT STRING   DataSource:=VehicleV2_Services.Constant.LOCAL_VAL;
			EXPORT BOOLEAN  noFail:=TRUE;
		END;

		// GET REALTIME RECORDS BY NAME AND ADDRESS
		rtv_mod:=MODULE(PROJECT(veh_mod,VehicleV2_Services.IParam.searchParams,OPT))
			EXPORT STRING30  firstname   := L.name_first;
			EXPORT STRING30  middlename  := L.name_middle;
			EXPORT STRING30  lastname    := L.name_last;
			EXPORT STRING    name_suffix := L.name_suffix;
			EXPORT STRING200 addr  := Address.Addr1FromComponents(L.prim_range,L.predir,L.prim_name,L.addr_suffix,L.postdir,L.unit_desig,L.sec_range);
			EXPORT STRING25  city  := L.p_city_name;
			EXPORT STRING2   state := L.st;
			EXPORT STRING6   zip   := L.z5;
			EXPORT STRING    DataSource:=VehicleV2_Services.Constant.REALTIME_VAL;
			EXPORT BOOLEAN   noFail:=TRUE;
		END;

		// ALWAYS FETCH LOCAL RECORDS
		veh_did_recs:=VehicleV2_Services.Get_Vehicle_Records(did_mod).sorted_vehs(EXISTS(registrants));
		veh_vin_recs:=DEDUP(SORT(veh_did_recs(NOT is_current),vin,-MAX(registrants,Reg_Latest_Expiration_Date)),vin);
		veh_max_recs:=CHOOSEN(veh_did_recs(is_current)+SORT(veh_vin_recs,-MAX(registrants,Reg_Latest_Expiration_Date)),max_vehicles);
		veh_slim_did_recs:=PROJECT(veh_max_recs,TRANSFORM(HomesteadExemptionV2_Services.Layouts.vehicleRec,
			SELF.acctno:=L.acctno,
			SELF.isCurrent:=LEFT.is_current,
			SELF.make_desc:=IF(LEFT.make_desc!='',LEFT.make_desc,LEFT.vehicle_type_desc),
			SELF.model_desc:=IF(LEFT.model_desc!='',LEFT.model_desc,LEFT.body_style_desc),
			SELF.registrants:=PROJECT(LEFT.registrants,TRANSFORM(HomesteadExemptionV2_Services.Layouts.registrantRec,
				SELF.isExpired:=(UNSIGNED)LEFT.Reg_Latest_Expiration_Date<=Std.Date.Today(),
				SELF.hasNameMatch:=L.did=(UNSIGNED)LEFT.append_did OR (L.name_first=LEFT.fname AND L.name_last=LEFT.lname AND L.name_suffix=LEFT.name_suffix),
				SELF.did:=(UNSIGNED)LEFT.append_did,
				SELF:=LEFT)),
			SELF:=LEFT));

		// CONDITIONALLY FETCH REALTIME RECORDS
		veh_rtv_recs:=IF(in_mod.IncludeRealtimeVehicles,VehicleV2_Services.Get_Vehicle_Records(rtv_mod).sorted_vehs,DATASET([],VehicleV2_Services.Layout_Report));
		veh_slim_rtv_recs:=PROJECT(veh_rtv_recs,TRANSFORM(HomesteadExemptionV2_Services.Layouts.vehicleRec,
			SELF.acctno:=L.acctno,
			SELF.isCurrent:=LEFT.is_current,
			SELF.source_code:='RT',
			SELF.registrants:=PROJECT(LEFT.registrants,TRANSFORM(HomesteadExemptionV2_Services.Layouts.registrantRec,
				SELF.isExpired:=(UNSIGNED)LEFT.Reg_Latest_Expiration_Date<=Std.Date.Today(),
				SELF.hasNameMatch:=L.name_first=LEFT.fname AND L.name_last=LEFT.lname AND L.name_suffix=LEFT.name_suffix,
				SELF.did:=(UNSIGNED)LEFT.append_did,
				SELF:=LEFT)),
			SELF:=LEFT));

		RETURN veh_slim_rtv_recs+veh_slim_did_recs;
	END;

	HomesteadExemptionV2_Services.Layouts.registrantRec setRegAddrMatch(HomesteadExemptionV2_Services.Layouts.registrantRec L,HomesteadExemptionV2_Services.Layouts.addrMin propAddr) := TRANSFORM
		regAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.v_city_name,L.st,L.zip5},HomesteadExemptionV2_Services.Layouts.addrMin);
		hasAddrMatch:=HomesteadExemptionV2_Services.Functions.compare2Addresses(regAddr,propAddr);
		SELF.hasCurrAddrMatch:=NOT L.isExpired AND L.hasNameMatch AND hasAddrMatch;
		SELF.hasPrevAddrMatch:=L.isExpired AND L.hasNameMatch AND hasAddrMatch;
		SELF:=L;
	END;

	HomesteadExemptionV2_Services.Layouts.vehicleRec setVehAddrMatch(HomesteadExemptionV2_Services.Layouts.vehicleRec L,HomesteadExemptionV2_Services.Layouts.addrMin propAddr) := TRANSFORM
		registrants:=PROJECT(L.registrants,setRegAddrMatch(LEFT,propAddr));
		SELF.hasCurrAddrMatch:=L.isCurrent AND EXISTS(registrants(hasCurrAddrMatch));
		SELF.hasPrevAddrMatch:=NOT L.isCurrent AND EXISTS(registrants(hasPrevAddrMatch));
		SELF.registrants:=registrants;
		SELF:=L;
	END;

	HomesteadExemptionV2_Services.Layouts.propVehicleRec vehicleRecords(HomesteadExemptionV2_Services.Layouts.propIdRec L) := TRANSFORM
		propAddr:=ROW({L.prim_range,L.prim_name,L.sec_range,L.p_city_name,L.st,L.z5},HomesteadExemptionV2_Services.Layouts.addrMin);
		SELF.vehicles:=PROJECT(fetchVehicles(L,HomesteadExemptionV2_Services.Constants.MAX_VEHICLES),setVehAddrMatch(LEFT,propAddr));
		SELF:=L;
	END;

	RETURN PROJECT(ds_srch_recs,vehicleRecords(LEFT));
END;
