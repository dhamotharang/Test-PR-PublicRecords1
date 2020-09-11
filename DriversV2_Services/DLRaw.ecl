IMPORT DriversV2, ut, AutoStandardI, Autokey, NID, STD;

EXPORT DLRaw := MODULE

  // ------------------------------------------
  // Key & layout abbreviations
  // ------------------------------------------
  SHARED k_did := DriversV2.Key_DL_DID;
  SHARED k_num := DriversV2.Key_DL_Number;
  SHARED k_ind := DriversV2.Key_DL_Indicatives;
  SHARED l_did := DriversV2_Services.layouts.did;
  SHARED l_seq := DriversV2_Services.layouts.seq;
  SHARED l_num := DriversV2_Services.layouts.num;
  SHARED l_snum := DriversV2_Services.layouts.snum;
  SHARED l_wide := DriversV2_Services.layouts.result_wide_tmp;
  SHARED l_narrow := DriversV2_Services.layouts.result_narrow;
  SHARED l_rolled := DriversV2_Services.layouts.result_rolled;
  SHARED l_moxie := DriversV2_Services.layouts.Layout_drivers_license2_1;
  SHARED l_moxieTmp := DriversV2_Services.layouts.moxie_tmp;
  
  SHARED l_dl := DriversV2_Services.layouts.result_wide;
  SHARED l_conviction := DriversV2_Services.layouts.cp.conviction;
  SHARED l_suspension := DriversV2_Services.layouts.cp.suspension;
  SHARED l_drinfo := DriversV2_Services.layouts.cp.drinfo;
  SHARED l_accident := DriversV2_Services.layouts.cp.accident;
  SHARED l_insurance := DriversV2_Services.layouts.cp.insurance;

  SHARED k_conviction := DriversV2_Services.layouts.key_conviction;
  SHARED k_suspension := DriversV2_Services.layouts.key_suspension;
  SHARED k_drinfo := DriversV2_Services.layouts.key_drinfo;
  SHARED k_accident := DriversV2_Services.layouts.key_accident;
  SHARED k_insurance := DriversV2_Services.layouts.key_insurance;
  

  // ------------------------------------------
  // Constants
  // ------------------------------------------
  SHARED max_raw_DLs := 1000;
  SHARED moxie_pThresh := 10;
  
  
  // ------------------------------------------
  // Key conversions
  // ------------------------------------------
  EXPORT get_seq_from_dids(DATASET(l_did) in_dids) := FUNCTION
    res := JOIN(DEDUP(SORT(in_dids,did),did), k_did,
                KEYED(LEFT.did = RIGHT.did),
                TRANSFORM(l_seq, SELF := RIGHT),
                LIMIT(max_raw_DLs));
    RETURN DEDUP(SORT(res,dl_seq),RECORD);
  END;
  
  EXPORT get_seq_from_num(DATASET(l_num) in_nums) := FUNCTION
    res := JOIN(DEDUP(SORT(in_nums,dl_number),dl_number), k_num,
                KEYED(LEFT.dl_number = RIGHT.s_dl),
                TRANSFORM(l_seq, SELF := RIGHT),
                LIMIT(max_raw_DLs));
    RETURN DEDUP(SORT(res,dl_seq),dl_seq);
  END;
  
  EXPORT get_seq_from_snum(DATASET(l_snum) in_snums) := FUNCTION
    res := JOIN(DEDUP(SORT(in_snums,dl_number,orig_state),dl_number,orig_state), k_num,
                KEYED(LEFT.dl_number = RIGHT.s_dl) AND LEFT.orig_state = RIGHT.orig_state,
                TRANSFORM(l_seq, SELF := RIGHT),
                LIMIT(max_raw_DLs,SKIP));
    RETURN DEDUP(SORT(res,dl_seq),dl_seq);
  END;
  
  EXPORT BOOLEAN histOK(STRING1 hist) := MAP(
    DriversV2_Services.input.IncludeHistory=DriversV2.Constants.IncludeHistory.current AND hist<>'' => FALSE,
    DriversV2_Services.input.IncludeHistory=DriversV2.Constants.IncludeHistory.history AND hist='' => FALSE,
    TRUE);
  
  EXPORT BOOLEAN ageOK(UNSIGNED8 dob, UNSIGNED8 asOfDate, UNSIGNED1 in_agelow, UNSIGNED1 in_agehigh) := FUNCTION
    age := ut.age(dob, asOfDate);
    RETURN (age <= in_agehigh AND age >= in_agelow);
  END;
  
  EXPORT get_seq_from_ind(STRING2 in_DLState, UNSIGNED1 in_agelow, UNSIGNED1 in_agehigh, STRING1 in_race, STRING1 in_gender) := FUNCTION
    // get DLs matching the indicatives
    raw := k_ind(
      KEYED(race = in_race),
      KEYED(sex_flag = in_gender),
      KEYED(age <= in_agehigh AND age >= in_agelow),
      KEYED(orig_state = in_DLState));
    
    // reduce to no more than 10K distinct records
    raw2 := DEDUP( SORT( PROJECT(raw, TRANSFORM(l_snum, SELF:=LEFT)), RECORD), RECORD);
    ut.MAC_Pick_Random(raw2,snums,10000);
    
    // convert to seqs
    seqs := JOIN(
      snums, k_num,
      KEYED(LEFT.dl_number=RIGHT.s_dl) AND
        LEFT.orig_state=RIGHT.orig_state AND
        histOK(RIGHT.history) AND
        ageOK(RIGHT.dob, RIGHT.lic_issue_date, in_agelow, in_agehigh),
      TRANSFORM({l_seq; k_num.dl_number; k_num.orig_state; k_num.lic_issue_date;}, SELF := RIGHT),
      LIMIT(max_raw_DLs,SKIP));
    
    // keep only the most recent seq per dl_number
    seqs_d := PROJECT(DEDUP(SORT(seqs, dl_number, orig_state, -lic_issue_date), dl_number, orig_state), l_seq);
    
    // pick some at random, getting more than we think we'll need because of reductions later
    scale := CASE(
      DriversV2_Services.input.IncludeHistory,
      DriversV2.Constants.IncludeHistory.current => 10,
      DriversV2.Constants.IncludeHistory.history => 10,
      3);
    ut.MAC_Pick_Random(seqs_d,seqs_r,DriversV2_Services.input.maxResults*scale);
    
    // NOTE: after the rest of the processing is done, we'll still need to
    //       randomly pare the results down to input.maxThisTime records
    
    RETURN seqs_r;
  END;
  
  EXPORT get_did_from_num(DATASET(l_num) in_nums) := FUNCTION
    res := JOIN(DEDUP(SORT(in_nums,dl_number),dl_number), k_num,
                KEYED(LEFT.dl_number = RIGHT.s_dl),
                TRANSFORM(l_did, SELF := RIGHT),
                LIMIT(max_raw_DLs));
    RETURN DEDUP(SORT(res(did<>0),did),did);
  END;
  
  EXPORT get_did_from_snum(DATASET(l_snum) in_snums) := FUNCTION
    res := JOIN(DEDUP(SORT(in_snums,dl_number,orig_state),dl_number,orig_state), k_num,
                KEYED(LEFT.dl_number = RIGHT.s_dl) AND LEFT.orig_state = RIGHT.orig_state,
                TRANSFORM(l_did, SELF := RIGHT),
                LIMIT(max_raw_DLs,SKIP));
    RETURN DEDUP(SORT(res(did<>0),did),did);
  END;
  
  // ------------------------------------------
  // Return DL data in the wide report format
  // ------------------------------------------
  EXPORT wide_view := MODULE
  
    SHARED DATASET(l_wide) applyFilter(
      DATASET(l_wide) wide_recs
    ) := FUNCTION
    
      sort_recs := SORT(wide_recs,
          -IF(lic_issue_date=0,dt_first_seen,lic_issue_date),-IF(lic_issue_date =0,dt_last_seen,expiration_date), RECORD,
          EXCEPT dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
          license_type, license_class, restrictions_delimited, lic_endorsement);
      results := DEDUP(sort_recs,
        lic_issue_date, expiration_date, RECORD,
        EXCEPT dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
          license_type, license_class, restrictions_delimited, lic_endorsement
      );
      dmv := results(source_code NOT IN DriversV2.Constants.nonDMVSources);
      non_dmv := results(source_code IN DriversV2.Constants.nonDMVSources);
      res := dmv & SORT(non_dmv, -dt_last_seen, RECORD);
      RETURN res;
    END;

    // ...using source to generate report
    EXPORT DATASET(l_wide) by_src(
      DATASET(DriversV2_Services.layouts.src) dl_src
    ) := FUNCTION
      recs := DriversV2_Services.fn_getDL_report(,dl_src);
      wide_recs := applyFilter(PROJECT(recs, l_wide));
      RETURN wide_recs;
    END;
    
    // ...using seq as the lookup mechanism
    EXPORT DATASET(l_wide) by_seq(
      DATASET(l_seq) in_seqs
    ) := FUNCTION
      recs := DriversV2_Services.fn_getDL_report(in_seqs);
      wide_recs := applyFilter(PROJECT(recs, l_wide));
      RETURN wide_recs;
    END;
    
    // ...using DID as the lookup mechanism
    EXPORT DATASET(l_wide) by_did(
      DATASET(l_did) in_dids
    ) := FUNCTION
      RETURN by_seq(get_seq_from_dids(in_dids));
    END;
    
    // ...using dl_number as the lookup mechanism
    EXPORT DATASET(l_wide) by_num(
      DATASET(l_num) in_nums
    ) := FUNCTION
      RETURN by_seq(get_seq_from_num(in_nums));
    END;

    // ...using dl_number as the lookup mechanism
    EXPORT DATASET(l_wide) by_snum(
      DATASET(l_snum) in_snums
    ) := FUNCTION
      RETURN by_seq(get_seq_from_snum(in_snums));
    END;
  END; // wide_view
  
  
  // ------------------------------------------
  // Return DL data in the narrow report format
  // ------------------------------------------
  EXPORT narrow_view := MODULE
  
    // ...using seq as the lookup mechanism
    EXPORT DATASET(l_narrow) by_seq(
      DATASET(l_seq) in_seqs,
      DriversV2_Services.GetDLParams.params gdlParams = DriversV2_Services.GetDLParams.getDefault()
    ) := FUNCTION
      recs := DriversV2_Services.fn_getDL_report(in_seqs,,gdlParams);
      narrow_recs := PROJECT(recs, l_narrow);
      sort_recs := SORT(narrow_recs, -lic_issue_date, -expiration_date, RECORD);
      results := DEDUP(
        sort_recs,
        EXCEPT dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
          license_type, restrictions_delimited, lic_endorsement
      );
      RETURN results;
    END;
    
    // ...using DID as the lookup mechanism
    EXPORT DATASET(l_narrow) by_did(
      DATASET(l_did) in_dids
    ) := FUNCTION
      RETURN by_seq(get_seq_from_dids(in_dids));
    END;
    
    // ...using dl_number as the lookup mechanism
    EXPORT DATASET(l_narrow) by_num(
      DATASET(l_num) in_nums
    ) := FUNCTION
      RETURN by_seq(get_seq_from_num(in_nums));
    END;
  END; // narrow_view

    // Function for perfomance improvement of Batch Services(DriversV2_Services.Batch_Service).
EXPORT DATASET(l_narrow) by_DL_src(
    DATASET(DriversV2_Services.layouts.src) in_dl_src,
    DriversV2_Services.GetDLParams.params gdlParams = DriversV2_Services.GetDLParams.getDefault(),
    BOOLEAN IsBatch = FALSE
    ) := FUNCTION
  recs := DriversV2_Services.fn_getDL_report(,in_dl_src,gdlParams,IsBatch);
  narrow_recs := PROJECT(recs, l_narrow);
  sort_recs := SORT(narrow_recs, -lic_issue_date, -expiration_date, RECORD);
  results := DEDUP(sort_recs, EXCEPT 
    dl_seq, sex_flag, history, eye_color, hair_color, attention_flag,
      license_type, restrictions_delimited, lic_endorsement);
  RETURN results;
END;
  
  // ------------------------------------------
  // Convert wide DL report to DLCP report format
  // ------------------------------------------
  EXPORT DATASET(l_rolled) wideToDLCP(
    DATASET(l_wide) in_recs,
    BOOLEAN incAll = FALSE
  ) := FUNCTION
    
    // we shouldn't roll records with a blank DLCP_key
    dl_blank := PROJECT(
      in_recs(DLCP_key=''),
      TRANSFORM(
        l_rolled,
        SELF.dl := PROJECT(LEFT, TRANSFORM(l_dl, SELF := LEFT)),
        SELF := []
      )
    );
    
    // group by DLCP_key
    dl_srt := SORT(in_recs(DLCP_key<>''), DLCP_key, -lic_issue_date, -expiration_date, RECORD);
    dl_grp := GROUP(dl_srt, DLCP_key);
    
    //Accident Transform to fix CountyName decode
    DriversV2_Services.layouts.cp.accident accident_xrf(DriversV2_Services.layouts.cp.accident childRow) := TRANSFORM
      tmp := DriversV2_Services.Functions.getCensusCountyDecode(childRow.jurisdiction,childRow.county);
      SELF.county_name := IF(LENGTH(tmp)>0, tmp, '');
      SELF := childRow;
    END;
    DriversV2_Services.layouts.cp.conviction conviction_xrf(DriversV2_Services.layouts.cp.conviction childRow) := TRANSFORM
      tmp := DriversV2_Services.Functions.getStateSpecificCountyDecode(childRow.court_county);
      SELF.court_name_desc := IF(LENGTH(tmp)>0, tmp, childRow.court_name_desc);
      SELF := childRow;
    END;
    DriversV2_Services.layouts.cp.suspension suspension_xrf(DriversV2_Services.layouts.cp.suspension childRow) := TRANSFORM
      tmp := DriversV2_Services.Functions.getStateSpecificCountyDecode(childRow.court_county);
      SELF.court_name_desc := IF(LENGTH(tmp)>0, tmp, childRow.court_name_desc);
      SELF := childRow;
    END;
    
    
    // rollup by DLCP_key and add to output layout
    l_rolled doRollup(l_wide L, DATASET(l_wide) allRows) := TRANSFORM
      SELF.DLCP_key := L.DLCP_key;
      SELF.dl := CHOOSEN( DEDUP( PROJECT(allRows, TRANSFORM(l_dl, SELF := LEFT)), EXCEPT dl_seq ), DriversV2_Services.layouts.max_dl );
      SELF := [];
    END;
    dl_rolled := NOFOLD( ROLLUP(dl_grp, GROUP, doRollup(LEFT, ROWS(LEFT))) );
    
    recs := dl_blank + dl_rolled;
    dmv := recs(dl[1].source_code NOT IN DriversV2.Constants.nonDMVSources);
    non_dmv := recs(dl[1].source_code IN DriversV2.Constants.nonDMVSources);
    dl_sorted := SORT(dmv, -dl[1].lic_issue_date, -dl[1].expiration_date, RECORD) &
                 SORT(non_dmv, -dl[1].dt_last_seen, RECORD);
    
    
    // and add CP data to the results
    l_rolled addCP(l_rolled L) := TRANSFORM
      key := L.DLCP_key;
      
      conviction := PROJECT( LIMIT( k_conviction( KEYED(dlcp_key=key) ), DriversV2_Services.layouts.max_dlcp_raw, SKIP), l_conviction );
      suspension := PROJECT( LIMIT( k_suspension( KEYED(dlcp_key=key) ), DriversV2_Services.layouts.max_dlcp_raw, SKIP), l_suspension );
      drinfo := PROJECT( LIMIT( k_drinfo( KEYED(dlcp_key=key) ), DriversV2_Services.layouts.max_dlcp_raw, SKIP), l_drinfo );
      accident := PROJECT( LIMIT( k_accident( KEYED(dlcp_key=key) ), DriversV2_Services.layouts.max_dlcp_raw, SKIP), l_accident );
      insurance := PROJECT( LIMIT( k_insurance( KEYED(dlcp_key=key) ), DriversV2_Services.layouts.max_dlcp_raw, SKIP), l_insurance );

      conviction_d := DEDUP( SORT( conviction, -violation_date, -conviction_date, RECORD), RECORD);
      suspension_d := DEDUP( SORT( suspension, -violation_date, -clear_date, RECORD), RECORD);
      drinfo_d := DEDUP( SORT( drinfo, -action_date, -clear_date, RECORD), RECORD);
      accident_d := DEDUP( SORT( accident, -accident_date, -create_date, RECORD), RECORD);
      insurance_d := DEDUP( SORT( insurance, -create_date, -cancel_posted_date, RECORD), RECORD);
      
      //Add choosen logic and add decodes for Accidents
      accident_cn := IF(incAll OR DriversV2_Services.input.incAccidents, CHOOSEN( accident_d, DriversV2_Services.layouts.max_accidents ) );
      accident_f := PROJECT(accident_cn,accident_xrf(LEFT));
      conviction_cn := IF(incAll OR DriversV2_Services.input.incConvictions, CHOOSEN( conviction_d, DriversV2_Services.layouts.max_convictions ) );
      conviction_f := PROJECT(conviction_cn,conviction_xrf(LEFT));
      suspension_cn := IF(incAll OR DriversV2_Services.input.incSuspensions, CHOOSEN( suspension_d, DriversV2_Services.layouts.max_suspensions ) );
      suspension_f := PROJECT(suspension_cn,suspension_xrf(LEFT));

      SELF.Convictions := conviction_f;
      SELF.Suspensions := suspension_f;
      SELF.DR_Info := IF(incAll OR DriversV2_Services.input.incDRInfo, CHOOSEN( drinfo_d, DriversV2_Services.layouts.max_drinfo ) );
      SELF.Accidents := accident_f;
      SELF.FRA_Insurance := IF(incAll OR DriversV2_Services.input.incFRAInsurance, CHOOSEN( insurance_d, DriversV2_Services.layouts.max_insurance ) );
      
      SELF := L;
    END;
    dl_cp := PROJECT(dl_sorted, addCP(LEFT));
    
    RETURN dl_cp;
    
  END;
  
  
    EXPORT uber_view := MODULE
     
     SHARED in_mod := AutoStandardI.GlobalModule();
     EXPORT get_words():= FUNCTION
      format_word(STRING wrd) := STD.Str.ToUpperCase(wrd);
      BOOLEAN nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.nicknames.params));
      BOOLEAN phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.phonetics.params));
      STRING fname_val := AutoStandardI.InterfaceTranslator.fname_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
      STRING fname := IF(~nicknames, fname_val,'');
      STRING lname_val := AutoStandardI.InterfaceTranslator.lname_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
      STRING lname := IF(~phonetics, lname_val,'');
      STRING mname := AutoStandardI.InterfaceTranslator.mname_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.mname_value.params));
      STRING addr_val := AutoStandardI.InterfaceTranslator.addr_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.addr_value.params));
      STRING prange_val := AutoStandardI.InterfaceTranslator.prange_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.prange_value.params));
      //can't use AutoStandardI.InterfaceTranslator.pname_value since it removes street ordinals (ut.StripOrdinal)
      STRING pname_val := in_mod.prim_name;
      STRING addr := format_word(IF(prange_val ='' AND pname_val='',addr_val,''));
      STRING prange := IF(addr_val ='',prange_val,'');
      STRING pname := IF(addr_val ='',pname_val,'');
      STRING city := AutoStandardI.InterfaceTranslator.city_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
      STRING state := AutoStandardI.InterfaceTranslator.state_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
      STRING zip := (STRING)AutoStandardI.InterfaceTranslator.zip_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params))[1];
      STRING dob := (STRING)AutoStandardI.InterfaceTranslator.dob_val.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.dob_val.params));
      STRING pfname := IF(nicknames,NID.PreferredFirstNew(fname_val),'');
      STRING dph_lname := IF(phonetics,metaphonelib.DMetaPhone1(lname_val)[1..6],'');
      
      addr_Rec := RECORD
        STRING30 word;
      END;
      addr_ds := DATASET([{addr}],addr_rec); // Parameter into DATASET to allow NORMALIZE

      addr_rec split(addr_ds le,UNSIGNED2 c) := TRANSFORM
        SELF.word := ut.Word(le.word,c);
      END;
      norm_addr := NORMALIZE(addr_ds,ut.NoWords(LEFT.word),split(LEFT,COUNTER));
      fld_cnst(STRING fld) := Autokey.UBER_Constants.Uber_FieldData(FieldName=fld)[1].FieldID;
      WDS := DATASET([{FNAME,FLD_CNST('FNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + DATASET([{PFNAME,FLD_CNST('PFNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + DATASET([{MNAME,FLD_CNST('MNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + DATASET([{LNAME,FLD_CNST('LNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + DATASET([{DPH_LNAME,FLD_CNST('DPH_LNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + DATASET([{PRANGE,FLD_CNST('PRANGE')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + DATASET([{PNAME,FLD_CNST('PNAME')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + DATASET([{CITY,FLD_CNST('CITY')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + DATASET([{STATE,FLD_CNST('STATE')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + DATASET([{ZIP,FLD_CNST('ZIP')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + DATASET([{DOB,FLD_CNST('DOB')}],AUTOKEY.LAYOUT_UBER.WORD_PARAMS)
             + PROJECT(NORM_ADDR,TRANSFORM(AUTOKEY.LAYOUT_UBER.WORD_PARAMS
                                ,SELF.FIELD :=FLD_CNST('ADDR'),SELF := LEFT));
    
    RETURN wds(~word in ['','0']);

    END;
  
  END;

END;
