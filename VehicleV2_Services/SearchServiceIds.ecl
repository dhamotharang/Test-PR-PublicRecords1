IMPORT doxie,DriversV2,AutoStandardI,AutoHeaderI, doxie_cbrs, STD;

EXPORT SearchServiceIds (VehicleV2_Services.IParam.searchParams aInputData) := MODULE
  SHARED BOOLEAN is_CompSearchL := aInputData.companyname <> '' OR aInputData.phone <> '' OR aInputData.fein > '' OR aInputData.bdid > '';
  //SHARED BOOLEAN is_ContSearchL := aInputData.lastname <> ''; not used
  SHARED isCRS:= aInputData.isCRS;
  SHARED outrec := VehicleV2_Services.Layout_Vehicle_Key;
  SHARED STRING30 vk := aInputData.vehicleKey;
  SHARED STRING15 itk := aInputData.iterationKey;
  SHARED STRING15 sk := aInputData.sequenceKey;
  SHARED STRING20 title_Num_raw := aInputData.titleNumber;
  SHARED STRING20 title_Num := STD.STR.ToUpperCase(title_Num_raw);
  SHARED STRING vin_value := aInputData.vin_in;
  SHARED STRING tag_value := aInputData.LicensePlateNum;
  SHARED STRING state_value := aInputData.state;
  SHARED STRING fname_value := aInputData.firstname;
  SHARED STRING lname_value := aInputData.lastname;
  SHARED UNSIGNED8 maxresults_val := aInputData.maxresultsVal;
  SHARED UNSIGNED8 maxresultsthistime_val := aInputData.maxResultsThisTimeVal;
  SHARED UNSIGNED8 skiprecords_val := aInputData.skipRecordsVal;
  SHARED STRING dl_value := aInputData.dlValue;
  SHARED STRING14 did_value := aInputData.didValue;
  SHARED UNSIGNED6 bdid_value := aInputData.bdidValue;
  SHARED BOOLEAN doMFD := aInputData.multiFamilyDwelling;
  
  //********* MFD
  SHARED byMFD := VehicleV2_Services.Raw.get_vehicle_keys_from_mfd_address(aInputData);
  
  //********* Autokeys
  SHARED byak := VehicleV2_Services.AutoKeyIds(aInputData);

  //********* DIDS
  SHARED dids :=IF(aInputData.isDeepDive, doxie.get_dids(TRUE,NOT isCRS));
  SHARED commonParams := MODULE(PROJECT(aInputData, VehicleV2_Services.IParam.reportParams)) END;
  SHARED bydid := VehicleV2_Services.Raw.get_Vehicle_keys_from_dids(commonParams, dids);


  //*********BDIDS
  temp_bdid_mod := MODULE(PROJECT(AutoStandardI.GlobalModule(),AutoHeaderI.LIBIN.FetchI_Hdr_Biz.full,opt))
    EXPORT BOOLEAN nofail := TRUE;
  END;
  SHARED bdids := IF(is_CompSearchL AND aInputData.isDeepDive,AutoHeaderI.LIBCALL_FetchI_Hdr_Biz.do(temp_bdid_mod));

  SHARED bybdid := VehicleV2_Services.Raw.get_Vehicle_keys_from_bdids(commonParams, PROJECT(bdids,doxie_cbrs.layout_references));


  //*********Vehicle_key
  SHARED Vehicle_key := IF(vk <> '', DATASET([{vk, itk, sk}],VehicleV2_Services.layout_Vehicle_key));
  SHARED ByVehicle_key := IF(sk <> '', vehicle_key, VehicleV2_Services.Raw.get_vehicle_keys_from_vehkey(Vehicle_key,,,aInputData.IncludeNonRegulatedSources));


  //get vehicle keys from other keyed fields...


  //*********Vin
  SHARED vinnum :=DATASET([{vin_value,state_value}], VehicleV2_Services.Layouts.Layout_Vehicle_Vin_New);
  SHARED byvinnum :=IF(vin_value<>'', VehicleV2_Services.Raw.get_vehicle_keys_from_vin(commonParams, vinnum));

  //*********tag (licence plate)
  SHARED is_leading := tag_value[LENGTH(tag_value)] = '*';
  SHARED no_ast_tag := STD.STR.FilterOut(tag_value,'* ');
  SHARED tagnum :=DATASET([{no_ast_tag,state_value,fname_value,lname_value}], VehicleV2_Services.Layouts.Layout_Vehicle_lic_plate_New);
  
  /* PROJECTing input data to set getMinor to TRUE because the default should be false, but for
  the following searches it should be TRUE */
  SHARED in_mod := MODULE(PROJECT(aInputData, VehicleV2_Services.IParam.searchParams))
        EXPORT BOOLEAN getMinors := TRUE;
  END;
  SHARED get_from_plate :=VehicleV2_Services.Raw.get_vehicle_keys_from_lic_plate(in_mod, tagnum,,is_leading,MaxResultsThisTime_val,
    SkipRecords_val+1,MaxResults_val);

  SHARED bytagnum :=IF(tag_value <>'' AND tag_value[1] <> '*',
    PROJECT(get_from_plate.recs,outrec));
  SHARED bytag_cnt := IF(tag_value <>'' AND tag_value[1] <> '*', get_from_plate.cnt,0);

  SHARED is_trailing := tag_value[1] = '*';
  SHARED tagnum_reverse := IF(is_trailing,
    DATASET([{STD.STR.reverse(no_ast_tag),state_value,fname_value,lname_value}], VehicleV2_Services.Layouts.Layout_Vehicle_lic_plate_New),
    DATASET([], VehicleV2_Services.Layouts.Layout_Vehicle_lic_plate_New));

  SHARED get_from_plate_reverse := VehicleV2_Services.Raw.get_vehicle_keys_from_lic_plate_reverse(
    in_mod, tagnum_reverse,, is_leading, MaxResultsThisTime_val, SkipRecords_val+1, MaxResults_val);
  SHARED bytagnum_reverse := IF(is_trailing,
    PROJECT(get_from_plate_reverse.recs,outrec));
  SHARED bytagreverse_cnt := IF(is_trailing, get_from_plate_reverse.cnt,0);


  //*********Driver's License
  SHARED dlnum := DATASET([{dl_value,state_value}], VehicleV2_Services.Layouts.Layout_Vehicle_DL_Number_New);
  SHARED bydlnum := IF(dl_value <>'', VehicleV2_Services.Raw.get_vehicle_keys_from_dl_number(commonParams, dlnum));


  //*********Driver's License - Cloned from Driversv2
  // - get dids from driversv2
  //
  SHARED driversRecs:= JOIN(dlnum, DriversV2.Key_DL_Number,
                KEYED(LEFT.DL_Number = RIGHT.s_dl),
                TRANSFORM(doxie.layout_references, SELF := RIGHT),
                LIMIT(1000,skip));

  // remove any dupes
  SHARED driverDids := DEDUP(SORT(driversRecs,did),all);

  //get vehicle/iteration keys from the dids
  SHARED vkeysfromDids := VehicleV2_Services.Raw.get_Vehicle_keys_from_dids(commonParams, driverDids);

  // combine/sort/dedup results
  SHARED vkeysfromDLNums := DEDUP(SORT(vkeysfromDids + bydlnum, Vehicle_Key, Iteration_Key), Vehicle_Key, Iteration_Key);


  //*********Title
  SHARED ttlnum := DATASET([{title_Num,state_value}], VehicleV2_Services.Layouts.Layout_Vehicle_Title_Number_New);
  SHARED byttlnum := IF(title_Num <>'', VehicleV2_Services.Raw.get_vehicle_keys_from_title(commonParams, ttlnum));

  //********* input DID
  SHARED in_did := DATASET([{did_value}], doxie.layout_references);
  SHARED by_did := VehicleV2_Services.Raw.get_vehicle_keys_from_dids(commonParams, in_did);

  //********* input BDID
  SHARED in_bdid := DATASET([{bdid_value}], doxie_cbrs.layout_references);
  SHARED by_bdid := VehicleV2_Services.Raw.get_vehicle_keys_from_bdids(commonParams, in_bdid);

  //************figure out what id's to get
  SHARED from_keys := MAP(
    doMFD => byMFD,
    vk<>'' => byVehicle_key,
    vin_value<>'' => byvinnum,
    dl_value<>'' => vkeysfromDLNums,
    title_Num<>'' => byttlnum,
    did_value<>'' => by_did,
    bdid_value<>0 => by_bdid,
    bytagnum + bytagnum_reverse);
                
  SHARED from_tagnum := vk ='' AND vin_value='' AND dl_value='' AND title_Num='' AND did_value ='' AND bdid_value =0 AND tag_value<>'';
                
  EXPORT is_truncated := (from_tagnum AND EXISTS(from_keys));// OR
    //(count(byak) >= ut.imin2(MaxResultsThisTime_val+SkipRecords_val,MaxResults_val));

  //***********Combine all results
  SHARED by_bdid_and_did := bydid+bybdid;
  SHARED Vehicle_keys := IF(EXISTS(from_keys),
    DEDUP(PROJECT(from_keys,TRANSFORM(outrec,SELF.is_deep_dive:=FALSE,SELF:=LEFT)),all),
    DEDUP(SORT(byak + IF(NOT is_truncated, PROJECT(by_bdid_and_did,TRANSFORM(outrec,SELF.is_deep_dive:=TRUE,SELF:=LEFT))),vehicle_key,
      iteration_key,sequence_key,IF(is_deep_dive, 1, 0)),vehicle_key,iteration_key,sequence_key));

  EXPORT truncated_cnt := bytag_cnt + bytagreverse_cnt;

  EXPORT ids := Vehicle_keys;
  
END;
