IMPORT Census_Data, Doxie, dx_Gong, Gong_Services, MDR, Phones, Suppress;

lBatchIn   := PhoneFinder_Services.Layouts.BatchInAppendDID;
lCommon    := PhoneFinder_Services.Layouts.PhoneFinder.Common;

// Gong and gong history data
EXPORT GetGongPhones( DATASET(lBatchIn)                        dIn,
                      PhoneFinder_Services.iParam.SearchParams inMod) :=
FUNCTION
  mod_access := PROJECT(inMod, Doxie.IDataAccess);
  // Split the phone number into phone7 and area code
  rBatchInSplitPhone_Layout :=
  RECORD(lBatchIn)
    STRING7 phone7;
    STRING3 area_code;
  END;

  rBatchInSplitPhone_Layout  tSplitPhone10(dIn pInput) :=
  TRANSFORM
    SELF.phone7    := IF(LENGTH(TRIM(pInput.homephone)) = 10,pInput.homephone[4..10],pInput.homephone[1..7]);
    SELF.area_code := IF(LENGTH(TRIM(pInput.homephone)) = 10,pInput.homephone[1..3],'');
    SELF           := pInput;
  END;

  dInSplitPhone10 := PROJECT(dIn,tSplitPhone10(LEFT));

  // Get gong records
  rGongPhone_Layout :=
  RECORD(Gong_Services.Layout_GongHistorySearchService)
    rBatchInSplitPhone_Layout batch_in;
  END;

  rGongPhone_Layout_optout := RECORD
    rGongPhone_Layout;
    unsigned4 global_sid;
    unsigned8 record_sid;
  END;

  key_history_phone := dx_Gong.key_history_phone();
  rGongPhone_Layout_optout tGetByPhone(dInSplitPhone10 le, key_history_phone ri) :=
  TRANSFORM
    SELF.batch_in := le;
    SELF.global_sid := ri.global_sid;
    SELF.record_sid := ri.record_sid;
    SELF.did := ri.did;
    SELF          := ri;
  END;

  pre_dPhoneRecs := JOIN( dInSplitPhone10,
                      key_history_phone,
                      KEYED(LEFT.phone7 = RIGHT.p7) and
                      KEYED(LEFT.area_code = RIGHT.p3 or LEFT.area_code = ''),
                      tGetByPhone(LEFT,RIGHT),
                      LIMIT(PhoneFinder_Services.Constants.MaxGongPhones,SKIP));

  dPhoneRecs_optout := Suppress.MAC_SuppressSource(pre_dPhoneRecs, mod_access);
  dPhoneRecs := PROJECT(dPhoneRecs_optout, rGongPhone_Layout);

  dPhoneRecsSort := SORT( dPhoneRecs,
                          batch_in.acctno,publish_code,phone10,
                          prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,
                          p_city_name,st,z5,z4,
                          listed_name,name_first,name_last,
                          omit_address,omit_phone,omit_locality);

  rGongPhone_Layout tPhoneRollup(rGongPhone_Layout le,rGongPhone_Layout ri) :=
  TRANSFORM
    SELF.dt_first_seen       := IF( (le.dt_first_seen = '' or ri.dt_first_seen <> '') and (ri.dt_first_seen < le.dt_first_seen),
                                    ri.dt_first_seen,
                                    le.dt_first_seen);
    SELF.dt_last_seen        := IF( (le.dt_last_seen = '' or ri.dt_last_seen <> '') and (ri.dt_last_seen > le.dt_last_seen),
                                    ri.dt_last_seen,
                                    le.dt_last_seen);
    SELF.current_record_flag := IF(le.current_record_flag <> '',le.current_record_flag,ri.current_record_flag);
    SELF.v_city_name         := IF( le.p_city_name = le.v_city_name and le.v_city_name <> ri.v_city_name,
                                    ri.v_city_name,
                                    le.v_city_name);
    BOOLEAN substitute_vname := le.prim_name = le.v_prim_name and le.v_prim_name <> ri.v_prim_name;
    SELF.v_predir            := IF(substitute_vname,ri.v_predir,le.v_predir);
    SELF.v_prim_name         := IF(substitute_vname,ri.v_prim_name,le.v_prim_name);
    SELF.v_suffix            := IF(substitute_vname,ri.v_suffix,le.v_suffix);
    SELF.v_postdir           := IF(substitute_vname,ri.v_postdir,le.v_postdir);

    SELF                     := ri;
  END;

  dPhoneRecsRollup := rollup( dPhoneRecsSort
                              ,tPhoneRollup(LEFT,RIGHT)
                              ,batch_in.acctno
                              ,publish_code
                              ,phone10
                              ,prim_range
                              ,predir
                              ,prim_name
                              ,suffix
                              ,postdir
                              ,unit_desig
                              ,sec_range
                              ,p_city_name
                              ,st
                              ,z5
                              ,z4
                              ,listed_name
                              ,omit_address
                              ,omit_phone
                              ,omit_locality
                              ,name_first
                              ,name_last);

  // Append county name
  rAppendcountyName_Layout :=
  RECORD(rGongPhone_Layout)
    STRING18 county_name;
  END;

  rAppendcountyName_Layout tAppendcountyName(rGongPhone_Layout le,Census_Data.Key_Fips2county ri) :=
  TRANSFORM
    SELF.county_name := IF(le.county_code <> '',ri.county_name,'');
    SELF             := le;
  END;

  dAppendcountyName := JOIN(dPhoneRecsRollup,
                            Census_Data.Key_Fips2county,
                            KEYED(LEFT.st                = RIGHT.state_code and
                                  LEFT.county_code[3..5] = RIGHT.county_fips),
                            tAppendcountyName(LEFT,RIGHT),
                            LEFT OUTER,
                            KEEP(1));

  // Reformat to common layout
  lCommon tFormatGong2Common(dAppendcountyName pInput) :=
  TRANSFORM
    SELF.src             := MDR.SourceTools.src_Gong_phone_append;
    SELF.vendor_id       := 'GH';
    SELF.fname           := pInput.name_first;
    SELF.mname           := pInput.name_middle;
    SELF.lname           := pInput.name_last;
    SELF.city_name       := pInput.p_city_name;
    SELF.zip             := pInput.z5;
    SELF.zip4            := pInput.z4;
    SELF.phone           := pInput.phone10;
    SELF.listed_phone    := pInput.phone10;
    SELF.TNT             := 'V';
    SELF.ConfidenceScore := 30;
    SELF.phone_source    := PhoneFinder_Services.Constants.PhoneSource.Gong;
    SELF                 := pInput;
    SELF                 := [];
  END;

  dGongFormat2Common := PROJECT(dAppendcountyName,tFormatGong2Common(LEFT));

  // Calculate penalty
  lCommon tGetPenalty(dGongFormat2Common pInput) :=
  TRANSFORM
    SELF.penalt := Phones.GetPenalty.GetPhonePenalty(pInput);
    SELF        := pInput;
  END;

  dGongPenalty := PROJECT(dGongFormat2Common,tGetPenalty(LEFT));

  // Filter out records which do not meet the penalty threshold
  dGongPenaltyFilter := dGongPenalty(penalt <= inMod.PenaltyThreshold);

  // Debug
  #IF(PhoneFinder_Services.Constants.Debug.Gong)
    OUTPUT(dIn,NAMED('dGong_In'),EXTEND);
    OUTPUT(dInSplitPhone10,NAMED('dGong_InSplitPhone10'),OVERWRITE);
    OUTPUT(dPhoneRecs,NAMED('dGong_PhoneRecs'),OVERWRITE);
    OUTPUT(dPhoneRecsSort,NAMED('dGong_PhoneRecsSort'),OVERWRITE);
    OUTPUT(dPhoneRecsRollup,NAMED('dGong_PhoneRecsRollup'),OVERWRITE);
    OUTPUT(dAppendcountyName,NAMED('dGong_AppendcountyName'),OVERWRITE);
    OUTPUT(dGongFormat2Common,NAMED('dGongFormat2Common'),OVERWRITE);
    OUTPUT(dGongPenalty,NAMED('dGongPenalty'),OVERWRITE);
  #END

  RETURN dGongPenaltyFilter;
END;
