IMPORT DCA,DMA,Doxie,ExecAtHomeV2,Gong,ProfileBooster,dx_BestRecords;

EXPORT GetContactInfo(DATASET(ExecAtHomeV2.Layouts.expandedLayout) ds_Contacts,
                      STRING DataRestrictionMask,
                      STRING DataPermissionMask) := 
FUNCTION
  
  // This function joins to various keys as well as calls the Profile Booster
  // to get as much additional identifying info for each executive as possible
	best_recs := dx_BestRecords.append(ds_Contacts, DID, dx_BestRecords.Constants.perm_type.marketing_preglb);
	ds_PII := project(best_recs, ExecAtHomeV2.Transforms.xfmAddWatchdogFields(left, left._best));

  ds_ProfBoostInLayout := 
  PROJECT(ds_PII,ExecAtHomeV2.Transforms.xfmToProfileBoosterInput(LEFT,COUNTER));

  ds_ProfBoosterAtts := 
  ProfileBooster.Search_Function(ds_ProfBoostInLayout, 
                                 DataRestrictionMask,
                                 DataPermissionMask,
                                 ExecAtHomeV2.Constants.PROFILE_BOOSTER_ATTR_NAME, 
                                 FALSE); // DoModel: TRUE = get Banking Experience score: PBM1803_0_1_score

  ds_ProfileBoostAttrs := 
  JOIN(ds_PII,ds_ProfBoosterAtts,
       LEFT.DID = RIGHT.LexID,
       ExecAtHomeV2.Transforms.xfmAddProfileBoosterFields(LEFT, RIGHT),
       KEEP(1),
       LIMIT(0),
       LEFT OUTER); 
  
  ds_AddPhone := 
  JOIN(ds_ProfileBoostAttrs,Gong.Key_History_Did,
       KEYED(LEFT.DID = RIGHT.l_did AND 
             RIGHT.current_flag AND
             ~RIGHT.business_flag),
       ExecAtHomeV2.Transforms.xfmAddGongPhoneFields(LEFT, RIGHT),
       KEEP(1),
       LIMIT(0),
       LEFT OUTER);
  
  ds_AddDoNotCallFlag := 
  JOIN(ds_AddPhone,DMA.key_DNC_Phone,
       KEYED(LEFT.person_best_phone = RIGHT.phonenumber),
       TRANSFORM(ExecAtHomeV2.Layouts.expandedLayout,
                 SELF.do_not_call_flag := IF(LEFT.person_best_phone = RIGHT.phonenumber,'Y','');
                 SELF := LEFT),
       KEEP(1),
       LIMIT(0),
       LEFT OUTER);
   
  // In the following join, the do_not_mail_flag uses only the RIGHT.l_lname
  // with an OR in addition to all of the conditions in the KEYED join. The thought 
  // is that if there is a RIGHT.l_lname, then there is a key hit 
  // and the record needs to be flagged as "do not mail"; thus saving the 
  // additional validation checks for each record as this is a LEFT OUTER join.
  // The additional key validations will only have to be done approx 0.00312% of the time
  ds_AddDoNotMail := 
  JOIN(ds_AddDoNotCallFlag,DMA.key_DNM_Name_Address,
       KEYED(LEFT.person_prim_name = RIGHT.l_prim_name AND
             LEFT.person_prim_range = RIGHT.l_prim_range AND
             LEFT.person_best_state = RIGHT.l_st AND
             doxie.Make_CityCode(LEFT.person_best_city) = RIGHT.l_city_code AND
             LEFT.person_best_zip = RIGHT.l_zip AND
             LEFT.person_sec_range = RIGHT.l_sec_range AND
             LEFT.person_best_lname = RIGHT.l_lname AND
             LEFT.person_best_fname = RIGHT.l_fname),
       TRANSFORM(ExecAtHomeV2.Layouts.expandedLayout,
                 SELF.do_not_mail_flag := IF(RIGHT.l_lname != '' OR
                                             (LEFT.person_prim_name = RIGHT.l_prim_name AND
                                              LEFT.person_prim_range = RIGHT.l_prim_range AND
                                              LEFT.person_best_state = RIGHT.l_st AND
                                              doxie.Make_CityCode(LEFT.person_best_city) = RIGHT.l_city_code AND
                                              LEFT.person_best_zip = RIGHT.l_zip AND
                                              LEFT.person_sec_range = RIGHT.l_sec_range AND
                                              LEFT.person_best_lname = RIGHT.l_lname AND
                                              LEFT.person_best_fname = RIGHT.l_fname),
                                             'Y','');
                 SELF := LEFT),
       KEEP(1),
       LIMIT(0),
       LEFT OUTER);

  ds_dcaData  := 
  JOIN(ds_AddDoNotMail,DCA.Key_DCA_BDID,
       KEYED(LEFT.bdid = RIGHT.bdid),
       ExecAtHomeV2.Transforms.xfmAddDCAFields(LEFT, RIGHT),
       KEEP(1),
       LIMIT(0),
       LEFT OUTER);

  RETURN ds_dcaData;

END;
