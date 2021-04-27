IMPORT STANDARD, dx_ProfileBooster;

EXPORT Layouts := MODULE

 	EXPORT  ProspectDemographicEducation := RECORD
		INTEGER3		DemEduCollCurrFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollNewLevelEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollNewPvtFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollNewTierIndx := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollLevelHighEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING6 		DemEduCollRecNewInstTypeEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		DemEduCollTierHighEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollRecNewMajorTypeEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollEvidFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollSrcNewRecOldMsncEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollSrcNewRecNewMsncEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollRecSpanEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollRecNewClassEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollSrcNewExpGradYr := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollInstPvtFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollMajorMedicalFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollMajorPhysSciFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollMajorSocSciFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollMajorLibArtsFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollMajorTechnicalFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollMajorBusFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollMajorEduFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DemEduCollMajorLawFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	ProspectDemographic := RECORD
		String6		  	DemUpdtOldMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String6		  	DemUpdtNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String6		  	DemUpdtFlag1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String6		  	DemAge := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String6		  	DemGender := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String6		  	DemIsMarriedFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String6		  	DemEstInc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String6		  	DemDeceasedFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
    	ProspectDemographicEducation;
		String6		  	DemBankingIndx := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
	END;
	
	EXPORT	ProspectInterests := RECORD
		INTEGER3    	IntSportPersonFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;	
    	INTEGER3    	IntSportPersonFlag1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;	
    	INTEGER3    	IntSportPersonFlag5Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;	
    	INTEGER3    	IntSportPersonTravelerFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;	
	END;

	EXPORT	ProspectLifeEvents := RECORD
		INTEGER3		LifeMoveNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		LifeNameLastChngFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		LifeNameLastChngFlag1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		LifeNameLastCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		LifeNameLastChngNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		LifeAstPurchOldMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		LifeAstPurchNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		LifeAddrCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING6 		LifeAddrCurrToPrevValRatio5Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		LifeAddrEconTrajType := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		LifeAddrEconTrajIndx := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	ProspectAsset := RECORD
    	INTEGER3		AstCurrFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstPropCurrFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstPropCurrCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER4		AstPropCurrValTot := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER4		AstPropCurrAVMTot := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstPropSaleNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstPropCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstPropSoldCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstPropSoldCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING6 		AstPropSoldNewRatio := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		AstPropPurchCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
    	INTEGER3    	AstPropAirCrftCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
    	INTEGER3    	AstPropWtrcrftCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT; 
  	END;
	
	EXPORT  ProspectCurrAddrHelpers := RECORD
		STRING 			AddrCurrFull;
		UNSIGNED8 		curr_addr_rawaid;
		STRING10 		curr_prim_range;
		STRING2  		curr_predir;
		STRING28    	curr_prim_name;
		STRING4     	curr_addr_suffix;
		STRING2     	curr_postdir;
		STRING10    	curr_unit_desig;
		STRING8     	curr_sec_range;
		STRING25    	curr_city_name;
		STRING2     	curr_st;
		STRING5     	curr_z5;
		STRING4     	curr_zip4;
		STRING1     	curr_addr_type;
		STRING4     	curr_addr_status;	
		STRING3 		curr_county;
		STRING7 		curr_geo_blk;	
		UNSIGNED3		curr_date_first_seen;	
		UNSIGNED3		curr_date_last_seen;	
	END;
	
	EXPORT  ProspectPrevAddrHelpers := RECORD
		STRING 			AddrPrevFull;
		UNSIGNED8 		prev_addr_rawaid;
		STRING10 		prev_prim_range;
		STRING2  		prev_predir;
		STRING28    	prev_prim_name;
		STRING4     	prev_addr_suffix;
		STRING2     	prev_postdir;
		STRING10    	prev_unit_desig;
		STRING8     	prev_sec_range;
		STRING25    	prev_city_name;
		STRING2     	prev_st;
		STRING5     	prev_z5;
		STRING4     	prev_zip4;
		STRING1     	prev_addr_type;
		STRING4     	prev_addr_status;	
		STRING3 		prev_county;
		STRING7 		prev_geo_blk;	
		UNSIGNED3		prev_date_first_seen;	
		UNSIGNED3		prev_date_last_seen;
	END;

	EXPORT	ProspectCurrAddrCharac := RECORD
		INTEGER3		CurrAddrOwnershipIndx := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		AddrCurrProspectRent := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		AddrCurrRentValue := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3 		CurrAddrHasPoolFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrIsMobileHomeFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrBathCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrParkingCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrBuildYr := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrBedCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrBldgSize := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING		  	CurrAddrLat := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		STRING		  	CurrAddrLng := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		CurrAddrIsCollegeFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrAVMVal := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrAVMValA1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING  		CurrAddrAVMRatio1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		CurrAddrAVMValA5Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING		  	CurrAddrAVMRatio5Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		STRING		  	CurrAddrMedAVMCtyRatio := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		STRING		  	CurrAddrMedAVMCenTractRatio := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		STRING		  	CurrAddrMedAVMCenBlockRatio := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		STRING6 		CurrAddrType := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		CurrAddrTypeIndx := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrBusRegCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrIsVacantFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrStatus := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		CurrAddrIsAptFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	ProspectPurchaseBehavior := RECORD
		INTEGER3		PurchNewAmt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		PurchTotEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		PurchCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		PurchNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		PurchOldMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		PurchItemCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		PurchAmtAvg := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
	END;
	
  	EXPORT	ProspectPurchaseBehaviorExtended := RECORD
		INTEGER3    	PurchAge := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING      	PurchDOB := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		STRING      	PurchGender := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		STRING      	PurchMarried := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER8    	PL_PurchMinDate := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER8    	PL_PurchMaxDate := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	ProspectVehicle := RECORD
		INTEGER3		AstVehAutoCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoCarCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoSUVCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoTruckCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoVanCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoNewTypeIndx := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoExpCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoEliteCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoLuxuryCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoOrigOwnCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoMakeCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING 			AstVehAutoFreqMake := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		AstVehAutoFreqMakeCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING 			AstVehAuto2ndFreqMake := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		AstVehAuto2ndFreqMakeCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoEmrgPriceAvg := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoEmrgPriceMax := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoEmrgPriceMin := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoNewPrice := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoEmrgPriceDiff := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoLastAgeAvg := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoLastAgeMax := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoLastAgeMin := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoEmrgAgeAvg := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoEmrgAgeMax := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoEmrgAgeMin := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoEmrgSpanAvg := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehAutoTimeOwnSpanAvg := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherATVCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherCamperCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3  		AstVehOtherCommCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3  		AstVehOtherMtrCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherScooterCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherNewTypeIndx := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherOrigOwnCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherPriceAvg := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherPriceMax := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherPriceMin := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		AstVehOtherNewPrice := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;	
  	END;

  	EXPORT	ProspectVehicleExtended := RECORD
    	INTEGER8    	PL_VehicleMinDate := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
    	INTEGER8    	PL_VehicleMaxDate := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
  	END;
  	
	EXPORT	ProspectOccupationalRecords := RECORD
		INTEGER3		ProfLicFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3	    ProfLicActivNewIndx := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		BusAssocFlagEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		BusAssocOldMSnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		BusLeadershipTitleFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		BusAssocCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		BusAssocSmBusFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING6		    ProfLicActvNewTitleType := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		BusUCCFilingCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		BusUCCFilingActiveCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	ProspectEmergence := RECORD
		INTEGER3		EmrgAge := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		EmrgAtOrAfter21Flag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		STRING6 		EmrgRecordType := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		STRING6  		EmrgAddrType := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		EmrgLexIDsAtEmrgAddrCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		EmrgAge25to59Flag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
	END;

	EXPORT  ProspectEmergenceHelpers := RECORD
		STRING      	EmrgDOB;
		STRING2			EmrgSrc;
		UNSIGNED6 		EmrgDt_first_seen;
		STRING   		EmrgAddrFull;
		STRING10 		EmrgPrimaryRange;
		STRING6  		EmrgPredirectional;
		STRING28 		EmrgPrimaryName;
		STRING6  		EmrgSuffix;
		STRING6  		EmrgPostdirectional;
		STRING10 		EmrgUnitDesignation;
		STRING8  		EmrgSecondaryRange;
		STRING6  		EmrgZIP5;
		STRING6  		EmrgZIP4;
		STRING25 		EmrgCity_Name;
		STRING6  		EmrgSt;
	END;
	
	EXPORT	ProspectCourtRecords := RECORD
		INTEGER3		DrgCnt7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgSeverityIndx7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgNewMsnc7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgCrimFelCnt7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgCrimFelCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgCrimFelNewMsnc7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgCrimNFelCnt7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgCrimNFelCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgCrimNFelNewMsnc7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgEvictCnt7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgEvictCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgEvictNewMsnc7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgLnJCnt7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgLnJCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgLnJNewMsnc7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER4		DrgLnJAmtTot7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgBkCnt10Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgBkCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		DrgBkNewMsnc10Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		DrgFrClCnt7Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		DrgFrClCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		DrgFrClNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	InputAddrCharac := RECORD
		INTEGER3		InpAddrOwnershipIndx := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		ResInputProspectRent := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		ResInputRentValue := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		InpAddrHasPoolFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		InpAddrIsMobileHomeFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		InpAddrBathCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		InpAddrParkingCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		InpAddrBuildYr := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		InpAddrBedCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER4		InpAddrBldgSize := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		String  		InpAddrLat := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String	  		InpAddrLng := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		InpAddrIsCollegeFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER		 	InpAddrAVMVal := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER		 	InpAddrAVMValA1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		String7		  	InpAddrAVMRatio1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER		  	InpAddrAVMValA5Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		String7		  	InpAddrAVMRatio5Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String7		  	InpAddrMedAVMCtyRatio := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String7		  	InpAddrMedAVMCenTractRatio := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String7		  	InpAddrMedAVMCenBlockRatio := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		String6		  	InpAddrType := dx_ProfileBooster.Constants.MISSING_INPUT_DATA;
		INTEGER3		InpAddrTypeIndex := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		InpAddrBusRegCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		InpAddrIsVacantFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		InpAddrStatus := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		InpAddrIsAptFlag := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
	END;

  	EXPORT ProspectShortTermCreditActivity := RECORD
		INTEGER3  		ShortTermShopNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3  		ShortTermShopOldMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3  		ShortTermShopCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3  		ShortTermShopCnt6M := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3  		ShortTermShopCnt5Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3  		ShortTermShopCnt1Y := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3  ShortTermCredBusCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3  ShortTermCredIncNewMsnc := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3  ShortTermCredIncNewAmt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3  ShortTermCredBankFlg := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3  ShortTermCreditBankType := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
  	END;

	EXPORT Address := RECORD 
		STRING   		AddrFull;
		STRING10 		PrimaryRange;
		STRING6  		Predirectional;
		STRING28 		PrimaryName;
		STRING6  		Suffix;
		STRING6  		Postdirectional;
		STRING10 		UnitDesignation;
		STRING8  		SecondaryRange;
		STRING6  		ZIP5;
		STRING6  		ZIP4;
		STRING25 		City_Name;
		STRING6  		St;
		STRING6  		AddrType;
		INTEGER3 		AddrTypeIndx;
		INTEGER3 		AddrStatus;
		STRING6  		County;
		STRING7  		Geo_Blk;
		STRING   		Addr1;
		STRING13 		geoLink;
	END; 

	EXPORT Address_Extended :=   RECORD
		INTEGER4 		Rent;
		INTEGER4 		RentValue;
		INTEGER3 		AddrHasPoolFlag;
		INTEGER3 		AddrIsMobileHomeFlag;
		INTEGER1 		AddrBathCnt;
		INTEGER1 		AddrParkingCnt;
		INTEGER2 		AddrBuildYr;
		INTEGER1 		AddrBedCnt;
		INTEGER2 		AddrBldgSize;
		STRING10 		AddrLat;
		STRING11 		AddrLng;
		INTEGER3 		AddrIsCollegeFlag;
		INTEGER3 		AddrIsVacantFlag;
		INTEGER3 		AddrForeclosure;
		INTEGER4 		AddrAVMVal;
		INTEGER4 		AddrAVMValA1Y;
		DECIMAL10_2 	AddrAVMRatio1Y;
		INTEGER4 		AddrAVMValA5Y;
		DECIMAL10_2 	AddrAVMRatio5Y;
		DECIMAL10_2 	AddrMedAVMCtyRatio;
		DECIMAL10_2 	AddrMedAVMCenTractRatio;
		DECIMAL10_2 	AddrMedAVMCenBlockRatio;
		INTEGER3 		AddrBusRegCnt;
		INTEGER3 		AddrIsAptFlag;
		INTEGER4 		HHID;  
		INTEGER4 		NBHDID;
		//NBHDRiskViewBankScoreAvg
		//NBHDTelecomScoreAvg
		//NBHDShortTermLendingScoreAvg
		//NBHDAutoScoreAvg

	END;

	EXPORT i_address  := RECORD 
		UNSIGNED8 		rawaid;
		Address;
		Address_extended;
		INTEGER	  		datetime;
      	UNSIGNED4 		global_sid   := 0;   
		UNSIGNED8 		record_sid   := 0; 			
	END;

	EXPORT i_lexid  := RECORD 
		UNSIGNED6 		DID;
		unsigned6 		HHID;
		// string12 		geoLink;
		ProspectDemographicEducation;      
		ProspectInterests;
		ProspectLifeEvents -LifeAddrCurrToPrevValRatio5Y;
		ProspectAsset;      
		ProspectCurrAddrCharac -curraddrlat -curraddrlng;
		ProspectPurchaseBehavior;
		ProspectPurchaseBehaviorExtended;
		ProspectVehicleExtended;
		ProspectVehicle;      
		ProspectOccupationalRecords;
		ProspectEmergence;
		ProspectEmergenceHelpers;
		ProspectCourtRecords;
		ProspectShortTermCreditActivity;

		ProspectCurrAddrHelpers;
		ProspectPrevAddrHelpers;
		
		// INTEGER 		date_first_seen;
		// INTEGER 		date_last_seen;
		INTEGER 		datetime;
		UNSIGNED4 		global_sid   := 0;   
		UNSIGNED8 		record_sid   := 0; 			
	END;
END;