IMPORT doxie,DriversV2,AutoStandardI,AutoHeaderI, doxie_cbrs;

EXPORT SearchServiceIds (VehicleV2_Services.IParam.searchParams aInputData) := module
	shared BOOLEAN is_CompSearchL := aInputData.companyname <> '' or aInputData.phone <> '' or aInputData.fein > '' or aInputData.bdid > '';
	//shared BOOLEAN is_ContSearchL := aInputData.lastname <> '';		not used
	shared isCRS:= aInputData.isCRS;
	shared outrec := VehicleV2_Services.Layout_Vehicle_Key;
	shared STRING30 	vk := aInputData.vehicleKey;
	shared STRING15  	itk := aInputData.iterationKey;
	shared STRING15 	sk := aInputData.sequenceKey;
	shared STRING20  	title_Num_raw := aInputData.titleNumber;
	shared STRING20  	title_Num := StringLib.StringToUpperCase(title_Num_raw);
	shared STRING 		vin_value := aInputData.vin_in;
	SHARED STRING 		tag_value := aInputData.LicensePlateNum;
	SHARED STRING 		state_value := aInputData.state;
	SHARED STRING 		fname_value := aInputData.firstname;
	SHARED STRING			lname_value := aInputData.lastname;
	SHARED unsigned8 	maxresults_val := aInputData.maxresultsVal;
	SHARED unsigned8 	maxresultsthistime_val := aInputData.maxResultsThisTimeVal;
	SHARED unsigned8 	skiprecords_val := aInputData.skipRecordsVal;
	SHARED STRING 	 	dl_value := aInputData.dlValue;
	SHARED STRING14 	did_value := aInputData.didValue;
	SHARED unsigned6 	bdid_value := aInputData.bdidValue;
	SHARED BOOLEAN    doMFD := aInputData.multiFamilyDwelling;
	
	//********* MFD
	shared byMFD := VehicleV2_Services.Raw.get_vehicle_keys_from_mfd_address(aInputData);
	
	//********* Autokeys
	shared byak := VehicleV2_Services.AutoKeyIds(aInputData);

	//********* DIDS
	shared dids :=if(aInputData.isDeepDive, doxie.get_dids(true,not isCRS));
	shared commonParams := MODULE(PROJECT(aInputData, VehicleV2_Services.IParam.reportParams)) END;
	shared bydid := VehicleV2_Services.Raw.get_Vehicle_keys_from_dids(commonParams, dids);


	//*********BDIDS
  temp_bdid_mod := module(project(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
    export boolean nofail := true;
  end;
  shared bdids  := if(is_CompSearchL and aInputData.isDeepDive,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(temp_bdid_mod));

	shared bybdid := VehicleV2_Services.Raw.get_Vehicle_keys_from_bdids(commonParams, project(bdids,doxie_cbrs.layout_references));


	//*********Vehicle_key
	shared Vehicle_key := if(vk <> '', dataset([{vk, itk, sk}],VehicleV2_Services.layout_Vehicle_key));
	shared ByVehicle_key := if(sk <> '', vehicle_key, VehicleV2_Services.Raw.get_vehicle_keys_from_vehkey(Vehicle_key,,,aInputData.IncludeNonRegulatedSources));


	//get vehicle keys from other keyed fields...


	//*********Vin
	shared vinnum :=dataset([{vin_value,state_value}], VehicleV2_Services.Layouts.Layout_Vehicle_Vin_New);
	shared byvinnum :=if(vin_value<>'', VehicleV2_Services.Raw.get_vehicle_keys_from_vin(commonParams, vinnum));

	//*********tag (licence plate)
	shared is_leading := tag_value[length(tag_value)] = '*';
	shared no_ast_tag := stringlib.StringFilterOut(tag_value,'* ');
	shared tagnum :=dataset([{no_ast_tag,state_value,fname_value,lname_value}], VehicleV2_Services.Layouts.Layout_Vehicle_lic_plate_New);
	
	/* projecting input data to set getMinor to TRUE because the default should be false, but for 
	the following searches it should be TRUE */
	shared in_mod := module(project(aInputData, VehicleV2_Services.IParam.searchParams))
	      export boolean getMinors := TRUE;
  end;
	shared get_from_plate :=VehicleV2_Services.Raw.get_vehicle_keys_from_lic_plate(in_mod, tagnum,,is_leading,MaxResultsThisTime_val,
		SkipRecords_val+1,MaxResults_val);

	shared bytagnum :=if(tag_value <>'' and tag_value[1] <> '*',
		project(get_from_plate.recs,outrec));
	shared bytag_cnt := if(tag_value <>'' and tag_value[1] <> '*', get_from_plate.cnt,0);	

	shared is_trailing := tag_value[1] = '*';
	shared tagnum_reverse := if(is_trailing,
		dataset([{stringlib.stringreverse(no_ast_tag),state_value,fname_value,lname_value}], VehicleV2_Services.Layouts.Layout_Vehicle_lic_plate_New),
		dataset([], VehicleV2_Services.Layouts.Layout_Vehicle_lic_plate_New));

	shared get_from_plate_reverse := VehicleV2_Services.Raw.get_vehicle_keys_from_lic_plate_reverse(
		in_mod, tagnum_reverse,, is_leading, MaxResultsThisTime_val, SkipRecords_val+1, MaxResults_val);
	shared bytagnum_reverse := if(is_trailing,
		project(get_from_plate_reverse.recs,outrec));
	shared bytagreverse_cnt := if(is_trailing, get_from_plate_reverse.cnt,0);


	//*********Driver's License
	shared dlnum := dataset([{dl_value,state_value}], VehicleV2_Services.Layouts.Layout_Vehicle_DL_Number_New);
	shared bydlnum := if(dl_value <>'', VehicleV2_Services.Raw.get_vehicle_keys_from_dl_number(commonParams, dlnum));


	//*********Driver's License - Cloned from Driversv2
	//       - get dids from driversv2
	//
	shared driversRecs:= join(dlnum, DriversV2.Key_DL_Number,
		            keyed(left.DL_Number = right.s_dl),
								transform(doxie.layout_references, self := right),
								limit(1000,skip));

	// remove any dupes
	shared driverDids := dedup(sort(driversRecs,did),all);

	//get vehicle/iteration keys from the dids
	shared vkeysfromDids := VehicleV2_Services.Raw.get_Vehicle_keys_from_dids(commonParams, driverDids);

	// combine/sort/dedup results	
	shared vkeysfromDLNums := dedup(sort(vkeysfromDids + bydlnum, Vehicle_Key, Iteration_Key), Vehicle_Key, Iteration_Key);


	//*********Title
	shared ttlnum := dataset([{title_Num,state_value}], VehicleV2_Services.Layouts.Layout_Vehicle_Title_Number_New);
	shared byttlnum := if(title_Num <>'', VehicleV2_Services.Raw.get_vehicle_keys_from_title(commonParams, ttlnum));

	//********* input DID
	shared in_did := dataset([{did_value}], doxie.layout_references);
	shared by_did := VehicleV2_Services.Raw.get_vehicle_keys_from_dids(commonParams, in_did);

	//********* input BDID
	shared in_bdid := dataset([{bdid_value}], doxie_cbrs.layout_references);
	shared by_bdid := VehicleV2_Services.Raw.get_vehicle_keys_from_bdids(commonParams, in_bdid);

	//************figure out what id's to get
	shared from_keys := map(
		doMFD         => byMFD,
		vk<>''				=> byVehicle_key,
		vin_value<>''	=> byvinnum,
		dl_value<>''	=> vkeysfromDLNums,
		title_Num<>''	=> byttlnum,
		did_value<>''	=> by_did,
		bdid_value<>0	=> by_bdid,
		bytagnum + bytagnum_reverse);
								
	shared from_tagnum := vk ='' and vin_value='' and dl_value='' and title_Num='' and did_value ='' and bdid_value =0 and tag_value<>'';
								
	export is_truncated := (from_tagnum and exists(from_keys));// or
		//(count(byak) >= ut.imin2(MaxResultsThisTime_val+SkipRecords_val,MaxResults_val));						 

	//***********Combine all results 
	shared by_bdid_and_did := bydid+bybdid;
	shared Vehicle_keys := if(exists(from_keys),
		dedup(project(from_keys,transform(outrec,self.is_deep_dive:=FALSE,self:=left)),all),
		dedup(sort(byak + if(not is_truncated, project(by_bdid_and_did,transform(outrec,self.is_deep_dive:=TRUE,self:=left))),vehicle_key,
			iteration_key,sequence_key,if(is_deep_dive, 1, 0)),vehicle_key,iteration_key,sequence_key));

	export truncated_cnt := bytag_cnt + bytagreverse_cnt;

	export ids := Vehicle_keys;
	
end;
