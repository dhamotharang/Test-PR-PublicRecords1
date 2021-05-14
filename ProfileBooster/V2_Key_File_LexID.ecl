import ProfileBooster, MDR, dx_header, risk_indicators, dx_ProfileBooster, STD, address;

#OPTION('multiplePersistInstances', FALSE); // TRUE - to allow multiple files/jobs to run at same time
#OPTION('expandSelectCreateRow', TRUE);
#OPTION('outputLimit', 2000);
#OPTION('outputLimitMb', 1000);
#OPTION('splitterSpill', 1);
#OPTION('defaultSkewError', 1);
#OPTION('globalAutoHoist', FALSE);

export V2_Key_File_LexID(STRING8 history_date) := function

 	nines		 		:= 9999999;
  Score_threshold := 80;

  base := DATASET('~jfrancis::in::pb20::sampleHeaderAllDids.csv',dx_Header.layout_key_header,CSV(heading(single), quote('"')));
  // base := dx_Header.key_header();
  // base := DATASET('~jfrancis::in::pb20::sampleHeader.csv',dx_Header.layout_key_header,CSV(heading(single), quote('"')));
  distributed_allDIDs := distribute(base(did>0 AND dt_first_seen<=(unsigned)risk_indicators.iid_constants.myGetDate((integer)history_date[1..6])), hash64(did));

	uniqueDIDs := dedup(sort(distributed_allDIDs, DID, -dt_first_seen, local), DID, local);//   : PERSIST('~PROFILEBOOSTER::unique_DIDs_thor');  // remove persists because low on disk space and it's rebuilding persist file each time anyway

  //slim down the uniqueDIDs records to create a smaller layout to pass into all of the following searches
	slimShell := project(uniqueDIDs,  
												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim,
                                  self.seq          := left.did;
                                  self.did2         := left.did;
                                  self.did          := left.did;
                                  self.rec_type     := 1;
                                  self.addr_suffix  := left.suffix;
                                  self.p_city_name  := left.city_name;
                                  self.z5           := left.zip;
                                  self.historydate  := (INTEGER)history_date[1..6];
																	self 							:= left;
                                  self              := []), local);

  PB_In := PROJECT(uniqueDIDs, TRANSFORM(ProfileBooster.V2_Key_Layouts.Layout_PB2_In, 
            SELF.AcctNo := (STRING)LEFT.did;
            SELF.seq := LEFT.did;
            SELF.LexID := LEFT.did;
            SELF.Name_First := LEFT.fname;
            SELF.Name_Middle := LEFT.mname;
            SELF.Name_Last := LEFT.lname;
            SELF.Name_Suffix := LEFT.name_suffix;
            SELF.ssn := LEFT.ssn;
            SELF.dob := (STRING)LEFT.dob;
            SELF.phone10 := LEFT.phone;
            SELF.street_addr := address.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name,
                         LEFT.suffix, LEFT.postdir, LEFT.unit_desig, LEFT.sec_range);
            SELF.streetnumber := LEFT.prim_range;
            SELF.streetpredirection := LEFT.predir;
            SELF.streetname := LEFT.prim_name;
            SELF.streetsuffix := LEFT.suffix;
            SELF.streetpostdirection := LEFT.postdir;
            SELF.unitdesignation := LEFT.unit_desig;
            SELF.unitnumber := LEFT.sec_range;
            SELF.City_name := LEFT.city_name;
            SELF.st := LEFT.st;
            SELF.z5 := LEFT.zip;
            SELF.HistoryDate := (integer)history_date[1..6];
            SELF := LEFT; 
            SELF := [];), local);
  DataRestrictionMask := Risk_Indicators.iid_constants.default_DataRestriction;
  DataPermissionMask  := Risk_Indicators.iid_constants.default_DataPermission;
  PB_Search_Function_THOR := ProfileBooster.V2_Key_Search_Function_THOR(PB_In,DataRestrictionMask);

  final := PROJECT(PB_Search_Function_THOR, TRANSFORM(dx_ProfileBooster.Layouts.i_lexid, 
                  SELF.DID := LEFT.LexID;
                  SELF.HHID := LEFT.attributes.version2.hhid;
                  SELF.DemEduCollCurrFlag := LEFT.attributes.version2.DemEduCollCurrFlag;
                  SELF.DemEduCollFlagEv := LEFT.attributes.version2.DemEduCollFlagEv;
                  SELF.DemEduCollNewLevelEv := LEFT.attributes.version2.DemEduCollNewLevelEv;
                  SELF.DemEduCollNewPvtFlag := LEFT.attributes.version2.DemEduCollNewPvtFlag;
                  SELF.DemEduCollNewTierIndx := LEFT.attributes.version2.DemEduCollNewTierIndx;
                  SELF.DemEduCollLevelHighEv := LEFT.attributes.version2.DemEduCollLevelHighEv;
                  SELF.DemEduCollRecNewInstTypeEv := (STRING6)LEFT.attributes.version2.DemEduCollRecNewInstTypeEv;
                  SELF.DemEduCollTierHighEv := LEFT.attributes.version2.DemEduCollTierHighEv;
                  SELF.DemEduCollRecNewMajorTypeEv := LEFT.attributes.version2.DemEduCollRecNewMajorTypeEv;
                  SELF.DemEduCollEvidFlagEv := LEFT.attributes.version2.DemEduCollEvidFlagEv;  
                  SELF.DemEduCollSrcNewRecOldMsncEv := LEFT.attributes.version2.DemEduCollSrcNewRecOldMsncEv;
                  SELF.DemEduCollSrcNewRecNewMsncEv := LEFT.attributes.version2.DemEduCollSrcNewRecNewMsncEv;
                  SELF.DemEduCollRecSpanEv := LEFT.attributes.version2.DemEduCollRecSpanEv;
                  SELF.DemEduCollRecNewClassEv := LEFT.attributes.version2.DemEduCollRecNewClassEv;
                  SELF.DemEduCollSrcNewExpGradYr := LEFT.attributes.version2.DemEduCollSrcNewExpGradYr;
                  SELF.DemEduCollInstPvtFlagEv := LEFT.attributes.version2.DemEduCollInstPvtFlagEv;
                  SELF.DemEduCollMajorMedicalFlagEv := LEFT.attributes.version2.DemEduCollMajorMedicalFlagEv;
                  SELF.DemEduCollMajorPhysSciFlagEv := LEFT.attributes.version2.DemEduCollMajorPhysSciFlagEv;
                  SELF.DemEduCollMajorSocSciFlagEv := LEFT.attributes.version2.DemEduCollMajorSocSciFlagEv;
                  SELF.DemEduCollMajorLibArtsFlagEv := LEFT.attributes.version2.DemEduCollMajorLibArtsFlagEv;
                  SELF.DemEduCollMajorTechnicalFlagEv := LEFT.attributes.version2.DemEduCollMajorTechnicalFlagEv;
                  SELF.DemEduCollMajorBusFlagEv := LEFT.attributes.version2.DemEduCollMajorBusFlagEv;
                  SELF.DemEduCollMajorEduFlagEv := LEFT.attributes.version2.DemEduCollMajorEduFlagEv;
                  SELF.DemEduCollMajorLawFlagEv := LEFT.attributes.version2.DemEduCollMajorLawFlagEv;
                  SELF.IntSportPersonFlagEv := LEFT.attributes.version2.IntSportPersonFlagEv;
                  SELF.IntSportPersonFlag1Y := LEFT.attributes.version2.IntSportPersonFlag1Y;
                  SELF.IntSportPersonFlag5Y := LEFT.attributes.version2.IntSportPersonFlag5Y;
                  SELF.IntSportPersonTravelerFlagEv := LEFT.attributes.version2.IntSportPersonTravelerFlagEv;
                  SELF.LifeMoveNewMsnc := LEFT.attributes.version2.LifeMoveNewMsnc;
                  SELF.LifeNameLastChngFlag := LEFT.attributes.version2.LifeNameLastChngFlag;
                  SELF.LifeNameLastChngFlag1Y := LEFT.attributes.version2.LifeNameLastChngFlag1Y;
                  SELF.LifeNameLastCntEv := LEFT.attributes.version2.LifeNameLastCntEv;
                  SELF.LifeNameLastChngNewMsnc := LEFT.attributes.version2.LifeNameLastChngNewMsnc;
                  SELF.LifeAstPurchOldMsnc := LEFT.attributes.version2.LifeAstPurchOldMsnc;
                  SELF.LifeAstPurchNewMsnc := LEFT.attributes.version2.LifeAstPurchNewMsnc;
                  SELF.LifeAddrCnt := LEFT.attributes.version2.LifeAddrCnt;
                  SELF.LifeAddrEconTrajType := LEFT.attributes.version2.LifeAddrEconTrajType;
                  SELF.LifeAddrEconTrajIndx := LEFT.attributes.version2.LifeAddrEconTrajIndx;
                  SELF.AstCurrFlag := LEFT.attributes.version2.AstCurrFlag;
                  SELF.AstPropCurrFlag := LEFT.attributes.version2.AstPropCurrFlag;
                  SELF.AstPropCurrCntEv := LEFT.attributes.version2.AstPropCurrCntEv;
                  SELF.AstPropCurrValTot := LEFT.attributes.version2.AstPropCurrValTot;
                  SELF.AstPropCurrAVMTot := LEFT.attributes.version2.AstPropCurrAVMTot;
                  SELF.AstPropSaleNewMsnc := LEFT.attributes.version2.AstPropSaleNewMsnc;
                  SELF.AstPropCntEv := LEFT.attributes.version2.AstPropCntEv;
                  SELF.AstPropSoldCntEv := LEFT.attributes.version2.AstPropSoldCntEv;
                  SELF.AstPropSoldCnt1Y := LEFT.attributes.version2.AstPropSoldCnt1Y;
                  SELF.AstPropSoldNewRatio := LEFT.attributes.version2.AstPropSoldNewRatio;
                  SELF.AstPropPurchCnt1Y := LEFT.attributes.version2.AstPropPurchCnt1Y;
                  SELF.AstPropAirCrftCntEv := LEFT.attributes.version2.AstPropAirCrftCntEv;
                  SELF.AstPropWtrcrftCntEv := LEFT.attributes.version2.AstPropWtrcrftCntEv;
                  SELF.CurrAddrOwnershipIndx := LEFT.attributes.version2.CurrAddrOwnershipIndx;
                  SELF.CurrAddrHasPoolFlag := LEFT.attributes.version2.CurrAddrHasPoolFlag;
                  SELF.CurrAddrIsMobileHomeFlag := LEFT.attributes.version2.CurrAddrIsMobileHomeFlag;
                  SELF.CurrAddrBathCnt := LEFT.attributes.version2.CurrAddrBathCnt;
                  SELF.CurrAddrParkingCnt := LEFT.attributes.version2.CurrAddrParkingCnt;
                  SELF.CurrAddrBuildYr := LEFT.attributes.version2.CurrAddrBuildYr;
                  SELF.CurrAddrBedCnt := LEFT.attributes.version2.CurrAddrBedCnt;
                  SELF.CurrAddrBldgSize := LEFT.attributes.version2.CurrAddrBldgSize;
                  SELF.CurrAddrIsCollegeFlag := LEFT.attributes.version2.CurrAddrIsCollegeFlag;
                  SELF.CurrAddrAVMVal := LEFT.attributes.version2.CurrAddrAVMVal;
                  SELF.CurrAddrAVMValA1Y := LEFT.attributes.version2.CurrAddrAVMValA1Y;
                  SELF.CurrAddrAVMRatio1Y := LEFT.attributes.version2.CurrAddrAVMRatio1Y;
                  SELF.CurrAddrAVMValA5Y := LEFT.attributes.version2.CurrAddrAVMValA5Y;
                  SELF.CurrAddrAVMRatio5Y := LEFT.attributes.version2.CurrAddrAVMRatio5Y;
                  SELF.CurrAddrMedAVMCtyRatio := LEFT.attributes.version2.CurrAddrMedAVMCtyRatio;
                  SELF.CurrAddrMedAVMCenTractRatio := LEFT.attributes.version2.CurrAddrMedAVMCenTractRatio;
                  SELF.CurrAddrMedAVMCenBlockRatio := LEFT.attributes.version2.CurrAddrMedAVMCenBlockRatio;
                  SELF.CurrAddrType := LEFT.attributes.version2.CurrAddrType;
                  SELF.CurrAddrTypeIndx := LEFT.attributes.version2.CurrAddrTypeIndx;
                  SELF.CurrAddrBusRegCnt := LEFT.attributes.version2.CurrAddrBusRegCnt;
                  SELF.CurrAddrIsVacantFlag := LEFT.attributes.version2.CurrAddrIsVacantFlag;
                  SELF.CurrAddrStatus := LEFT.attributes.version2.CurrAddrStatus;
                  SELF.CurrAddrIsAptFlag := LEFT.attributes.version2.CurrAddrIsAptFlag;
                  SELF.ProfLicFlagEv := LEFT.attributes.version2.ProfLicFlagEv;
                  SELF.ProfLicActivNewIndx := LEFT.attributes.version2.ProfLicActivNewIndx;
                  SELF.BusAssocFlagEv := LEFT.attributes.version2.BusAssocFlagEv;
                  SELF.BusAssocOldMSnc := LEFT.attributes.version2.BusAssocOldMSnc;
                  SELF.BusLeadershipTitleFlag := LEFT.attributes.version2.BusLeadershipTitleFlag;
                  SELF.BusAssocCntEv := LEFT.attributes.version2.BusAssocCntEv;
                  SELF.ProfLicActvNewTitleType := LEFT.attributes.version2.ProfLicActvNewTitleType;
                  SELF.BusUCCFilingCntEv := LEFT.attributes.version2.BusUCCFilingCntEv;
                  SELF.BusUCCFilingActiveCnt := LEFT.attributes.version2.BusUCCFilingActiveCnt;
                  SELF.EmrgAge := LEFT.attributes.version2.EmrgAge;
                  SELF.EmrgAtOrAfter21Flag := LEFT.attributes.version2.EmrgAtOrAfter21Flag;
                  SELF.EmrgRecordType := LEFT.attributes.version2.EmrgRecordType;
                  SELF.EmrgAddrType := LEFT.attributes.version2.EmrgAddrType;
                  SELF.EmrgLexIDsAtEmrgAddrCnt1Y := LEFT.attributes.version2.EmrgLexIDsAtEmrgAddrCnt1Y;
                  SELF.EmrgAge25to59Flag := LEFT.attributes.version2.EmrgAge25to59Flag;
                  SELF.EmrgDOB := LEFT.attributes.version2.EmrgDOB;
                  SELF.EmrgSrc := LEFT.attributes.version2.EmrgSrc;
                  SELF.EmrgDt_first_seen := (UNSIGNED)ProfileBooster.V2_Key_Common.convertDateTo8((STRING8)LEFT.attributes.version2.EmrgDt_first_seen);
                  SELF.EmrgAddrFull := LEFT.attributes.version2.EmrgAddrFull;
                  SELF.EmrgPrimaryRange := LEFT.attributes.version2.EmrgPrimaryRange;
                  SELF.EmrgPredirectional := LEFT.attributes.version2.EmrgPredirectional;
                  SELF.EmrgPrimaryName := LEFT.attributes.version2.EmrgPrimaryName;
                  SELF.EmrgSuffix := LEFT.attributes.version2.EmrgSuffix;
                  SELF.EmrgPostdirectional := LEFT.attributes.version2.EmrgPostdirectional;
                  SELF.EmrgUnitDesignation := LEFT.attributes.version2.EmrgUnitDesignation;
                  SELF.EmrgSecondaryRange := LEFT.attributes.version2.EmrgSecondaryRange;
                  SELF.EmrgZIP5 := LEFT.attributes.version2.EmrgZIP5;
                  SELF.EmrgZIP4 := LEFT.attributes.version2.EmrgZIP4;
                  SELF.EmrgCity_Name := LEFT.attributes.version2.EmrgCity_Name;
                  SELF.EmrgSt := LEFT.attributes.version2.EmrgSt;
                  SELF.DrgCnt7Y := LEFT.attributes.version2.DrgCnt7Y;
                  SELF.DrgSeverityIndx7Y := LEFT.attributes.version2.DrgSeverityIndx7Y;
                  SELF.DrgCnt1Y := LEFT.attributes.version2.DrgCnt1Y;
                  SELF.DrgNewMsnc7Y := LEFT.attributes.version2.DrgNewMsnc7Y;
                  SELF.DrgCrimFelCnt7Y := LEFT.attributes.version2.DrgCrimFelCnt7Y;
                  SELF.DrgCrimFelCnt1Y := LEFT.attributes.version2.DrgCrimFelCnt1Y;
                  SELF.DrgCrimFelNewMsnc7Y := LEFT.attributes.version2.DrgCrimFelNewMsnc7Y;
                  SELF.DrgCrimNFelCnt7Y := LEFT.attributes.version2.DrgCrimNFelCnt7Y;
                  SELF.DrgCrimNFelCnt1Y := LEFT.attributes.version2.DrgCrimNFelCnt1Y;
                  SELF.DrgCrimNFelNewMsnc7Y := LEFT.attributes.version2.DrgCrimNFelNewMsnc7Y;
                  SELF.DrgEvictCnt7Y := LEFT.attributes.version2.DrgEvictCnt7Y;
                  SELF.DrgEvictCnt1Y := LEFT.attributes.version2.DrgEvictCnt1Y;
                  SELF.DrgEvictNewMsnc7Y := LEFT.attributes.version2.DrgEvictNewMsnc7Y;
                  SELF.DrgLnJCnt7Y := LEFT.attributes.version2.DrgLnJCnt7Y;
                  SELF.DrgLnJCnt1Y := LEFT.attributes.version2.DrgLnJCnt1Y;
                  SELF.DrgLnJNewMsnc7Y := LEFT.attributes.version2.DrgLnJNewMsnc7Y;
                  SELF.DrgLnJAmtTot7Y := LEFT.attributes.version2.DrgLnJAmtTot7Y;
                  SELF.DrgBkCnt10Y := LEFT.attributes.version2.DrgBkCnt10Y;
                  SELF.DrgBkCnt1Y := LEFT.attributes.version2.DrgBkCnt1Y;
                  SELF.DrgBkNewMsnc10Y := LEFT.attributes.version2.DrgBkNewMsnc10Y;
                  SELF.ShortTermShopNewMsnc := LEFT.attributes.version2.ShortTermShopNewMsnc;
                  SELF.ShortTermShopOldMsnc := LEFT.attributes.version2.ShortTermShopOldMsnc;
                  SELF.ShortTermShopCntEv := LEFT.attributes.version2.ShortTermShopCntEv;
                  SELF.ShortTermShopCnt6M := LEFT.attributes.version2.ShortTermShopCnt6M;
                  SELF.ShortTermShopCnt5Y := LEFT.attributes.version2.ShortTermShopCnt5Y;
                  SELF.ShortTermShopCnt1Y := LEFT.attributes.version2.ShortTermShopCnt1Y;
                  SELF.AddrCurrFull := LEFT.attributes.version2.AddrCurrFull;
                  SELF.curr_addr_rawaid := LEFT.attributes.version2.curr_addr_rawaid;
                  SELF.curr_prim_range := LEFT.attributes.version2.curr_prim_range;
                  SELF.curr_predir := LEFT.attributes.version2.curr_predir;
                  SELF.curr_prim_name := LEFT.attributes.version2.curr_prim_name;
                  SELF.curr_addr_suffix := LEFT.attributes.version2.curr_addr_suffix;
                  SELF.curr_postdir := LEFT.attributes.version2.curr_postdir;
                  SELF.curr_unit_desig := LEFT.attributes.version2.curr_unit_desig;
                  SELF.curr_sec_range := LEFT.attributes.version2.curr_sec_range;
                  SELF.curr_city_name := LEFT.attributes.version2.curr_city_name;
                  SELF.curr_st := LEFT.attributes.version2.curr_st;
                  SELF.curr_z5 := LEFT.attributes.version2.curr_z5;
                  SELF.curr_zip4 := LEFT.attributes.version2.curr_zip4;
                  SELF.curr_addr_type := LEFT.attributes.version2.curr_addr_type;
                  SELF.curr_addr_status := LEFT.attributes.version2.curr_addr_status;	
                  SELF.curr_county := LEFT.attributes.version2.curr_county;
                  SELF.curr_geo_blk := LEFT.attributes.version2.curr_geo_blk;	
                  SELF.curr_date_first_seen := LEFT.attributes.version2.curr_date_first_seen;	
                  SELF.curr_date_last_seen := LEFT.attributes.version2.curr_date_last_seen;
                  SELF.AddrPrevFull := LEFT.attributes.version2.AddrPrevFull;
                  SELF.prev_addr_rawaid := LEFT.attributes.version2.prev_addr_rawaid;
                  SELF.prev_prim_range := LEFT.attributes.version2.prev_prim_range;
                  SELF.prev_predir := LEFT.attributes.version2.prev_predir;
                  SELF.prev_prim_name := LEFT.attributes.version2.prev_prim_name;
                  SELF.prev_addr_suffix := LEFT.attributes.version2.prev_addr_suffix;
                  SELF.prev_postdir := LEFT.attributes.version2.prev_postdir;
                  SELF.prev_unit_desig := LEFT.attributes.version2.prev_unit_desig;
                  SELF.prev_sec_range := LEFT.attributes.version2.prev_sec_range;
                  SELF.prev_city_name := LEFT.attributes.version2.prev_city_name;
                  SELF.prev_st := LEFT.attributes.version2.prev_st;
                  SELF.prev_z5 := LEFT.attributes.version2.prev_z5;
                  SELF.prev_zip4 := LEFT.attributes.version2.prev_zip4;
                  SELF.prev_addr_type := LEFT.attributes.version2.prev_addr_type;
                  SELF.prev_addr_status := LEFT.attributes.version2.prev_addr_status;	
                  SELF.prev_county := LEFT.attributes.version2.prev_county;
                  SELF.prev_geo_blk := LEFT.attributes.version2.prev_geo_blk;	
                  SELF.prev_date_first_seen := LEFT.attributes.version2.prev_date_first_seen;	
                  SELF.prev_date_last_seen := LEFT.attributes.version2.prev_date_last_seen;
                  SELF.history_date := (UNSIGNED)ProfileBooster.V2_Key_Common.convertDateToQuarter((STRING)history_date);
                  // SELF.global_sid   := 0;   
                  // SELF.record_sid   := 0; 
                  SELF := LEFT.attributes.version2;
                  SELF := LEFT;
                  SELF := [];), LOCAL);

  /* ********************
  *  KEL Section *
  ********************* */
  // PP1 := PROJECT(PB_Search_Function_THOR, TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII, 
  //   SELF.P_InpArchDt := history_date[1..6]+'01';
  //   SELF.P_InpLexID := (INTEGER7)LEFT.LexID;
  //   SELF.P_LexID := (INTEGER7)LEFT.LexID;
  //   SELF.G_ProcUID := COUNTER;
  //   SELF.P_InpAcct := LEFT.AcctNo;
  //   SELF.P_InpClnArchDt := (STRING)history_date[1..6]+'01';
  //   SELF := LEFT;
  //   SELF := [];
  //   ), LOCAL);	
  // PP := DISTRIBUTE(PP1, P_LexID);

  // GLBA := 1; 
  // DPPA := 1; 

  // Options := MODULE(ProfileBooster.ProfileBoosterV2_KEL.Interface_Options)
  //   EXPORT STRING AttributeSetName := 'Development KEL Attributes';
  //   EXPORT STRING VersionName := 'Version 1.0';
  //   EXPORT BOOLEAN isFCRA := FALSE;
  //   EXPORT STRING ArchiveDate := history_date;
  //   EXPORT STRING InputFileName := '';
  //   EXPORT STRING Data_Restriction_Mask := DataRestrictionMask;
  //   EXPORT STRING Data_Permission_Mask := DataPermissionMask;
  //   EXPORT UNSIGNED GLBAPurpose := GLBA;
  //   EXPORT UNSIGNED DPPAPurpose := DPPA;
  //   EXPORT INTEGER ScoreThreshold := Score_threshold;
  //   EXPORT BOOLEAN OutputMasterResults := FALSE;
  //   EXPORT BOOLEAN isMarketing := TRUE; // When TRUE enables Marketing Restrictions
  // END;

  // pbKelResult:= DISTRIBUTE(ProfileBooster.ProfileBoosterV2_KEL.FnThor_GetPB20Attributes(PP, Options),lexid); 
  finalWithKEL := final;
/*
JOIN(DISTRIBUTE(final(did<>0),did), 
     DISTRIBUTE(pbKelResult(lexid<>-99999),lexid),
                     LEFT.did=RIGHT.lexid,
                     TRANSFORM(dx_ProfileBooster.Layouts.i_lexid,
                     //PROSPECT PURCHASE BEHAVIOUR
                     SELF.PurchNewAmt := RIGHT.PurchNewAmt;
                     SELF.PurchTotEv := RIGHT.PurchTotEv;
                     SELF.PurchCntEv := RIGHT.PurchCntEv;
                     SELF.PurchNewMsnc := RIGHT.PurchNewMsnc;
                     SELF.PurchOldMsnc := RIGHT.PurchOldMsnc;
                     SELF.PurchItemCntEv := RIGHT.PurchItemCntEv;
                     SELF.PurchAmtAvg := RIGHT.PurchAmtAvg;
                     SELF.PurchAge := RIGHT.PurchAge;
                     SELF.PurchDOB := RIGHT.PurchDOB;
                     SELF.PurchMarried := RIGHT.PurchMaritalStatus;
                     SELF.PurchGender := RIGHT.PurchGender;
                     SELF.PL_PurchMinDate := RIGHT.PL_PurchMinDate;
                     SELF.PL_PurchMaxDate := RIGHT.PL_PurchMaxDate;
                     SELF.PL_VehicleMinDate := RIGHT.PL_VehicleMinDate;
                     SELF.PL_VehicleMaxDate := RIGHT.PL_VehicleMaxDate;
                     SELF.AstVehAutoNewTypeIndx := RIGHT.AstVehAutoNewTypeIndx;
                     
                     // SELF.LifeAstPurchOldMsnc := MAX(LEFT.LifeAstPurchOldMsnc,RIGHT.AstVehAutoEmrgOldMsncEv,RIGHT.AstVehOtherEmrgOldMsncEv);
                     LifeAstPurchNewMsnc := MIN(
                                                IF(LEFT.LifeAstPurchNewMsnc<0,nines,LEFT.LifeAstPurchNewMsnc), 
                                                IF(RIGHT.AstVehAutoNewMsnc<=0,nines,RIGHT.AstVehAutoNewMsnc),
                                                IF(RIGHT.AstVehOtherNewMsnc<=0,nines,RIGHT.AstVehOtherNewMsnc)
                                               );
                     SELF.LifeAstPurchNewMsnc := IF(LifeAstPurchNewMsnc=nines,-99997,LifeAstPurchNewMsnc);                    
                     SELF := RIGHT;
                     SELF := LEFT;
                     ), LEFT OUTER, KEEP(1), LOCAL);
*/
/*
 **********************
 *  Debugging Section *
 **********************/
 
  // eyeball := 100;
  // output(choosen(PB_In, eyeball), named('PB_In_File_LexID'));
  // output(choosen(slimShell, eyeball), named('slimShell_File_LexID'));
	// output(choosen(studentRecs, eyeball), named('studentRecs'));
	// output(choosen(withStudent, eyeball), named('withStudent'));
	// output(choosen(watercraftRecs, eyeball), named('watercraftRecs'));
	// output(choosen(withWatercraft, eyeball), named('withWatercraft'));
	// output(choosen(aircraftRecs, eyeball), named('aircraftRecs'));
	// output(choosen(withAircraft, eyeball), named('withAircraft'));
	// output(choosen(vehicleRecs, eyeball), named('vehicleRecs'));
	// output(choosen(withVehicles, eyeball), named('withVehicles'));
  // output(choosen(preDerogs, eyeball), named('preDerogs'));
  // output(choosen(derogRecs, eyeball), named('derogRecs'));
  // output(choosen(withDerogs, eyeball), named('withDerogs'));
	// output(choosen(profLicRecs, eyeball), named('profLicRecs'));
  // output(choosen(withProfLic, eyeball), named('withProfLic'));
  // output(choosen(busnAssocRecs, eyeball), named('busnAssocRecs'));
  // output(choosen(withBusnAssoc, eyeball), named('withBusnAssoc'));
  // output(choosen(sportsRecs, eyeball), named('sportsRecs'));
  // output(choosen(withSports, eyeball), named('withSports'));
  // output(choosen(finalSort, eyeball), named('finalSort'));
  // output(choosen(final, 100), named('final_lexid'));
  // OUTPUT(choosen(PP1,eyeball), named('PP1'));
  // OUTPUT(choosen(PP,eyeball), named('PP'));
  // output(choosen(pbKelResult, eyeball), named('pbKelResult'));
  // output(choosen(PB_Search_Function_THOR, eyeball), named('PB_Search_Function_THOR'));
  // output(choosen(final(did=250159), 100), named('finalSample'));
  // output(choosen(finalWithKEL(did=250159), 100), named('finalWithKELSample'));

/* ********************/

return finalWithKEL;

end;