IMPORT doxie, doxie_cbrs, VehicleV2, ut, NID, MDR, Address, STD, D2C;

EXPORT Raw := MODULE
    
  EXPORT VehicleV2_Services.Layout_Vehicle_Key get_vehicle_keys_from_dids(
              VehicleV2_Services.IParam.reportParams in_mod,
                DATASET(doxie.layout_references) in_dids,
                UNSIGNED in_LIMIT = 0) := FUNCTION
    
    BOOLEAN isCNSMR := in_mod.isConsumer();
    lookup_value := in_mod.lookupValue;
    
    lookupwithexclude := lookup_value | IF(in_mod.excludeLessors, doxie.lookup_bit(Vehiclev2_services.lookup_bit.no_lessors), 0);
                                
    key := VehicleV2.key_vehicle_did;
    
    vks_vehicleV2_info := JOIN(DEDUP(SORT(in_dids,did),did),key,
      KEYED(LEFT.did = RIGHT.append_did) AND
      (in_mod.getMinors OR RIGHT.is_minor=FALSE) AND
      (lookupwithexclude = 0 OR
        EXISTS( LIMIT( vehiclev2.Key_Vehicle_Party_Key(KEYED(vehicle_key = RIGHT.vehicle_key) AND
                                                       KEYED(iteration_key=RIGHT.iteration_key) AND
                                                       KEYED(sequence_key = RIGHT.sequence_key) AND
                                                       (UNSIGNED6)append_did = LEFT.did AND
                                                       orig_name_type <> '2' ),
                      10000, skip ))),
    TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key, SELF := RIGHT),
    LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_DID, skip));

    //CCPA suppression is not required as no PII is sxtracted from the party key
    vks := IF(~isCNSMR, vks_vehicleV2_info);
    ded := DEDUP(vks,all);
    RETURN IF(in_LIMIT = 0,ded,CHOOSEN(ded,in_LIMIT));
  END;

  EXPORT VehicleV2_Services.Layout_Vehicle_Key get_vehicle_keys_from_vehkey (
    DATASET(VehicleV2_Services.Layout_Vehicle_Key) in_veh_keys,
    UNSIGNED in_LIMIT = 0,BOOLEAN get_minors = TRUE,BOOLEAN include_non_regulated_sources = FALSE):= FUNCTION
    
    BOOLEAN isCNSMR := ut.IndustryClass.is_Knowx;
    key := vehiclev2.Key_Vehicle_Main_Key;
    key_party := Vehiclev2.Key_Vehicle_Party_Key;
    
    BOOLEAN include_non_regulated_data := include_non_regulated_sources AND ~doxie.DataRestriction.InfutorMV;
    vks := JOIN(DEDUP(SORT(in_veh_keys,RECORD),RECORD), key,
      KEYED(LEFT.vehicle_key = RIGHT.vehicle_key) AND
      KEYED(LEFT.iteration_key = RIGHT.iteration_key OR LEFT.iteration_key = '') AND
      (include_non_regulated_data OR RIGHT.source_code NOT in [MDR.sourceTools.src_infutor_veh,MDR.sourceTools.src_infutor_motorcycle_veh]),
      TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key,SELF := RIGHT),
      LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_KEY, skip));
    ded := DEDUP(vks,all);
    w_seq_info := JOIN(ded,key_party,KEYED(LEFT.vehicle_key=RIGHT.vehicle_key)
      AND KEYED(LEFT.iteration_key=RIGHT.iteration_key) AND (get_minors OR NOT (ut.age((INTEGER)RIGHT.orig_dob) BETWEEN 1 AND 17)),
      TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key,SELF.sequence_key := RIGHT.sequence_key,SELF := LEFT), LIMIT(10000,skip));
    //CCPA suppression is not required as no PII is sxtracted from the party key
   
    w_seq := IF(~isCNSMR, w_seq_info);
    ded_w_seq := DEDUP(w_seq,all);
    RETURN IF(in_LIMIT=0,ded_w_seq,CHOOSEN(ded_w_seq,in_LIMIT));
  END;

  EXPORT VehicleV2_Services.Layout_Vehicle_Key get_vehicle_keys_from_bdids(
    VehicleV2_Services.IParam.reportParams in_mod,
    DATASET(doxie_cbrs.layout_references) in_bdids,
    UNSIGNED in_LIMIT = 0) := FUNCTION
    
    BOOLEAN isCNSMR := in_mod.isConsumer();
    lookup_value := in_mod.lookupValue;
    key := VehicleV2.key_vehicle_bdid;
    vks_info := JOIN(DEDUP(SORT(in_bdids,bdid),bdid),key,
      KEYED(LEFT.bdid = RIGHT.append_bdid) AND
      (lookup_value = 0 OR EXISTS( LIMIT( vehiclev2.Key_Vehicle_Party_Key((UNSIGNED6)append_bdid = LEFT.bdid AND vehicle_key = RIGHT.vehicle_key
        AND iteration_key=RIGHT.iteration_key AND sequence_key = RIGHT.sequence_key AND orig_name_type <> '2' ), 10000, skip ))),
      TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key, SELF := RIGHT),
      LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_BDID,skip));

  //CCPA suppression is not required as no PII is sxtracted from the party key
  vks := IF(~isCNSMR, vks_info);
    ded := DEDUP(vks,all);
    RETURN IF(in_LIMIT = 0,ded,CHOOSEN(ded,in_LIMIT));
  END;
  
  EXPORT get_vehicle_keys_from_vin(
    VehicleV2_Services.IParam.reportParams in_mod,
    DATASET(VehicleV2_Services.Layouts.Layout_Vehicle_Vin_New) in_VIN,
    UNSIGNED in_LIMIT = 0,
    STRING13 dl_num ='',
    STRING20 Vehicle_Num ='') := FUNCTION
    
    BOOLEAN isCNSMR := in_mod.isConsumer();
    key := VehicleV2.key_vehicle_VIN;
    key_party := Vehiclev2.Key_Vehicle_Party_Key;
    vks0 := JOIN(DEDUP(SORT(in_VIN,vin),vin),key,
      KEYED(LEFT.vin = RIGHT.vin),
      TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key, SELF := RIGHT, SELF.sequence_key := ''),
      LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_VIN,FAIL(11, doxie.ErrorCodes(11))));
    vks1_info := JOIN(DEDUP(SORT(in_VIN,vin),vin),key,
      KEYED(LEFT.vin = RIGHT.vin),
      TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key, SELF := RIGHT, SELF.sequence_key := ''),
      LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_VIN,skip));
    
    vks1 := IF(~isCNSMR, vks1_info);
    STRING did_value := in_mod.didValue;
    
    vks := IF(EXISTS(vks1)OR did_value<>'' OR dl_num<>'' OR vehicle_Num <> '',vks1,vks0);
            
    ded := DEDUP(vks,all);
    w_seq := JOIN(ded,key_party,KEYED(LEFT.vehicle_key=RIGHT.vehicle_key) AND KEYED(LEFT.iteration_key=RIGHT.iteration_key) AND (in_mod.getMinors OR NOT (ut.age((INTEGER)RIGHT.orig_dob) BETWEEN 1 AND 17)),
    TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key,SELF.sequence_key := RIGHT.sequence_key,SELF := LEFT), LIMIT(10000,skip));
    //CCPA suppression is not required as no PII is sxtracted from the party key
    ded_w_seq := DEDUP(w_seq,all);
    
    RETURN IF(in_LIMIT = 0,ded_w_seq,CHOOSEN(ded_w_seq,in_LIMIT));
  END;
  
  EXPORT get_vehicle_keys_from_title(
    VehicleV2_Services.IParam.reportParams in_mod,
    DATASET(VehicleV2_Services.Layouts.Layout_Vehicle_Title_Number_New) in_ttl,
    UNSIGNED in_LIMIT = 0) := FUNCTION
  
  BOOLEAN isCNSMR := in_mod.isConsumer();
    key := VehicleV2.key_vehicle_title_number;
    vks_info := JOIN(DEDUP(SORT(in_ttl,Ttl_Number),Ttl_Number),key,
      KEYED(LEFT.Ttl_Number = RIGHT.ttl_number) AND (LEFT.state_origin=RIGHT.state_origin
      OR LEFT.state_origin =''),
      TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key, SELF := RIGHT),
      LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_TITLE,FAIL(11, doxie.ErrorCodes(11))));

    vks := IF(~isCNSMR, vks_info);
    ded := DEDUP(vks,all);
    RETURN IF(in_LIMIT = 0,ded,CHOOSEN(ded,in_LIMIT));
  END;
  
  EXPORT get_vehicle_keys_from_dl_number(
                               VehicleV2_Services.IParam.reportParams in_mod,
                               DATASET(VehicleV2_Services.Layouts.Layout_Vehicle_DL_Number_New) in_dlnum,
                               UNSIGNED in_LIMIT = 0,BOOLEAN get_minors=FALSE) := FUNCTION
                               
    BOOLEAN isCNSMR := in_mod.isConsumer();
    key := VehicleV2.key_vehicle_dl_number;
    vks_info := JOIN(DEDUP(SORT(in_dlnum,DL_Number),DL_Number),key,
      KEYED(LEFT.DL_Number = RIGHT.DL_number) AND
      (get_minors OR RIGHT.is_minor=FALSE),
      TRANSFORM(VehicleV2_Services.Layout_Vehicle_Key, SELF := RIGHT),
      LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_DL_NUMBER,FAIL(11, doxie.ErrorCodes(11))));
    
    vks := IF(~isCNSMR, vks_info);
    ded := DEDUP(vks,all);
    RETURN IF(in_LIMIT = 0,ded,CHOOSEN(ded,in_LIMIT));
  END;
  
  SHARED lic_plate_mac := MACRO
    KEYED(LEFT.state_origin=RIGHT.state_origin
    OR LEFT.state_origin ='') AND
    KEYED(LEFT.lname='' OR RIGHT.dph_lname=metaphonelib.DMetaPhone1(LEFT.lname)[1..6]) AND
    KEYED(pfe(RIGHT.pfname,LEFT.fname) OR (LENGTH(TRIM(LEFT.fname))<2)) AND
    (in_mod.getMinors OR RIGHT.is_minor = FALSE)
  ENDMACRO;
    
  EXPORT get_vehicle_keys_from_lic_plate(
    VehicleV2_Services.IParam.searchParams in_mod,
    DATASET(VehicleV2_Services.Layouts.Layout_Vehicle_Lic_Plate_New) in_lic_plate,
    UNSIGNED in_LIMIT = VehicleV2_Services.Constant.VEHICLE_PER_LIC_PLATE,
    BOOLEAN get_leading = FALSE,
    UNSIGNED return_count = 9999,
    UNSIGNED starting_record = 1,
    UNSIGNED MAX_results = 9999,STRING1 state_type ='C'
    ) := MODULE
       
    BOOLEAN isCNSMR := in_mod.isConsumer();
    key := VehicleV2.key_vehicle_lic_plate;
    pfe(STRING20 l, STRING20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);
    
    l_blur := RECORD(VehicleV2_Services.Layouts.Layout_Vehicle_Lic_Plate_New)
      typeof(VehicleV2_Services.Layouts.Layout_Vehicle_Lic_Plate_New.lic_plate) lic_plate_blur;
    END;
    in_blur := nofold(PROJECT(in_lic_plate, TRANSFORM(l_blur, SELF.lic_plate_blur:=ut.blur(LEFT.lic_plate), SELF:=LEFT)));
    in_unblurred := JOIN(
      in_blur, VehicleV2.Key_Vehicle_Lic_Plate_Blur,
      KEYED(LEFT.lic_plate_blur = RIGHT.license_plate_blur),
      // LEFT.lic_plate_blur = RIGHT.license_plate_blur,
      TRANSFORM(VehicleV2_Services.Layouts.Layout_Vehicle_Lic_Plate_New, SELF.lic_plate:=RIGHT.license_plate, SELF:=LEFT),
      LEFT OUTER,
      LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_BLUR_LICENSE,FAIL(11, doxie.ErrorCodes(11)))
    );

    in_lic := IF(in_mod.UseTagBlur, in_unblurred, in_lic_plate);
    
    l_lic_cast := RECORD
      typeof(key.license_plate) lic_plate;
      VehicleV2_Services.Layouts.Layout_Vehicle_Lic_Plate_New AND NOT lic_plate;
    END;
    in_lic_cast := PROJECT(in_lic_plate, l_lic_cast);
    vks_leading0 := JOIN(DEDUP(SORT(in_lic_cast,lic_plate),lic_plate),key,
      KEYED(LEFT.lic_plate<>'' AND LEFT.lic_plate = RIGHT.license_plate[1..LENGTH(TRIM(LEFT.lic_plate,LEFT,RIGHT))]) AND
      lic_plate_mac()
      ,TRANSFORM(VehicleV2_Services.Layouts.lic_plate_key_payload_fields_New, SELF := RIGHT),
      LIMIT(0),KEEP(in_LIMIT+1));
    vks_info:= JOIN(DEDUP(SORT(in_lic,lic_plate),lic_plate),key,
      KEYED(LEFT.lic_plate<>'' AND LEFT.lic_plate = RIGHT.license_plate) AND
      lic_plate_mac()
      ,TRANSFORM(VehicleV2_Services.Layouts.lic_plate_key_payload_fields_New, SELF := RIGHT),
      LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_LIC_PLATE,FAIL(11, doxie.ErrorCodes(11))));
   
    vks := IF(~isCNSMR, vks_info);
    vks_leading_bool := EXISTS(LIMIT(vks_leading0,in_LIMIT,skip));
    vks_leading := MAP( vks_leading_bool=>vks_leading0,
                        EXISTS(vks_leading0) => FAIL(vks_leading0, 11, doxie.ErrorCodes(11)));
    
    SHARED pre_DEDUP := IF(get_leading,vks_leading,vks);
    
    // state_type is 'A' if this is called by moxie AND the state origin field is input.
    // The purpose of this parameter is to only return records where the state_origin matches the input
    // AND this may be seen by looking at the payload field state_type
    SHARED out := VehicleV2_Services.Functions.lic_plate_filter_New(pre_DEDUP,return_count,starting_record,
    in_mod.penalty_threshold,MAX_results, in_LIMIT,in_mod.dppa,state_type);

    EXPORT recs := out.recs;
    EXPORT cnt := out.cnt;

  END;

  EXPORT get_vehicle_keys_from_lic_plate_reverse(
    VehicleV2_Services.IParam.searchParams in_mod,
    DATASET(VehicleV2_Services.Layouts.Layout_Vehicle_Lic_Plate_New) in_lic_plate,
    UNSIGNED in_LIMIT = VehicleV2_Services.Constant.VEHICLE_PER_LIC_PLATE,
    BOOLEAN get_leading = FALSE,
    UNSIGNED return_count = 9999,
    UNSIGNED starting_record = 1,
    UNSIGNED MAX_results = 9999
    ) := MODULE
           
    BOOLEAN isCNSMR := in_mod.isConsumer();
    key := VehicleV2.key_vehicle_reverse_lic_plate;
    pfe(STRING20 l, STRING20 r) := NID.mod_PFirstTools.SubLinPFR(l,r);
    l_lic_cast := RECORD
      typeof(key.reverse_license_plate) lic_plate;
      VehicleV2_Services.Layouts.Layout_Vehicle_Lic_Plate_New AND NOT lic_plate;
    END;
    in_lic_cast := PROJECT(in_lic_plate, l_lic_cast);
    vks_trailing_info := JOIN(DEDUP(SORT(in_lic_cast,lic_plate),lic_plate),key,
      KEYED(LEFT.lic_plate <> '' AND LEFT.lic_plate = RIGHT.reverse_license_plate[1..LENGTH(TRIM(LEFT.lic_plate,LEFT,RIGHT))]) AND
      lic_plate_mac()
      ,TRANSFORM(VehicleV2_Services.Layouts.lic_plate_key_payload_fields_New, SELF := RIGHT),
      LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_LIC_PLATE,FAIL(11, doxie.ErrorCodes(11))));
      
    vks_trailing := IF(~isCNSMR, vks_trailing_info);
    
    // state_type param is hardcoded to 'C' because moxie doesn't do reverse license plate
    // lookups so this code is only called by roxie queries AND in roxie queries we don't want
    // to LIMIT results based on which state matches
    SHARED out := VehicleV2_Services.Functions.lic_plate_filter_New(vks_trailing,return_count,starting_record,
    in_mod.penalty_threshold,MAX_results, in_LIMIT,in_mod.dppa,'C');
    
    EXPORT recs := out.recs;
    EXPORT cnt := out.cnt;
  END;

  /* move all reports attr to ReportRecords*/
  EXPORT get_vehicle_report(
    VehicleV2_Services.IParam.reportParams in_mod,
    GROUPED DATASET(VehicleV2_Services.Layout_Vehicle_Key) in_veh_keys
    ) := FUNCTION
    RETURN PROJECT(VehicleV2_Services.Functions.GetVehicleReport(in_mod, in_veh_keys), VehicleV2_Services.Layout_Report);
  END;
  
  EXPORT get_vehicle_search(
    VehicleV2_Services.IParam.searchParams in_mod,
    GROUPED DATASET(VehicleV2_Services.Layout_Vehicle_Key) in_veh_keys,
    STRING in_ssn_mask_type = ''
    ) := FUNCTION
    in_veh_keys_input := PROJECT(in_veh_keys,
      TRANSFORM (VehicleV2_Services.Layout_VKeysWithInput, SELF := LEFT, SELF := []));
    RETURN PROJECT(VehicleV2_Services.Functions.Get_VehicleSearch(in_mod, in_veh_keys_input), VehicleV2_Services.Layout_Report);
  END;


  EXPORT get_vehicle_crs_report_by_Veh_key (
    VehicleV2_Services.IParam.reportParams in_mod,
    DATASET(VehicleV2_Services.Layout_Vehicle_Key) in_veh_keys) := FUNCTION

    SORT_keys := SORT(in_veh_keys, Vehicle_Key, -Iteration_Key);
    group_keys := GROUP(SORT_keys, Vehicle_key, Iteration_key);
    DEDUP_keys := DEDUP(group_keys, Vehicle_Key, Iteration_Key,sequence_key);

    vsr := UNGROUP(get_vehicle_report(in_mod, DEDUP_keys));
  
    rec := RECORD
      vsr;
      UNSIGNED1 priority_num;
      UNSIGNED2 srt_num;
    END;

    srt := SORT(vsr, vin,-((UNSIGNED1)is_current),
    -MAX(registrants,reg_latest_effective_date), -MAX(registrants,reg_latest_expiration_date),
    -((UNSIGNED) iteration_key),-sequence_key,RECORD);
    
    srt_title_holders := SORT(vsr,vin,IF(EXISTS(owners),0,1),
    -MAX(owners,ttl_latest_issue_date),-MAX(owners,ttl_earliest_issue_date),
    -((UNSIGNED) iteration_key),-sequence_key);

    rec get_num(vsr l,INTEGER C):=TRANSFORM
      SELF :=l;
      SELF.priority_num := 1;
      SELF.srt_num := C;
    END;
    
    ddp := PROJECT(SORT(DEDUP(srt, vin),
    -((UNSIGNED1)is_current),-MAX(registrants,reg_latest_effective_date), -MAX(registrants,reg_latest_expiration_date),
    -((UNSIGNED) iteration_key)),
    get_num(LEFT,COUNTER));

    rec get_num_from_reg(vsr l,rec r):=TRANSFORM
      SELF :=l;
      SELF.priority_num := 2;
      SELF.srt_num := r.srt_num;
    END;

    title_holders := DEDUP(srt_title_holders,vin)(EXISTS(owners));
    
    ddp_titles := JOIN(title_holders,ddp(~EXISTS(owners)),LEFT.vin=RIGHT.vin, get_num_from_reg(LEFT,RIGHT));
    
    RETURN PROJECT(SORT(ddp + ddp_titles,NonDMVSource,srt_num,priority_num),TRANSFORM(RECORDOF(vsr),SELF :=LEFT));

  END;
  
  
  EXPORT get_vehicle_crs_report (
    VehicleV2_Services.IParam.reportParams in_mod,
    DATASET(doxie.layout_references) in_dids) := FUNCTION

    by_did := get_vehicle_keys_from_dids (in_mod, in_dids);
    RETURN get_vehicle_crs_report_by_Veh_key(in_mod, by_did);
  END;
  
  EXPORT get_vehicle_keys_from_mfd_address(
    VehicleV2_Services.IParam.searchParams inMod,
    BOOLEAN get_minors=FALSE
  ) := FUNCTION

  BOOLEAN isCNSMR := inMod.isConsumer();
    addr1:=IF(inMod.addr!='',inMod.addr,address.Addr1FromComponents(
      inMod.prim_range,inMod.predir,inMod.prim_name,inMod.suffix,inMod.postdir,'',inMod.sec_range));
    addr2:=address.Addr2FromComponents(inMod.city,inMod.state,inMod.zip);
    addr182:=address.GetCleanAddress(addr1,addr2,address.Components.Country.US).str_addr;
    clnAddr:=address.CleanFields(addr182);

    srchAddrRecs:=DATASET([
      {clnAddr.prim_range,clnAddr.predir,clnAddr.prim_name,clnAddr.addr_suffix,clnAddr.postdir,
       clnAddr.unit_desig,clnAddr.sec_range,clnAddr.v_city_name,clnAddr.st,clnAddr.zip,clnAddr.zip4}
    ],VehicleV2_Services.Layouts.layout_standard_address);

    registrationType:=CASE(inMod.registrationType,
      VehicleV2_Services.Constant.History.USE_CURRENT => VehicleV2_Services.Constant.History.CURRENT,
      VehicleV2_Services.Constant.History.USE_EXPIRED => VehicleV2_Services.Constant.History.EXPIRED,
      VehicleV2_Services.Constant.History.INCLUDEALL);

    VehicleV2_Services.Layout_Vehicle_Key filterBySecRng(VehicleV2_Services.Layouts.layout_standard_address L,RECORDOF(VehicleV2.Key_Vehicle_MFD_Srch) R) := TRANSFORM
      hasWild:=LENGTH(std.str.filter(L.sec_range,'*?'))>0;
      isSecRngMatch:=(NOT hasWild) AND R.sec_range=L.sec_range;
      isWildSecRngMatch:=hasWild AND std.str.wildmatch(TRIM(R.sec_range),TRIM(L.sec_range),TRUE);
      SELF.is_deep_dive:=IF(L.sec_range='' OR isSecRngMatch OR isWildSecRngMatch,FALSE,SKIP);
      SELF:=R;
    END;

    rawVehKeys_info:=JOIN(srchAddrRecs,VehicleV2.Key_Vehicle_MFD_Srch,
      KEYED(LEFT.zip5=RIGHT.zip5) AND
      KEYED(LEFT.prim_range=RIGHT.prim_range) AND
      KEYED(LEFT.prim_name=RIGHT.prim_name) AND
      KEYED(LEFT.addr_suffix=RIGHT.suffix) AND
      KEYED(LEFT.predir=RIGHT.predir) AND
      KEYED(LEFT.postdir=RIGHT.postdir) AND
      RIGHT.history IN registrationType AND
      (get_minors OR RIGHT.is_minor=FALSE),
      filterBySecRng(LEFT,RIGHT),
      LIMIT(VehicleV2_Services.Constant.VEHICLE_PER_MFD_ADDR,FAIL(11,doxie.ErrorCodes(11))));
  
    rawVehKeys := IF(~isCNSMR, rawVehKeys_info);
    RETURN DEDUP(SORT(rawVehKeys,RECORD),RECORD);
  END;

END;
