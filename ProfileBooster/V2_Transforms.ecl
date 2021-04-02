IMPORT ProfileBooster, Risk_Indicators, RiskWise, Address, STD, AID, dma, Watchdog, dx_ProfileBooster, doxie, MDR, dx_header, Relationship;
EXPORT V2_Transforms := MODULE

	EXPORT Risk_Indicators.Layout_Input xfm_RI_Layout_Input(ProfileBooster.V2_Layouts.Layout_PB2_In l) := TRANSFORM
		SELF.did 		:= (integer)l.LexId;
		SELF.score := if((integer)l.lexid<>0, 100, 0);  // hard code the DID score if DID is passed in on input
		SELF.seq 		:= l.seq;
		SELF.HistoryDate 	:= if(l.historydate=0, risk_indicators.iid_constants.default_history_date, l.HistoryDate);
		SELF.ssn 		:= l.ssn;
		dob_val 		:= riskwise.cleandob(l.dob);
		dob 				:= dob_val;
		SELF.dob 		:= if((unsigned)dob=0, '', dob);

		fname  			:= l.Name_First ;
		mname  			:= l.Name_Middle;
		lname  			:= l.Name_Last ;
		suffix 			:= l.Name_Suffix ;
		SELF.fname  := std.str.ToUpperCase(fname);
		SELF.mname  := std.str.ToUpperCase(mname);
		SELF.lname  := std.str.ToUpperCase(lname);
		SELF.suffix := std.str.ToUpperCase(suffix);
		
		addr_value 	:= trim(l.street_addr);
		clean_a2 		:= Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.City_name, l.st, l.z5);
		SELF.in_streetAddress:= addr_value;
		SELF.in_city         := l.City_name;
		SELF.in_state        := l.st;
		SELF.in_zipCode      := l.z5;	
		SELF.prim_range      := Address.CleanFields(clean_a2).prim_range;
		SELF.predir          := Address.CleanFields(clean_a2).predir;
		SELF.prim_name       := Address.CleanFields(clean_a2).prim_name;
		SELF.addr_suffix     := Address.CleanFields(clean_a2).addr_suffix;
		SELF.postdir         := Address.CleanFields(clean_a2).postdir;
		SELF.unit_desig      := Address.CleanFields(clean_a2).unit_desig;
		SELF.sec_range       := Address.CleanFields(clean_a2).sec_range;
		SELF.p_city_name     := Address.CleanFields(clean_a2).p_city_name;
		SELF.st              := Address.CleanFields(clean_a2).st;
		SELF.z5              := Address.CleanFields(clean_a2).zip;
		SELF.zip4            := Address.CleanFields(clean_a2).zip4;
		SELF.lat             := Address.CleanFields(clean_a2).geo_lat;
		SELF.long            := Address.CleanFields(clean_a2).geo_long;
		SELF.addr_type 			 := risk_indicators.iid_constants.override_addr_type(l.street_addr, Address.CleanFields(clean_a2).rec_type[1],Address.CleanFields(clean_a2).cart);
		SELF.addr_status     := Address.CleanFields(clean_a2).err_stat;
		county          		 := Address.CleanFields(clean_a2).county;
		SELF.county          := county[3..5]; //bytes 1-2 are state code, 3-5 are county number
		SELF.geo_blk         := Address.CleanFields(clean_a2).geo_blk;
		SELF.Phone10				 := StringLib.StringFilter(l.Phone10, '0123456789');
		// SELF.emailAddress		 := l.emailAddress;
		self := [];
	END;	
  
  EXPORT ProfileBooster.V2_Layouts.r_layout_input_PlusRaw	prep_for_AID(ProfileBooster.V2_Layouts.Layout_PB2_In le)	:= TRANSFORM
		SELF.Line1		:=	trim(std.str.ToUpperCase(le.street_addr));
		SELF.LineLast	:=	address.addr2fromcomponents(std.str.ToUpperCase(le.City_name), std.str.ToUpperCase(le.St),  le.Z5);  // );, uppercase and trim city and state, zip5 only
		SELF.rawAID			:=	0;
		self	:=	le;
	end;
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell setDNMFlag(ProfileBooster.V2_Layouts.Layout_Output_with_input_addr_rawaid le, RECORDOF(dma.key_DNM_Name_Address) ri ) := TRANSFORM
		SELF.DoNotMail 		:= if(ri.l_zip='', '0', '1');
		SELF.DID2 				:= le.DID; 	//propogate the prospect's DID to DID2 at this point
		SELF.rec_type 		:= ProfileBooster.Constants.recType.Prospect; //all records are "Prospect" type at this point.  Household and Relatives will be added later.
    SELF.acctno       := le.account;
    self 							:= le;
		self 							:= [];
	END;
  
  EXPORT ProfileBooster.V2_Layouts.Layout_Output_with_input_addr_rawaid xfm_with_DID(ProfileBooster.V2_Layouts.Layout_PB2_In le, Risk_Indicators.layout_output ri) := TRANSFORM //Risk_Indicators.Layout_Output, 
											SELF.Account := le.AcctNo; 
                      SELF.input_addr_rawaid := ri.rawaid_orig;
											SELF := ri;
  END;
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell xfm_setEmailAddress(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Layouts.Layout_PB2_In ri ) := TRANSFORM
		SELF.email_address	:= ri.emailAddress;
    SELF.acctno         := ri.AcctNo;
		self 								:= le;
		self 								:= [];
	END;
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell setWatchdog(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, Watchdog.Layout_Best ri ) := TRANSFORM
 		dob_val 		:= riskwise.cleandob((STRING)ri.dob);
		dob 				:= dob_val;
    fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
		SELF.dob 		:= if((unsigned)le.dob<=0, dob, le.dob);
    SELF.ProspectAge 			:= if((unsigned)le.dob<=0, risk_indicators.years_apart((unsigned)fullhistorydate, (unsigned)dob), (unsigned)le.ProspectAge);
 		
    SELF.title := if(le.title='',ri.title, le.title);
		self 								:= le;
    // self                := ri;
		self 								:= [];
	END;
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell setWatchdogDEAD(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, Watchdog.Layout_Best ri ) := TRANSFORM
 		dod_val 		:= riskwise.cleandob((STRING)ri.dod);
		dod 				:= dod_val;
    fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
		SELF.dod 		:= if((UNSIGNED4)le.dod<=0, (UNSIGNED4)dod, (UNSIGNED4)le.dod);
		self 								:= le;
		self 								:= [];
	END;
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell setInfutorNARC(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, ProfileBooster.Layouts.Layout_Infutor ri ) := TRANSFORM
		// SELF.email_address	:= ri.emailAddress;
 		dob_val 		:= riskwise.cleandob((STRING)ri.dob);
		dob 				:= dob_val;
		SELF.dob 		:= if((unsigned)le.dob<=0, dob, le.dob);
    fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
		SELF.ProspectAge 			:= if((unsigned)le.dob<=0, risk_indicators.years_apart((unsigned)fullhistorydate, (unsigned)dob), (unsigned)le.ProspectAge);
 		SELF.gender := if(le.gender='',ri.gender,le.gender), 
		SELF.marital_status := if(le.marital_status='',ri.marital_status,le.marital_status);
		self 								:= le;
    // self                := ri;
		self 								:= [];
	END;

  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell xfmAddLexIDKey(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, dx_ProfileBooster.Layouts.i_lexid ri ) := TRANSFORM
		// SELF.email_address	:= ri.emailAddress;
 		dob_val 		:= riskwise.cleandob(ri.PurchDOB);
		dob 				:= dob_val;
		SELF.dob 		:= if((unsigned)le.dob<=0, dob, le.dob);
    fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
		SELF.ProspectAge 			:= if((unsigned)le.dob<=0, risk_indicators.years_apart((unsigned)fullhistorydate, (unsigned)dob), (unsigned)le.ProspectAge);
 		SELF.gender := if(le.gender='' AND ri.PurchGender<>'', ri.PurchGender, le.gender);
    SELF.marital_status := if(le.marital_status='' and le.title='',IF(ri.PurchMarried='M','Y','N'),le.marital_status);
    historydate := (unsigned3)fullhistorydate[1..6];    
    PB20VehDtFirstSeen := if(ri.PL_VehicleMinDate<=0,(unsigned3)((STRING8)le.dt_first_seen)[1..6],(unsigned3)((STRING8)ri.PL_VehicleMinDate)[1..6]);
    PB20DunnDtFirstSeen := if(ri.PL_PurchMinDate<=0,(unsigned3)((STRING8)le.dt_first_seen)[1..6],(unsigned3)((STRING8)ri.PL_PurchMinDate)[1..6]);
 		dt_first_seen 		    := MIN(IF(PB20VehDtFirstSeen<=0,999999,PB20VehDtFirstSeen),
                                 IF(PB20DunnDtFirstSeen<=0,999999,PB20DunnDtFirstSeen),
                                 IF((unsigned3)((STRING8)le.dt_first_seen)[1..6]<=0,999999,(unsigned3)((STRING8)le.dt_first_seen)[1..6]));
    SELF.dt_first_seen 		:= IF(dt_first_seen=999999,0,dt_first_seen);
    PB20VehDtLastSeen := if(ri.PL_VehicleMaxDate=-99997,(unsigned3)((STRING8)le.dt_last_seen)[1..6],(unsigned3)((STRING8)ri.PL_VehicleMaxDate)[1..6]);
    PB20DunnDtLastSeen := if(ri.PL_PurchMaxDate=-99997,(unsigned3)((STRING8)le.dt_last_seen)[1..6],(unsigned3)((STRING8)ri.PL_PurchMaxDate)[1..6]);
		SELF.dt_last_seen			:= MAX(PB20VehDtLastSeen,PB20DunnDtLastSeen,(unsigned3)((STRING8)le.dt_last_seen)[1..6]);
    SELF.DemEduCollCurrFlag := ri.DemEduCollCurrFlag;
    SELF.DemEduCollFlagEv := ri.DemEduCollFlagEv;
    SELF.DemEduCollNewLevelEv := ri.DemEduCollNewLevelEv;
    SELF.DemEduCollNewPvtFlag := ri.DemEduCollNewPvtFlag;
    SELF.DemEduCollNewTierIndx := ri.DemEduCollNewTierIndx;
    SELF.DemEduCollLevelHighEv := ri.DemEduCollLevelHighEv;
    SELF.DemEduCollRecNewInstTypeEv := ri.DemEduCollRecNewInstTypeEv;
    SELF.DemEduCollTierHighEv := ri.DemEduCollTierHighEv;
    SELF.DemEduCollRecNewMajorTypeEv := ri.DemEduCollRecNewMajorTypeEv;
    SELF.DemEduCollEvidFlagEv := ri.DemEduCollEvidFlagEv;  
    SELF.DemEduCollSrcNewRecOldMsncEv := ri.DemEduCollSrcNewRecOldMsncEv;
    SELF.DemEduCollSrcNewRecNewMsncEv := ri.DemEduCollSrcNewRecNewMsncEv;
    SELF.DemEduCollRecSpanEv := ri.DemEduCollRecSpanEv;
    SELF.DemEduCollRecNewClassEv := ri.DemEduCollRecNewClassEv;
    SELF.DemEduCollSrcNewExpGradYr := ri.DemEduCollSrcNewExpGradYr;
    SELF.DemEduCollInstPvtFlagEv := ri.DemEduCollInstPvtFlagEv;
    SELF.DemEduCollMajorMedicalFlagEv := ri.DemEduCollMajorMedicalFlagEv;
    SELF.DemEduCollMajorPhysSciFlagEv := ri.DemEduCollMajorPhysSciFlagEv;
    SELF.DemEduCollMajorSocSciFlagEv := ri.DemEduCollMajorSocSciFlagEv;
    SELF.DemEduCollMajorLibArtsFlagEv := ri.DemEduCollMajorLibArtsFlagEv;
    SELF.DemEduCollMajorTechnicalFlagEv := ri.DemEduCollMajorTechnicalFlagEv;
    SELF.DemEduCollMajorBusFlagEv := ri.DemEduCollMajorBusFlagEv;
    SELF.DemEduCollMajorEduFlagEv := ri.DemEduCollMajorEduFlagEv;
    SELF.DemEduCollMajorLawFlagEv := ri.DemEduCollMajorLawFlagEv;
    // SELF.DemBankingIndx := ri.DemBankingIndx;
    SELF.PurchNewAmt := ri.PurchNewAmt;
		SELF.PurchTotEv := ri.PurchTotEv;
		SELF.PurchCntEv := ri.PurchCntEv;
		SELF.PurchNewMsnc := ri.PurchNewMsnc;
		SELF.PurchOldMsnc := ri.PurchOldMsnc;
		SELF.PurchItemCntEv := ri.PurchItemCntEv;
		SELF.PurchAmtAvg := (INTEGER3)ri.PurchAmtAvg;
    SELF.AstVehAutoCntEv := ri.AstVehAutoCntEv;
		SELF.AstVehAutoCarCntEv := ri.AstVehAutoCarCntEv;
		SELF.AstVehAutoSUVCntEv := ri.AstVehAutoSUVCntEv;
		SELF.AstVehAutoTruckCntEv := ri.AstVehAutoTruckCntEv;
		SELF.AstVehAutoVanCntEv := ri.AstVehAutoVanCntEv;
		SELF.AstVehAutoNewTypeIndx := (INTEGER3)ri.AstVehAutoNewTypeIndx;
		SELF.AstVehAutoExpCntEv := ri.AstVehAutoExpCntEv;
		SELF.AstVehAutoEliteCntEv := ri.AstVehAutoEliteCntEv;
		SELF.AstVehAutoLuxuryCntEv := ri.AstVehAutoLuxuryCntEv;
		SELF.AstVehAutoOrigOwnCntEv := ri.AstVehAutoOrigOwnCntEv;
		SELF.AstVehAutoMakeCntEv := ri.AstVehAutoMakeCntEv;
		SELF.AstVehAutoFreqMake := ri.AstVehAutoFreqMake;
		SELF.AstVehAutoFreqMakeCntEv := ri.AstVehAutoFreqMakeCntEv;
		SELF.AstVehAuto2ndFreqMake := ri.AstVehAuto2ndFreqMake;
		SELF.AstVehAuto2ndFreqMakeCntEv := ri.AstVehAuto2ndFreqMakeCntEv;
		SELF.AstVehAutoEmrgPriceAvg := ri.AstVehAutoEmrgPriceAvg;
		SELF.AstVehAutoEmrgPriceMax := ri.AstVehAutoEmrgPriceMax;
		SELF.AstVehAutoEmrgPriceMin := ri.AstVehAutoEmrgPriceMin;
		SELF.AstVehAutoNewPrice := ri.AstVehAutoNewPrice;
		SELF.AstVehAutoEmrgPriceDiff := ri.AstVehAutoEmrgPriceDiff;
		SELF.AstVehAutoLastAgeAvg := ri.AstVehAutoLastAgeAvg;
		SELF.AstVehAutoLastAgeMax := ri.AstVehAutoLastAgeMax;
		SELF.AstVehAutoLastAgeMin := ri.AstVehAutoLastAgeMin;
		SELF.AstVehAutoEmrgAgeAvg := ri.AstVehAutoEmrgAgeAvg;
		SELF.AstVehAutoEmrgAgeMax := ri.AstVehAutoEmrgAgeMax;
		SELF.AstVehAutoEmrgAgeMin := ri.AstVehAutoEmrgAgeMin;
		SELF.AstVehAutoEmrgSpanAvg := ri.AstVehAutoEmrgSpanAvg;
		SELF.AstVehAutoNewMsnc := ri.AstVehAutoNewMsnc;
		SELF.AstVehAutoTimeOwnSpanAvg := ri.AstVehAutoTimeOwnSpanAvg;
		SELF.AstVehOtherCntEv := ri.AstVehOtherCntEv;
		SELF.AstVehOtherATVCntEv := ri.AstVehOtherATVCntEv;
		SELF.AstVehOtherCamperCntEv := ri.AstVehOtherCamperCntEv;
		SELF.AstVehOtherCommCntEv := ri.AstVehOtherCommCntEv;
		SELF.AstVehOtherMtrCntEv := ri.AstVehOtherMtrCntEv;
		SELF.AstVehOtherScooterCntEv := ri.AstVehOtherScooterCntEv;
		SELF.AstVehOtherNewTypeIndx := ri.AstVehOtherNewTypeIndx;
		SELF.AstVehOtherOrigOwnCntEv := ri.AstVehOtherOrigOwnCntEv;
		SELF.AstVehOtherNewMsnc := ri.AstVehOtherNewMsnc;
		SELF.AstVehOtherPriceAvg := ri.AstVehOtherPriceAvg;
		SELF.AstVehOtherPriceMax := ri.AstVehOtherPriceMax;
		SELF.AstVehOtherPriceMin := ri.AstVehOtherPriceMin;
		SELF.AstVehOtherNewPrice := ri.AstVehOtherNewPrice;	
    SELF.IntSportPersonFlagEv := ri.IntSportPersonFlagEv;
    SELF.IntSportPersonFlag1Y := ri.IntSportPersonFlag1Y;
    SELF.IntSportPersonFlag5Y := ri.IntSportPersonFlag5Y;
    SELF.IntSportPersonTravelerFlagEv := ri.IntSportPersonTravelerFlagEv;
    SELF.AstCurrFlag := ri.AstCurrFlag;
		// SELF.AstPropCurrFlag := ri.AstPropCurrFlag;
		// SELF.AstPropCurrCntEv := ri.AstPropCurrCntEv;
		// SELF.AstPropCurrValTot := ri.AstPropCurrValTot;
		// SELF.AstPropCurrAVMTot := ri.AstPropCurrAVMTot;
		// SELF.AstPropSaleNewMsnc := ri.AstPropSaleNewMsnc;
		// SELF.AstPropCntEv := ri.AstPropCntEv;
		// SELF.AstPropSoldCntEv := ri.AstPropSoldCntEv;
		// SELF.AstPropSoldCnt1Y := ri.AstPropSoldCnt1Y;
		// SELF.AstPropSoldNewRatio := ri.AstPropSoldNewRatio;
		// SELF.AstPropPurchCnt1Y := ri.AstPropPurchCnt1Y;
    PPCurrOwnedCnt := le.PPCurrOwnedCnt+if(ri.AstVehAutoCntEv<=0,0,ri.AstVehAutoCntEv)
                                            +if(ri.AstVehOtherCntEv<=0,0,ri.AstVehOtherCntEv)
                                            +if(ri.AstPropAirCrftCntEv<=0,0,ri.AstPropAirCrftCntEv)
                                            +if(ri.AstPropWtrcrftCntEv<=0,0,ri.AstPropWtrcrftCntEv);
    SELF.PPCurrOwnedCnt := PPCurrOwnedCnt;    
    SELF.AstPropAirCrftCntEv := ri.AstPropAirCrftCntEv;
    SELF.AstPropWtrcrftCntEv := ri.AstPropWtrcrftCntEv; 
    // SELF.LifeMoveNewMsnc := ri.LifeMoveNewMsnc; Calculated in Verification
    SELF.LifeNameLastChngFlag := ri.LifeNameLastChngFlag;
    SELF.LifeNameLastChngFlag1Y := ri.LifeNameLastChngFlag1Y;
    SELF.LifeNameLastCntEv := ri.LifeNameLastCntEv;
    SELF.LifeNameLastChngNewMsnc := ri.LifeNameLastChngNewMsnc;
    SELF.LifeAstPurchOldMsnc := ri.LifeAstPurchOldMsnc;//MAX(ri.LifeAstPurchOldMsnc,le.LifeAstPurchOldMsnc);
    SELF.LifeAstPurchNewMsnc := IF(ri.LifeAstPurchNewMsnc=99998,-99998,ri.LifeAstPurchNewMsnc);//MAP(le.LifeAstPurchNewMsnc < 0 => ri.LifeAstPurchNewMsnc,
                                    // ri.LifeAstPurchNewMsnc < 0 => le.LifeAstPurchNewMsnc,
                                                                   // MIN(ri.LifeAstPurchNewMsnc,le.LifeAstPurchNewMsnc));
    SELF.LifeAddrCnt := ri.LifeAddrCnt;
    SELF.LifeAddrCurrToPrevValRatio5y := ri.LifeAddrCurrToPrevValRatio5y;
    SELF.LifeAddrEconTrajType := ri.LifeAddrEconTrajType;
    SELF.LifeAddrEconTrajIndx := ri.LifeAddrEconTrajIndx;
    SELF.ProfLicFlagEv := ri.ProfLicFlagEv;
    SELF.ProfLicActivNewIndx := ri.ProfLicActivNewIndx;
    SELF.BusAssocFlagEv := ri.BusAssocFlagEv;
    SELF.BusAssocOldMSnc := ri.BusAssocOldMSnc;
    SELF.BusLeadershipTitleFlag := ri.BusLeadershipTitleFlag;
    SELF.BusAssocCntEv := ri.BusAssocCntEv;
    SELF.ProfLicActvNewTitleType := ri.ProfLicActvNewTitleType;
    SELF.BusUCCFilingCntEv := ri.BusUCCFilingCntEv;
    SELF.BusUCCFilingActiveCnt := ri.BusUCCFilingActiveCnt;
    
    OlderErmgRecord := ri.EmrgDt_first_seen < le.EmrgDt_first_seen and ri.EmrgDt_first_seen>0;
  	self.EmrgDt_first_seen   := IF(OlderErmgRecord,ri.EmrgDt_first_seen,le.EmrgDt_first_seen);
		self.EmrgSrc             := IF(OlderErmgRecord,ri.EmrgSrc,le.EmrgSrc);
		self.EmrgDob			       := IF(OlderErmgRecord,ri.EmrgDob,le.EmrgDob);
		self.EmrgAge   			     := IF(OlderErmgRecord,ri.EmrgAge,le.EmrgAge);
		self.EmrgPrimaryRange    := IF(OlderErmgRecord,ri.EmrgPrimaryRange,le.EmrgPrimaryRange);
		self.EmrgPredirectional	 := IF(OlderErmgRecord,ri.EmrgPredirectional,le.EmrgPredirectional);
		self.EmrgPrimaryName	   := IF(OlderErmgRecord,ri.EmrgPrimaryName,le.EmrgPrimaryName);
		self.EmrgSuffix	         := IF(OlderErmgRecord,ri.EmrgSuffix,le.EmrgSuffix);	
		self.EmrgPostdirectional := IF(OlderErmgRecord,ri.EmrgPostdirectional,le.EmrgPostdirectional);
		self.EmrgUnitDesignation := IF(OlderErmgRecord,ri.EmrgUnitDesignation,le.EmrgUnitDesignation);
		self.EmrgSecondaryRange	 := IF(OlderErmgRecord,ri.EmrgSecondaryRange,le.EmrgSecondaryRange);
		self.EmrgCity_Name	     := IF(OlderErmgRecord,ri.EmrgCity_Name,le.EmrgCity_Name);	
		self.EmrgSt			         := IF(OlderErmgRecord,ri.EmrgSt,le.EmrgSt);
		self.EmrgZIP5			       := IF(OlderErmgRecord,ri.EmrgZIP5,le.EmrgZIP5);
		self.EmrgZIP4		         := IF(OlderErmgRecord,ri.EmrgZIP4,le.EmrgZIP4);
	
    SELF.EmrgAtOrAfter21Flag := IF(OlderErmgRecord,ri.EmrgAtOrAfter21Flag,le.EmrgAtOrAfter21Flag);
    SELF.EmrgRecordType      := IF(OlderErmgRecord,ri.EmrgRecordType,le.EmrgRecordType);
    SELF.EmrgAddrType        := IF(OlderErmgRecord,ri.EmrgAddrType,le.EmrgAddrType);
    SELF.EmrgLexIDsAtEmrgAddrCnt1Y := IF(OlderErmgRecord,ri.EmrgLexIDsAtEmrgAddrCnt1Y,le.EmrgLexIDsAtEmrgAddrCnt1Y);
    SELF.EmrgAge25to59Flag   := IF(OlderErmgRecord,ri.EmrgAge25to59Flag,le.EmrgAge25to59Flag);
    
    SELF.DrgCnt7Y := ri.DrgCnt7Y;
    SELF.DrgSeverityIndx7Y := ri.DrgSeverityIndx7Y;
    SELF.DrgCnt1Y := ri.DrgCnt1Y;
    SELF.DrgNewMsnc7Y := ri.DrgNewMsnc7Y;
    SELF.DrgCrimFelCnt7Y := ri.DrgCrimFelCnt7Y;
    SELF.DrgCrimFelCnt1Y := ri.DrgCrimFelCnt1Y;
    SELF.DrgCrimFelNewMsnc7Y := ri.DrgCrimFelNewMsnc7Y;
    SELF.DrgCrimNFelCnt7Y := ri.DrgCrimNFelCnt7Y;
    SELF.DrgCrimNFelCnt1Y := ri.DrgCrimNFelCnt1Y;
    SELF.DrgCrimNFelNewMsnc7Y := ri.DrgCrimNFelNewMsnc7Y;
    SELF.DrgEvictCnt7Y := ri.DrgEvictCnt7Y;
    SELF.DrgEvictCnt1Y := ri.DrgEvictCnt1Y;
    SELF.DrgEvictNewMsnc7Y := ri.DrgEvictNewMsnc7Y;
    SELF.DrgLnJCnt7Y := ri.DrgLnJCnt7Y;
    SELF.DrgLnJCnt1Y := ri.DrgLnJCnt1Y;
    SELF.DrgLnJNewMsnc7Y := ri.DrgLnJNewMsnc7Y;
    SELF.DrgLnJAmtTot7Y := ri.DrgLnJAmtTot7Y;
    SELF.DrgBkCnt10Y := ri.DrgBkCnt10Y;
    SELF.DrgBkCnt1Y := ri.DrgBkCnt1Y;
    SELF.DrgBkNewMsnc10Y := ri.DrgBkNewMsnc10Y;
    // SELF.DrgFrClCnt7Y := ri.DrgFrClCnt7Y;
    // SELF.DrgFrClCnt1Y := ri.DrgFrClCnt1Y;
    // SELF.DrgFrClNewMsnc := ri.DrgFrClNewMsnc;
    SELF.ShortTermShopNewMsnc := ri.ShortTermShopNewMsnc;
    SELF.ShortTermShopOldMsnc := ri.ShortTermShopOldMsnc;
    SELF.ShortTermShopCntEv := ri.ShortTermShopCntEv;
    SELF.ShortTermShopCnt6M := ri.ShortTermShopCnt6M;
    SELF.ShortTermShopCnt5Y := ri.ShortTermShopCnt5Y;
    SELF.ShortTermShopCnt1Y := ri.ShortTermShopCnt1Y;
    SELF.HHID := ri.HHID;

    SELF.CurrAddrAVMVal := ri.CurrAddrAVMVal;
    SELF.CurrAddrAVMValA1Y := ri.CurrAddrAVMValA1Y;
    SELF.CurrAddrAVMRatio1Y := (STRING10)ri.CurrAddrAVMRatio1Y;
    SELF.CurrAddrAVMValA5Y := ri.CurrAddrAVMValA5Y;
    SELF.CurrAddrAVMRatio5Y := (STRING10)ri.CurrAddrAVMRatio5Y;
    SELF.CurrAddrMedAVMCtyRatio := (STRING10)ri.CurrAddrMedAVMCtyRatio;
    SELF.CurrAddrMedAVMCenTractRatio := (STRING10)ri.CurrAddrMedAVMCenTractRatio;
    SELF.CurrAddrMedAVMCenBlockRatio := (STRING10)ri.CurrAddrMedAVMCenBlockRatio;
    SELF.CurrAddrBusRegCnt := ri.CurrAddrBusRegCnt;
    
    SELF.AddrCurrFull := ri.AddrCurrFull;
    SELF.curr_addr_rawaid := ri.curr_addr_rawaid;
    SELF.AddrPrevFull := ri.AddrPrevFull;    
    SELF.prev_addr_rawaid := ri.prev_addr_rawaid;
    self 								:= le;  
		self 								:= [];
	END;  
  
     EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell xfmAddHouseholdInfo(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, dx_ProfileBooster.Layouts.i_lexid ri) := TRANSFORM
        notDid2 := le.did2 != ri.did;
        SELF.PurchNewAmt := IF(notDid2, ri.PurchNewAmt, le.PurchNewAmt);
        SELF.PurchTotEv := IF(notDid2, ri.PurchTotEv, le.PurchTotEv);
        SELF.PurchCntEv := IF(notDid2, ri.PurchCntEv, le.PurchCntEv);
        SELF.PurchNewMsnc := IF(notDid2, ri.PurchNewMsnc, le.PurchNewMsnc);
        SELF.PurchOldMsnc := IF(notDid2, ri.PurchOldMsnc, le.PurchOldMsnc);
        SELF.PurchItemCntEv := IF(notDid2, ri.PurchItemCntEv, le.PurchItemCntEv);
        SELF.PurchAmtAvg := IF(notDid2, ri.PurchAmtAvg, le.PurchAmtAvg);
        SELF := le;
    END;
    
/*   EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell xfmAddCurrentAddressData(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, dx_ProfileBooster.Layouts.i_address ri ) := TRANSFORM
   		fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
   		// SELF.CurrAddrOwnershipIndx := ri.AddrOwnershipIndx;
       SELF.CurrAddrHasPoolFlag := ri.AddrHasPoolFlag;
       SELF.CurrAddrIsMobileHomeFlag := ri.AddrIsMobileHomeFlag;
       SELF.CurrAddrBathCnt := ri.AddrBathCnt;
       SELF.CurrAddrParkingCnt := ri.AddrParkingCnt;
       SELF.CurrAddrBuildYr := ri.AddrBuildYr;
       SELF.CurrAddrBedCnt := ri.AddrBedCnt;
       SELF.CurrAddrBldgSize := ri.AddrBldgSize;
       SELF.CurrAddrLat := ri.AddrLat;
       SELF.CurrAddrLng := ri.AddrLng;
       SELF.CurrAddrIsCollegeFlag := ri.AddrIsCollegeFlag;
       // SELF.CurrAddrAVMVal := ri.AddrAVMVal;
       // SELF.CurrAddrAVMValA1Y := ri.AddrAVMValA1Y;
       // SELF.CurrAddrAVMRatio1Y := (STRING10)ri.AddrAVMRatio1Y;
       // SELF.CurrAddrAVMValA5Y := ri.AddrAVMValA5Y;
       // SELF.CurrAddrAVMRatio5Y := (STRING10)ri.AddrAVMRatio5Y;
       // SELF.CurrAddrMedAVMCtyRatio := (STRING10)ri.AddrMedAVMCtyRatio;
       // SELF.CurrAddrMedAVMCenTractRatio := (STRING10)ri.AddrMedAVMCenTractRatio;
       // SELF.CurrAddrMedAVMCenBlockRatio := (STRING10)ri.AddrMedAVMCenBlockRatio;
       SELF.CurrAddrType := ri.AddrType;
       SELF.CurrAddrTypeIndx := ri.AddrTypeIndx;
       SELF.CurrAddrBusRegCnt := ri.AddrBusRegCnt;
       SELF.CurrAddrIsVacantFlag := ri.AddrIsVacantFlag;
       SELF.CurrAddrStatus := ri.AddrStatus;
       SELF.CurrAddrIsAptFlag := ri.AddrIsAptFlag;
       self 								:= le;  
   		self 								:= [];
   	END;
     
     EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell xfmAddInputAddressData(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, dx_ProfileBooster.Layouts.i_address ri ) := TRANSFORM
   		fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
   		// SELF.InpAddrOwnershipIndx := ri.AddrOwnershipIndx;
       SELF.InpAddrHasPoolFlag := ri.AddrHasPoolFlag;
       SELF.InpAddrIsMobileHomeFlag := ri.AddrIsMobileHomeFlag;
       SELF.InpAddrBathCnt := ri.AddrBathCnt;
       SELF.InpAddrParkingCnt := ri.AddrParkingCnt;
       SELF.InpAddrBuildYr := ri.AddrBuildYr;
       SELF.InpAddrBedCnt := ri.AddrBedCnt;
       SELF.InpAddrBldgSize := ri.AddrBldgSize;
       SELF.InpAddrLat := ri.AddrLat;
       SELF.InpAddrLng := ri.AddrLng;
       SELF.InpAddrIsCollegeFlag := ri.AddrIsCollegeFlag;
       // SELF.InpAddrAVMVal := ri.AddrAVMVal;
       // SELF.InpAddrAVMValA1Y := ri.AddrAVMValA1Y;
       // SELF.InpAddrAVMRatio1Y := (STRING10)ri.AddrAVMRatio1Y;
       // SELF.InpAddrAVMValA5Y := ri.AddrAVMValA5Y;
       // SELF.InpAddrAVMRatio5Y := (STRING10)ri.AddrAVMRatio5Y;
       // SELF.InpAddrMedAVMCtyRatio := (STRING10)ri.AddrMedAVMCtyRatio;
       // SELF.InpAddrMedAVMCenTractRatio := (STRING10)ri.AddrMedAVMCenTractRatio;
       // SELF.InpAddrMedAVMCenBlockRatio := (STRING10)ri.AddrMedAVMCenBlockRatio;
       SELF.InpAddrType := ri.AddrType;
       SELF.InpAddrTypeIndex := ri.AddrTypeIndx;
       SELF.InpAddrBusRegCnt := ri.AddrBusRegCnt;
       SELF.InpAddrIsVacantFlag := ri.AddrIsVacantFlag;
       // SELF.InpAddrForeclosure := ri.AddrForeclosure;
       // SELF.InpAddrStatus := ri.AddrStatus;
       SELF.InpAddrIsAptFlag := ri.AddrIsAptFlag;
       self 								:= le;  
   		self 								:= [];
   	END;  
*/
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell getDeceasedDID(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, Doxie.key_Death_masterV2_ssa_DID ri) := transform
		SELF.dod 		:= if(ri.src <> MDR.sourceTools.src_Death_Restricted, (UNSIGNED)ri.dod8, 0);  //excludes SSA 
		SELF.dodSSA := (UNSIGNED)ri.dod8;  //unrestricted so includes SSA
		self 	      := le;
	END;
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell rollDeceased(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Layouts.Layout_PB2_Shell ri) := transform
		SELF.dod		:= max(le.dod, ri.dod);
		SELF.dodSSA	:= max(le.dodSSA, ri.dodSSA);
		self				:= le;
	END;

  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell rollEmergence(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Layouts.Layout_PB2_Shell ri) := transform
		SELF.emrglexidsatemrgaddrcnt1y := le.emrglexidsatemrgaddrcnt1y + ri.emrglexidsatemrgaddrcnt1y;
		self				:= le;
	END;
  
  EXPORT Relationship.Layout_GetRelationship.DIDs_layout xfm_getEmailDIDs(ProfileBooster.V2_Layouts.Layout_PB2_Shell le) := TRANSFORM
    SELF.DID := le.DID;
  END;
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell xfm_getRelativeDIDs(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, Relationship.layout_GetRelationship.interfaceOutputNeutral ri) := TRANSFORM
    SELF.DID2			:= ri.did2;
    SELF.rec_type	:= ProfileBooster.Constants.recType.Relative; //set rec_type as relative
    self          := le;
  END;    
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell xfm_addPropertyCommon(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Layouts.Layout_PB2_Shell ri) := TRANSFORM
    SELF.sale_date_by_did := ri.sale_date_by_did;
    SELF.PropCurrOwner := ri.PropCurrOwner;
    SELF.AstPropCurrFlag := ri.AstPropCurrFlag;
    SELF.PropCurrOwnedCnt := ri.PropCurrOwnedCnt;
    SELF.AstPropCurrCntEv := ri.AstPropCurrCntEv;
    SELF.PropCurrOwnedAssessedTtl := ri.PropCurrOwnedAssessedTtl;
    SELF.AstPropCurrValTot := ri.AstPropCurrValTot;
    SELF.PropTimeLastSale := ri.PropTimeLastSale;
    SELF.AstPropSaleNewMsnc := ri.AstPropSaleNewMsnc;
    SELF.PropEverOwnedCnt := ri.PropEverOwnedCnt;
    SELF.AstPropCntEv := ri.AstPropCntEv;
    SELF.PropEverSoldCnt := ri.PropEverSoldCnt;
    SELF.AstPropSoldCntEv := ri.AstPropSoldCntEv;
    SELF.PropSoldCnt12Mo := ri.PropSoldCnt12Mo;
    SELF.AstPropSoldCnt1Y := ri.AstPropSoldCnt1Y;
    SELF.PropSoldRatio := ri.PropSoldRatio;
    SELF.AstPropSoldNewRatio := ri.AstPropSoldNewRatio;
    SELF.PropPurchaseCnt12Mo := ri.PropPurchaseCnt12Mo;
    SELF.AstPropPurchCnt1Y := ri.AstPropPurchCnt1Y;
    SELF.LifeAstPurchOldMsnc := IF(ri.LifeAstPurchOldMsnc=0 and ri.LifeAstPurchNewMsnc=-99998,le.LifeAstPurchOldMsnc,ri.LifeAstPurchOldMsnc);
    SELF.LifeAstPurchNewMsnc := IF(ri.LifeAstPurchOldMsnc=0 and ri.LifeAstPurchNewMsnc=-99998,le.LifeAstPurchNewMsnc,ri.LifeAstPurchNewMsnc);
    SELF.CurrAddrOwnershipIndx := ri.CurrAddrOwnershipIndx;
    SELF.InpAddrOwnershipIndx := ri.InpAddrOwnershipIndx;
    SELF.HHPropCurrOwnerMmbrCnt := ri.HHPropCurrOwnerMmbrCnt;
    SELF.HHPropCurrOwnedCnt := ri.HHPropCurrOwnedCnt;
    SELF.RaAPropCurrOwnerMmbrCnt := ri.RaAPropCurrOwnerMmbrCnt;
    SELF.owned_prim_range := ri.owned_prim_range;
    SELF.owned_predir := ri.owned_predir;
    SELF.owned_prim_name := ri.owned_prim_name;
    SELF.owned_addr_suffix := ri.owned_addr_suffix;
    SELF.owned_postdir := ri.owned_postdir;
    SELF.owned_unit_desig := ri.owned_unit_desig;
    SELF.owned_sec_range := ri.owned_sec_range;
    SELF.owned_z5 := ri.owned_z5;
    SELF.owned_city_name := ri.owned_city_name;
    SELF.owned_st := ri.owned_st;
    SELF.sold_prim_range := ri.sold_prim_range;
    SELF.sold_predir := ri.sold_predir;
    SELF.sold_prim_name := ri.sold_prim_name;
    SELF.sold_addr_suffix := ri.sold_addr_suffix;
    SELF.sold_postdir := ri.sold_postdir;
    SELF.sold_unit_desig := ri.sold_unit_desig;
    SELF.sold_sec_range := ri.sold_sec_range;
    SELF.sold_z5 := ri.sold_z5;
    SELF.sold_city_name := ri.sold_city_name;
    SELF.sold_st := ri.sold_st;
    SELF.curr_AssessedAmount := ri.curr_AssessedAmount;
    SELF.prev_AssessedAmount := ri.prev_AssessedAmount;
    SELF.CurrAddrAVMVal := ri.CurrAddrAVMVal;
    SELF.CurrAddrAVMValA1Y := ri.CurrAddrAVMValA1Y;
    SELF.CurrAddrAVMRatio1Y := ri.CurrAddrAVMRatio1Y;
    SELF.CurrAddrAVMValA5Y := ri.CurrAddrAVMValA5Y;
    SELF.CurrAddrAVMRatio5Y := ri.CurrAddrAVMRatio5Y;
    SELF.CurrAddrMedAVMCtyRatio := ri.CurrAddrMedAVMCtyRatio;
    SELF.CurrAddrMedAVMCenTractRatio := ri.CurrAddrMedAVMCenTractRatio;
    SELF.CurrAddrMedAVMCenBlockRatio := ri.CurrAddrMedAVMCenBlockRatio;
    SELF.InpAddrAVMVal := ri.InpAddrAVMVal;
    SELF.InpAddrAVMValA1Y := ri.InpAddrAVMValA1Y;
    SELF.InpAddrAVMRatio1Y := ri.InpAddrAVMRatio1Y;
    SELF.InpAddrAVMValA5Y := ri.InpAddrAVMValA5Y;
    SELF.InpAddrAVMRatio5Y := ri.InpAddrAVMRatio5Y;
    SELF.InpAddrMedAVMCtyRatio := ri.InpAddrMedAVMCtyRatio;
    SELF.InpAddrMedAVMCenTractRatio := ri.InpAddrMedAVMCenTractRatio;
    SELF.InpAddrMedAVMCenBlockRatio := ri.InpAddrMedAVMCenBlockRatio;
    SELF.AstPropCurrAVMTot := ri.AstPropCurrAVMTot;
    SELF.HHPropCurrAVMHighest := ri.HHPropCurrAVMHighest;
    SELF.RaAPropOwnerAVMHighest := ri.RaAPropOwnerAVMHighest;
    SELF.RaAPropOwnerAVMMed := ri.RaAPropOwnerAVMMed;
    SELF.LifeAddrEconTrajType := ri.LifeAddrEconTrajType;
    SELF.LifeAddrEconTrajIndx := ri.LifeAddrEconTrajIndx;
    SELF.HHTeenagerMmbrCnt := ri.HHTeenagerMmbrCnt;
    SELF.HHYoungAdultMmbrCnt := ri.HHYoungAdultMmbrCnt;
    SELF.HHMiddleAgemmbrCnt := ri.HHMiddleAgemmbrCnt;
    SELF.HHSeniorMmbrCnt := ri.HHSeniorMmbrCnt;
    SELF.HHElderlyMmbrCnt := ri.HHElderlyMmbrCnt;
    SELF.HHCnt := ri.HHCnt;
    SELF.HHEstimatedIncomeRange := ri.HHEstimatedIncomeRange;
    SELF.HHCollegeAttendedMmbrCnt := ri.HHCollegeAttendedMmbrCnt;
    SELF.HHCollege2yrAttendedMmbrCnt := ri.HHCollege2yrAttendedMmbrCnt;
    SELF.HHCollege4yrAttendedMmbrCnt := ri.HHCollege4yrAttendedMmbrCnt;
    SELF.HHCollegeGradAttendedMmbrCnt := ri.HHCollegeGradAttendedMmbrCnt;
    SELF.HHCollegePrivateMmbrCnt := ri.HHCollegePrivateMmbrCnt;
    SELF.HHMmbrCollTierHighest := ri.HHMmbrCollTierHighest;
    SELF.HHPPCurrOwnedCnt := ri.HHPPCurrOwnedCnt;
    SELF.HHPPCurrOwnedAutoCnt := ri.HHPPCurrOwnedAutoCnt;
    SELF.HHPPCurrOwnedMtrcycleCnt := ri.HHPPCurrOwnedMtrcycleCnt;
    SELF.HHPPCurrOwnedAircrftCnt := ri.HHPPCurrOwnedAircrftCnt;
    SELF.HHPPCurrOwnedWtrcrftCnt := ri.HHPPCurrOwnedWtrcrftCnt;
    SELF.HHCrtRecMmbrCnt := ri.HHCrtRecMmbrCnt;
    SELF.HHCrtRecMmbrCnt12Mo := ri.HHCrtRecMmbrCnt12Mo;
    SELF.HHCrtRecFelonyMmbrCnt := ri.HHCrtRecFelonyMmbrCnt;
    SELF.HHCrtRecFelonyMmbrCnt12Mo := ri.HHCrtRecFelonyMmbrCnt12Mo;
    SELF.HHCrtRecMsdmeanMmbrCnt := ri.HHCrtRecMsdmeanMmbrCnt;
    SELF.HHCrtRecMsdmeanMmbrCnt12Mo := ri.HHCrtRecMsdmeanMmbrCnt12Mo;
    SELF.HHCrtRecEvictionMmbrCnt := ri.HHCrtRecEvictionMmbrCnt;
    SELF.HHCrtRecEvictionMmbrCnt12Mo := ri.HHCrtRecEvictionMmbrCnt12Mo;
    SELF.HHCrtRecLienJudgMmbrCnt := ri.HHCrtRecLienJudgMmbrCnt;
    SELF.HHCrtRecLienJudgMmbrCnt12Mo := ri.HHCrtRecLienJudgMmbrCnt12Mo;
    SELF.HHMmbrLnJAmtTot7Y := ri.HHMmbrLnJAmtTot7Y;
    SELF.HHCrtRecBkrptMmbrCnt := ri.HHCrtRecBkrptMmbrCnt;
    SELF.HHCrtRecBkrptMmbrCnt12Mo := ri.HHCrtRecBkrptMmbrCnt12Mo;
    SELF.HHCrtRecBkrptMmbrCnt24Mo := ri.HHCrtRecBkrptMmbrCnt24Mo;
    SELF.HHOccProfLicMmbrCnt := ri.HHOccProfLicMmbrCnt;
    SELF.HHOccBusinessAssocMmbrCnt := ri.HHOccBusinessAssocMmbrCnt;
    SELF.HHInterestSportPersonMmbrCnt := ri.HHInterestSportPersonMmbrCnt;
    SELF.RaATeenageMmbrCnt := ri.RaATeenageMmbrCnt;
    SELF.RaAYoungAdultMmbrCnt := ri.RaAYoungAdultMmbrCnt;
    SELF.RaAMiddleAgeMmbrCnt := ri.RaAMiddleAgeMmbrCnt;
    SELF.RaASeniorMmbrCnt := ri.RaASeniorMmbrCnt;
    SELF.RaAElderlyMmbrCnt := ri.RaAElderlyMmbrCnt;
    SELF.RaAHHCnt := ri.RaAHHCnt;
    SELF.RaAMmbrCnt := ri.RaAMmbrCnt;
    SELF.RaAMedIncomeRange := ri.RaAMedIncomeRange;
    SELF.RaACollegeAttendedMmbrCnt := ri.RaACollegeAttendedMmbrCnt;
    SELF.RaACollege2yrAttendedMmbrCnt := ri.RaACollege2yrAttendedMmbrCnt;
    SELF.RaACollege4yrAttendedMmbrCnt := ri.RaACollege4yrAttendedMmbrCnt;
    SELF.RaACollegeGradAttendedMmbrCnt := ri.RaACollegeGradAttendedMmbrCnt;
    SELF.RaACollegePrivateMmbrCnt := ri.RaACollegePrivateMmbrCnt;
    SELF.RaACollegeTopTierMmbrCnt := ri.RaACollegeTopTierMmbrCnt;
    SELF.RaACollegeMidTierMmbrCnt := ri.RaACollegeMidTierMmbrCnt;
    SELF.RaACollegeLowTierMmbrCnt := ri.RaACollegeLowTierMmbrCnt;
    SELF.RaAPPCurrOwnerMmbrCnt := ri.RaAPPCurrOwnerMmbrCnt;
    SELF.RaAPPCurrOwnerAutoMmbrCnt := ri.RaAPPCurrOwnerAutoMmbrCnt;
    SELF.RaAPPCurrOwnerMtrcycleMmbrCnt := ri.RaAPPCurrOwnerMtrcycleMmbrCnt;
    SELF.RaAPPCurrOwnerAircrftMmbrCnt := ri.RaAPPCurrOwnerAircrftMmbrCnt;
    SELF.RaAPPCurrOwnerWtrcrftMmbrCnt := ri.RaAPPCurrOwnerWtrcrftMmbrCnt;
    SELF.RaACrtRecMmbrCnt := ri.RaACrtRecMmbrCnt;
    SELF.RaACrtRecMmbrCnt12Mo := ri.RaACrtRecMmbrCnt12Mo;
    SELF.RaACrtRecFelonyMmbrCnt := ri.RaACrtRecFelonyMmbrCnt;
    SELF.RaACrtRecFelonyMmbrCnt12Mo := ri.RaACrtRecFelonyMmbrCnt12Mo;
    SELF.RaACrtRecMsdmeanMmbrCnt := ri.RaACrtRecMsdmeanMmbrCnt;
    SELF.RaACrtRecMsdmeanMmbrCnt12Mo := ri.RaACrtRecMsdmeanMmbrCnt12Mo;
    SELF.RaACrtRecEvictionMmbrCnt := ri.RaACrtRecEvictionMmbrCnt;
    SELF.RaACrtRecEvictionMmbrCnt12Mo := ri.RaACrtRecEvictionMmbrCnt12Mo;
    SELF.RaACrtRecLienJudgMmbrCnt := ri.RaACrtRecLienJudgMmbrCnt;
    SELF.RaACrtRecLienJudgMmbrCnt12Mo := ri.RaACrtRecLienJudgMmbrCnt12Mo;
    SELF.RaACrtRecLienJudgAmtMax := ri.RaACrtRecLienJudgAmtMax;
    SELF.RaACrtRecBkrptMmbrCnt36Mo := ri.RaACrtRecBkrptMmbrCnt36Mo;
    SELF.RaAOccProfLicMmbrCnt := ri.RaAOccProfLicMmbrCnt;
    SELF.RaAOccBusinessAssocMmbrCnt := ri.RaAOccBusinessAssocMmbrCnt;
    SELF.RaAInterestSportPersonMmbrCnt  := ri.RaAInterestSportPersonMmbrCnt;
    SELF := le;
  END;
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_BatchOut xfm_tfEmpty(ProfileBooster.V2_Layouts.Layout_PB2_In le) := transform
		SELF.seq			:= le.seq;
		SELF.AcctNo		:= le.AcctNo;
		self 					:= [];
	END;
  
    EXPORT ProfileBooster.V2_Layouts.Layout_PB2_Shell xfmPurchaseBehaviorRollup(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Layouts.Layout_PB2_Shell ri) := transform
		  SELF.HHPurchNewAmt := IF(le.dt_last_seen >= ri.dt_last_seen AND le.PurchNewAmt > 0, le.PurchNewAmt, ri.PurchNewAmt);
		  SELF.HHPurchTotEv := le.PurchTotEv + IF(ri.PurchTotEv >= 0, ri.PurchTotEv, 0);
		  SELF.HHPurchCntEv := le.PurchCntEv + IF(ri.PurchCntEv >= 0, ri.PurchCntEv, 0);
          SELF.HHPurchNewMsnc := IF(le.PurchNewMsnc >= 0 AND ri.PurchNewMsnc >= 0, MIN(le.PurchNewMsnc, ri.PurchNewMsnc), MAX(le.PurchNewMsnc, ri.PurchNewMsnc, 0));
          SELF.HHPurchOldMsnc := MAX(le.PurchOldMsnc, ri.PurchOldMsnc);
		  SELF.HHPurchItemCntEv := le.PurchItemCntEv + IF(ri.PurchItemCntEv >= 0, ri.PurchItemCntEv, 0);
          SELF := le;
	END;
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_BatchOut xfm_PB20_mod5(ProfileBooster.V2_Layouts.Layout_PB2_BatchOut l) := TRANSFORM
            SELF.attributes.version2.HHPurchNewAmt  := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
            SELF.attributes.version2.HHPurchTotEv  := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
            SELF.attributes.version2.HHPurchNewMsnc  :=  ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
            SELF.attributes.version2.HHPurchOldMsnc  := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
            SELF.attributes.version2.HHPurchItemCntEv  := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
            SELF.attributes.version2.HHPurchAmtAvg  := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
            SELF.attributes.version2.HHPurchCntEv  := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.PurchNewAmt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.PurchTotEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.PurchCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.PurchNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.PurchOldMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.PurchItemCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.PurchAmtAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoCarCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoEliteCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoExpCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoLuxuryCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoOrigOwnCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoSUVCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoTruckCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoVanCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAuto2ndFreqMake := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.attributes.version2.AstVehAuto2ndFreqMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoFreqMake := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.attributes.version2.AstVehAutoFreqMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoNewTypeIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoEmrgPriceAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoEmrgPriceDiff := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoEmrgPriceMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoNewPrice := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoEmrgAgeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoEmrgAgeMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoEmrgAgeMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoEmrgSpanAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoLastAgeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoLastAgeMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoLastAgeMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoTimeOwnSpanAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherATVCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherCamperCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherCommCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherMtrCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherOrigOwnCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherScooterCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherNewTypeIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherNewPrice := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherPriceAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherPriceMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehOtherPriceMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.attributes.version2.AstVehAutoEmrgPriceMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF := l;
	END;
		
	EXPORT ProfileBooster.V2_Layouts.Layout_PB2_BatchOut xfm_PB20_mod4(ProfileBooster.V2_Layouts.Layout_PB2_BatchOut l) := TRANSFORM
		Modification4 := l.attributes.version2.PurchCntEv > 0;
        HHModification4 := l.attributes.version2.HHPurchCntEv > 0;
        SELF.attributes.version2.HHPurchNewAmt  := IF(HHModification4 AND l.attributes.version2.HHPurchNewAmt=ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.HHPurchNewAmt);
        SELF.attributes.version2.HHPurchTotEv  := IF(HHModification4 AND l.attributes.version2.HHPurchTotEv=ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.HHPurchTotEv);
        SELF.attributes.version2.HHPurchNewMsnc  := IF(HHModification4 AND l.attributes.version2.HHPurchNewMsnc=ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.HHPurchNewMsnc);
        SELF.attributes.version2.HHPurchOldMsnc  := IF(HHModification4 AND l.attributes.version2.HHPurchOldMsnc=ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.HHPurchOldMsnc);
        SELF.attributes.version2.HHPurchItemCntEv  := IF(HHModification4 AND l.attributes.version2.HHPurchItemCntEv=0,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.HHPurchItemCntEv);
        SELF.attributes.version2.HHPurchAmtAvg  := IF(HHModification4 AND l.attributes.version2.HHPurchAmtAvg=ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.HHPurchAmtAvg);
		SELF.attributes.version2.PurchItemCntEv := IF(Modification4 AND l.attributes.version2.PurchItemCntEv=0,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.PurchItemCntEv);
		SELF.attributes.version2.PurchOldMsnc := IF(Modification4 AND l.attributes.version2.PurchOldMsnc=ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.PurchOldMsnc);
		SELF.attributes.version2.PurchNewMsnc := IF(Modification4 AND l.attributes.version2.PurchNewMsnc=ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.PurchNewMsnc);
		SELF.attributes.version2.PurchTotEv := IF(Modification4 AND l.attributes.version2.PurchTotEv=ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.PurchTotEv);
		SELF.attributes.version2.PurchAmtAvg := IF(Modification4 AND l.attributes.version2.PurchAmtAvg=ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.PurchAmtAvg);
		SELF.attributes.version2.PurchNewAmt := IF(Modification4 AND l.attributes.version2.PurchNewAmt=ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.RECS_AVAIL_BUT_CANNOT_CALCULATE_INT,l.attributes.version2.PurchNewAmt);
		SELF := l;
		SELF := [];
	END;	
		
	EXPORT ProfileBooster.V2_Layouts.Layout_PB2_BatchOut xfm_PB20_mod3(ProfileBooster.V2_Layouts.Layout_PB2_BatchOut l) := TRANSFORM
		Modification3 := l.attributes.version2.PurchCntEv = 0;
        HHModification3 := l.attributes.version2.HHPurchCntEv = 0;
        SELF.attributes.version2.HHPurchNewAmt  := IF(HHModification3,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.HHPurchNewAmt);
        SELF.attributes.version2.HHPurchTotEv  := IF(HHModification3,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.HHPurchTotEv);
        SELF.attributes.version2.HHPurchNewMsnc  :=  IF(HHModification3,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.HHPurchNewMsnc);
        SELF.attributes.version2.HHPurchOldMsnc  := IF(HHModification3,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.HHPurchOldMsnc);
        SELF.attributes.version2.HHPurchItemCntEv  := IF(HHModification3,0,l.attributes.version2.HHPurchItemCntEv);
        SELF.attributes.version2.HHPurchAmtAvg  := IF(HHModification3,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.HHPurchAmtAvg);
		SELF.attributes.version2.PurchItemCntEv := IF(Modification3,0,l.attributes.version2.PurchItemCntEv);
		SELF.attributes.version2.PurchOldMsnc := IF(Modification3,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.PurchOldMsnc);
		SELF.attributes.version2.PurchNewMsnc := IF(Modification3,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.PurchNewMsnc);
		SELF.attributes.version2.PurchTotEv := IF(Modification3,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.PurchTotEv);
		SELF.attributes.version2.PurchAmtAvg := IF(Modification3,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.PurchAmtAvg);
		SELF.attributes.version2.PurchNewAmt := IF(Modification3,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.PurchNewAmt);
		SELF := l;
		SELF := [];
	END;
	
	EXPORT ProfileBooster.V2_Layouts.Layout_PB2_BatchOut xfm_PB20_mod2(ProfileBooster.V2_Layouts.Layout_PB2_BatchOut l) := TRANSFORM
		Modification2 := l.attributes.version2.VerProspectFoundFlag = '-1' and l.attributes.version2.PurchCntEv <> ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		SELF.attributes.version2.VerProspectFoundFlag := IF(Modification2,'1',l.attributes.version2.VerProspectFoundFlag);
		SELF := l;
		SELF := [];
	END;
	
	EXPORT ProfileBooster.V2_Layouts.Layout_PB2_BatchOut xfm_PB20_mod1(ProfileBooster.V2_Layouts.Layout_PB2_BatchOut l) := TRANSFORM
		Modification1 := l.attributes.version2.VerProspectFoundFlag = '1' and l.attributes.version2.PurchCntEv = ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		SELF.attributes.version2.PurchCntEv := IF(Modification1,0,l.attributes.version2.PurchCntEv);
		SELF.attributes.version2.PurchItemCntEv := IF(Modification1,0,l.attributes.version2.PurchItemCntEv);
		SELF.attributes.version2.PurchOldMsnc := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.PurchOldMsnc);
		SELF.attributes.version2.PurchNewMsnc := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.PurchNewMsnc);
		SELF.attributes.version2.PurchTotEv := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.PurchTotEv);
		SELF.attributes.version2.PurchAmtAvg := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.PurchAmtAvg);
		SELF.attributes.version2.PurchNewAmt := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.PurchNewAmt);
		SELF.attributes.version2.AstVehAutoCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoCntEv);
		SELF.attributes.version2.AstVehAutoCarCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoCarCntEv);
		SELF.attributes.version2.AstVehAutoSUVCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoSUVCntEv);
		SELF.attributes.version2.AstVehAutoTruckCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoTruckCntEv);
		SELF.attributes.version2.AstVehAutoVanCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoVanCntEv);
		SELF.attributes.version2.AstVehAutoNewTypeIndx := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoNewTypeIndx);
		SELF.attributes.version2.AstVehAutoExpCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoExpCntEv);
		SELF.attributes.version2.AstVehAutoEliteCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoEliteCntEv);
		SELF.attributes.version2.AstVehAutoLuxuryCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoLuxuryCntEv);
		SELF.attributes.version2.AstVehAutoOrigOwnCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoOrigOwnCntEv);
		SELF.attributes.version2.AstVehAutoMakeCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoMakeCntEv);
		SELF.attributes.version2.AstVehAutoFreqMake := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND,l.attributes.version2.AstVehAutoFreqMake);
		SELF.attributes.version2.AstVehAutoFreqMakeCntEv := IF(Modification1,0,l.attributes.version2.AstVehAutoFreqMakeCntEv);
		SELF.attributes.version2.AstVehAuto2ndFreqMake := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND,l.attributes.version2.AstVehAuto2ndFreqMake);
		SELF.attributes.version2.AstVehAuto2ndFreqMakeCntEv := IF(Modification1,0,l.attributes.version2.AstVehAuto2ndFreqMakeCntEv);
		SELF.attributes.version2.AstVehAutoEmrgPriceAvg := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoEmrgPriceAvg);
		SELF.attributes.version2.AstVehAutoEmrgPriceMax := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoEmrgPriceMax);
		SELF.attributes.version2.AstVehAutoEmrgPriceMin := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoEmrgPriceMin);
		SELF.attributes.version2.AstVehAutoNewPrice := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoNewPrice);
		SELF.attributes.version2.AstVehAutoEmrgPriceDiff := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoEmrgPriceDiff);
		SELF.attributes.version2.AstVehAutoLastAgeAvg := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoLastAgeAvg);
		SELF.attributes.version2.AstVehAutoLastAgeMax := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoLastAgeMax);
		SELF.attributes.version2.AstVehAutoLastAgeMin := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoLastAgeMin);
		SELF.attributes.version2.AstVehAutoEmrgAgeAvg := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoEmrgAgeAvg);
		SELF.attributes.version2.AstVehAutoEmrgAgeMax := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoEmrgAgeMax);
		SELF.attributes.version2.AstVehAutoEmrgAgeMin := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoEmrgAgeMin);
		SELF.attributes.version2.AstVehAutoEmrgSpanAvg := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoEmrgSpanAvg);
		SELF.attributes.version2.AstVehAutoNewMsnc := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoNewMsnc);
		SELF.attributes.version2.AstVehAutoTimeOwnSpanAvg := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehAutoTimeOwnSpanAvg);
		SELF.attributes.version2.AstVehOtherCntEv := IF(Modification1,0,l.attributes.version2.AstVehOtherCntEv);
		SELF.attributes.version2.AstVehOtherATVCntEv := IF(Modification1,0,l.attributes.version2.AstVehOtherATVCntEv);
		SELF.attributes.version2.AstVehOtherCamperCntEv := IF(Modification1,0,l.attributes.version2.AstVehOtherCamperCntEv);
		SELF.attributes.version2.AstVehOtherCommCntEv := IF(Modification1,0,l.attributes.version2.AstVehOtherCommCntEv);
		SELF.attributes.version2.AstVehOtherMtrCntEv := IF(Modification1,0,l.attributes.version2.AstVehOtherMtrCntEv);
		SELF.attributes.version2.AstVehOtherScooterCntEv := IF(Modification1,0,l.attributes.version2.AstVehOtherScooterCntEv);
		SELF.attributes.version2.AstVehOtherNewTypeIndx := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehOtherNewTypeIndx);
		SELF.attributes.version2.AstVehOtherOrigOwnCntEv := IF(Modification1,0,l.attributes.version2.AstVehOtherOrigOwnCntEv);
		SELF.attributes.version2.AstVehOtherNewMsnc := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehOtherNewMsnc);
		SELF.attributes.version2.AstVehOtherPriceAvg := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehOtherPriceAvg);
		SELF.attributes.version2.AstVehOtherPriceMax := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehOtherPriceMax);
		SELF.attributes.version2.AstVehOtherPriceMin := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehOtherPriceMin);
		SELF.attributes.version2.AstVehOtherNewPrice := IF(Modification1,ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT,l.attributes.version2.AstVehOtherNewPrice);
    
		SELF := l;
		SELF := [];
	END;	
  
  EXPORT ProfileBooster.V2_Layouts.Layout_PB2_BatchOut xfm_Final(ProfileBooster.V2_Layouts.Layout_PB2_BatchOut le) := TRANSFORM
     SELF.attributes.version2.demeducollcurrflag := le.attributes.version2.demeducollcurrflag;
     SELF.attributes.version2.demeducollflagev := le.attributes.version2.demeducollflagev;
     SELF.attributes.version2.demeducollnewlevelev := le.attributes.version2.demeducollnewlevelev;
     SELF.attributes.version2.demeducollnewpvtflag := le.attributes.version2.demeducollnewpvtflag;
     SELF.attributes.version2.demeducollnewtierindx :=le.attributes.version2.demeducollnewtierindx;
     SELF.attributes.version2.demeducolllevelhighev := le.attributes.version2.demeducolllevelhighev;
     SELF.attributes.version2.demeducollrecnewinsttypeev := IF(le.attributes.version2.demeducollrecnewinsttypeev='','-99998',le.attributes.version2.demeducollrecnewinsttypeev);
     SELF.attributes.version2.demeducolltierhighev := le.attributes.version2.demeducolltierhighev;
     SELF.attributes.version2.demeducollrecnewmajortypeev := le.attributes.version2.demeducollrecnewmajortypeev;
     SELF.attributes.version2.demeducollevidflagev := le.attributes.version2.demeducollevidflagev;
     SELF.attributes.version2.demeducollsrcnewrecoldmsncev := le.attributes.version2.demeducollsrcnewrecoldmsncev;
     SELF.attributes.version2.demeducollsrcnewrecnewmsncev := le.attributes.version2.demeducollsrcnewrecnewmsncev;
     SELF.attributes.version2.demeducollrecspanev := le.attributes.version2.demeducollrecspanev;
     SELF.attributes.version2.demeducollrecnewclassev := le.attributes.version2.demeducollrecnewclassev;
     SELF.attributes.version2.demeducollsrcnewexpgradyr := le.attributes.version2.demeducollsrcnewexpgradyr;
     SELF.attributes.version2.demeducollinstpvtflagev := le.attributes.version2.demeducollinstpvtflagev;
     SELF.attributes.version2.demeducollmajormedicalflagev := le.attributes.version2.demeducollmajormedicalflagev;
     SELF.attributes.version2.demeducollmajorphyssciflagev := le.attributes.version2.demeducollmajorphyssciflagev;
     SELF.attributes.version2.demeducollmajorsocsciflagev := le.attributes.version2.demeducollmajorsocsciflagev;
     SELF.attributes.version2.demeducollmajorlibartsflagev := le.attributes.version2.demeducollmajorlibartsflagev;
     SELF.attributes.version2.demeducollmajortechnicalflagev := le.attributes.version2.demeducollmajortechnicalflagev;
     SELF.attributes.version2.demeducollmajorbusflagev := le.attributes.version2.demeducollmajorbusflagev;
     SELF.attributes.version2.demeducollmajoreduflagev := le.attributes.version2.demeducollmajoreduflagev;
     SELF.attributes.version2.demeducollmajorlawflagev := le.attributes.version2.demeducollmajorlawflagev;
     SELF.attributes.version2.LifeMoveNewMsnc := le.attributes.version2.LifeMoveNewMsnc;
     SELF.attributes.version2.LifeNameLastChngFlag := le.attributes.version2.LifeNameLastChngFlag;
     SELF.attributes.version2.LifeNameLastChngFlag1Y := le.attributes.version2.LifeNameLastChngFlag1Y;
     SELF.attributes.version2.LifeNameLastCntEv := le.attributes.version2.LifeNameLastCntEv;
     SELF.attributes.version2.LifeNameLastChngNewMsnc := le.attributes.version2.LifeNameLastChngNewMsnc;
     SELF.attributes.version2.LifeAstPurchOldMsnc := le.attributes.version2.LifeAstPurchOldMsnc;
     SELF.attributes.version2.LifeAstPurchNewMsnc := le.attributes.version2.LifeAstPurchNewMsnc;
     SELF.attributes.version2.LifeAddrCnt := le.attributes.version2.LifeAddrCnt;
     SELF.attributes.version2.LifeAddrCurrToPrevValRatio5Y := le.attributes.version2.LifeAddrCurrToPrevValRatio5Y;
     SELF.attributes.version2.LifeAddrEconTrajType := le.attributes.version2.LifeAddrEconTrajType;
     SELF.attributes.version2.LifeAddrEconTrajIndx := le.attributes.version2.LifeAddrEconTrajIndx;
     
     SELF := le;
    END;
END;