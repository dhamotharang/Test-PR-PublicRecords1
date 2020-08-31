import DEA, doxie, suppress, AutoStandardI, ut, Doxie_raw, CriminalRecords_Services, STD;

todays_date := (string)STD.Date.Today();

export DEAV2_Search_recs (
  DATASET(Assorted_layouts.layout_search_IDs) ids = DATASET([],assorted_Layouts.layout_search_IDs),
  string in_ssn_mask_type = '', string32 appType, boolean includeCriminalIndicators = false) := FUNCTION

  //String9 reg_num := '' : STORED('Registration_Number');

  //******* GRAB IDS using REG NUM
  dea_reg_all := dea.Key_dea_reg_num;


  //******* LAYOUT ids with Payload
  Layout_recs := RECORD
    DEA.layout_DEA_Out;
    boolean IsDeepDive;
    boolean hasCriminalConviction := false;
    boolean isSexualOffender := false;
  END;

  //******* Creating a layout of ids and payload
  Layout_recs xfm_ids(ids l,dea_reg_all r) := TRANSFORM
        isIndividual := r.Business_activity_code[1] in ['C','G','M'];
        hasName := r.fname <> '' or r.lname <> '';
        keeprec := if(isIndividual and not hasname,false,true);
        self.Dea_Registration_Number := if(keepRec, r.Dea_Registration_Number,skip);
        self              := l ;
        self              := r ;


  END;

  sorted_Ids := SORT(ids,dea_registration_number);
  grouped_Ids := GROUP(sorted_ids,dea_registration_number);
  dea_reg := UNGROUP(JOIN(grouped_ids,dea_reg_all
                     ,KEYED(LEFT.dea_registration_number = RIGHT.dea_registration_number)
                     ,xfm_ids(LEFT,RIGHT),limit(ut.limits.DEA_PER_DID)));

  dea_active := dea_reg(expiration_Date > todays_date);
  dea_inactive := dea_reg(expiration_Date <= todays_date);
  Doxie_Raw.MAC_ENTRP_CLEAN(dea_inactive,Expiration_Date,dea_entrp);
  dea_curr := CHOOSEN(SORT(dea_Active + dea_entrp,-Expiration_Date,record),1);
  dea_recs_1 := IF(ut.IndustryClass.is_entrp,IF(ut.industryClass.entDateVal=1,dea_curr,dea_entrp+dea_active),dea_reg);
  dea_recs := GROUP(SORT(dea_recs_1,dea_registration_number),dea_registration_number);

  doxie.MAC_PruneOldSSNs(dea_recs, pruned_recs, best_ssn, did);
  Suppress.MAC_Suppress(pruned_recs,did_suppressed,appType,Suppress.Constants.LinkTypes.DID,did);
  Suppress.MAC_Suppress(did_suppressed,ssn_suppressed,appType,Suppress.Constants.LinkTypes.SSN,best_ssn);
  Suppress.MAC_Mask(ssn_suppressed, masked_recs, best_ssn, null, true, false, maskVal:=in_ssn_mask_type);


  sorted_recs := SORT(masked_recs,dea_registration_number);

  // add crim indicators
  recsIn := PROJECT(sorted_recs,TRANSFORM({Layout_recs,STRING12 UniqueId},SELF.UniqueId:=LEFT.did,SELF:=LEFT));
  CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
  crimInd_recs := PROJECT(IF(includeCriminalIndicators,recsOut,recsIn),Layout_recs);

  grouped_recs := GROUP(crimInd_recs,dea_registration_number);

  //******* OUTPUT LAYOUT fname mname lname name suffix
  Assorted_Layouts.Layout_Output_Child xfm_output_child(Layout_recs l) := TRANSFORM

    SELF.Bussiness_Type := BUSINESS_ACTIVITY(l.Business_Activity_code);
    SELF.Name := trim(l.address1,LEFT,RIGHT);

    SELF := l;
  END;

  Assorted_Layouts.Layout_Output xfm_output(Layout_recs l , DATASET(Layout_recs) r) := TRANSFORM

    SELF.dea_registration_number:= l.dea_registration_number;

    tempmodbizname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
      export string cname_field := r.cname;
    end;
    tempmodindvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
      export boolean allow_wildcard := false;
      export string fname_field := r.fname;
      export string lname_field := r.lname;
      export string mname_field := r.mname;
    end;
    tempmodbdid := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_BDID.full,opt))
      export string bdid_field := r.bdid;
    end;
    tempmodaddr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
      export boolean allow_wildcard := false;
      export string city_field := r.p_city_name;
      export string city2_field := '';
      export string pname_field := r.prim_name;
      export string postdir_field := r.postdir;
      export string prange_field := r.prim_range;
      export string predir_field := r.predir;
      export string state_field := r.st;
      export string suffix_field := r.addr_suffix;
      export string zip_field := r.zip;
    end;
    tempmoddid := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_DID.full,opt))
      export string did_field := r.did;
    end;

    party_penalt :=       min(r,AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)) +
                          min(r,AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)) +
                          min(r,AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)) ;

//    SELF.penalt := if(reg_num <>'' and reg_num = l.Dea_Registration_Number,0,party_penalt);
    SELF.penalt := party_penalt;

    SELF.Children := choosen(DEDUP(SORT(PROJECT(r,xfm_Output_child(LEFT)),
                                  -expiration_date,drug_schedules,bussiness_type,record, except name, address, did, bdid),
                             record, except name, address, did, bdid), ut.limits.DEA_MAX);
  END;

  DEASearch_results := rollup( grouped_recs,group, xfm_output(LEFT,rows(left)));

  return DEASearch_results;



END;
