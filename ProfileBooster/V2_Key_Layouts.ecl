IMPORT ProfileBooster, Risk_Indicators, dx_ProfileBooster, BIPV2_Crosswalk;

EXPORT V2_Key_Layouts := MODULE
  EXPORT Layout_Infutor := RECORD
	unsigned6 DID;
	string1 	marital_status;
	string1 	gender;
	string8		dob;
	// string8 	dt_first_seen;
	//Added for CCPA-10
	UNSIGNED4 global_sid;
	UNSIGNED8 record_sid;
  END;
  
  EXPORT  ProspectDemographicEducation := RECORD
  	dx_ProfileBooster.Layouts.ProspectDemographicEducation;
  END;
  
  EXPORT Layout_Output_with_input_addr_rawaid := RECORD
    Risk_Indicators.Layout_Output;
    UNSIGNED8 input_addr_rawaid;
  END;

  EXPORT Layout_PB2_Slim := RECORD
    unsigned4 seq;
    unsigned6 DID;
    unsigned6 DID2;
    unsigned3 historydate := 999999;
    unsigned1 rec_type := 1; //1=Prospect, 2=Household, 3=Relative/Associate
    string20  fname;
    string20  lname;
    string10  prim_range;
    string2   predir;
    string28  prim_name;
    string4   addr_suffix;
    string2   postdir;
    string10  unit_desig;
    string8   sec_range;
    string25  p_city_name;
    string2   st;
    string5   z5;
  END;
  
  EXPORT Layout_PB2_Slim_header := RECORD
    Layout_PB2_Slim;
    unsigned1	age;
    unsigned6	HHID;
    unsigned3	dt_first_seen;
    unsigned3	dt_last_seen;
    string12	geoLink;
    unsigned6	med_hhinc;
  END;
  
  EXPORT Layout_PB2_Slim_student := RECORD
    Layout_PB2_Slim;
    string8 student_date_first_seen := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    string8 student_date_last_seen := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    STRING6 student_college_code := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    STRING6 student_college_type := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    STRING6 student_college_tier := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    STRING6 student_college_name := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    STRING6 student_college_major := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    string8 student_new_college_major := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    STRING6 student_college_class := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    STRING6 student_file_type := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    STRING6 src := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND;
    ProspectDemographicEducation;
  END;
  EXPORT Layout_PB2_Slim_vehicles := RECORD
	Layout_PB2_Slim;
	string30	vehicle_key;
	string15 	iteration_key;
	string15 	sequence_key;
	string2  	state_origin;
	string4		year_make;
	string5		make;
	string3		model;

	string1 	vina_veh_type;
	unsigned1 totalCount;
	unsigned1 vehicleCount;
	unsigned1 motorcycleCount;
	integer3	months_first_reg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT;
	integer3	months_last_reg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.NO_DATA_FOUND_INT;

	string25 PPCurrOwnedAutoVIN;
	string4 PPCurrOwnedAutoYear;
	string36 PPCurrOwnedAutoMake;
	string30 PPCurrOwnedAutoModel;
	string20 PPCurrOwnedAutoSeries;
	string25 PPCurrOwnedAutoType;
  END;
  EXPORT Layout_PB2_Slim_Crosswalk := RECORD
	Layout_PB2_Slim;
	integer4		   BusAssocFlagEv;
	integer4           BusAssocOldMSnc;
	integer4           BusLeadershipTitleFlag;
	integer4           BusAssocCntEv;
	unsigned6          uniqueID;
    unsigned6          ultid;
    unsigned6          orgid;
    unsigned6          seleid;
    unsigned6          proxid;
	unsigned6          contact_did;          
    unsigned4          dt_first_seen;
    unsigned4          dt_last_seen;
    unsigned4          dt_first_seen_at_business;
    unsigned4          dt_last_seen_at_business;
    integer            executive_ind_order;
    string50           job_title1;
    string50           job_title2;
    string50           job_title3;
    // dataset(BIPV2_Crosswalk.Layouts.SourceInfoRec) sourceInfo;
  END;

  EXPORT Layout_PB2_Slim_UCC := RECORD
	unsigned6  UniqueID;
	Layout_PB2_Slim;
	string2     sourceCode:='';
	string1  	party_type:='';
	string31 	tmsid;	
    string23 	rmsid:='';
    string8     orig_filing_date;
	// string8     dt_vendor_first_reported;
	INTEGER3	BusUCCFilingCntEv := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
	INTEGER3	BusUCCFilingActiveCnt := dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
  END;

  EXPORT Layout_PB2_Slim_PAW := RECORD
		Layout_PB2_Slim;
		unsigned6 contact_id;
		string12 	bid;
		string10 	company_status;
		string100 company_title; 
		string8  	dt_first_seen;
		string8  	dt_last_seen;
		unsigned1	OccBusinessAssociation;
		unsigned2	OccBusinessAssociationTime;
		unsigned1	OccBusinessTitleLeadership;
  END;

	EXPORT Layout_PB2_Slim_profLic := RECORD
		Layout_PB2_Slim;
		string50	prolic_key;
		string8 	date_first_seen;
		boolean  	professional_license_flag;
		string60	license_type;
		unsigned1	proflic_count;
		string100	jobCategory; 
		string1 	PLcategory;	
		string6     ActiveNewTitleType;
		string2		source_st;
	END;

	EXPORT Layout_PB2_Slim_emergence := RECORD
		Layout_PB2_Slim;
		
		dx_ProfileBooster.Layouts.ProspectEmergence;
		dx_ProfileBooster.Layouts.ProspectEmergenceHelpers;
  	END;

EXPORT	Verification := RECORD
		String6		VerDoNotMailFlag := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		VerProspectFoundFlag := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		VerInpNameIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		VerInpSSNFlag := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		VerInpPhoneFlag := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		VerInpAddrMatchIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		VerInpEmailFlag := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
	END;


	EXPORT	ProspectDemographic := RECORD
		String6		DemUpdtOldMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		DemUpdtNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		DemUpdtFlag1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		DemAge := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		DemGender := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		DemIsMarriedFlag := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		DemEstInc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String6		DemDeceasedFlag := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		dx_ProfileBooster.Layouts.ProspectDemographicEducation;
		String6		DemBankingIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
	END;

	EXPORT	ProspectInterests := RECORD
		dx_ProfileBooster.Layouts.ProspectInterests;
	END;

	EXPORT Layout_PB2_Slim_sports := RECORD
		Layout_PB2_Slim;
		unsigned6	rid;
		ProspectInterests;
	END;

	EXPORT	ProspectLifeEvents := RECORD
		dx_ProfileBooster.Layouts.ProspectLifeEvents;
	END;
	
	EXPORT	ProspectAsset := RECORD
		dx_ProfileBooster.Layouts.ProspectAsset;
  END;
	
	EXPORT	ProspectCurrAddrCharac := RECORD
		dx_ProfileBooster.Layouts.ProspectCurrAddrCharac;
	END;
	
	EXPORT	ProspectPurchaseBehavior := RECORD
		dx_ProfileBooster.Layouts.ProspectPurchaseBehavior;
	END;
	
	EXPORT	ProspectVehicle := RECORD
		dx_ProfileBooster.Layouts.ProspectVehicle;
	END;
	
	EXPORT	ProspectOccupationalRecords := RECORD
		dx_ProfileBooster.Layouts.ProspectOccupationalRecords;
	END;
	
	EXPORT	ProspectEmergence := RECORD
		dx_ProfileBooster.Layouts.ProspectEmergence;
	END;

	EXPORT	ProspectCourtRecords := RECORD
		dx_ProfileBooster.Layouts.ProspectCourtRecords;
	END;

  EXPORT  ProspectShortTermCreditActivity := RECORD
    dx_ProfileBooster.Layouts.ProspectShortTermCreditActivity;
  END;
	
	EXPORT	InputAddrCharac := RECORD
		dx_ProfileBooster.Layouts.InputAddrCharac;
	END;
		
	EXPORT	HouseholdDemographics := RECORD
		INTEGER8		HHID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHTeenagerMmbrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHYoungAdultMmbrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMiddleAgeMmbrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHSeniorMmbrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHElderlyMmbrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrAgeMed := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrAgeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHComplexTotalCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHUnitsInComplexCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHEstimatedIncomeTotal := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHEstimatedIncomeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWEduCollCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWEduCollEvidEvCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWEduColl2YrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWEduColl4YrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWEduCollGradCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWCollPvtCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrCollTierHighest := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrCollTierAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		HHTimeSinceAddition := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		HHTimeSinceDeparture := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		HHAdditionCnt6Mo := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		HHAdditionUnder25Cnt6M := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		HHAdditionOver60Cnt6M := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		HHDepartureCnt6M := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	HouseholdAssets := RECORD
		INTEGER3		HHMmbrWAstPropCurrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstPropCurrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER4		HHMmbrPropAVMMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER5	    HHMmbrPropAVMAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER5	    HHMmbrPropAVMTtl := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER4		HHMemberPropAVMTtl1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER4		HHMemberPropAVMTtl5Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHVehicleOwnedCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAutoOwnedCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMotorcycleOwnedCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAircraftOwnedCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHWatercraftOwnedCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	HouseholdInterests := RECORD
		INTEGER3		HHMmbrWIntSportCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	HouseholdCourtRecords := RECORD
		INTEGER3		HHMmbrWDrgCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWDrgCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHDrgNewMsnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWCrimFelCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWCrimFelCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWCrimFelNewMsnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWCrimNFelCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWCrimNFelCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWCrimNFelNewMsnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWEvictCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWEvictCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWEvictNewMsnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWLnJCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWLnJCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER4		HHMmbrLnJAmtTot7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWLnJNewMsnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWBkCnt10Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWBkCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWBkCnt2Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWBkNewMsnc10Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWFrClCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWFrClNewMSnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	HouseholdOccupationalRecords := RECORD
		INTEGER3		HHMmbrWithProfLicCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWBusAssocCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWProfLicCat1Cnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWProfLicCat2Cnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWProfLicCat3Cnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWProfLicCat4Cnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWProfLicCat5Cnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHMmbrWProfLicUncatCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	HouseholdPurchaseBehavior := RECORD
		INTEGER3		HHPurchNewAmt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHPurchTotEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHPurchCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHPurchNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHPurchOldMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHPurchItemCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHPurchAmtAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	HouseholdVehicleInsights := RECORD
		INTEGER3		HHAstVehAutoCarCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoEliteCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoExpCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoLuxuryCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoOrigOwnCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoSUVCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoTruckCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoVanCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		STRING36		HHAstVehAuto2ndFreqMake := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		INTEGER3		HHAstVehAuto2ndFreqMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		STRING36		HHAstVehAutoFreqMake := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		INTEGER3		HHAstVehAutoFreqMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoNewTypeIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoEmrgPriceAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoEmrgPriceDiff := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoEmrgPriceMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoNewPrice := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoEmrgAgeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoEmrgAgeMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoEmrgAgeMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoEmrgSpanAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoLastAgeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoLastAgeMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoLastAgeMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoTimeOwnSpanAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherATVCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherCamperCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherCommCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherMtrCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherOrigOwnCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherScooterCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherNewTypeIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherNewPrice := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherPriceAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherPriceMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehOtherPriceMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		HHAstVehAutoEmrgPriceMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;		
	END;
	
	EXPORT	RelativeDemographic := RECORD
		INTEGER3		RaATeenagerCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAYoungAdultCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAMiddleAgeCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaASeniorCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAElderlyCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAUniqueHHCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaACnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAMedianIncome := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWEduCollCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWEduColl2YCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWEduColl4YCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWEduCollGradCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWCollPvtCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWTopTierCollCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWMidTierCollCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWLowTierCollCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaACurrAddrCloseDist := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaACurrAddrCloseNZDist := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaACurrAddr25MiDistCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaACurrAddr100MiDistCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaACurrAddrGT500MiDistCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RelOver500MiCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaACurrAddrDistAvg1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWCrim25MiCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWCrimCurrAddrCloseDist7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAEstIncomeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAEstIncomeMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaACurrHomeValAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	RelativeAssociateAssets := RECORD
		INTEGER3		RaAPropOwnCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAPropCurrOwnTot := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAPropCurrAVMValMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAPropCurrAVMValAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAPropCurrAVMValTot := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAPropCurrAVMValTot1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAPropCurrAVMValTot5Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAVehicleOwnedCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAAutoOwnedCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAMotorcycleOwnedCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAAircraftOwnedCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWatercraftOwnedCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	RelativeAssociateInterests := RECORD
		INTEGER3		RaAWIntSportCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	RelativeAssociateCourtRecords := RECORD
		INTEGER3		RaAWDrgCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWDrgCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWDrgNewMSnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWCrimFelCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWCrimFelCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWCrimFelNewMSnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWCrimNFelCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWCrmiNFelCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWCrimNFelNewMSnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWEvictCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWEvictCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWEvictNewMSnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWLnJCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWLnJCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER4		RaALnJAmtTot := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWLnJNewMSnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWBkCnt10Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWBkCnt1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWBkCnt2Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWBkNewMSnc10Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAFrClCnt7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAFrClNewMsnc7Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	RelativeAssociateOccupationRecords := RECORD
		INTEGER3		RaAWProfLicCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWBusAssocCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWProfLicCat1Cnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWProfLicCat2Cnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWProfLicCat3Cnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWProfLicCat4Cnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWProfLicCat5Cnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAWProfLicUncatCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	RelativeAssociatePurchaseBehaviour := RECORD
		INTEGER3		RaAPurchNewAmt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAPurchTotEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAPurchCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAPurchItemCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		RaAPurchAmtAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
	EXPORT	NeighborhoodDemographic := RECORD
		INTEGER3	  NBHDHHCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDHHSizeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDMmbrCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDMmbrAgeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDMarriedMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDMedIncome := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCollegeAttendedMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCollege2yrAttendedMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCollege4yrAttendedMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCollegePrivateMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCollegeTopTierMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCollegeCurrentAttendingPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCollegeMidTierMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCollegeLowTierMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDBusinessCnt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDValueChangeIndex := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDPropCurrOwnershipHHPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDPropOwnerMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDPPCurrOwnedHHPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDPPCurrOwnedAutoHHPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDPPCurrOwnedMtrcycleHHPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDPPCurrOwnedAircraftHHPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDPPCurrOwnedWtrcrftHHPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDOccProfLicenseMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDOccBusinessAssociationMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDInterestSportsPersonMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCrtRcrdMmbrPct1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCrtRcrdFelonyMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCrtRcrdMsdmeanMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCrtRcrdEvictionMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCrtRcrdLienJudgeMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCrtRcrdBkrptMmbrPct := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDCrtRcrdBkrptMmbrPct1Y := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDRiskViewBankScoreAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDTelecomScoreAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDShortTermLendingScoreAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		INTEGER3		NBHDAutoScoreAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		NBHDAdditionPct6Mo := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		NBHDAdditionUnder25Pct6M := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		NBHDAdditionOver60Pct6M := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
		// INTEGER3		NBHDDeparturePct6M := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
	END;
	
  EXPORT HelperAttributes := RECORD
    STRING12 ln_fares_id;
    // STRING AddrCurrFull;
    // unsigned8 input_addr_rawaid;
    // unsigned8 curr_addr_rawaid;
    // STRING AddrPrevFull;    
    // unsigned8 prev_addr_rawaid;
	dx_ProfileBooster.Layouts.ProspectEmergenceHelpers;
	dx_ProfileBooster.Layouts.ProspectCurrAddrHelpers;
	dx_ProfileBooster.Layouts.ProspectPrevAddrHelpers;
  END;
  
	EXPORT Layout_ProfileBoosterV2 := RECORD
		//PROSPECT 
		Verification;
		ProspectDemographic;
		ProspectInterests;
		ProspectLifeEvents;
		ProspectAsset;
		ProspectCurrAddrCharac;
		ProspectPurchaseBehavior;
		ProspectVehicle;
		ProspectOccupationalRecords;
		ProspectEmergence;
		ProspectCourtRecords;
    	ProspectShortTermCreditActivity;
		InputAddrCharac;
		//HOUSEHOLD
		HouseholdDemographics;
		HouseholdAssets;
		HouseholdInterests;
		HouseholdCourtRecords;
		HouseholdOccupationalRecords;
		HouseholdPurchaseBehavior;
		HouseholdVehicleInsights;
		//RELATIVES
		RelativeDemographic;
		RelativeAssociateAssets;
		RelativeAssociateInterests;
		RelativeAssociateCourtRecords;
		RelativeAssociateOccupationRecords;
		RelativeAssociatePurchaseBehaviour;
		//NEIGHBORHOOD
		NeighborhoodDemographic;
    //HELPER
    HelperAttributes;
	END;
 
  export Layout_Derogs :=
    RECORD
      BOOLEAN bankrupt := false;
      UNSIGNED4 date_last_seen := 0;
      STRING1 filing_type := '';
      STRING35 disposition := '';	
      UNSIGNED1 filing_count := 0;
      UNSIGNED1 filing_count7y := 0;
      UNSIGNED1 bk_recent_count := 0;
      UNSIGNED1 bk_dismissed_recent_count := 0;
      UNSIGNED1 bk_dismissed_historical_count := 0;
      UNSIGNED1 bk_disposed_recent_count := 0;
      UNSIGNED1 bk_disposed_historical_count := 0;
      UNSIGNED1 bk_count30 := 0;
      UNSIGNED1 bk_count90 := 0;
      UNSIGNED1 bk_count180 := 0;
      UNSIGNED1 bk_count12 := 0;
      UNSIGNED1 bk_count24 := 0;
      UNSIGNED1 bk_count36 := 0;
      UNSIGNED1 bk_count60 := 0;
      STRING3   bk_chapter := '';
      
      UNSIGNED1 liens_recent_unreleased_count := 0;
      UNSIGNED1 liens_historical_unreleased_count := 0;
      UNSIGNED1 liens_unreleased_count30 := 0;
      UNSIGNED1 liens_unreleased_count90 := 0;
      UNSIGNED1 liens_unreleased_count180 := 0;
      UNSIGNED1 liens_unreleased_count12 := 0;
      UNSIGNED1 liens_unreleased_count24 := 0;
      UNSIGNED1 liens_unreleased_count36 := 0;
      UNSIGNED1 liens_unreleased_count60 := 0;
      string8 last_liens_unreleased_date := '';
      
      UNSIGNED1 liens_recent_released_count := 0;
      UNSIGNED1 liens_historical_released_count := 0;
      UNSIGNED1 liens_released_count30 := 0;
      UNSIGNED1 liens_released_count90 := 0;
      UNSIGNED1 liens_released_count180 := 0;
      UNSIGNED1 liens_released_count12 := 0;
      UNSIGNED1 liens_released_count24 := 0;
      UNSIGNED1 liens_released_count36 := 0;
      UNSIGNED1 liens_released_count60 := 0;
      UNSIGNED4 last_liens_released_date := 0;
      
      UNSIGNED1 criminal_count := 0;
      UNSIGNED1 criminal_count30 := 0;
      UNSIGNED1 criminal_count90 := 0;
      UNSIGNED1 criminal_count180 := 0;
      UNSIGNED1 criminal_count12 := 0;
      UNSIGNED1 criminal_count24 := 0;
      UNSIGNED1 criminal_count36 := 0;
      UNSIGNED1 criminal_count60 := 0;
      UNSIGNED4 last_criminal_date := 0;
      UNSIGNED1 felony_count := 0;
      UNSIGNED4 last_felony_date := 0;
      
      UNSIGNED1 nonfelony_criminal_count := 0;  // added for riskview attributes 5.0, populated only in FCRA shell
      UNSIGNED1 nonfelony_criminal_count12 := 0;  // added for riskview attributes 5.0, populated only in FCRA shell
      UNSIGNED4 last_nonfelony_criminal_date := 0; // added for riskview attributes 5.0, populated only in FCRA shell
      
      UNSIGNED1 eviction_recent_unreleased_count := 0;
      UNSIGNED1 eviction_historical_unreleased_count := 0;
      UNSIGNED1 eviction_recent_released_count := 0;
      UNSIGNED1 eviction_historical_released_count := 0;
      UNSIGNED1 eviction_count := 0;
      UNSIGNED1 eviction_count30 := 0;
      UNSIGNED1 eviction_count90 := 0;
      UNSIGNED1 eviction_count180 := 0;
      UNSIGNED1 eviction_count12 := 0;
      UNSIGNED1 eviction_count24 := 0;
      UNSIGNED1 eviction_count36 := 0;
      UNSIGNED1 eviction_count60 := 0;
      UNSIGNED4 last_eviction_date := 0;
      
      UNSIGNED1 arrests_count := 0;
      UNSIGNED1 arrests_count30 := 0;
      UNSIGNED1 arrests_count90 := 0;
      UNSIGNED1 arrests_count180 := 0;
      UNSIGNED1 arrests_count12 := 0;
      UNSIGNED1 arrests_count24 := 0;
      UNSIGNED1 arrests_count36 := 0;
      UNSIGNED1 arrests_count60 := 0;
      UNSIGNED4 date_last_arrest := 0;
      
      BOOLEAN foreclosure_flag := false;
      STRING8 last_foreclosure_date := '';

    END;


	EXPORT Layout_ProfileBooster := RECORD
		Layout_ProfileBoosterV2 version2;
	END;

	EXPORT Layout_PB2_In  := RECORD
		string30  AcctNo;
		unsigned4 seq;
		unsigned6	LexID;
		STRING70	Name_Full;
		STRING5		Name_Title;
		STRING20	Name_First;
		STRING20	Name_Middle;
		STRING20	Name_Last;
		STRING5		Name_Suffix;
		STRING9		ssn;
		STRING8		dob;
		STRING10	phone10;
		STRING120	street_addr;
		String10	streetnumber;
		String2		streetpredirection;
		String28	streetname;
		String4		streetsuffix;
		String2		streetpostdirection;
		String10	unitdesignation;
		String8		unitnumber;
		STRING25	City_name;
		STRING2		st;
		STRING5		z5;
		STRING25	country;
		STRING100	emailAddress;
		unsigned3	HistoryDate;
	END;

	EXPORT Layout_PB2_BatchIn  := RECORD
		string30  AcctNo;
		unsigned6 seq;
		unsigned6 LexID;
		STRING20  Name_First;
		STRING20  Name_Middle;
		STRING20  Name_Last;
		STRING5   Name_Suffix;
		STRING9   ssn;
		STRING8   dob;
		STRING10 	phone10;
		STRING120 street_addr;
		STRING25  City_name;
		STRING2   st;
		STRING5   z5;
		STRING100	emailAddress;
		unsigned3	HistoryDate;
	END;
  
  EXPORT r_layout_input_PlusRaw	:= RECORD
		Layout_PB2_In;
		// add these 3 fields to existing layout anytime i want to use this macro
		string60	Line1;
		string60	LineLast;
		unsigned8	rawAID;
	END;

	EXPORT Layout_PB2_BatchOut := RECORD
		string30 	AcctNo;
		unsigned6	Seq;
		unsigned6 LexID;
		Layout_ProfileBooster 		attributes;
	END;

	EXPORT Layout_PB2_BatchOutFlat := RECORD
		string30 	AcctNo;
		unsigned6	Seq;
		unsigned6	LexID;
		Layout_ProfileBoosterV2;
	END;

	EXPORT Layout_PB2_Shell := RECORD
		Risk_Indicators.Layout_Input;
		unsigned1 rec_type := 1; //1=Prospect, 2=Household, 3=Relative/Associate
		unsigned6 DID2 := 0;
		unsigned8	HHID;
		string12	geoLink;
		string12	relat_geoLink;
    Layout_ProfileBoosterV2;
    HelperAttributes;
	dx_ProfileBooster.Layouts.ProspectEmergenceHelpers;
        STRING10 	hdr_prim_range;
		STRING2  	hdr_predir;
		STRING28  hdr_prim_name;
		STRING4   hdr_addr_suffix;
		STRING2   hdr_postdir;
		STRING10  hdr_unit_desig;
		STRING8   hdr_sec_range;
		STRING5   hdr_z5;		
		STRING4   hdr_zip4;
		STRING25  hdr_city_name;
		STRING2   hdr_st;
		STRING1   hdr_addr_type;
		STRING4   hdr_addr_status;	
		STRING3 	hdr_county;
		STRING7 	hdr_geo_blk;	
		string40	hdr_addr1;
		unsigned8 hdr_rawaid;	
		string20	hdr_lname;	
		UNSIGNED3	hdr_date_first_seen;	
		UNSIGNED3	hdr_date_last_seen;	
		unsigned1	address_history_seq;
		boolean 	inputAddrIsCurrent;
		// STRING10 	curr_prim_range;
		// STRING2  	curr_predir;
		// STRING28  curr_prim_name;
		// STRING4   curr_addr_suffix;
		// STRING2   curr_postdir;
		// STRING10  curr_unit_desig;
		// STRING8   curr_sec_range;
		// STRING25  curr_city_name;
		// STRING2   curr_st;
		// STRING5   curr_z5;
		// STRING4   curr_zip4;
		// STRING1   curr_addr_type;
		// STRING4   curr_addr_status;	
		// STRING3 	curr_county;
		// STRING7 	curr_geo_blk;	
		// UNSIGNED3	curr_date_first_seen;	
		// UNSIGNED3	curr_date_last_seen;	
		UNSIGNED4	curr_AssessedAmount;	
		// STRING10 	prev_prim_range;
		// STRING2  	prev_predir;
		// STRING28  prev_prim_name;
		// STRING4   prev_addr_suffix;
		// STRING2   prev_postdir;
		// STRING10  prev_unit_desig;
		// STRING8   prev_sec_range;
		// STRING25  prev_city_name;
		// STRING2   prev_st;
		// STRING5   prev_z5;
		// STRING4   prev_zip4;
		// STRING1   prev_addr_type;
		// STRING4   prev_addr_status;	
		// STRING3 	prev_county;
		// STRING7 	prev_geo_blk;	
		// UNSIGNED3	prev_date_first_seen;	
		// UNSIGNED3	prev_date_last_seen;	
		UNSIGNED4	prev_AssessedAmount;	
		STRING10 	owned_prim_range;
		STRING2  	owned_predir;
		STRING28  owned_prim_name;
		STRING4   owned_addr_suffix;
		STRING2   owned_postdir;
		STRING10  owned_unit_desig;
		STRING8   owned_sec_range;
		STRING25  owned_city_name;
		STRING2   owned_st;
		STRING5   owned_z5;	
		STRING10 	sold_prim_range;
		STRING2  	sold_predir;
		STRING28  sold_prim_name;
		STRING4   sold_addr_suffix;
		STRING2   sold_postdir;
		STRING10  sold_unit_desig;
		STRING8   sold_sec_range;
		STRING25  sold_city_name;
		STRING2   sold_st;
		STRING5   sold_z5;
		unsigned4 sale_date_by_did;	
		string30 	AcctNo := '';
		unsigned1 firstscore := 0;
		unsigned1 lastscore := 0;
		unsigned1 addrscore := 0;
		unsigned1 phonescore := 0;
		unsigned1 socsscore := 0;	
		unsigned2 firstcount := 0;
		unsigned2 lastcount := 0;
		unsigned2 addrcount := 0;
		unsigned2 phonecount := 0;
		unsigned2 socscount := 0;
		unsigned3	dt_first_seen;
		unsigned3	dt_last_seen;
		unsigned4	dod;
		unsigned4	dodSSA;
		string1 	marital_status;
		string1 	gender;
		String2		DoNotMail;
		String2		VerifiedProspectFound;
		String2		VerifiedName;
		String2		VerifiedSSN;
		String2		VerifiedPhone;
		string		veremail;  
		unsigned	email_score;
		unsigned	email_count;
		String2		VerifiedCurrResMatchIndex := '0';
		String4		ProspectTimeOnRecord;
		String3		ProspectTimeLastUpdate;
		String2		ProspectLastUpdate12Mo;
		Unsigned1	ProspectAge;
		String2		ProspectGender;
		String2		ProspectMaritalStatus;
		String2		ProspectEstimatedIncomeRange;
		String2		ProspectDeceased;
		String2		ProspectCollegeAttending;
		String2		ProspectCollegeAttended;
		String2		ProspectCollegeProgramType;
		String2		ProspectCollegePrivate;
		String2		ProspectCollegeTier;
		// String6		DemBankingIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
		String2		AssetCurrOwner;
		Unsigned1	PropCurrOwner;
		Unsigned1 PropCurrOwnedCnt;
		Unsigned4	PropCurrOwnedAssessedTtl;
		Unsigned4	PropCurrOwnedAVMTtl;
		Unsigned3 PropTimeLastSale;
		Unsigned2 PropEverOwnedCnt;
		Unsigned2 PropEverSoldCnt;
		Unsigned2 PropSoldCnt12Mo;
		String5		PropSoldRatio;
		Unsigned2 PropPurchaseCnt12Mo;
		Unsigned2	PPCurrOwner;
		Unsigned2 PPCurrOwnedCnt;
		Unsigned2 PPCurrOwnedAutoCnt;
		Unsigned2 PPCurrOwnedMtrcycleCnt;
		Unsigned2 PPCurrOwnedAircrftCnt;
		Unsigned2 PPCurrOwnedWtrcrftCnt;
		Unsigned1	ResCurrOwnershipIndex;
		Unsigned4	ResCurrAVMValue;
		Unsigned4	ResCurrAVMValue12Mo;
		String5		ResCurrAVMRatioDiff12Mo;
		Unsigned4	ResCurrAVMValue60Mo;
		String5		ResCurrAVMRatioDiff60Mo;
		String5		ResCurrAVMCntyRatio;
		String5		ResCurrAVMTractRatio;
		String5		ResCurrAVMBlockRatio;
		String2		ResCurrDwellType;
		String2		ResCurrDwellTypeIndex;
		String2		ResCurrMortgageType;
		Unsigned4	ResCurrMortgageAmount;
		Unsigned2	ResCurrBusinessCnt;
		// Unsigned1	ResInputOwnershipIndex;
		// Unsigned4	ResInputAVMValue;
		Unsigned4	ResInputAVMValue12Mo;
		String5		ResInputAVMRatioDiff12Mo;
		Unsigned4	ResInputAVMValue60Mo;
		String5		ResInputAVMRatioDiff60Mo;
		// String5		ResInputAVMCntyRatio;
		// String5		ResInputAVMTractRatio;
		// String5		ResInputAVMBlockRatio;
		// String2		ResInputDwellType;
		// String2		ResInputDwellTypeIndex;
		String2		ResInputMortgageType;
		Unsigned4	ResInputMortgageAmount;
		// Unsigned2	ResInputBusinessCnt;	
		Unsigned2	CrtRecCnt;
		Unsigned2	CrtRecCnt12Mo;
		Unsigned3 CrtRecTimeNewest;
		Unsigned2	CrtRecFelonyCnt;
		Unsigned2	CrtRecFelonyCnt12Mo;
		Unsigned3 CrtRecFelonyTimeNewest;
		Unsigned2	CrtRecMsdmeanCnt;
		Unsigned2	CrtRecMsdmeanCnt12Mo;
		Unsigned3 CrtRecMsdmeanTimeNewest;
		Unsigned2	CrtRecEvictionCnt;
		Unsigned2	CrtRecEvictionCnt12Mo;
		Unsigned3 CrtRecEvictionTimeNewest;
		Unsigned2	CrtRecLienJudgCnt;
		Unsigned2	CrtRecLienJudgCnt12Mo;
		Unsigned3 CrtRecLienJudgTimeNewest;
		Unsigned4 CrtRecLienJudgAmtTtl;
		Unsigned2	CrtRecBkrptCnt;
		Unsigned2	CrtRecBkrptCnt12Mo;
		Unsigned3	CrtRecBkrptTimeNewest;
		String2		CrtRecSeverityIndex;
		// Unsigned1	OccProfLicense;
		// String2		OccProfLicenseCategory;
		// Unsigned1	OccBusinessAssociation;
		// Unsigned3	OccBusinessAssociationTime;
		// Unsigned1	OccBusinessTitleLeadership;
    // Unsigned2 HHTeenagerMmbrCnt;
		// Unsigned2 HHYoungAdultMmbrCnt;
		// Unsigned2 HHMiddleAgemmbrCnt;
		// Unsigned2 HHSeniorMmbrCnt;
		// Unsigned2 HHElderlyMmbrCnt;
		Unsigned2 HHCnt;
		String2		HHEstimatedIncomeRange;
		Unsigned2 HHCollegeAttendedMmbrCnt;
		Unsigned2 HHCollege2yrAttendedMmbrCnt;
		Unsigned2 HHCollege4yrAttendedMmbrCnt;
		Unsigned2 HHCollegeGradAttendedMmbrCnt;
		Unsigned2 HHCollegePrivateMmbrCnt;
		// Unsigned2	HHCollegeTierMmbrHighest;
		Unsigned2 HHPropCurrOwnerMmbrCnt;
		Unsigned2 HHPropCurrOwnedCnt;
		Unsigned4	HHPropCurrAVMHighest;
		Unsigned2 HHPPCurrOwnedCnt;
		Unsigned2 HHPPCurrOwnedAutoCnt;
		Unsigned2 HHPPCurrOwnedMtrcycleCnt;
		Unsigned2 HHPPCurrOwnedAircrftCnt;
		Unsigned2 HHPPCurrOwnedWtrcrftCnt;
		Unsigned2 HHCrtRecMmbrCnt;
		Unsigned2 HHCrtRecMmbrCnt12Mo;
		Unsigned2 HHCrtRecFelonyMmbrCnt;
		Unsigned2 HHCrtRecFelonyMmbrCnt12Mo;
		Unsigned2 HHCrtRecMsdmeanMmbrCnt;
		Unsigned2 HHCrtRecMsdmeanMmbrCnt12Mo;
		Unsigned2 HHCrtRecEvictionMmbrCnt;
		Unsigned2 HHCrtRecEvictionMmbrCnt12Mo;
		Unsigned2 HHCrtRecLienJudgMmbrCnt;
		Unsigned2 HHCrtRecLienJudgMmbrCnt12Mo;
		Unsigned8	HHDrgLnJAmtTot;
		// Unsigned8	HHCrtRecLienJudgAmtTtl;
		Unsigned2 HHCrtRecBkrptMmbrCnt;
		Unsigned2 HHCrtRecBkrptMmbrCnt12Mo;
		Unsigned2 HHCrtRecBkrptMmbrCnt24Mo;
		Unsigned2 HHOccProfLicMmbrCnt;
		Unsigned2 HHOccBusinessAssocMmbrCnt;
		Unsigned2 HHInterestSportPersonMmbrCnt;	
		Unsigned2 RaATeenageMmbrCnt;
		Unsigned2 RaAYoungAdultMmbrCnt;
		Unsigned2 RaAMiddleAgeMmbrCnt;
		Unsigned2 RaASeniorMmbrCnt;
		Unsigned2 RaAElderlyMmbrCnt;
		Unsigned2 RaAHHCnt;
		Unsigned2 RaAMmbrCnt;
		Unsigned6	RaAMedIncomeRange;
		Unsigned2 RaACollegeAttendedMmbrCnt;
		Unsigned2 RaACollege2yrAttendedMmbrCnt;
		Unsigned2 RaACollege4yrAttendedMmbrCnt;
		Unsigned2 RaACollegeGradAttendedMmbrCnt;
		Unsigned2 RaACollegePrivateMmbrCnt;
		Unsigned2 RaACollegeTopTierMmbrCnt;
		Unsigned2 RaACollegeMidTierMmbrCnt;
		Unsigned2 RaACollegeLowTierMmbrCnt;
		Unsigned2 RaAPropCurrOwnerMmbrCnt;
		Unsigned4	RaAPropOwnerAVMHighest;
		Unsigned4	RaAPropOwnerAVMMed;
		Unsigned2 RaAPPCurrOwnerMmbrCnt;
		Unsigned2 RaAPPCurrOwnerAutoMmbrCnt;
		Unsigned2 RaAPPCurrOwnerMtrcycleMmbrCnt;
		Unsigned2 RaAPPCurrOwnerAircrftMmbrCnt;
		Unsigned2 RaAPPCurrOwnerWtrcrftMmbrCnt;
		Unsigned2 RaACrtRecMmbrCnt;
		Unsigned2 RaACrtRecMmbrCnt12Mo;
		Unsigned2 RaACrtRecFelonyMmbrCnt;
		Unsigned2 RaACrtRecFelonyMmbrCnt12Mo;
		Unsigned2 RaACrtRecMsdmeanMmbrCnt;
		Unsigned2 RaACrtRecMsdmeanMmbrCnt12Mo;
		Unsigned2 RaACrtRecEvictionMmbrCnt;
		Unsigned2 RaACrtRecEvictionMmbrCnt12Mo;
		Unsigned2 RaACrtRecLienJudgMmbrCnt;
		Unsigned2 RaACrtRecLienJudgMmbrCnt12Mo;
		Unsigned8	RaACrtRecLienJudgAmtMax;
		Unsigned2 RaACrtRecBkrptMmbrCnt36Mo;
		Unsigned2 RaAOccProfLicMmbrCnt;
		Unsigned2 RaAOccBusinessAssocMmbrCnt;
		Unsigned2 RaAInterestSportPersonMmbrCnt;	
		
		string25 PPCurrOwnedAutoVIN;
		string4 PPCurrOwnedAutoYear;
		string36 PPCurrOwnedAutoMake;
		string30 PPCurrOwnedAutoModel;
		string20 PPCurrOwnedAutoSeries;
		string25 PPCurrOwnedAutoType;
    
    // ProspectPurchaseBehavior;		
    // ProspectVehicle;		
    // ProspectDemographicEducation;
    dx_ProfileBooster.Layouts.Address_Extended;
    UNSIGNED8 rawaid;
	END;

END;