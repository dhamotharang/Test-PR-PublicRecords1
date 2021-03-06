EXPORT Global_Output_Layouts :=module
import models, Risk_Indicators, Business_Risk, ut, riskwise, riskview, RiskProcessing, iESP, Address_Shell, Business_Risk_BIP, ProfileBooster;

//********************************************FCRA PRODUCTS LAYOUTS *****************************************************************************

Export FCRA_RiskView_Generic_allflagships_Attributes_V5_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
	
string accountnumber;
	// riskview.layouts.layout_riskview5_batch_response;
// layout_riskview5_batch_response;
	string30 acctno;
	riskview.layouts.layout_riskview5-Risk_Indicators.Layouts_Derog_Info.LNR_AttrIbutes;
	STRING errorcode;
	RiskProcessing.layout_internal_extras;
END;

// layout_riskview5_batch_response := record

// end;





Export FCRA_RiskView_Capone_allflagships_Attributes_V5_Batch_Layout:=RECORD
	// string accountnumber;
	// riskview.layouts.layout_RV5capOneBatch_searchResults-seq;
	unsigned8 time_ms := 0;  
		
		string30  AcctNo;
	string12  LexID;
	riskview.layouts.layout_RV5capOneBatch_modelResults-seq;  //Seq was used in the service to join the model results back to attribute results.
	riskview.layouts.layout_riskview_attributes_5-Risk_Indicators.Layouts_Derog_Info.LNR_AttrIbutes;
  riskview.layouts.layout_riskview5_alerts-ConsumerStatementText;
	STRING errorcode;
	RiskProcessing.layout_internal_extras;
END;

EXPORT ProfileBooster_layout := RECORD
	unsigned8 time_ms := 0;  

	ProfileBooster.Layouts.Layout_PB_BatchOutFlat;
	STRING errorcode;
END;


Export FCRA_RiskView_XML_Santander_RVA1304_2_V3_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

	STRING30 acctNo;
	string3 RV_score_auto;
	string3 RV_auto_reason;
	string3 RV_auto_reason2;
	string3 RV_auto_reason3;
	string3 RV_auto_reason4;
	string3 RV_auto_reason5;
	// string3 RV_score_bank;
	// string3 RV_bank_reason;
	// string3 RV_bank_reason2;
	// string3 RV_bank_reason3;
	// string3 RV_bank_reason4;
	// string3 RV_bank_reason5;	
	// string3 RV_score_retail;
	// string3 RV_retail_reason;
	// string3 RV_retail_reason2;
	// string3 RV_retail_reason3;
	// string3 RV_retail_reason4;
	// string3 RV_retail_reason5;
	// string3 RV_score_telecom;
	// string3 RV_telecom_reason;
	// string3 RV_telecom_reason2;
	// string3 RV_telecom_reason3;
	// string3 RV_telecom_reason4;
	// string3 RV_telecom_reason5;	
	// string3 RV_score_money;
	// string3 RV_money_reason;
	// string3 RV_money_reason2;
	// string3 RV_money_reason3;
	// string3 RV_money_reason4;
	// string3 RV_money_reason5;
	// string3 RV_score_prescreen;
	// string3 RV_prescreen_reason;

	STRING errorcode;
		RiskProcessing.layout_internal_extras;


END;

Export FCRA_RiskView_XML_Santander_RVA1304_1_V3_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
	
	STRING30 acctNo;
	string3 RV_score_auto;
	string3 RV_auto_reason;
	string3 RV_auto_reason2;
	string3 RV_auto_reason3;
	string3 RV_auto_reason4;
	string3 RV_auto_reason5;
	// string3 RV_score_bank;
	// string3 RV_bank_reason;
	// string3 RV_bank_reason2;
	// string3 RV_bank_reason3;
	// string3 RV_bank_reason4;
	// string3 RV_bank_reason5;	
	// string3 RV_score_retail;
	// string3 RV_retail_reason;
	// string3 RV_retail_reason2;
	// string3 RV_retail_reason3;
	// string3 RV_retail_reason4;
	// string3 RV_retail_reason5;
	// string3 RV_score_telecom;
	// string3 RV_telecom_reason;
	// string3 RV_telecom_reason2;
	// string3 RV_telecom_reason3;
	// string3 RV_telecom_reason4;
	// string3 RV_telecom_reason5;	
	// string3 RV_score_money;
	// string3 RV_money_reason;
	// string3 RV_money_reason2;
	// string3 RV_money_reason3;
	// string3 RV_money_reason4;
	// string3 RV_money_reason5;
	// string3 RV_score_prescreen;
	// string3 RV_prescreen_reason;
	STRING errorcode;
		RiskProcessing.layout_internal_extras;


END;

Export FCRA_RiskView_XML_T_mobile_RVT1210_1_V4_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
	
	STRING30 acctNo;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_telecom_reason5;	
	STRING errorcode;
		RiskProcessing.layout_internal_extras;
	END;

Export FCRA_RiskView_XML_T_mobile_RVT1212_1_V4_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
	
	STRING30 acctNo;
	// string3 RV_score_auto;
	// string3 RV_auto_reason;
	// string3 RV_auto_reason2;
	// string3 RV_auto_reason3;
	// string3 RV_auto_reason4;
	// string3 RV_auto_reason5;
	// string3 RV_score_bank;
	// string3 RV_bank_reason;
	// string3 RV_bank_reason2;
	// string3 RV_bank_reason3;
	// string3 RV_bank_reason4;
	// string3 RV_bank_reason5;	
	// string3 RV_score_retail;
	// string3 RV_retail_reason;
	// string3 RV_retail_reason2;
	// string3 RV_retail_reason3;
	// string3 RV_retail_reason4;
	// string3 RV_retail_reason5;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_telecom_reason5;	
	// string3 RV_score_money;
	// string3 RV_money_reason;
	// string3 RV_money_reason2;
	// string3 RV_money_reason3;
	// string3 RV_money_reason4;
	// string3 RV_money_reason5;
	// string3 RV_score_prescreen;
	// string3 RV_prescreen_reason;
		STRING errorcode;
		RiskProcessing.layout_internal_extras;


END;


Export FCRA_RiskView_XML_CreditAcceptancecorp_Attributes_V2_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

	string30 AccountNumber;

	string8 SSNFirstSeen;
	string8 DateLastSeen;
	string1 isRecentUpdate;
	string2 NumSources;
	string1 isPhoneFullNameMatch;
	string1 isPhoneLastNameMatch;
	string1 isSSNInvalid;
	string1 isPhoneInvalid;
	string1 isAddrInvalid;
	string1 isDLInvalid;
	string1 isNoVer;
	
	string1 isDeceased;
	string8 DeceasedDate;
	string1 isSSNValid;
	string1 isRecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 isNonUS;
	string1 isIssued3;
	string1 isIssuedAge5;

	string6 IADateFirstReported;
	string6 IADateLastReported;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string10 IAAssessedValue;
	string1 IAisOwnedBySubject;
	string1 IAisFamilyOwned;
	string1 IAisOccupantOwned;
	string8 IALastSaleDate;
	string10 IALastSaleAmount;
	string1 IAisNotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string6 CADateFirstReported;
	string6 CADateLastReported;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string10 CAAssessedValue;
	string1 CAisOwnedBySubject;
	string1 CAisFamilyOwned;
	string1 CAisOccupantOwned;
	string8 CALastSaleDate;
	string10 CALastSaleAmount;
	string1 CAisNotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string6 PADateFirstReported;
	string6 PADateLastReported;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string10 PAAssessedValue;
	string1 PAisOwnedBySubject;
	string1 PAisFamilyOwned;
	string1 PAisOccupantOwned;
	string8 PALastSaleDate;
	string10 PALastSaleAmount;
	string1 PAisNotPrimaryRes;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 isInputCurrMatch;
	string4 DistInputCurr;
	string1 isDiffState;
	string10 AssessedDiff;
	string2 EcoTrajectory;
	
	string1 isInputPrevMatch;
	string4 DistCurrPrev;
	string1 isDiffState2;
	string10 AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string6 PADateFirstReported2;
	string6 NPADateFirstReported;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string13 property_owned_assessed_total;
	string3 property_historically_owned;
	string8 date_first_purchase;
	string8 date_most_recent_purchase;
	string8 date_most_recent_sale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string8 date_last_derog;
	
	string3 felonies;
	string8 date_last_conviction;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string8 date_last_unreleased;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string8 date_last_released;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string8 date_last_bankruptcy;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string8 date_last_eviction;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string8 date_last_proflic;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 isAddrHighRisk;
	string1 isPhoneHighRisk;
	string1 isAddrPrison;
	string1 isZipPOBox;
	string1 isZipCorpMil;
	string1 phoneStatus;
	string1 isPhonePager;
	string1 isPhoneMobile;
	string1 isPhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	string1 negativeAlert;
	string1 idTheftFlag;
		
	string6 history_date;
	
	string200 errorcode;
		RiskProcessing.layout_internal_extras;
END;
		

Export FCRA_RiskView_BATCH_Capitalone_Attributes_V3_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

	string30 AccountNumber;
  string4 ageoldestrecord;
  string4 agenewestrecord;
  string1 isrecentupdate;
  string3 numsources;
  string1 verifiedphonefullname;
  string1 verifiedphonelastname;
  string1 invalidssn;
  string1 invalidphone;
  string1 invalidaddr;
  string1 invaliddl;
  string1 isnover;
  string1 ssndeceased;
  string8 deceaseddate;
  string1 ssnvalid;
  string1 recentissue;
  string8 lowissuedate;
  string8 highissuedate;
  string2 issuestate;
  string1 nonus;
  string1 issued3;
  string1 issuedage5;
  string4 iaageoldestrecord;
  string4 iaagenewestrecord;
  string4 ialenofres;
  string1 iadwelltype;
  string1 ialandusecode;
  string iaassessedvalue;
  string1 iaownedbysubject;
  string1 iafamilyowned;
  string1 iaoccupantowned;
  string4 iaagelastsale;
  string ialastsaleamount;
  string1 ianotprimaryres;
  string1 iaphonelisted;
  string10 iaphonenumber;
  string4 caageoldestrecord;
  string4 caagenewestrecord;
  string4 calenofres;
  string1 cadwelltype;
  string1 calandusecode;
  string caassessedvalue;
  string1 caownedbysubject;
  string1 cafamilyowned;
  string1 caoccupantowned;
  string4 caagelastsale;
  string calastsaleamount;
  string1 canotprimaryres;
  string1 caphonelisted;
  string10 caphonenumber;
  string4 paageoldestrecord;
  string4 paagenewestrecord;
  string4 palenofres;
  string1 padwelltype;
  string1 palandusecode;
  string paassessedvalue;
  string1 paownedbysubject;
  string1 pafamilyowned;
  string1 paoccupantowned;
  string4 paagelastsale;
  string palastsaleamount;
  string1 paphonelisted;
  string10 paphonenumber;
  string1 inputcurrmatch;
  string distinputcurr;
  string1 diffstate;
  string assesseddiff;
  string2 ecotrajectory;
  string1 inputprevmatch;
  string distcurrprev;
  string1 diffstate2;
  string assesseddiff2;
  string2 ecotrajectory2;
  string1 mobility_indicator;
  string1 statusaddr;
  string1 statusaddr2;
  string1 statusaddr3;
  string3 addrchanges30;
  string3 addrchanges90;
  string3 addrchanges180;
  string3 addrchanges12;
  string3 addrchanges24;
  string3 addrchanges36;
  string3 addrchanges60;
  string3 property_owned_total;
  string14 property_owned_assessed_total;
  string3 property_historically_owned;
  string4 propageoldestpurchase;
  string4 propagenewestpurchase;
  string4 propagenewestsale;
  string3 numpurchase30;
  string3 numpurchase90;
  string3 numpurchase180;
  string3 numpurchase12;
  string3 numpurchase24;
  string3 numpurchase36;
  string3 numpurchase60;
  string3 numsold30;
  string3 numsold90;
  string3 numsold180;
  string3 numsold12;
  string3 numsold24;
  string3 numsold36;
  string3 numsold60;
  string3 numwatercraft;
  string3 numwatercraft30;
  string3 numwatercraft90;
  string3 numwatercraft180;
  string3 numwatercraft12;
  string3 numwatercraft24;
  string3 numwatercraft36;
  string3 numwatercraft60;
  string3 numaircraft;
  string3 numaircraft30;
  string3 numaircraft90;
  string3 numaircraft180;
  string3 numaircraft12;
  string3 numaircraft24;
  string3 numaircraft36;
  string3 numaircraft60;
  string1 wealth_indicator;
  string3 total_number_derogs;
  string4 derogage;
  string3 felonies;
  string4 felonyage;
  string3 felonies30;
  string3 felonies90;
  string3 felonies180;
  string3 felonies12;
  string3 felonies24;
  string3 felonies36;
  string3 felonies60;
  string3 num_liens;
  string3 num_unreleased_liens;
  string4 lienfiledage;
  string3 num_unreleased_liens30;
  string3 num_unreleased_liens90;
  string3 num_unreleased_liens180;
  string3 num_unreleased_liens12;
  string3 num_unreleased_liens24;
  string3 num_unreleased_liens36;
  string3 num_unreleased_liens60;
  string3 num_released_liens;
  string4 lienreleasedage;
  string3 num_released_liens30;
  string3 num_released_liens90;
  string3 num_released_liens180;
  string3 num_released_liens12;
  string3 num_released_liens24;
  string3 num_released_liens36;
  string3 num_released_liens60;
  string3 bankruptcy_count;
  string4 bankruptcyage;
  string1 filing_type;
  string35 disposition;
  string3 bankruptcy_count30;
  string3 bankruptcy_count90;
  string3 bankruptcy_count180;
  string3 bankruptcy_count12;
  string3 bankruptcy_count24;
  string3 bankruptcy_count36;
  string3 bankruptcy_count60;
  string3 eviction_count;
  string4 evictionage;
  string3 eviction_count30;
  string3 eviction_count90;
  string3 eviction_count180;
  string3 eviction_count12;
  string3 eviction_count24;
  string3 eviction_count36;
  string3 eviction_count60;
  string3 num_nonderogs;
  string3 num_nonderogs30;
  string3 num_nonderogs90;
  string3 num_nonderogs180;
  string3 num_nonderogs12;
  string3 num_nonderogs24;
  string3 num_nonderogs36;
  string3 num_nonderogs60;
  string3 num_proflic;
  string4 proflicage;
  string60 proflic_type;
  string8 expire_date_last_proflic;
  string3 num_proflic30;
  string3 num_proflic90;
  string3 num_proflic180;
  string3 num_proflic12;
  string3 num_proflic24;
  string3 num_proflic36;
  string3 num_proflic60;
  string3 num_proflic_exp30;
  string3 num_proflic_exp90;
  string3 num_proflic_exp180;
  string3 num_proflic_exp12;
  string3 num_proflic_exp24;
  string3 num_proflic_exp36;
  string3 num_proflic_exp60;
  string1 addrhighrisk;
  string1 phonehighrisk;
  string1 addrprison;
  string1 zippobox;
  string1 zipcorpmil;
  string1 phonestatus;
  string1 phonepager;
  string1 phonemobile;
  string1 phonezipmismatch;
  string4 phoneaddrdist;
  string1 correctedflag;
  string1 securityfreeze;
  string1 securityalert;
  string1 idtheftflag;
  string1 ssnnotfound;
  string3 verifiedname;
  string3 verifiedssn;
  string3 verifiedphone;
  string3 verifiedaddress;
  string3 verifieddob;
  string3 inferredminimumage;
  string3 bestreportedage;
  string3 subjectssncount;
  string3 subjectaddrcount;
  string3 subjectphonecount;
  string3 subjectssnrecentcount;
  string3 subjectaddrrecentcount;
  string3 subjectphonerecentcount;
  string3 ssnidentitiescount;
  string3 ssnaddrcount;
  string3 ssnidentitiesrecentcount;
  string3 ssnaddrrecentcount;
  string3 inputaddridentitiescount;
  string3 inputaddrssncount;
  string3 inputaddrphonecount;
  string3 inputaddridentitiesrecentcount;
  string3 inputaddrssnrecentcount;
  string3 inputaddrphonerecentcount;
  string3 phoneidentitiescount;
  string3 phoneidentitiesrecentcount;
  string1 ssnissuedpriordob;
  string4 inputaddrtaxyr;
  string14 inputaddrtaxmarketvalue;
  string14 inputaddravmtax;
  string14 inputaddravmsalesprice;
  string14 inputaddravmhedonic;
  string14 inputaddravmvalue;
  string3 inputaddravmconfidence;
  string8 inputaddrcountyindex;
  string8 inputaddrtractindex;
  string8 inputaddrblockindex;
  string4 curraddrtaxyr;
  string14 curraddrtaxmarketvalue;
  string14 curraddravmtax;
  string14 curraddravmsalesprice;
  string14 curraddravmhedonic;
  string14 curraddravmvalue;
  string3 curraddravmconfidence;
  string8 curraddrcountyindex;
  string8 curraddrtractindex;
  string8 curraddrblockindex;
  string4 prevaddrtaxyr;
  string14 prevaddrtaxmarketvalue;
  string14 prevaddravmtax;
  string14 prevaddravmsalesprice;
  string14 prevaddravmhedonic;
  string14 prevaddravmvalue;
  string3 prevaddravmconfidence;
  string8 prevaddrcountyindex;
  string8 prevaddrtractindex;
  string8 prevaddrblockindex;
  string1 educationattendedcollege;
  string1 educationprogram2yr;
  string1 educationprogram4yr;
  string1 educationprogramgraduate;
  string1 educationinstitutionprivate;
  string1 educationinstitutionrating;
  string predictedannualincome;
  string14 propnewestsaleprice;
  string8 propnewestsalepurchaseindex;
  string3 subprimesolicitedcount;
  string3 subprimesolicitedcount01;
  string3 subprimesolicitedcount03;
  string3 subprimesolicitedcount06;
  string3 subprimesolicitedcount12;
  string3 subprimesolicitedcount24;
  string3 subprimesolicitedcount36;
  string3 subprimesolicitedcount60;
  string14 lienfederaltaxfiledtotal;
  string14 lientaxotherfiledtotal;
  string14 lienforeclosurefiledtotal;
  string14 lienpreforeclosurefiledtotal;
  string14 lienlandlordtenantfiledtotal;
  string14 lienjudgmentfiledtotal;
  string14 liensmallclaimsfiledtotal;
  string14 lienotherfiledtotal;
  string14 lienfederaltaxreleasedtotal;
  string14 lientaxotherreleasedtotal;
  string14 lienforeclosurereleasedtotal;
  string14 lienpreforeclosurereleasedtotal;
  string14 lienlandlordtenantreleasedtotal;
  string14 lienjudgmentreleasedtotal;
  string14 liensmallclaimsreleasedtotal;
  string14 lienotherreleasedtotal;
  string3 lienfederaltaxfiledcount;
  string3 lientaxotherfiledcount;
  string3 lienforeclosurefiledcount;
  string3 lienpreforeclosurefiledcount;
  string3 lienlandlordtenantfiledcount;
  string3 lienjudgmentfiledcount;
  string3 liensmallclaimsfiledcount;
  string3 lienotherfiledcount;
  string3 lienfederaltaxreleasedcount;
  string3 lientaxotherreleasedcount;
  string3 lienforeclosurereleasedcount;
  string3 lienpreforeclosurereleasedcount;
  string3 lienlandlordtenantreleasedcount;
  string3 lienjudgmentreleasedcount;
  string3 liensmallclaimsreleasedcount;
  string3 lienotherreleasedcount;
  string1 proflictypecategory;
  string4 phoneedaageoldestrecord;
  string4 phoneedaagenewestrecord;
  string4 phoneotherageoldestrecord;
  string4 phoneotheragenewestrecord;
  string1 prescreenoptout;
  string6 history_date;
  string200 errorcode;	
	
		RiskProcessing.layout_internal_extras;
END;
	
	

Export FCRA_RiskView_BATCH_Capitalone_Attributes_V2_Global_Layout:=RECORD

	unsigned8 time_ms := 0;  

	string30 AccountNumber;

	string8 SSNFirstSeen;
	string8 DateLastSeen;
	string1 isRecentUpdate;
	string2 NumSources;
	string1 isPhoneFullNameMatch;
	string1 isPhoneLastNameMatch;
	string1 isSSNInvalid;
	string1 isPhoneInvalid;
	string1 isAddrInvalid;
	string1 isDLInvalid;
	string1 isNoVer;
	
	string1 isDeceased;
	string8 DeceasedDate;
	string1 isSSNValid;
	string1 isRecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 isNonUS;
	string1 isIssued3;
	string1 isIssuedAge5;

	string6 IADateFirstReported;
	string6 IADateLastReported;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string10 IAAssessedValue;
	string1 IAisOwnedBySubject;
	string1 IAisFamilyOwned;
	string1 IAisOccupantOwned;
	string8 IALastSaleDate;
	string10 IALastSaleAmount;
	string1 IAisNotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string6 CADateFirstReported;
	string6 CADateLastReported;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string10 CAAssessedValue;
	string1 CAisOwnedBySubject;
	string1 CAisFamilyOwned;
	string1 CAisOccupantOwned;
	string8 CALastSaleDate;
	string10 CALastSaleAmount;
	string1 CAisNotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string6 PADateFirstReported;
	string6 PADateLastReported;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string10 PAAssessedValue;
	string1 PAisOwnedBySubject;
	string1 PAisFamilyOwned;
	string1 PAisOccupantOwned;
	string8 PALastSaleDate;
	string10 PALastSaleAmount;
	string1 PAisNotPrimaryRes;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 isInputCurrMatch;
	string4 DistInputCurr;
	string1 isDiffState;
	string10 AssessedDiff;
	string2 EcoTrajectory;
	
	string1 isInputPrevMatch;
	string4 DistCurrPrev;
	string1 isDiffState2;
	string10 AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string6 PADateFirstReported2;
	string6 NPADateFirstReported;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string13 property_owned_assessed_total;
	string3 property_historically_owned;
	string8 date_first_purchase;
	string8 date_most_recent_purchase;
	string8 date_most_recent_sale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string8 date_last_derog;
	
	string3 felonies;
	string8 date_last_conviction;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string8 date_last_unreleased;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string8 date_last_released;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string8 date_last_bankruptcy;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string8 date_last_eviction;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string8 date_last_proflic;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 isAddrHighRisk;
	string1 isPhoneHighRisk;
	string1 isAddrPrison;
	string1 isZipPOBox;
	string1 isZipCorpMil;
	string1 phoneStatus;
	string1 isPhonePager;
	string1 isPhoneMobile;
	string1 isPhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	string1 negativeAlert;
	string1 idTheftFlag;
		
	string6 history_date;
	
	string200 errorcode;
	
	
		RiskProcessing.layout_internal_extras;
END;

Export FCRA_RiskView_BATCH_Generic_Attributes_V2_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

string12 DID;
	string30 AccountNumber;

	string8 SSNFirstSeen;
	string8 DateLastSeen;
	string1 isRecentUpdate;
	string2 NumSources;
	string1 isPhoneFullNameMatch;
	string1 isPhoneLastNameMatch;
	string1 isSSNInvalid;
	string1 isPhoneInvalid;
	string1 isAddrInvalid;
	string1 isDLInvalid;
	string1 isNoVer;
	
	string1 isDeceased;
	string8 DeceasedDate;
	string1 isSSNValid;
	string1 isRecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 isNonUS;
	string1 isIssued3;
	string1 isIssuedAge5;

	string6 IADateFirstReported;
	string6 IADateLastReported;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string10 IAAssessedValue;
	string1 IAisOwnedBySubject;
	string1 IAisFamilyOwned;
	string1 IAisOccupantOwned;
	string8 IALastSaleDate;
	string10 IALastSaleAmount;
	string1 IAisNotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string6 CADateFirstReported;
	string6 CADateLastReported;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string10 CAAssessedValue;
	string1 CAisOwnedBySubject;
	string1 CAisFamilyOwned;
	string1 CAisOccupantOwned;
	string8 CALastSaleDate;
	string10 CALastSaleAmount;
	string1 CAisNotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string6 PADateFirstReported;
	string6 PADateLastReported;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string10 PAAssessedValue;
	string1 PAisOwnedBySubject;
	string1 PAisFamilyOwned;
	string1 PAisOccupantOwned;
	string8 PALastSaleDate;
	string10 PALastSaleAmount;
	string1 PAisNotPrimaryRes;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 isInputCurrMatch;
	string4 DistInputCurr;
	string1 isDiffState;
	string10 AssessedDiff;
	string2 EcoTrajectory;
	
	string1 isInputPrevMatch;
	string4 DistCurrPrev;
	string1 isDiffState2;
	string10 AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string6 PADateFirstReported2;
	string6 NPADateFirstReported;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string13 property_owned_assessed_total;
	string3 property_historically_owned;
	string8 date_first_purchase;
	string8 date_most_recent_purchase;
	string8 date_most_recent_sale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string8 date_last_derog;
	
	string3 felonies;
	string8 date_last_conviction;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string8 date_last_unreleased;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string8 date_last_released;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string8 date_last_bankruptcy;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string8 date_last_eviction;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string8 date_last_proflic;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 isAddrHighRisk;
	string1 isPhoneHighRisk;
	string1 isAddrPrison;
	string1 isZipPOBox;
	string1 isZipCorpMil;
	string1 phoneStatus;
	string1 isPhonePager;
	string1 isPhoneMobile;
	string1 isPhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	string1 negativeAlert;
	string1 idTheftFlag;
		
	string6 history_date;
	
	string200 errorcode;
	RiskProcessing.layout_internal_extras;
END;	

Export FCRA_RiskView_XML_ENOVA_rvg1103_0_V4_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

STRING30 acctNo;
	string3 RV_score_auto;
	string3 RV_auto_reason;
	string3 RV_auto_reason2;
	string3 RV_auto_reason3;
	string3 RV_auto_reason4;
	string3 RV_auto_reason5;
	string3 RV_score_bank;
	string3 RV_bank_reason;
	string3 RV_bank_reason2;
	string3 RV_bank_reason3;
	string3 RV_bank_reason4;
	string3 RV_bank_reason5;	
	string3 RV_score_retail;
	string3 RV_retail_reason;
	string3 RV_retail_reason2;
	string3 RV_retail_reason3;
	string3 RV_retail_reason4;
	string3 RV_retail_reason5;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_telecom_reason5;	
	string3 RV_score_money;
	string3 RV_money_reason;
	string3 RV_money_reason2;
	string3 RV_money_reason3;
	string3 RV_money_reason4;
	string3 RV_money_reason5;
	string3 RV_score_prescreen;
	string3 RV_prescreen_reason;
	
	STRING errorcode;
	
		RiskProcessing.layout_internal_extras;
END;	
	
Export FCRA_RiskView_Experian_Attributes_V3_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

unsigned seq;

	string30 AccountNumber;
	
	STRING FirstName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING SSN;
	STRING DateOfBirth;
	STRING DLNumber;
	STRING DLState;
	STRING HomePhone;

	string4 AgeOldestRecord; 
	string4 AgeNewestRecord; 
	string1 isRecentUpdate;
	string3 NumSources;
	string1 VerifiedPhoneFullName;
	string1 VerifiedPhoneLastName;
	string1 InvalidSSN; 
	string1 InvalidPhone; 
	string1 InvalidAddr; 
	string1 InvalidDL; 
	string1 isNoVer;
	
	string1 SSNDeceased;
	string8 DeceasedDate;
	string1 SSNValid;
	string1 RecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 NonUS;
	string1 Issued3;
	string1 IssuedAge5;

	string4 IAAgeOldestRecord;
	string4 IAAgeNewestRecord;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string IAAssessedValue;
	string1 IAOwnedBySubject;
	string1 IAFamilyOwned;
	string1 IAOccupantOwned;
	string4 IAAgeLastSale;
	string IALastSaleAmount;
	string1 IANotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string4 CAAgeOldestRecord;
	string4 CAAgeNewestRecord;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string CAAssessedValue;
	string1 CAOwnedBySubject;
	string1 CAFamilyOwned;
	string1 CAOccupantOwned;
	string4 CAAgeLastSale;
	string CALastSaleAmount;
	string1 CANotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string4 PAAgeOldestRecord;
	string4 PAAgeNewestRecord;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string PAAssessedValue;
	string1 PAOwnedBySubject;
	string1 PAFamilyOwned;
	string1 PAOccupantOwned;
	string4 PAAgeLastSale;
	string PALastSaleAmount;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 InputCurrMatch;
	string DistInputCurr;
	string1 DiffState;
	string AssessedDiff;
	string2 EcoTrajectory;
	
	string1 InputPrevMatch;
	string DistCurrPrev;
	string1 DiffState2;
	string AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string14 property_owned_assessed_total;
	string3 property_historically_owned;
	string4 PropAgeOldestPurchase;
	string4 PropAgeNewestPurchase;
	string4 PropAgeNewestSale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string4 DerogAge;
	
	string3 felonies;
	string4 FelonyAge;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string4 LienFiledAge;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string4 LienReleasedAge;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string4 BankruptcyAge;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string4 EvictionAge;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string4 ProfLicAge;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 AddrHighRisk;
	string1 PhoneHighRisk;
	string1 AddrPrison;
	string1 ZipPOBox;
	string1 ZipCorpMil;
	string1 phoneStatus;
	string1 PhonePager;
	string1 PhoneMobile;
	string1 PhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	//string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	//string1 negativeAlert;
	string1 idTheftFlag;
	
	// new version 3 fields
	string1 SSNNotFound;
	string3 VerifiedName;
	string3 VerifiedSSN;
	string3 VerifiedPhone;
	string3 VerifiedAddress;
	string3 VerifiedDOB;
	string3 InferredMinimumAge;
	string3 BestReportedAge;
	string3 SubjectSSNCount;
	string3 SubjectAddrCount;
	string3 SubjectPhoneCount;
	string3 SubjectSSNRecentCount;
	string3 SubjectAddrRecentCount;
	string3 SubjectPhoneRecentCount;
	string3 SSNIdentitiesCount;
	string3 SSNAddrCount;
	string3 SSNIdentitiesRecentCount;
	string3 SSNAddrRecentCount;
	string3 InputAddrIdentitiesCount;
	string3 InputAddrSSNCount;
	string3 InputAddrPhoneCount;
	string3 InputAddrIdentitiesRecentCount;
	string3 InputAddrSSNRecentCount;
	string3 InputAddrPhoneRecentCount;
	string3 PhoneIdentitiesCount;
	string3 PhoneIdentitiesRecentCount;
	string1 SSNIssuedPriorDOB;
	
	string4 InputAddrTaxYr;
	string14 InputAddrTaxMarketValue;
	string14 InputAddrAVMTax;
	string14 InputAddrAVMSalesPrice;
	string14 InputAddrAVMHedonic;
	string14 InputAddrAVMValue;
	string3 InputAddrAVMConfidence;
	string8 InputAddrCountyIndex;
	string8 InputAddrTractIndex;
	string8 InputAddrBlockIndex;
	
	string4 CurrAddrTaxYr;
	string14 CurrAddrTaxMarketValue;
	string14 CurrAddrAVMTax;
	string14 CurrAddrAVMSalesPrice;
	string14 CurrAddrAVMHedonic;
	string14 CurrAddrAVMValue;
	string3 CurrAddrAVMConfidence;
	string8 CurrAddrCountyIndex;
	string8 CurrAddrTractIndex;
	string8 CurrAddrBlockIndex;
	
	string4 PrevAddrTaxYr;
	string14 PrevAddrTaxMarketValue;
	string14 PrevAddrAVMTax;
	string14 PrevAddrAVMSalesPrice;
	string14 PrevAddrAVMHedonic;
	string14 PrevAddrAVMValue;
	string3 PrevAddrAVMConfidence;
	string8 PrevAddrCountyIndex;
	string8 PrevAddrTractIndex;
	string8 PrevAddrBlockIndex;
	
	string1 EducationAttendedCollege;
	string1 EducationProgram2Yr;
	string1 EducationProgram4Yr;
	string1 EducationProgramGraduate;
	string1 EducationInstitutionPrivate;
	string1 EducationInstitutionRating;
	
	string PredictedAnnualIncome;
	
	string14 PropNewestSalePrice;
	string8 PropNewestSalePurchaseIndex;
	// string8 PropNewestSaleTaxIndex;
	// string8 PropNewestSaleAVMIndex;
	
	string3 SubPrimeSolicitedCount;
	string3 SubPrimeSolicitedCount01;
	string3 SubprimeSolicitedCount03;
	string3 SubprimeSolicitedCount06;
	string3 SubPrimeSolicitedCount12;
	string3 SubPrimeSolicitedCount24;
	string3 SubPrimeSolicitedCount36;
	string3 SubPrimeSolicitedCount60;
	
	string14 LienFederalTaxFiledTotal;
	string14 LienTaxOtherFiledTotal;
	string14 LienForeclosureFiledTotal;
	string14 LienPreforeclosureFiledTotal;
	string14 LienLandlordTenantFiledTotal;
	string14 LienJudgmentFiledTotal;
	string14 LienSmallClaimsFiledTotal;
	string14 LienOtherFiledTotal;
	string14 LienFederalTaxReleasedTotal;
	string14 LienTaxOtherReleasedTotal;
	string14 LienForeclosureReleasedTotal;
	string14 LienPreforeclosureReleasedTotal;
	string14 LienLandlordTenantReleasedTotal;
	string14 LienJudgmentReleasedTotal;
	string14 LienSmallClaimsReleasedTotal;
	string14 LienOtherReleasedTotal;
	
	string3 LienFederalTaxFiledCount;
	string3 LienTaxOtherFiledCount;
	string3 LienForeclosureFiledCount;
	string3 LienPreforeclosureFiledCount;
	string3 LienLandlordTenantFiledCount;
	string3 LienJudgmentFiledCount;
	string3 LienSmallClaimsFiledCount;
	string3 LienOtherFiledCount;
	string3 LienFederalTaxReleasedCount;
	string3 LienTaxOtherReleasedCount;
	string3 LienForeclosureReleasedCount;
	string3 LienPreforeclosureReleasedCount;
	string3 LienLandlordTenantReleasedCount;
	string3 LienJudgmentReleasedCount;
	string3 LienSmallClaimsReleasedCount;
	string3 LienOtherReleasedCount;
	
	string1 ProfLicTypeCategory;
	
	string4 PhoneEDAAgeOldestRecord;
	string4 PhoneEDAAgeNewestRecord;
	string4 PhoneOtherAgeOldestRecord;
	string4 PhoneOtherAgeNewestRecord;
	
	string1 PrescreenOptOut;
	
	string6 history_date;
	
	string200 errorcode;
	
			RiskProcessing.layout_internal_extras;
END;

Export FCRA_RiskView_XML_RegionalAcceptance_RVA1008_1_V4_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

STRING30 acctNo;
	string3 RV_score_auto;
	string3 RV_auto_reason;
	string3 RV_auto_reason2;
	string3 RV_auto_reason3;
	string3 RV_auto_reason4;
	string3 RV_auto_reason5;
	// string3 RV_score_bank;
	// string3 RV_bank_reason;
	// string3 RV_bank_reason2;
	// string3 RV_bank_reason3;
	// string3 RV_bank_reason4;
	// string3 RV_bank_reason5;	
	// string3 RV_score_retail;
	// string3 RV_retail_reason;
	// string3 RV_retail_reason2;
	// string3 RV_retail_reason3;
	// string3 RV_retail_reason4;
	// string3 RV_retail_reason5;
	// string3 RV_score_telecom;
	// string3 RV_telecom_reason;
	// string3 RV_telecom_reason2;
	// string3 RV_telecom_reason3;
	// string3 RV_telecom_reason4;
	// string3 RV_telecom_reason5;	
	// string3 RV_score_money;
	// string3 RV_money_reason;
	// string3 RV_money_reason2;
	// string3 RV_money_reason3;
	// string3 RV_money_reason4;
	// string3 RV_money_reason5;
	// string3 RV_score_prescreen;
	// string3 RV_prescreen_reason;

	STRING errorcode;
	
		RiskProcessing.layout_internal_extras;
		
END;
		

Export FCRA_RiskView_Generic_allflagships_V3_Global_Layout:=RECORD
unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing ;  
 
 STRING30 acctNo;
	string3 RV_score_auto;
	string3 RV_auto_reason;
	string3 RV_auto_reason2;
	string3 RV_auto_reason3;
	string3 RV_auto_reason4;
	string3 RV_score_bank;
	string3 RV_bank_reason;
	string3 RV_bank_reason2;
	string3 RV_bank_reason3;
	string3 RV_bank_reason4;
	string3 RV_score_retail;
	string3 RV_retail_reason;
	string3 RV_retail_reason2;
	string3 RV_retail_reason3;
	string3 RV_retail_reason4;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_score_money;
	string3 RV_money_reason;
	string3 RV_money_reason2;
	string3 RV_money_reason3;
	string3 RV_money_reason4;
	string3 RV_score_prescreen;
	string3 RV_prescreen_reason;
	
	STRING errorcode;
	
		RiskProcessing.layout_internal_extras;
		
END;

Export FCRA_RiskView_Generic_allflagships_V4_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

	STRING30 acctNo;
	string3 RV_score_auto;
	string3 RV_auto_reason;
	string3 RV_auto_reason2;
	string3 RV_auto_reason3;
	string3 RV_auto_reason4;
	string3 RV_auto_reason5;
	string3 RV_score_bank;
	string3 RV_bank_reason;
	string3 RV_bank_reason2;
	string3 RV_bank_reason3;
	string3 RV_bank_reason4;
	string3 RV_bank_reason5;	
	string3 RV_score_retail;
	string3 RV_retail_reason;
	string3 RV_retail_reason2;
	string3 RV_retail_reason3;
	string3 RV_retail_reason4;
	string3 RV_retail_reason5;
	string3 RV_score_telecom;
	string3 RV_telecom_reason;
	string3 RV_telecom_reason2;
	string3 RV_telecom_reason3;
	string3 RV_telecom_reason4;
	string3 RV_telecom_reason5;	
	string3 RV_score_money;
	string3 RV_money_reason;
	string3 RV_money_reason2;
	string3 RV_money_reason3;
	string3 RV_money_reason4;
	string3 RV_money_reason5;
	string3 RV_score_prescreen;
	string3 RV_prescreen_reason;
  STRING errorcode;
		RiskProcessing.layout_internal_extras;
END;

Export FCRA_RiskView_Generic_Attributes_V3_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
	
	unsigned seq;

	string30 AccountNumber;
	
	STRING FirstName;
	STRING LastName;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING SSN;
	STRING DateOfBirth;
	STRING DLNumber;
	STRING DLState;
	STRING HomePhone;

	string4 AgeOldestRecord; 
	string4 AgeNewestRecord; 
	string1 isRecentUpdate;
	string3 NumSources;
	string1 VerifiedPhoneFullName;
	string1 VerifiedPhoneLastName;
	string1 InvalidSSN; 
	string1 InvalidPhone; 
	string1 InvalidAddr; 
	string1 InvalidDL; 
	string1 isNoVer;
	
	string1 SSNDeceased;
	string8 DeceasedDate;
	string1 SSNValid;
	string1 RecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 NonUS;
	string1 Issued3;
	string1 IssuedAge5;

	string4 IAAgeOldestRecord;
	string4 IAAgeNewestRecord;
	string4 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string IAAssessedValue;
	string1 IAOwnedBySubject;
	string1 IAFamilyOwned;
	string1 IAOccupantOwned;
	string4 IAAgeLastSale;
	string IALastSaleAmount;
	string1 IANotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string4 CAAgeOldestRecord;
	string4 CAAgeNewestRecord;
	string4 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string CAAssessedValue;
	string1 CAOwnedBySubject;
	string1 CAFamilyOwned;
	string1 CAOccupantOwned;
	string4 CAAgeLastSale;
	string CALastSaleAmount;
	string1 CANotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string4 PAAgeOldestRecord;
	string4 PAAgeNewestRecord;
	string4 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string PAAssessedValue;
	string1 PAOwnedBySubject;
	string1 PAFamilyOwned;
	string1 PAOccupantOwned;
	string4 PAAgeLastSale;
	string PALastSaleAmount;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 InputCurrMatch;
	string DistInputCurr;
	string1 DiffState;
	string AssessedDiff;
	string2 EcoTrajectory;
	
	string1 InputPrevMatch;
	string DistCurrPrev;
	string1 DiffState2;
	string AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total;
	string14 property_owned_assessed_total;
	string3 property_historically_owned;
	string4 PropAgeOldestPurchase;
	string4 PropAgeNewestPurchase;
	string4 PropAgeNewestSale;
	
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	
	string1 wealth_indicator;

	string3 total_number_derogs;
	string4 DerogAge;
	
	string3 felonies;
	string4 FelonyAge;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	
	string3 num_liens;
	string3 num_unreleased_liens;
	string4 LienFiledAge;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	
	string3 num_released_liens;
	string4 LienReleasedAge;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	
	string3 bankruptcy_count;
	string4 BankruptcyAge;
	STRING1 filing_type;
	STRING35 disposition;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	
	string3 eviction_count;
	string4 EvictionAge;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	
	string3 num_proflic;
	string4 ProfLicAge;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 AddrHighRisk;
	string1 PhoneHighRisk;
	string1 AddrPrison;
	string1 ZipPOBox;
	string1 ZipCorpMil;
	string1 phoneStatus;
	string1 PhonePager;
	string1 PhoneMobile;
	string1 PhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	//string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	//string1 negativeAlert;
	string1 idTheftFlag;
	
	// new version 3 fields
	string1 SSNNotFound;
	string3 VerifiedName;
	string3 VerifiedSSN;
	string3 VerifiedPhone;
	string3 VerifiedAddress;
	string3 VerifiedDOB;
	string3 InferredMinimumAge;
	string3 BestReportedAge;
	string3 SubjectSSNCount;
	string3 SubjectAddrCount;
	string3 SubjectPhoneCount;
	string3 SubjectSSNRecentCount;
	string3 SubjectAddrRecentCount;
	string3 SubjectPhoneRecentCount;
	string3 SSNIdentitiesCount;
	string3 SSNAddrCount;
	string3 SSNIdentitiesRecentCount;
	string3 SSNAddrRecentCount;
	string3 InputAddrIdentitiesCount;
	string3 InputAddrSSNCount;
	string3 InputAddrPhoneCount;
	string3 InputAddrIdentitiesRecentCount;
	string3 InputAddrSSNRecentCount;
	string3 InputAddrPhoneRecentCount;
	string3 PhoneIdentitiesCount;
	string3 PhoneIdentitiesRecentCount;
	string1 SSNIssuedPriorDOB;
	
	string4 InputAddrTaxYr;
	string14 InputAddrTaxMarketValue;
	string14 InputAddrAVMTax;
	string14 InputAddrAVMSalesPrice;
	string14 InputAddrAVMHedonic;
	string14 InputAddrAVMValue;
	string3 InputAddrAVMConfidence;
	string8 InputAddrCountyIndex;
	string8 InputAddrTractIndex;
	string8 InputAddrBlockIndex;
	
	string4 CurrAddrTaxYr;
	string14 CurrAddrTaxMarketValue;
	string14 CurrAddrAVMTax;
	string14 CurrAddrAVMSalesPrice;
	string14 CurrAddrAVMHedonic;
	string14 CurrAddrAVMValue;
	string3 CurrAddrAVMConfidence;
	string8 CurrAddrCountyIndex;
	string8 CurrAddrTractIndex;
	string8 CurrAddrBlockIndex;
	
	string4 PrevAddrTaxYr;
	string14 PrevAddrTaxMarketValue;
	string14 PrevAddrAVMTax;
	string14 PrevAddrAVMSalesPrice;
	string14 PrevAddrAVMHedonic;
	string14 PrevAddrAVMValue;
	string3 PrevAddrAVMConfidence;
	string8 PrevAddrCountyIndex;
	string8 PrevAddrTractIndex;
	string8 PrevAddrBlockIndex;
	
	string1 EducationAttendedCollege;
	string1 EducationProgram2Yr;
	string1 EducationProgram4Yr;
	string1 EducationProgramGraduate;
	string1 EducationInstitutionPrivate;
	string1 EducationInstitutionRating;
	
	string PredictedAnnualIncome;
	
	string14 PropNewestSalePrice;
	string8 PropNewestSalePurchaseIndex;
	// string8 PropNewestSaleTaxIndex;
	// string8 PropNewestSaleAVMIndex;
	
	string3 SubPrimeSolicitedCount;
	string3 SubPrimeSolicitedCount01;
	string3 SubprimeSolicitedCount03;
	string3 SubprimeSolicitedCount06;
	string3 SubPrimeSolicitedCount12;
	string3 SubPrimeSolicitedCount24;
	string3 SubPrimeSolicitedCount36;
	string3 SubPrimeSolicitedCount60;
	
	string14 LienFederalTaxFiledTotal;
	string14 LienTaxOtherFiledTotal;
	string14 LienForeclosureFiledTotal;
	string14 LienPreforeclosureFiledTotal;
	string14 LienLandlordTenantFiledTotal;
	string14 LienJudgmentFiledTotal;
	string14 LienSmallClaimsFiledTotal;
	string14 LienOtherFiledTotal;
	string14 LienFederalTaxReleasedTotal;
	string14 LienTaxOtherReleasedTotal;
	string14 LienForeclosureReleasedTotal;
	string14 LienPreforeclosureReleasedTotal;
	string14 LienLandlordTenantReleasedTotal;
	string14 LienJudgmentReleasedTotal;
	string14 LienSmallClaimsReleasedTotal;
	string14 LienOtherReleasedTotal;
	
	string3 LienFederalTaxFiledCount;
	string3 LienTaxOtherFiledCount;
	string3 LienForeclosureFiledCount;
	string3 LienPreforeclosureFiledCount;
	string3 LienLandlordTenantFiledCount;
	string3 LienJudgmentFiledCount;
	string3 LienSmallClaimsFiledCount;
	string3 LienOtherFiledCount;
	string3 LienFederalTaxReleasedCount;
	string3 LienTaxOtherReleasedCount;
	string3 LienForeclosureReleasedCount;
	string3 LienPreforeclosureReleasedCount;
	string3 LienLandlordTenantReleasedCount;
	string3 LienJudgmentReleasedCount;
	string3 LienSmallClaimsReleasedCount;
	string3 LienOtherReleasedCount;
	
	string1 ProfLicTypeCategory;
	
	string4 PhoneEDAAgeOldestRecord;
	string4 PhoneEDAAgeNewestRecord;
	string4 PhoneOtherAgeOldestRecord;
	string4 PhoneOtherAgeNewestRecord;
	
	string1 PrescreenOptOut;
	
	string6 history_date;
	
	string200 errorcode;
	
	RiskProcessing.layout_internal_extras;

END;

Export FCRA_RiskView_BATCH_Generic_Attributes_V4_Global_Layout:=RECORD
// string12 DID;
	unsigned8 time_ms := 0;  
	
	string30 AccountNumber;

string3	 v4_AgeOldestRecord;
string3	 v4_AgeNewestRecord;
string1	 v4_RecentUpdate;
string3	 v4_SrcsConfirmIDAddrCount;
string2	 v4_InvalidDL;
string1	 v4_VerificationFailure;
string2	 v4_SSNNotFound;
string1	 v4_VerifiedName;
string2	 v4_VerifiedSSN;
string2	 v4_VerifiedPhone;
string2	 v4_VerifiedAddress;
string2	 v4_VerifiedDOB;
string3	 v4_InferredMinimumAge;
string3	 v4_BestReportedAge;
string3	 v4_SubjectSSNCount;
string3	 v4_SubjectAddrCount;
string3	 v4_SubjectPhoneCount;
string3	 v4_SubjectSSNRecentCount;
string3	 v4_SubjectAddrRecentCount;
string3	 v4_SubjectPhoneRecentCount;
string3	 v4_SSNIdentitiesCount;
string3	 v4_SSNAddrCount;
string3	 v4_SSNIdentitiesRecentCount;
string3	 v4_SSNAddrRecentCount;
string3	 v4_InputAddrPhoneCount;
string3	 v4_InputAddrPhoneRecentCount;
string3	 v4_PhoneIdentitiesCount;
string3	 v4_PhoneIdentitiesRecentCount;
string3	 v4_SSNAgeDeceased;	 // was named SSNDateDeceased	 in version3
string2	 v4_SSNRecent;
string3	 v4_SSNLowIssueAge;	 // was named SSNLowIssueDate	 in version3
string3	 v4_SSNHighIssueAge;	 // was named SSNHighIssueDate	 in version3
string2	 v4_SSNIssueState;
string2	 v4_SSNNonUS;
string2	 v4_SSN3Years;
string2	 v4_SSNAfter5 ;
string2	 v4_SSNProblems;	 // new to 4.0	
string3	 v4_InputAddrAgeOldestRecord;
string3	 v4_InputAddrAgeNewestRecord;
string2	 v4_InputAddrHistoricalMatch;	// new to 4.0	
string3	 v4_InputAddrLenOfRes ;
string2	 v4_InputAddrDwellType ;
string2	 v4_InputAddrDelivery;	 // new to 4.0	
string2	 v4_InputAddrApplicantOwned;
string2	 v4_InputAddrFamilyOwned;
string2	 v4_InputAddrOccupantOwned ;
string3	 v4_InputAddrAgeLastSale;
string10	 v4_InputAddrLastSalesPrice;
string2	 v4_InputAddrMortgageType;	 // new to 4.0	
string2	 v4_InputAddrNotPrimaryRes ;
string2	 v4_InputAddrActivePhoneList ;
string10	 v4_InputAddrTaxValue ;
string4	 v4_InputAddrTaxYr;
string10	 v4_InputAddrTaxMarketValue;
string10	 v4_InputAddrAVMValue;
string10	 v4_InputAddrAVMValue12;	 // new to 4.0	
string10	 v4_InputAddrAVMValue60;	 // new to 4.0	
string5	 v4_InputAddrCountyIndex;
string5	 v4_InputAddrTractIndex;
string5	 v4_InputAddrBlockIndex;
string3	 v4_CurrAddrAgeOldestRecord;
string3	 v4_CurrAddrAgeNewestRecord;
string3	 v4_CurrAddrLenOfRes ;
string2	 v4_CurrAddrDwellType ;
string2	 v4_CurrAddrApplicantOwned ;
string2	 v4_CurrAddrFamilyOwned ;
string2	 v4_CurrAddrOccupantOwned ;
string3	 v4_CurrAddrAgeLastSale;
string10	 v4_CurrAddrLastSalesPrice;
string2	 v4_CurrAddrMortgageType;	 // new to 4.0	
string2	 v4_CurrAddrActivePhoneList ;
string10	 v4_CurrAddrTaxValue ;
string4	 v4_CurrAddrTaxYr;
string10	 v4_CurrAddrTaxMarketValue;
string10	 v4_CurrAddrAVMValue;
string10	 v4_CurrAddrAVMValue12;	 // new to 4.0	
string10	 v4_CurrAddrAVMValue60;	 // new to 4.0	
string5	 v4_CurrAddrCountyIndex;
string5	 v4_CurrAddrTractIndex;
string5	 v4_CurrAddrBlockIndex;
string3	 v4_PrevAddrAgeOldestRecord;
string3	 v4_PrevAddrAgeNewestRecord;
string3	 v4_PrevAddrLenOfRes ;
string2	 v4_PrevAddrDwellType ;
string2	 v4_PrevAddrApplicantOwned ;
string2	 v4_PrevAddrFamilyOwned ;
string2	 v4_PrevAddrOccupantOwned;
string3	 v4_PrevAddrAgeLastSale;
string10	 v4_PrevAddrLastSalesPrice;
string10	 v4_PrevAddrTaxValue;
string4	 v4_PrevAddrTaxYr;
string10	 v4_PrevAddrTaxMarketValue;
string10	 v4_PrevAddrAVMValue;
string5	 v4_PrevAddrCountyIndex;
string5	 v4_PrevAddrTractIndex;
string5	 v4_PrevAddrBlockIndex;
string4	 v4_AddrMostRecentDistance;	 // new to 4.0	
string2	 v4_AddrMostRecentStateDiff;	 // new to 4.0	
string11	 v4_AddrMostRecentTaxDiff;	 // new to 4.0	
string3	 v4_AddrMostRecentMoveAge;	 // new to 4.0	
string2	 v4_AddrRecentEconTrajectory;	 // new to 4.0	
string2	 v4_AddrRecentEconTrajectoryIndex;	 // new to 4.0	
string1	 v4_EducationAttendedCollege;
string2	 v4_EducationProgram2Yr;
string2	 v4_EducationProgram4Yr;
string2	 v4_EducationProgramGraduate;
string2	 v4_EducationInstitutionPrivate;
string2	 v4_EducationFieldofStudyType;	 // new to 4.0	
string2	 v4_EducationInstitutionRating;
string1	 v4_AddrStability ;	 // is this the new addrstabilityv2 model or old model?	 
string2	 v4_StatusMostRecent ;
string2	 v4_StatusPrevious ;
string2	 v4_StatusNextPrevious;
string3	 v4_AddrChangeCount01;
string3	 v4_AddrChangeCount03;
string3	 v4_AddrChangeCount06;
string3	 v4_AddrChangeCount12;
string3	 v4_AddrChangeCount24 ;
string3	 v4_AddrChangeCount60 ;
string10	 v4_EstimatedAnnualIncome;	 // was named PredictedAnnualIncome	 in version3
string1	 v4_PropertyOwner;	 // new to 4.0	
string3	 v4_PropOwnedCount;
string10	 v4_PropOwnedTaxTotal;
string3	 v4_PropOwnedHistoricalCount;
string3	 v4_PropAgeOldestPurchase;
string3	 v4_PropAgeNewestPurchase;
string3	 v4_PropAgeNewestSale;
string10	 v4_PropNewestSalePrice;
string5	 v4_PropNewestSalePurchaseIndex;
string3	 v4_PropPurchasedCount01;
string3	 v4_PropPurchasedCount03;
string3	 v4_PropPurchasedCount06;
string3	 v4_PropPurchasedCount12;
string3	 v4_PropPurchasedCount24;
string3	 v4_PropPurchasedCount60;
string3	 v4_PropSoldCount01;
string3	 v4_PropSoldCount03;
string3	 v4_PropSoldCount06;
string3	 v4_PropSoldCount12;
string3	 v4_PropSoldCount24 ;
string3	 v4_PropSoldCount60 ;
string1	 v4_AssetOwner;	 // new to 4.0	
string1	 v4_WatercraftOwner;	 // new to 4.0	
string3	 v4_WatercraftCount;
string3	 v4_WatercraftCount01;
string3	 v4_WatercraftCount03;
string3	 v4_WatercraftCount06;
string3	 v4_WatercraftCount12 ;
string3	 v4_WatercraftCount24;
string3	 v4_WatercraftCount60 ;
string1	 v4_AircraftOwner;	 // new to 4.0	
string3	 v4_AircraftCount;
string3	 v4_AircraftCount01;
string3	 v4_AircraftCount03;
string3	 v4_AircraftCount06;
string3	 v4_AircraftCount12 ;
string3	 v4_AircraftCount24;
string3	 v4_AircraftCount60 ;
string2	 v4_WealthIndex ;
string2	 v4_BusinessActiveAssociation;	 // new to 4.0	
string2	 v4_BusinessInactiveAssociation;	 // new to 4.0	
string3	 v4_BusinessAssociationAge;	 // new to 4.0	
string100	 v4_BusinessTitle;	 // new to 4.0	
string1	 v4_DerogSeverityIndex;	 // new to 4.0	
string3	 v4_DerogCount;
string3	 v4_DerogRecentCount;	 // new to 4.0	
string3	 v4_DerogAge;
string3	 v4_FelonyCount;
string3	 v4_FelonyAge;
string3	 v4_FelonyCount01;
string3	 v4_FelonyCount03;
string3	 v4_FelonyCount06;
string3	 v4_FelonyCount12;
string3	 v4_FelonyCount24;
string3	 v4_FelonyCount60;
string3	 v4_LienCount;
string3	 v4_LienFiledCount;
string3	 v4_LienFiledAge;
string3	 v4_LienFiledCount01;
string3	 v4_LienFiledCount03;
string3	 v4_LienFiledCount06;
string3	 v4_LienFiledCount12;
string3	 v4_LienFiledCount24;
string3	 v4_LienFiledCount60;
string3	 v4_LienReleasedCount;
string3	 v4_LienReleasedAge;
string3	 v4_LienReleasedCount01;
string3	 v4_LienReleasedCount03;
string3	 v4_LienReleasedCount06;
string3	 v4_LienReleasedCount12;
string3	 v4_LienReleasedCount24;
string3	 v4_LienReleasedCount60;
string10	 v4_LienFiledTotal;	 // new to 4.0	
string10	 v4_LienFederalTaxFiledTotal;
string10	 v4_LienTaxOtherFiledTotal;
string10	 v4_LienForeclosureFiledTotal;
string10	 v4_LienLandlordTenantFiledTotal;
string10	 v4_LienJudgmentFiledTotal;
string10	 v4_LienSmallClaimsFiledTotal;
string10	 v4_LienOtherFiledTotal;
string10	 v4_LienReleasedTotal;	 // new to 4.0	
string10	 v4_LienFederalTaxReleasedTotal;
string10	 v4_LienTaxOtherReleasedTotal;
string10	 v4_LienForeclosureReleasedTotal;
string10	 v4_LienLandlordTenantReleasedTotal;
string10	 v4_LienJudgmentReleasedTotal;
string10	 v4_LienSmallClaimsReleasedTotal;
string10	 v4_LienOtherReleasedTotal;
string3	 v4_LienFederalTaxFiledCount;
string3	 v4_LienTaxOtherFiledCount;
string3	 v4_LienForeclosureFiledCount;
string3	 v4_LienLandlordTenantFiledCount;
string3	 v4_LienJudgmentFiledCount;
string3	 v4_LienSmallClaimsFiledCount;
string3	 v4_LienOtherFiledCount;
string3	 v4_LienFederalTaxReleasedCount;
string3	 v4_LienTaxOtherReleasedCount;
string3	 v4_LienForeclosureReleasedCount;
string3	 v4_LienLandlordTenantReleasedCount;
string3	 v4_LienJudgmentReleasedCount;
string3	 v4_LienSmallClaimsReleasedCount;
string3	 v4_LienOtherReleasedCount;
string3	 v4_BankruptcyCount;
string3	 v4_BankruptcyAge;
string3	 v4_BankruptcyType;
string35	 v4_BankruptcyStatus;
string3	 v4_BankruptcyCount01;
string3	 v4_BankruptcyCount03;
string3	 v4_BankruptcyCount06;
string3	 v4_BankruptcyCount12;
string3	 v4_BankruptcyCount24;
string3	 v4_BankruptcyCount60;
string3	 v4_EvictionCount;
string3	 v4_EvictionAge;
string3	 v4_EvictionCount01;
string3	 v4_EvictionCount03;
string3	 v4_EvictionCount06;
string3	 v4_EvictionCount12 ;
string3	 v4_EvictionCount24 ;
string3	 v4_EvictionCount60 ;
string2	 v4_RecentActivityIndex;	 // new to 4.0	
string3	 v4_NonDerogCount;
string3	 v4_NonDerogCount01;
string3	 v4_NonDerogCount03;
string3	 v4_NonDerogCount06;
string3	 v4_NonDerogCount12;
string3	 v4_NonDerogCount24;
string3	 v4_NonDerogCount60;
string1	 v4_VoterRegistrationRecord;	 // new to 4.0	
string3	 v4_ProfLicCount;
string3	 v4_ProfLicAge;
string60	 v4_ProfLicType;
string2	 v4_ProfLicTypeCategory;
string2	 v4_ProfLicExpired;	 // was named ProfLicExpireDate	 in version3, changed to a boolean
string3	 v4_ProfLicCount01;
string3	 v4_ProfLicCount03;
string3	 v4_ProfLicCount06;
string3	 v4_ProfLicCount12;
string3	 v4_ProfLicCount24;
string3	 v4_ProfLicCount60;
string1	 v4_InquiryCollectionsRecent;	 // new to 4.0	
string1	 v4_InquiryPersonalFinanceRecent;  // new to 4.0	
string1	 v4_InquiryOtherRecent;	 // new to 4.0	
string1	 v4_HighRiskCreditActivity;	 // new to 4.0	
string3	 v4_SubPrimeOfferRequestCount;	 // was named SubPrimeSolicitedCount	 in version3
string3	 v4_SubPrimeOfferRequestCount01;	 // was named SubPrimeSolicitedCount01	 in version3
string3	 v4_SubPrimeOfferRequestCount03;	 // was named SubprimeSolicitedCount03	 in version3
string3	 v4_SubPrimeOfferRequestCount06;	 // was named SubprimeSolicitedCount06	 in version3
string3	 v4_SubPrimeOfferRequestCount12;	 // was named SubPrimeSolicitedCount12	 in version3
string3	 v4_SubPrimeOfferRequestCount24;	 // was named SubPrimeSolicitedCount24	 in version3
string3	 v4_SubPrimeOfferRequestCount60;	 // was named SubPrimeSolicitedCount60	 in version3
string2	 v4_InputPhoneMobile ;
string3	 v4_PhoneEDAAgeOldestRecord;
string3	 v4_PhoneEDAAgeNewestRecord;
string3	 v4_PhoneOtherAgeOldestRecord;
string3	 v4_PhoneOtherAgeNewestRecord;
string2	 v4_InputPhoneHighRisk;
string2	 v4_InputPhoneProblems;	 // new to 4.0	
string2	 v4_EmailAddress;	 // new to 4.0	
string2	 v4_InputAddrHighRisk;
string2	 v4_CurrAddrCorrectional;	 // new to 4.0	
string2	 v4_PrevAddrCorrectional;	 // new to 4.0	
string2	 v4_HistoricalAddrCorrectional;	 // new to 4.0	
string2	 v4_InputAddrProblems;	 // new to 4.0	
string1	 v4_SecurityFreeze;
string1	 v4_SecurityAlert;
string1	 v4_IDTheftFlag;
string1	 v4_ConsumerStatement;	 // new to 4.0	
string2	 v4_PrescreenOptOut;
			string6 history_date;
      string200 errorcode;
			
			RiskProcessing.layout_internal_extras;
END;

Export FCRA_RiskView_XML_Generic_Attributes_V4_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
	  
		unsigned seq;
	    string30 AccountNumber;
	    string3	AgeOldestRecord	;		
			string3	AgeNewestRecord	;		
			string1	RecentUpdate	;		
			string3	SrcsConfirmIDAddrCount	;		
			string2	InvalidDL	;		
			string1	VerificationFailure	;		
			string2	SSNNotFound	;		
			string1	VerifiedName	;		
			string2	VerifiedSSN	;		
			string2	VerifiedPhone	;		
			string2	VerifiedAddress	;		
			string2	VerifiedDOB	;		
			string3	InferredMinimumAge	;		
			string3	BestReportedAge	;		
			string3	SubjectSSNCount	;		
			string3	SubjectAddrCount	;		
			string3	SubjectPhoneCount	;		
			string3	SubjectSSNRecentCount	;		
			string3	SubjectAddrRecentCount	;		
			string3	SubjectPhoneRecentCount	;		
			string3	SSNIdentitiesCount	;		
			string3	SSNAddrCount	;		
			string3	SSNIdentitiesRecentCount	;		
			string3	SSNAddrRecentCount	;		
			string3	InputAddrPhoneCount	;		
			string3	InputAddrPhoneRecentCount	;		
			string3	PhoneIdentitiesCount	;		
			string3	PhoneIdentitiesRecentCount	;		
			string3	SSNAgeDeceased	;	// was named SSNDateDeceased	in version3
			string2	SSNRecent	;		
			string3	SSNLowIssueAge	;	// was named SSNLowIssueDate	in version3
			string3	SSNHighIssueAge	;	// was named SSNHighIssueDate	in version3
			string2	SSNIssueState	;		
			string2	SSNNonUS	;		
			string2	SSN3Years	;		
			string2	SSNAfter5 	;		
			string2	SSNProblems	;	// new to 4.0	
			string3	InputAddrAgeOldestRecord	;		
			string3	InputAddrAgeNewestRecord	;		
			string2	InputAddrHistoricalMatch	;	// new to 4.0	
			string3	InputAddrLenOfRes 	;		
			string2	InputAddrDwellType 	;		
			string2	InputAddrDelivery	;	// new to 4.0	
			string2	InputAddrApplicantOwned	;		
			string2	InputAddrFamilyOwned	;		
			string2	InputAddrOccupantOwned 	;		
			string3	InputAddrAgeLastSale	;		
			string10	InputAddrLastSalesPrice	;		
			string2	InputAddrMortgageType	;	// new to 4.0				
			string2	InputAddrNotPrimaryRes 	;		
			string2	InputAddrActivePhoneList 	;		
			string10	InputAddrTaxValue 	;		
			string4	InputAddrTaxYr	;		
			string10	InputAddrTaxMarketValue	;		
			string10	InputAddrAVMValue	;		
			string10	InputAddrAVMValue12	;	// new to 4.0	
			string10	InputAddrAVMValue60	;	// new to 4.0	
			string5	InputAddrCountyIndex	;		
			string5	InputAddrTractIndex	;		
			string5	InputAddrBlockIndex	;		
			string3	CurrAddrAgeOldestRecord	;		
			string3	CurrAddrAgeNewestRecord	;		
			string3	CurrAddrLenOfRes 	;		
			string2	CurrAddrDwellType 	;		
			string2	CurrAddrApplicantOwned 	;		
			string2	CurrAddrFamilyOwned 	;		
			string2	CurrAddrOccupantOwned 	;		
			string3	CurrAddrAgeLastSale	;		
			string10	CurrAddrLastSalesPrice	;		
			string2	CurrAddrMortgageType	;	// new to 4.0	
			string2	CurrAddrActivePhoneList 	;		
			string10	CurrAddrTaxValue 	;		
			string4	CurrAddrTaxYr	;		
			string10	CurrAddrTaxMarketValue	;		
			string10	CurrAddrAVMValue	;		
			string10	CurrAddrAVMValue12	;	// new to 4.0	
			string10	CurrAddrAVMValue60	;	// new to 4.0	
			string5	CurrAddrCountyIndex	;		
			string5	CurrAddrTractIndex	;		
			string5	CurrAddrBlockIndex	;		
			string3	PrevAddrAgeOldestRecord	;		
			string3	PrevAddrAgeNewestRecord	;		
			string3	PrevAddrLenOfRes 	;		
			string2	PrevAddrDwellType 	;		
			string2	PrevAddrApplicantOwned 	;		
			string2	PrevAddrFamilyOwned 	;		
			string2	PrevAddrOccupantOwned	;		
			string3	PrevAddrAgeLastSale	;		
			string10	PrevAddrLastSalesPrice	;		
			string10	PrevAddrTaxValue	;		
			string4	PrevAddrTaxYr	;		
			string10	PrevAddrTaxMarketValue	;		
			string10	PrevAddrAVMValue	;		
			string5	PrevAddrCountyIndex	;		
			string5	PrevAddrTractIndex	;		
			string5	PrevAddrBlockIndex	;		
			string4	AddrMostRecentDistance	;	// new to 4.0	
			string2	AddrMostRecentStateDiff	;	// new to 4.0	
			string11	AddrMostRecentTaxDiff	;	// new to 4.0	
			string3	AddrMostRecentMoveAge	;	// new to 4.0				
			string2	AddrRecentEconTrajectory	;	// new to 4.0	
			string2	AddrRecentEconTrajectoryIndex	;	// new to 4.0	
			string1	EducationAttendedCollege	;		
			string2	EducationProgram2Yr	;		
			string2	EducationProgram4Yr	;		
			string2	EducationProgramGraduate	;		
			string2	EducationInstitutionPrivate	;		
			string2	EducationFieldofStudyType	;	// new to 4.0	
			string2	EducationInstitutionRating	;		
			string1	AddrStability 	;	// is this the new addrstabilityv2 model or old model?	
			string2	StatusMostRecent 	;		
			string2	StatusPrevious 	;		
			string2	StatusNextPrevious	;		
			string3	AddrChangeCount01	;		
			string3	AddrChangeCount03	;		
			string3	AddrChangeCount06	;		
			string3	AddrChangeCount12	;		
			string3	AddrChangeCount24 	;		
			string3	AddrChangeCount60 	;		
			string10	EstimatedAnnualIncome	;	// was named PredictedAnnualIncome	in version3
			string1	PropertyOwner	;	// new to 4.0	
			string3	PropOwnedCount	;		
			string10	PropOwnedTaxTotal	;		
			string3	PropOwnedHistoricalCount	;		
			string3	PropAgeOldestPurchase	;		
			string3	PropAgeNewestPurchase	;		
			string3	PropAgeNewestSale	;		
			string10	PropNewestSalePrice	;		
			string5	PropNewestSalePurchaseIndex	;		
			string3	PropPurchasedCount01	;		
			string3	PropPurchasedCount03	;		
			string3	PropPurchasedCount06	;		
			string3	PropPurchasedCount12	;		
			string3	PropPurchasedCount24	;		
			string3	PropPurchasedCount60	;		
			string3	PropSoldCount01	;		
			string3	PropSoldCount03	;		
			string3	PropSoldCount06	;		
			string3	PropSoldCount12	;		
			string3	PropSoldCount24 	;		
			string3	PropSoldCount60 	;		
			string1	AssetOwner	;	// new to 4.0	
			string1	WatercraftOwner	;	// new to 4.0	
			string3	WatercraftCount	;		
			string3	WatercraftCount01	;		
			string3	WatercraftCount03	;		
			string3	WatercraftCount06	;		
			string3	WatercraftCount12 	;		
			string3	WatercraftCount24	;		
			string3	WatercraftCount60 	;		
			string1	AircraftOwner	;	// new to 4.0	
			string3	AircraftCount	;		
			string3	AircraftCount01	;		
			string3	AircraftCount03	;		
			string3	AircraftCount06	;		
			string3	AircraftCount12 	;		
			string3	AircraftCount24	;		
			string3	AircraftCount60 	;		
			string2	WealthIndex 	;		
			string2	BusinessActiveAssociation	;	// new to 4.0	
			string2	BusinessInactiveAssociation	;	// new to 4.0	
			string3	BusinessAssociationAge	;	// new to 4.0	
			string100	BusinessTitle	;	// new to 4.0	
			string1	DerogSeverityIndex	;	// new to 4.0	
			string3	DerogCount	;		
			string3	DerogRecentCount	;	// new to 4.0	
			string3	DerogAge	;		
			string3	FelonyCount	;		
			string3	FelonyAge	;		
			string3	FelonyCount01	;		
			string3	FelonyCount03	;		
			string3	FelonyCount06	;		
			string3	FelonyCount12	;		
			string3	FelonyCount24	;		
			string3	FelonyCount60	;		
			string3	LienCount	;		
			string3	LienFiledCount	;		
			string3	LienFiledAge	;		
			string3	LienFiledCount01	;		
			string3	LienFiledCount03	;		
			string3	LienFiledCount06	;		
			string3	LienFiledCount12	;		
			string3	LienFiledCount24	;		
			string3	LienFiledCount60	;		
			string3	LienReleasedCount	;		
			string3	LienReleasedAge	;		
			string3	LienReleasedCount01	;		
			string3	LienReleasedCount03	;		
			string3	LienReleasedCount06	;		
			string3	LienReleasedCount12	;		
			string3	LienReleasedCount24	;		
			string3	LienReleasedCount60	;		
			string10	LienFiledTotal	;	// new to 4.0	
			string10	LienFederalTaxFiledTotal	;		
			string10	LienTaxOtherFiledTotal	;		
			string10	LienForeclosureFiledTotal	;		
			string10	LienLandlordTenantFiledTotal	;		
			string10	LienJudgmentFiledTotal	;		
			string10	LienSmallClaimsFiledTotal	;		
			string10	LienOtherFiledTotal	;		
			string10	LienReleasedTotal	;	// new to 4.0	
			string10	LienFederalTaxReleasedTotal	;		
			string10	LienTaxOtherReleasedTotal	;		
			string10	LienForeclosureReleasedTotal	;		
			string10	LienLandlordTenantReleasedTotal	;		
			string10	LienJudgmentReleasedTotal	;		
			string10	LienSmallClaimsReleasedTotal	;		
			string10	LienOtherReleasedTotal	;		
			string3	LienFederalTaxFiledCount	;		
			string3	LienTaxOtherFiledCount	;		
			string3	LienForeclosureFiledCount	;		
			string3	LienLandlordTenantFiledCount	;		
			string3	LienJudgmentFiledCount	;		
			string3	LienSmallClaimsFiledCount	;		
			string3	LienOtherFiledCount	;		
			string3	LienFederalTaxReleasedCount	;		
			string3	LienTaxOtherReleasedCount	;		
			string3	LienForeclosureReleasedCount	;		
			string3	LienLandlordTenantReleasedCount	;		
			string3	LienJudgmentReleasedCount	;		
			string3	LienSmallClaimsReleasedCount	;		
			string3	LienOtherReleasedCount	;		
			string3	BankruptcyCount	;		
			string3	BankruptcyAge	;		
			string3	BankruptcyType	;		
			string35	BankruptcyStatus	;		
			string3	BankruptcyCount01	;		
			string3	BankruptcyCount03	;		
			string3	BankruptcyCount06	;		
			string3	BankruptcyCount12	;		
			string3	BankruptcyCount24	;		
			string3	BankruptcyCount60	;		
			string3	EvictionCount	;		
			string3	EvictionAge	;		
			string3	EvictionCount01	;		
			string3	EvictionCount03	;		
			string3	EvictionCount06	;		
			string3	EvictionCount12 	;		
			string3	EvictionCount24 	;		
			string3	EvictionCount60 	;		
			string2	RecentActivityIndex	;	// new to 4.0	
			string3	NonDerogCount	;		
			string3	NonDerogCount01	;		
			string3	NonDerogCount03	;		
			string3	NonDerogCount06	;		
			string3	NonDerogCount12	;		
			string3	NonDerogCount24	;		
			string3	NonDerogCount60	;		
			string1	VoterRegistrationRecord	;	// new to 4.0	
			string3	ProfLicCount	;		
			string3	ProfLicAge	;		
			string60	ProfLicType	;		
			string2	ProfLicTypeCategory	;		
			string2	ProfLicExpired	;	// was named ProfLicExpireDate	in version3, changed to a boolean
			string3	ProfLicCount01	;		
			string3	ProfLicCount03	;		
			string3	ProfLicCount06	;		
			string3	ProfLicCount12	;		
			string3	ProfLicCount24	;		
			string3	ProfLicCount60	;		
			string1	InquiryCollectionsRecent	;	// new to 4.0	
			string1	InquiryPersonalFinanceRecent	;	// new to 4.0	
			string1	InquiryOtherRecent	;	// new to 4.0	
			string1	HighRiskCreditActivity	;	// new to 4.0	
			string3	SubPrimeOfferRequestCount	;	// was named SubPrimeSolicitedCount	in version3
			string3	SubPrimeOfferRequestCount01	;	// was named SubPrimeSolicitedCount01	in version3
			string3	SubPrimeOfferRequestCount03	;	// was named SubprimeSolicitedCount03	in version3
			string3	SubPrimeOfferRequestCount06	;	// was named SubprimeSolicitedCount06	in version3
			string3	SubPrimeOfferRequestCount12	;	// was named SubPrimeSolicitedCount12	in version3
			string3	SubPrimeOfferRequestCount24	;	// was named SubPrimeSolicitedCount24	in version3
			string3	SubPrimeOfferRequestCount60	;	// was named SubPrimeSolicitedCount60	in version3
			string2	InputPhoneMobile 	;		
			string3	PhoneEDAAgeOldestRecord	;		
			string3	PhoneEDAAgeNewestRecord	;		
			string3	PhoneOtherAgeOldestRecord	;		
			string3	PhoneOtherAgeNewestRecord	;		
			string2	InputPhoneHighRisk	;		
			string2	InputPhoneProblems	;	// new to 4.0	
			string2	EmailAddress	;	// new to 4.0	
			string2	InputAddrHighRisk	;			
			string2	CurrAddrCorrectional	;	// new to 4.0	
			string2	PrevAddrCorrectional	;	// new to 4.0	
			string2	HistoricalAddrCorrectional	;	// new to 4.0	
			string2	InputAddrProblems	;	// new to 4.0	
			string1	SecurityFreeze	;		
			string1	SecurityAlert	;		
			string1	IDTheftFlag	;		
			string1	ConsumerStatement	;	// new to 4.0	
			string2	PrescreenOptOut	;	
			string200 errorcode;
			
			RiskProcessing.layout_internal_extras;

END;


//********************************************NONFCRA PRODUCTS LAYOUTS **************************************************************************



Export NONFCRA_ITA_BATCH_CapitalOne_attributes_v3_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
	
	string20 seq;
			string30 acctno;
			Models.Layouts.layout_LeadIntegrity_attributes_batch_v1;
			string4 v3__ageoldestrecord;
			string4 v3__agenewestrecord;
			string3 v3__srcsconfirmidaddrcount;
			string1 v3__creditbureaurecord;
			string2 v3__invalidssn;
			string2 v3__invalidphone;
			string2 v3__invalidaddr;
			string2 v3__ssndeceased;
			string2 v3__ssnissued;
			string2 v3__verificationfailure;
			string2 v3__ssnnotfound;
			string2 v3__ssnfoundother;
			string2 v3__phoneother;
			string1 v3__verifiedname;
			string2 v3__verifiedssn;
			string2 v3__verifiedphone;
			string2 v3__verifiedphonefullname;
			string2 v3__verifiedphonelastname;
			string2 v3__verifiedaddress;
			string2 v3__verifieddob;
			string3 v3__subjectssncount;
			string3 v3__subjectaddrcount;
			string3 v3__subjectphonecount;
			string3 v3__subjectssnrecentcount;
			string3 v3__subjectaddrrecentcount;
			string3 v3__subjectphonerecentcount;
			string3 v3__ssnidentitiescount;
			string3 v3__ssnaddrcount;
			string3 v3__ssnidentitiesrecentcount;
			string3 v3__ssnaddrrecentcount;
			string3 v3__inputaddridentitiescount;
			string3 v3__inputaddrssncount;
			string3 v3__inputaddrphonecount;
			string3 v3__inputaddridentitiesrecentcount;
			string3 v3__inputaddrssnrecentcount;
			string3 v3__inputaddrphonerecentcount;
			string3 v3__phoneidentitiescount;
			string3 v3__phoneidentitiesrecentcount;
			string3 v3__ssnlastnamecount;
			string3 v3__subjectlastnamecount;
			string3 v3__lastnamechangecount01;
			string3 v3__lastnamechangecount03;
			string3 v3__lastnamechangecount06;
			string3 v3__lastnamechangecount12;
			string3 v3__lastnamechangecount24;
			string3 v3__lastnamechangecount36;
			string3 v3__lastnamechangecount60;
			string3 v3__sfduaddridentitiescount;
			string3 v3__sfduaddrssncount;
			string2 v3__ssnrecent;
			string2 v3__ssnnonus;
			string2 v3__ssn3years;
			string2 v3__ssnafter5;
			string2 v3__ssnissuedpriordob;
			string3 v3__relativescount;
			string3 v3__relativesbankruptcycount;
			string3 v3__relativesfelonycount;
			string3 v3__relativespropownedcount;
			string13 v3__relativespropownedtaxtotal;
			string2 v3__relativesdistanceclosest;
			string2 v3__inputaddrdwelltype;
			string2 v3__inputaddrlandusecode;
			string2 v3__inputaddrapplicantowned;
			string2 v3__inputaddrfamilyowned;
			string2 v3__inputaddroccupantowned;
			string3 v3__inputaddragelastsale;
			string2 v3__inputaddrnotprimaryres;
			string2 v3__inputaddractivephonelist;
			string2 v3__curraddrdwelltype;
			string2 v3__curraddrlandusecode;
			string2 v3__curraddrapplicantowned;
			string2 v3__curraddrfamilyowned;
			string2 v3__curraddroccupantowned;
			string3 v3__curraddragelastsale;
			string2 v3__curraddractivephonelist;
			string2 v3__prevaddrdwelltype;
			string2 v3__prevaddrlandusecode;
			string2 v3__prevaddrapplicantowned;
			string2 v3__prevaddrfamilyowned;
			string2 v3__prevaddroccupantowned;
			string3 v3__prevaddragelastsale;
			string2 v3__prevaddractivephonelist;
			string2 v3__inputcurraddrmatch;
			string2 v3__inputcurraddrstatediff;
			string2 v3__inputprevaddrmatch;
			string2 v3__currprevaddrstatediff;
			string1 v3__educationattendedcollege;
			string2 v3__educationprogram2yr;
			string2 v3__educationprogram4yr;
			string2 v3__educationprogramgraduate;
			string2 v3__educationinstitutionprivate;
			string2 v3__educationinstitutionrating;
			string2 v3__educationfieldofstudytype;
			string2 v3__statusmostrecent;
			string2 v3__statusprevious;
			string2 v3__statusnextprevious;
			string3 v3__addrchangecount01;
			string3 v3__addrchangecount03;
			string3 v3__addrchangecount06;
			string3 v3__addrchangecount12;
			string3 v3__addrchangecount24;
			string3 v3__addrchangecount36;
			string3 v3__addrchangecount60;
			string3 v3__propownedcount;
			string3 v3__propownedhistoricalcount;
			string6 v3__predictedannualincome;
			string3 v3__propageoldestpurchase;
			string3 v3__propagenewestpurchase;
			string3 v3__propagenewestsale;
			string3 v3__proppurchasedcount01;
			string3 v3__proppurchasedcount03;
			string3 v3__proppurchasedcount06;
			string3 v3__proppurchasedcount12;
			string3 v3__proppurchasedcount24;
			string3 v3__proppurchasedcount36;
			string3 v3__proppurchasedcount60;
			string3 v3__propsoldcount01;
			string3 v3__propsoldcount03;
			string3 v3__propsoldcount06;
			string3 v3__propsoldcount12;
			string3 v3__propsoldcount24;
			string3 v3__propsoldcount36;
			string3 v3__propsoldcount60;
			string3 v3__watercraftcount;
			string3 v3__watercraftcount01;
			string3 v3__watercraftcount03;
			string3 v3__watercraftcount06;
			string3 v3__watercraftcount12;
			string3 v3__watercraftcount24;
			string3 v3__watercraftcount36;
			string3 v3__watercraftcount60;
			string3 v3__aircraftcount;
			string3 v3__aircraftcount01;
			string3 v3__aircraftcount03;
			string3 v3__aircraftcount06;
			string3 v3__aircraftcount12;
			string3 v3__aircraftcount24;
			string3 v3__aircraftcount36;
			string3 v3__aircraftcount60;
			string3 v3__derogcount;
			string3 v3__felonycount;
			string3 v3__felonycount01;
			string3 v3__felonycount03;
			string3 v3__felonycount06;
			string3 v3__felonycount12;
			string3 v3__felonycount24;
			string3 v3__felonycount36;
			string3 v3__felonycount60;
			string3 v3__arrestcount;
			string3 v3__arrestcount01;
			string3 v3__arrestcount03;
			string3 v3__arrestcount06;
			string3 v3__arrestcount12;
			string3 v3__arrestcount24;
			string3 v3__arrestcount36;
			string3 v3__arrestcount60;
			string3 v3__liencount;
			string3 v3__lienfiledcount;
			string3 v3__lienfiledcount01;
			string3 v3__lienfiledcount03;
			string3 v3__lienfiledcount06;
			string3 v3__lienfiledcount12;
			string3 v3__lienfiledcount24;
			string3 v3__lienfiledcount36;
			string3 v3__lienfiledcount60;
			string3 v3__lienreleasedcount;
			string3 v3__lienreleasedcount01;
			string3 v3__lienreleasedcount03;
			string3 v3__lienreleasedcount06;
			string3 v3__lienreleasedcount12;
			string3 v3__lienreleasedcount24;
			string3 v3__lienreleasedcount36;
			string3 v3__lienreleasedcount60;
			string3 v3__bankruptcycount;
			string3 v3__bankruptcycount01;
			string3 v3__bankruptcycount03;
			string3 v3__bankruptcycount06;
			string3 v3__bankruptcycount12;
			string3 v3__bankruptcycount24;
			string3 v3__bankruptcycount36;
			string3 v3__bankruptcycount60;
			string3 v3__evictioncount;
			string3 v3__evictioncount01;
			string3 v3__evictioncount03;
			string3 v3__evictioncount06;
			string3 v3__evictioncount12;
			string3 v3__evictioncount24;
			string3 v3__evictioncount36;
			string3 v3__evictioncount60;
			string3 v3__nonderogcount;
			string3 v3__nonderogcount01;
			string3 v3__nonderogcount03;
			string3 v3__nonderogcount06;
			string3 v3__nonderogcount12;
			string3 v3__nonderogcount24;
			string3 v3__nonderogcount36;
			string3 v3__nonderogcount60;
			string3 v3__profliccount;
			string3 v3__profliccount01;
			string3 v3__profliccount03;
			string3 v3__profliccount06;
			string3 v3__profliccount12;
			string3 v3__profliccount24;
			string3 v3__profliccount36;
			string3 v3__profliccount60;
			string3 v3__proflicexpirecount01;
			string3 v3__proflicexpirecount03;
			string3 v3__proflicexpirecount06;
			string3 v3__proflicexpirecount12;
			string3 v3__proflicexpirecount24;
			string3 v3__proflicexpirecount36;
			string3 v3__proflicexpirecount60;
			string4 v3__propnewestsalepurchaseindex;
			string3 v3__subprimesolicitedcount;
			string3 v3__subprimesolicitedcount01;
			string3 v3__subprimesolicitedcount03;
			string3 v3__subprimesolicitedcount06;
			string3 v3__subprimesolicitedcount12;
			string3 v3__subprimesolicitedcount24;
			string3 v3__subprimesolicitedcount36;
			string3 v3__subprimesolicitedcount60;
			string2 v3__derogseverityindex;
			string3 v3__derogage;
			string3 v3__felonyage;
			string3 v3__arrestage;
			string3 v3__lienfiledage;
			string3 v3__lienreleasedage;
			string3 v3__bankruptcyage;
			string2 v3__bankruptcytype;
			string3 v3__evictionage;
			string3 v3__proflicage;
			string2 v3__proflictypecategory;
			string3 v3__prsearchcollectioncount;
			string3 v3__prsearchcollectioncount01;
			string3 v3__prsearchcollectioncount03;
			string3 v3__prsearchcollectioncount06;
			string3 v3__prsearchcollectioncount12;
			string3 v3__prsearchcollectioncount24;
			string3 v3__prsearchcollectioncount36;
			string3 v3__prsearchcollectioncount60;
			string3 v3__prsearchidvfraudcount;
			string3 v3__prsearchidvfraudcount01;
			string3 v3__prsearchidvfraudcount03;
			string3 v3__prsearchidvfraudcount06;
			string3 v3__prsearchidvfraudcount12;
			string3 v3__prsearchidvfraudcount24;
			string3 v3__prsearchidvfraudcount36;
			string3 v3__prsearchidvfraudcount60;
			string3 v3__prsearchothercount;
			string3 v3__prsearchothercount01;
			string3 v3__prsearchothercount03;
			string3 v3__prsearchothercount06;
			string3 v3__prsearchothercount12;
			string3 v3__prsearchothercount24;
			string3 v3__prsearchothercount36;
			string3 v3__prsearchothercount60;
			string2 v3__inputphonestatus;
			string2 v3__inputphonepager;
			string2 v3__inputphonemobile;
			string2 v3__inputphonetype;
			string2 v3__inputareacodechange;
			string3 v3__phoneotherageoldestrecord;
			string3 v3__phoneotheragenewestrecord;
			string2 v3__invalidphonezip;
			string2 v3__inputaddrvalidation;
			string2 v3__inputaddrhighrisk;
			string2 v3__inputphonehighrisk;
			string2 v3__inputaddrprison;
			string2 v3__curraddrprison;
			string2 v3__prevaddrprison;
			string2 v3__historicaladdrprison;
			string2 v3__inputzippobox;
			string2 v3__inputzipcorpmil;
			string errorcode;
			
			RiskProcessing.layout_internal_extras;

END;

Export NONFCRA_BestBuy_CDS_CDN1109_1_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
	          
						STRING30 acctno := '';
            	STRING2  socsverlevel := '';
            	STRING2  phoneverlevel := '';
            	STRING20 correctlast := '';
            	STRING10 correcthphone := '';
            	STRING9  correctsocs := '';
            	STRING50 correctaddr := '';
            	STRING3  altareacode := '';
            	STRING8  areacodesplitdate := '';
            	STRING15 verfirst := '';
            	STRING20 verlast := '';
            	STRING50 veraddr := '';
            	STRING30 vercity := '';
            	STRING2  verstate := '';
            	STRING5  verzip5 := '';
            	STRING4  verzip4 := '';
            	STRING10 nameaddrphone := '';
            	STRING1  hphonetypeflag := '';
            	STRING1  dwelltypeflag := '';
            	STRING6  sic := '';
            	
            	STRING2  phoneverlevel2 := '';
            	STRING20 correctlast2 := '';
            	STRING10 correcthphone2 := '';
            	STRING50 correctaddr2 := '';
            	STRING3  altareacode2 := '';
            	STRING8  areacodesplitdate2 := '';
            	STRING15 verfirst2 := '';
            	STRING20 verlast2 := '';
            	STRING50 veraddr2 := '';
            	STRING30 vercity2 := '';
            	STRING2  verstate2 := '';
            	STRING5  verzip52 := '';
            	STRING4  verzip42 := '';
            	STRING10 nameaddrphone2 := '';
            	STRING1  hphonetypeflag2 := '';
            	STRING1  dwelltypeflag2 := '';
            	STRING6  sic2 := '';
            	
            	// score
            	string3	 cb_score;
            	string2  cb_reason1;
            	string2  cb_reason2;
            	string2  cb_reason3;
            	string2  cb_reason4;
            	string2  cb_reason5;
            	string2  cb_reason6;
            	
            	string2  cb_reason7;
            	string2  cb_reason8;
            	string2  cb_reason9;
            	string2  cb_reason10;
            	string2  cb_reason11;
            	string2  cb_reason12;
            	
            	string200 errorcode;
	
		RiskProcessing.layout_internal_extras;
END;

Export NONFCRA_LeadIntegrity_V4_Generic_MSN1210_1_Global_Layout:=RECORD
  
		unsigned8 time_ms := 0;  
STRING20 seq;
	STRING30 acctno;
	// string name;
	string3 score;
	string2 rc1;
	string2 rc2;
	string2 rc3;
	string2 rc4;
//	string2 rc5;
//	string2 rc6;
	STRING errorcode;
		RiskProcessing.layout_internal_extras;
END;



Export NONFCRA_LeadIntegrity_Attributes_V4_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

STRING20 seq;
		STRING30 AccountNumber;
		string4 AgeOldestRecord;
		string4 AgeNewestRecord;
		string1 RecentUpdate;
		string3 SrcsConfirmIDAddrCount;
		string1 CreditBureauRecord;
		string2 VerificationFailure;
		string2 SSNNotFound;
		string2 SSNFoundOther;
		string1 VerifiedName;
		string2 VerifiedSSN;
		string2 VerifiedPhone;
		string2 VerifiedAddress;
		string2 VerifiedDOB;
		string3 AgeRiskIndicator;
		string3 SubjectSSNCount;
		string3 SubjectAddrCount;
		string3 SubjectPhoneCount;
		string3 SubjectSSNRecentCount;
		string3 SubjectAddrRecentCount;
		string3 SubjectPhoneRecentCount;
		string3 SSNIdentitiesCount;
		string3 SSNAddrCount;
		string3 SSNIdentitiesRecentCount;
		string3 SSNAddrRecentCount;
		string3 InputAddrPhoneCount;
		string3 InputAddrPhoneRecentCount;
		string3 PhoneIdentitiesCount;
		string3 PhoneIdentitiesRecentCount;
		string2 PhoneOther;
		string3 SSNLastNameCount;
		string3 SubjectLastNameCount;
		string4 LastNameChangeAge;
		string3 LastNameChangeCount01;
		string3 LastNameChangeCount03;
		string3 LastNameChangeCount06;
		string3 LastNameChangeCount12;
		string3 LastNameChangeCount24;
		string3 LastNameChangeCount60;
		string3 SFDUAddrIdentitiesCount;
		string3 SFDUAddrSSNCount;
		string3 SSNAgeDeceased;
		string2 SSNRecent;
		string3 SSNLowIssueAge;
		string3 SSNHighIssueAge;
		string2 SSNIssueState;
		string2 SSNNonUS;
		string2 SSN3Years;
		string2 SSNAfter5;
		string2 SSNProblems;
		string3 RelativesCount;
		string3 RelativesBankruptcyCount;
		string3 RelativesFelonyCount;
		string3 RelativesPropOwnedCount;
		string10 RelativesPropOwnedTaxTotal;
		string2 RelativesDistanceClosest;
		string3 InputAddrAgeOldestRecord;
		string3 InputAddrAgeNewestRecord;
		string2 InputAddrHistoricalMatch;
		string3 InputAddrLenOfRes;
		string2 InputAddrDwellType;
		string2 InputAddrDelivery;
		string2 InputAddrApplicantOwned;
		string2 InputAddrFamilyOwned;
		string2 InputAddrOccupantOwned;
		string3 InputAddrAgeLastSale;
		string10 InputAddrLastSalesPrice;
		string2 InputAddrMortgageType;
		string2 InputAddrNotPrimaryRes;
		string2 InputAddrActivePhoneList;
		string10 InputAddrTaxValue;
		string4 InputAddrTaxYr;
		string10 InputAddrTaxMarketValue;
		string10 InputAddrAVMValue;
		string10 InputAddrAVMValue12;
		string10 InputAddrAVMValue60;
		string5 InputAddrCountyIndex;
		string5 InputAddrTractIndex;
		string5 InputAddrBlockIndex;
		string10 InputAddrMedianIncome;
		string10 InputAddrMedianValue;
		string3 InputAddrMurderIndex;
		string3 InputAddrCarTheftIndex;
		string3 InputAddrBurglaryIndex;
		string3 InputAddrCrimeIndex;
		string3 InputAddrMobilityIndex;
		string3 InputAddrVacantPropCount;
		string3 InputAddrBusinessCount;
		string3 InputAddrSingleFamilyCount;
		string3 InputAddrMultiFamilyCount;
		string3 CurrAddrAgeOldestRecord;
		string3 CurrAddrAgeNewestRecord;
		string3 CurrAddrLenOfRes;
		string2 CurrAddrDwellType;
		string2 CurrAddrApplicantOwned;
		string2 CurrAddrFamilyOwned;
		string2 CurrAddrOccupantOwned;
		string3 CurrAddrAgeLastSale;
		string10 CurrAddrLastSalesPrice;
		string2 CurrAddrMortgageType;
		string2 CurrAddrActivePhoneList;
		string10 CurrAddrTaxValue;
		string4 CurrAddrTaxYr;
		string10 CurrAddrTaxMarketValue;
		string10 CurrAddrAVMValue;
		string10 CurrAddrAVMValue12;
		string10 CurrAddrAVMValue60;
		string5 CurrAddrCountyIndex;
		string5 CurrAddrTractIndex;
		string5 CurrAddrBlockIndex;
		string10 CurrAddrMedianIncome;
		string10 CurrAddrMedianValue;
		string3 CurrAddrMurderIndex;
		string3 CurrAddrCarTheftIndex;
		string3 CurrAddrBurglaryIndex;
		string3 CurrAddrCrimeIndex;
		string3 PrevAddrAgeOldestRecord;
		string3 PrevAddrAgeNewestRecord;
		string3 PrevAddrLenOfRes;
		string2 PrevAddrDwellType;
		string2 PrevAddrApplicantOwned;
		string2 PrevAddrFamilyOwned;
		string2 PrevAddrOccupantOwned;
		string3 PrevAddrAgeLastSale;
		string10 PrevAddrLastSalesPrice;
		string10 PrevAddrTaxValue;
		string4 PrevAddrTaxYr;
		string10 PrevAddrTaxMarketValue;
		string10 PrevAddrAVMValue;
		string5 PrevAddrCountyIndex;
		string5 PrevAddrTractIndex;
		string5 PrevAddrBlockIndex;
		string10 PrevAddrMedianIncome;
		string10 PrevAddrMedianValue;
		string3 PrevAddrMurderIndex;
		string3 PrevAddrCarTheftIndex;
		string3 PrevAddrBurglaryIndex;
		string3 PrevAddrCrimeIndex;
		string4 AddrMostRecentDistance;
		string2 AddrMostRecentStateDiff;
		string11 AddrMostRecentTaxDiff;
		string3 AddrMostRecentMoveAge;
		string11 AddrMostRecentIncomeDiff;
		string11 AddrMostRecentValueDIff;
		string4 AddrMostRecentCrimeDiff;
		string2 AddrRecentEconTrajectory;
		string2 AddrRecentEconTrajectoryIndex;
		string1 EducationAttendedCollege;
		string2 EducationProgram2Yr;
		string2 EducationProgram4Yr;
		string2 EducationProgramGraduate;
		string2 EducationInstitutionPrivate;
		string2 EducationInstitutionRating;
		string2 EducationFieldofStudyType;
		string1 AddrStability;
		string2 StatusMostRecent;
		string2 StatusPrevious;
		string2 StatusNextPrevious;
		string3 AddrChangeCount01;
		string3 AddrChangeCount03;
		string3 AddrChangeCount06;
		string3 AddrChangeCount12;
		string3 AddrChangeCount24;
		string3 AddrChangeCount60;
		string10 EstimatedAnnualIncome;
		string1 AssetOwner;
		string1 PropertyOwner;
		string3 PropOwnedCount;
		string10 PropOwnedTaxTotal;
		string3 PropOwnedHistoricalCount;
		string3 PropAgeOldestPurchase;
		string3 PropAgeNewestPurchase;
		string3 PropAgeNewestSale;
		string10 PropNewestSalePrice;
		string4 PropNewestSalePurchaseIndex;
		string3 PropPurchasedCount01;
		string3 PropPurchasedCount03;
		string3 PropPurchasedCount06;
		string3 PropPurchasedCount12;
		string3 PropPurchasedCount24;
		string3 PropPurchasedCount60;
		string3 PropSoldCount01;
		string3 PropSoldCount03;
		string3 PropSoldCount06;
		string3 PropSoldCount12;
		string3 PropSoldCount24;
		string3 PropSoldCount60;
		string1 WatercraftOwner;
		string3 WatercraftCount;
		string3 WatercraftCount01;
		string3 WatercraftCount03;
		string3 WatercraftCount06;
		string3 WatercraftCount12;
		string3 WatercraftCount24;
		string3 WatercraftCount60;
		string1 AircraftOwner;
		string3 AircraftCount;
		string3 AircraftCount01;
		string3 AircraftCount03;
		string3 AircraftCount06;
		string3 AircraftCount12;
		string3 AircraftCount24;
		string3 AircraftCount60;
		string2 WealthIndex;
		string2 BusinessActiveAssociation;
		string2 BusinessInactiveAssociation;
		string3 BusinessAssociationAge;
		string100 BusinessTitle;
		string3 BusinessInputAddrCount;
		string2 DerogSeverityIndex;
		string3 DerogCount;
		string3 DerogRecentCount;
		string3 DerogAge;
		string3 FelonyCount;
		string3 FelonyAge;
		string3 FelonyCount01;
		string3 FelonyCount03;
		string3 FelonyCount06;
		string3 FelonyCount12;
		string3 FelonyCount24;
		string3 FelonyCount60;
		string3 ArrestCount;
		string3 ArrestAge;
		string3 ArrestCount01;
		string3 ArrestCount03;
		string3 ArrestCount06;
		string3 ArrestCount12;
		string3 ArrestCount24;
		string3 ArrestCount60;
		string3 LienCount;
		string3 LienFiledCount;
		string10 LienFiledTotal;
		string3 LienFiledAge;
		string3 LienFiledCount01;
		string3 LienFiledCount03;
		string3 LienFiledCount06;
		string3 LienFiledCount12;
		string3 LienFiledCount24;
		string3 LienFiledCount60;
		string3 LienReleasedCount;
		string10 LienReleasedTotal;
		string3 LienReleasedAge;
		string3 LienReleasedCount01;
		string3 LienReleasedCount03;
		string3 LienReleasedCount06;
		string3 LienReleasedCount12;
		string3 LienReleasedCount24;
		string3 LienReleasedCount60;
		string3 BankruptcyCount;
		string3 BankruptcyAge;
		string2 BankruptcyType;
		string35 BankruptcyStatus;
		string3 BankruptcyCount01;
		string3 BankruptcyCount03;
		string3 BankruptcyCount06;
		string3 BankruptcyCount12;
		string3 BankruptcyCount24;
		string3 BankruptcyCount60;
		string3 EvictionCount;
		string3 EvictionAge;
		string3 EvictionCount01;
		string3 EvictionCount03;
		string3 EvictionCount06;
		string3 EvictionCount12;
		string3 EvictionCount24;
		string3 EvictionCount60;
		string3 AccidentCount;
		string3 AccidentAge;
		string2 RecentActivityIndex;
		string3 NonDerogCount;
		string3 NonDerogCount01;
		string3 NonDerogCount03;
		string3 NonDerogCount06;
		string3 NonDerogCount12;
		string3 NonDerogCount24;
		string3 NonDerogCount60;
		string1 VoterRegistrationRecord;
		string3 ProfLicCount;
		string3 ProfLicAge;
		string2 ProfLicTypeCategory;
		string2 ProfLicExpired;
		string3 ProfLicCount01;
		string3 ProfLicCount03;
		string3 ProfLicCount06;
		string3 ProfLicCount12;
		string3 ProfLicCount24;
		string3 ProfLicCount60;
		string3 PRSearchLocateCount;
		string3 PRSearchLocateCount01;
		string3 PRSearchLocateCount03;
		string3 PRSearchLocateCount06;
		string3 PRSearchLocateCount12;
		string3 PRSearchLocateCount24;
		string3 PRSearchPersonalFinanceCount;
		string3 PRSearchPersonalFinanceCount01;
		string3 PRSearchPersonalFinanceCount03;
		string3 PRSearchPersonalFinanceCount06;
		string3 PRSearchPersonalFinanceCount12;
		string3 PRSearchPersonalFinanceCount24;
		string3 PRSearchOtherCount;
		string3 PRSearchOtherCount01;
		string3 PRSearchOtherCount03;
		string3 PRSearchOtherCount06;
		string3 PRSearchOtherCount12;
		string3 PRSearchOtherCount24;
		string3 PRSearchIdentitySSNs;
		string3 PRSearchIdentityAddrs;
		string3 PRSearchIdentityPhones;
		string3 PRSearchSSNIdentities;
		string3 PRSearchAddrIdentities;
		string3 PRSearchPhoneIdentities;
		string3 SubPrimeOfferRequestCount;
		string3 SubPrimeOfferRequestCount01;
		string3 SubPrimeOfferRequestCount03;
		string3 SubPrimeOfferRequestCount06;
		string3 SubPrimeOfferRequestCount12;
		string3 SubPrimeOfferRequestCount24;
		string3 SubPrimeOfferRequestCount60;
		string2 InputPhoneMobile;
		string2 InputPhoneType;
		string2 InputPhoneServiceType;
		string2 InputAreaCodeChange;
		string3 PhoneEDAAgeOldestRecord;
		string3 PhoneEDAAgeNewestRecord;
		string3 PhoneOtherAgeOldestRecord;
		string3 PhoneOtherAgeNewestRecord;
		string2 InputPhoneHighRisk;
		string2 InputPhoneProblems;
		string2 OnlineDirectory;
		string4 InputAddrSICCode;
		string2 InputAddrValidation;
		string5 InputAddrErrorCode;
		string2 InputAddrHighRisk;
		string2 CurrAddrCorrectional;
		string2 PrevAddrCorrectional;
		string2 HistoricalAddrCorrectional;
		string2 InputAddrProblems;
		string1 DoNotMail;
		// 4.1 Attributes (Part of 4.0)
		STRING2 IdentityRiskLevel := '';
		STRING2 IDVerRiskLevel := '';
		STRING3 IDVerAddressAssocCount := '';
		STRING2 IDVerSSNCreditBureauCount := '';
		STRING2 IDVerSSNCreditBureauDelete := '';
		STRING2 SourceRiskLevel := '';
		STRING1 SourceWatchList := '';
		STRING1 SourceOrderActivity := '';
		STRING3 SourceOrderSourceCount := '';
		STRING3 SourceOrderAgeLastOrder := '';
		STRING2 VariationRiskLevel := '';
		STRING3 VariationIdentityCount := '';
		STRING3 VariationMSourcesSSNCount := '';
		STRING3 VariationMSourcesSSNUnrelCount := '';
		STRING3 VariationDOBCount := '';
		STRING3 VariationDOBCountNew := '';
		STRING2 SearchVelocityRiskLevel := '';
		STRING3 SearchUnverifiedSSNCountYear := '';
		STRING3 SearchUnverifiedAddrCountYear := '';
		STRING3 SearchUnverifiedDOBCountYear := '';
		STRING3 SearchUnverifiedPhoneCountYear := '';
		STRING2 AssocRiskLevel := '';
		STRING3 AssocSuspicousIdentitiesCount := '';
		STRING3 AssocCreditBureauOnlyCount := '';
		STRING3 AssocCreditBureauOnlyCountNew := '';
		STRING3 AssocCreditBureauOnlyCountMonth := '';
		STRING3 AssocHighRiskTopologyCount := '';
		STRING1 ValidationRiskLevel := '';
		STRING1 CorrelationRiskLevel := '';
		STRING1 DivRiskLevel := '';
		STRING3 DivSSNIdentityMSourceCount := '';
		STRING3 DivSSNIdentityMSourceUrelCount := '';
		STRING3 DivSSNLNameCountNew := '';
		STRING3 DivSSNAddrMSourceCount := '';
		STRING3 DivAddrIdentityCount := '';
		STRING3 DivAddrIdentityCountNew := '';
		STRING3 DivAddrIdentityMSourceCount := '';
		STRING3 DivAddrSuspIdentityCountNew := '';
		STRING3 DivAddrSSNCount := '';
		STRING3 DivAddrSSNCountNew := '';
		STRING3 DivAddrSSNMSourceCount := '';
		STRING3 DivSearchAddrSuspIdentityCount := '';
		STRING1 SearchComponentRiskLevel := '';
		STRING3 SearchSSNSearchCount := '';
		STRING3 SearchAddrSearchCount := '';
		STRING3 SearchPhoneSearchCount := '';
		STRING1 ComponentCharRiskLevel := '';
		STRING errorcode;	
			RiskProcessing.layout_internal_extras;
END;

Export NONFCRA_LeadIntegrity_Attributes_V3_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

STRING20 seq;
		STRING30 AccountNumber;
		STRING4  AgeOldestRecord;
		STRING4  AgeNewestRecord;	
		STRING1  RecentUpdate;
		STRING2  SrcsConfirmIDAddrCount;
		STRING1  CreditBureauRecord;
		STRING2  InvalidSSN;
		STRING2  InvalidAddr;
		STRING2  InvalidPhone;
		STRING2  VerificationFailure;
		STRING2  SSNNotFound;
		STRING2  SSNFoundOther;
		STRING1  VerifiedName;
		STRING2  VerifiedSSN;
		STRING2  VerifiedPhone;
		STRING2  VerifiedPhoneFullName;
		STRING2  VerifiedPhoneLastName;
		STRING2  VerifiedAddress;
		STRING2  VerifiedDOB;
		STRING3  AgeRiskIndicator;
		STRING3  SubjectSSNCount;
		STRING3  SubjectAddrCount;
		STRING3  SubjectPhoneCount;
		STRING3  SubjectSSNRecentCount;
		STRING3  SubjectAddrRecentCount;
		STRING3  SubjectPhoneRecentCount;
		STRING3  SSNIdentitiesCount;
		STRING3  SSNAddrCount;
		STRING3  SSNIdentitiesRecentCount;
		STRING3  SSNAddrRecentCount;
		STRING3  InputAddrIdentitiesCount;
		STRING3  InputAddrSSNCount;
		STRING3  InputAddrPhoneCount;
		STRING3  InputAddrIdentitiesRecentCount;
		STRING3  InputAddrSSNRecentCount;
		STRING3  InputAddrPhoneRecentCount;
		STRING3  PhoneIdentitiesCount;
		STRING3  PhoneIdentitiesRecentCount;
		STRING2  PhoneOther;
		STRING3  SSNLastNameCount;
		STRING3  SubjectLastNameCount;
		STRING4  LastNameChangeAge;
		STRING3  LastNameChangeCount01;
		STRING3  LastNameChangeCount03;
		STRING3  LastNameChangeCount06;
		STRING3  LastNameChangeCount12;
		STRING3  LastNameChangeCount24;
		STRING3  LastNameChangeCount36;
		STRING3  LastNameChangeCount60;
		STRING3  SFDUAddrIdentitiesCount;
		STRING3  SFDUAddrSSNCount;
		STRING2  SSNDeceased;
		STRING8  SSNDateDeceased;
		STRING2  SSNIssued;
		STRING2  SSNRecent;
		STRING8  SSNLowIssueDate;
		STRING8  SSNHighIssueDate;
		STRING2  SSNIssueState;
		STRING2  SSNNonUS;
		STRING2  SSNIssuedPriorDOB;
		STRING2  SSN3Years;
		STRING2  SSNAfter5;
		STRING3  SSNProblems;
		STRING3  RelativesCount;
		STRING3  RelativesBankruptcyCount;
		STRING3  RelativesFelonyCount;
		STRING3  RelativesPropOwnedCount;
		STRING13 RelativesPropOwnedTaxTotal;
		STRING2  RelativesDistanceClosest;
		STRING4  InputAddrAgeOldestRecord;
		STRING4  InputAddrAgeNewestRecord;
		STRING3  InputAddrLenOfRes;
		STRING2  InputAddrDwellType;
		STRING2  InputAddrLandUseCode;
		STRING2  InputAddrApplicantOwned;
		STRING2  InputAddrFamilyOwned;
		STRING2  InputAddrOccupantOwned;
		STRING4  InputAddrAgeLastSale;
		STRING10 InputAddrLastSalesPrice;
		STRING2  InputAddrNotPrimaryRes;
		STRING2  InputAddrActivePhoneList;
		STRING10 InputAddrActivePhoneNumber;
		STRING10 InputAddrTaxValue;
		STRING4  InputAddrTaxYr;
		STRING10 InputAddrTaxMarketValue;
		STRING10 InputAddrAVMTax;
		STRING10 InputAddrAVMSalesPrice;
		STRING10 InputAddrAVMHedonic;
		STRING10 InputAddrAVMValue;
		STRING2  InputAddrAVMConfidence;
		STRING5  InputAddrCountyIndex;
		STRING5  InputAddrTractIndex;
		STRING5  InputAddrBlockIndex;
		STRING10 InputAddrMedianIncome;
		STRING10 InputAddrMedianValue;
		STRING3  InputAddrMurderIndex;
		STRING3  InputAddrCarTheftIndex;
		STRING3  InputAddrBurglaryIndex;
		STRING3  InputAddrCrimeIndex;
		STRING4  CurrAddrAgeOldestRecord;
		STRING4  CurrAddrAgeNewestRecord;
		STRING3  CurrAddrLenOfRes;
		STRING2  CurrAddrDwellType;
		STRING2  CurrAddrLandUseCode;
		STRING2  CurrAddrApplicantOwned;
		STRING2  CurrAddrFamilyOwned;
		STRING2  CurrAddrOccupantOwned;
		STRING4  CurrAddrAgeLastSale;
		STRING10 CurrAddrLastSalesPrice;
		STRING2  CurrAddrActivePhoneList;
		STRING10 CurrAddrActivePhoneNumber;
		STRING10 CurrAddrTaxValue;
		STRING4  CurrAddrTaxYr;
		STRING10 CurrAddrTaxMarketValue;
		STRING10 CurrAddrAVMTax;
		STRING10 CurrAddrAVMSalesPrice;
		STRING10 CurrAddrAVMHedonic;
		STRING10 CurrAddrAVMValue;
		STRING2  CurrAddrAVMConfidence;
		STRING5  CurrAddrCountyIndex;
		STRING5  CurrAddrTractIndex;
		STRING5  CurrAddrBlockIndex;
		STRING10 CurrAddrMedianIncome;
		STRING10 CurrAddrMedianValue;
		STRING3  CurrAddrMurderIndex;
		STRING3  CurrAddrCarTheftIndex;
		STRING3  CurrAddrBurglaryIndex;
		STRING3  CurrAddrCrimeIndex;
		STRING4  PrevAddrAgeOldestRecord;
		STRING4  PrevAddrAgeNewestRecord;
		STRING3  PrevAddrLenOfRes;
		STRING2  PrevAddrDwellType;
		STRING2  PrevAddrLandUseCode;
		STRING2  PrevAddrApplicantOwned;
		STRING2  PrevAddrFamilyOwned;
		STRING2  PrevAddrOccupantOwned;
		STRING4  PrevAddrAgeLastSale;
		STRING10 PrevAddrLastSalesPrice;
		STRING2  PrevAddrActivePhoneList;
		STRING10 PrevAddrActivePhoneNumber;
		STRING10 PrevAddrTaxValue;
		STRING4  PrevAddrTaxYr;
		STRING10 PrevAddrTaxMarketValue;
		STRING10 PrevAddrAVMTax;
		STRING10 PrevAddrAVMSalesPrice;
		STRING10 PrevAddrAVMHedonic;
		STRING10 PrevAddrAVMValue;
		STRING2  PrevAddrAVMConfidence;
		STRING5  PrevAddrCountyIndex;
		STRING5  PrevAddrTractIndex;
		STRING5  PrevAddrBlockIndex;
		STRING10 PrevAddrMedianIncome;
		STRING10 PrevAddrMedianValue;
		STRING3  PrevAddrMurderIndex;
		STRING3  PrevAddrCarTheftIndex;
		STRING3  PrevAddrBurglaryIndex;
		STRING3  PrevAddrCrimeIndex;
		STRING2  InputCurrAddrMatch;
		STRING4  InputCurrAddrDistance;
		STRING2  InputCurrAddrStateDiff;
		STRING10 InputCurrAddrTaxDiff;
		STRING11 InputCurrAddrIncomeDiff;
		STRING11 InputCurrAddrValueDiff;
		STRING4  InputCurrAddrCrimeDiff;
		STRING2  InputCurrEconTrajectory;
		STRING2  InputPrevAddrMatch;
		STRING4  CurrPrevAddrDistance;
		STRING2  CurrPrevAddrStateDiff;
		STRING10 CurrPrevAddrTaxDiff;
		STRING11 CurrPrevAddrIncomeDiff;
		STRING11 CurrPrevAddrValueDiff;
		STRING4  CurrPrevAddrCrimeDiff;
		STRING2  PrevCurrEconTrajectory;
		STRING1  EducationAttendedCollege;
		STRING2  EducationProgram2Yr;
		STRING2  EducationProgram4Yr;
		STRING2  EducationProgramGraduate;
		STRING2  EducationInstitutionPrivate;
		STRING2  EducationInstitutionRating;
		STRING2  EducationFieldofStudyType;
		STRING1  AddrStability;
		STRING2  StatusMostRecent;
		STRING2  StatusPrevious;
		STRING2  StatusNextPrevious;
		STRING3  AddrChangeCount01;
		STRING3  AddrChangeCount03;
		STRING3  AddrChangeCount06;
		STRING3  AddrChangeCount12;
		STRING3  AddrChangeCount24;
		STRING3  AddrChangeCount36;
		STRING3  AddrChangeCount60;
		STRING6  PredictedAnnualIncome;
		STRING3  PropOwnedCount;
		STRING13 PropOwnedTaxTotal;
		STRING3  PropOwnedHistoricalCount;
		STRING3  PropAgeOldestPurchase;
		STRING3  PropAgeNewestPurchase;
		STRING3  PropAgeNewestSale;
		STRING4  PropNewestSalePurchaseIndex;
		STRING3  PropPurchasedCount01;
		STRING3  PropPurchasedCount03;
		STRING3  PropPurchasedCount06;
		STRING3  PropPurchasedCount12;
		STRING3  PropPurchasedCount24;
		STRING3  PropPurchasedCount36;
		STRING3  PropPurchasedCount60;
		STRING3  PropSoldCount01;
		STRING3  PropSoldCount03;
		STRING3  PropSoldCount06;
		STRING3  PropSoldCount12;
		STRING3  PropSoldCount24;
		STRING3  PropSoldCount36;
		STRING3  PropSoldCount60;
		STRING3  WatercraftCount;
		STRING3  WatercraftCount01;
		STRING3  WatercraftCount03;
		STRING3  WatercraftCount06;
		STRING3  WatercraftCount12;
		STRING3  WatercraftCount24;
		STRING3  WatercraftCount36;
		STRING3  WatercraftCount60;
		STRING3  AircraftCount;
		STRING3  AircraftCount01;
		STRING3  AircraftCount03;
		STRING3  AircraftCount06;
		STRING3  AircraftCount12;
		STRING3  AircraftCount24;
		STRING3  AircraftCount36;
		STRING3  AircraftCount60;
		STRING1  WealthIndex;
		STRING3  SubPrimeSolicitedCount;
		STRING3  SubPrimeSolicitedCount01;
		STRING3  SubPrimeSolicitedCount03;
		STRING3  SubPrimeSolicitedCount06;
		STRING3  SubPrimeSolicitedCount12;
		STRING3  SubPrimeSolicitedCount24;
		STRING3  SubPrimeSolicitedCount36;
		STRING3  SubPrimeSolicitedCount60;
		STRING2  DerogSeverityIndex;
		STRING3  DerogCount;
		STRING4  DerogAge;
		STRING3  FelonyCount;
		STRING4  FelonyAge;
		STRING3  FelonyCount01;
		STRING3  FelonyCount03;
		STRING3  FelonyCount06;
		STRING3  FelonyCount12;
		STRING3  FelonyCount24;
		STRING3  FelonyCount36;
		STRING3  FelonyCount60;
		STRING3  ArrestCount;
		STRING4  ArrestAge;
		STRING3  ArrestCount01;
		STRING3  ArrestCount03;
		STRING3  ArrestCount06;
		STRING3  ArrestCount12;
		STRING3  ArrestCount24;
		STRING3  ArrestCount36;
		STRING3  ArrestCount60;
		STRING3  LienCount;
		STRING3  LienFiledCount;
		STRING4  LienFiledAge;
		STRING3  LienFiledCount01;
		STRING3  LienFiledCount03;
		STRING3  LienFiledCount06;
		STRING3  LienFiledCount12;
		STRING3  LienFiledCount24;
		STRING3  LienFiledCount36;
		STRING3  LienFiledCount60;
		STRING3  LienReleasedCount;
		STRING4  LienReleasedAge;
		STRING3  LienReleasedCount01;
		STRING3  LienReleasedCount03;
		STRING3  LienReleasedCount06;
		STRING3  LienReleasedCount12;
		STRING3  LienReleasedCount24;
		STRING3  LienReleasedCount36;
		STRING3  LienReleasedCount60;
		STRING3  BankruptcyCount;
		STRING4  BankruptcyAge;
		STRING2  BankruptcyType;
		STRING35 BankruptcyStatus;
		STRING3  BankruptcyCount01;
		STRING3  BankruptcyCount03;
		STRING3  BankruptcyCount06;
		STRING3  BankruptcyCount12;
		STRING3  BankruptcyCount24;
		STRING3  BankruptcyCount36;
		STRING3  BankruptcyCount60;
		STRING3  EvictionCount;
		STRING4  EvictionAge;
		STRING3  EvictionCount01;
		STRING3  EvictionCount03;
		STRING3  EvictionCount06;
		STRING3  EvictionCount12;
		STRING3  EvictionCount24;
		STRING3  EvictionCount36;
		STRING3  EvictionCount60;
		STRING3  NonDerogCount;
		STRING3  NonDerogCount01;
		STRING3  NonDerogCount03;
		STRING3  NonDerogCount06;
		STRING3  NonDerogCount12;
		STRING3  NonDerogCount24;
		STRING3  NonDerogCount36;
		STRING3  NonDerogCount60;
		STRING3  ProfLicCount;
		STRING4  ProfLicAge;
		STRING2  ProfLicTypeCategory;
		STRING8  ProfLicExpireDate;
		STRING3  ProfLicCount01;
		STRING3  ProfLicCount03;
		STRING3  ProfLicCount06;
		STRING3  ProfLicCount12;
		STRING3  ProfLicCount24;
		STRING3  ProfLicCount36;
		STRING3  ProfLicCount60;
		STRING3  ProfLicExpireCount01;
		STRING3  ProfLicExpireCount03;
		STRING3  ProfLicExpireCount06;
		STRING3  ProfLicExpireCount12;
		STRING3  ProfLicExpireCount24;
		STRING3  ProfLicExpireCount36;
		STRING3  ProfLicExpireCount60;
		STRING3  PRSearchCollectionCount;
		STRING3  PRSearchCollectionCount01;
		STRING3  PRSearchCollectionCount03;
		STRING3  PRSearchCollectionCount06;
		STRING3  PRSearchCollectionCount12;
		STRING3  PRSearchCollectionCount24;
		STRING3  PRSearchCollectionCount36;
		STRING3  PRSearchCollectionCount60;
		STRING3  PRSearchIDVFraudCount;
		STRING3  PRSearchIDVFraudCount01;
		STRING3  PRSearchIDVFraudCount03;
		STRING3  PRSearchIDVFraudCount06;
		STRING3  PRSearchIDVFraudCount12;
		STRING3  PRSearchIDVFraudCount24;
		STRING3  PRSearchIDVFraudCount36;
		STRING3  PRSearchIDVFraudCount60;
		STRING3  PRSearchOtherCount;
		STRING3  PRSearchOtherCount01;
		STRING3  PRSearchOtherCount03;
		STRING3  PRSearchOtherCount06;
		STRING3  PRSearchOtherCount12;
		STRING3  PRSearchOtherCount24;
		STRING3  PRSearchOtherCount36;
		STRING3  PRSearchOtherCount60;
		STRING2  InputPhoneStatus;
		STRING2  InputPhonePager;
		STRING2  InputPhoneMobile;
		STRING2  InputPhoneType;
		STRING2  InputPhoneServiceType;
		STRING2  InputAreaCodeChange;
		STRING4  PhoneEDAAgeOldestRecord;
		STRING4  PhoneEDAAgeNewestRecord;
		STRING4  PhoneOtherAgeOldestRecord;
		STRING4  PhoneOtherAgeNewestRecord;
		STRING2  InvalidPhoneZip;
		STRING4  InputPhoneAddrDist;
		STRING6  InputAddrSICCode;
		STRING2  InputAddrValidation;
		STRING5  InputAddrErrorCode;
		STRING2  InputAddrHighRisk;
		STRING2  InputPhoneHighRisk;
		STRING2  InputAddrPrison;
		STRING2  CurrAddrPrison;
		STRING2  PrevAddrPrison;
		STRING2  HistoricalAddrPrison;
		STRING2  InputZipPOBox;
		STRING2  InputZipCorpMil;
		STRING1  DoNotMail;
		STRING errorcode;
			
		RiskProcessing.layout_internal_extras;
END;


Export NONFCRA_InstantId_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
   	
		risk_indicators.Layout_InstandID_NuGen - ri - fua -Chronology - Additional_Lname - Red_Flags -watchlists ;
		 //	field 14-19: risk indicators
   	string4  hri_1;
   	string100 hri_desc_1;
   	string4  hri_2;
   	string100 hri_desc_2;
   	string4  hri_3;
   	string100 hri_desc_3;
   	string4  hri_4;
   	string100 hri_desc_4;
   	string4  hri_5;
   	string100 hri_desc_5;
   	string4  hri_6;
   	string100 hri_desc_6;
   //	field 19-22: potential follow-up actions
   	string4  fua_1;
   	string150 fua_desc_1;
   	string4  fua_2;
   	string150 fua_desc_2;
   	string4  fua_3;
   	string150 fua_desc_3;
   	string4  fua_4;
   	string150 fua_desc_4;
		
   
   //	field 55-60: additional last names
   	string20	additional_fname_1;
   	string20	additional_lname_1;
   	string8	    additional_lname_date_last_1;
   	string20	additional_fname_2;
   	string20	additional_lname_2;
   	string8	    additional_lname_date_last_2;
   	string20	additional_fname_3;
   	string20	additional_lname_3;
   	string8	    additional_lname_date_last_3;
			STRING200 Watchlist_country;
		
			STRING65  Chron_Address_1;
   	STRING25  Chron_City_1;
   	STRING2   Chron_St_1;
   	STRING5   Chron_Zip_1;
   	STRING4   Chron_Zip4_1;					// **** added zip4
   	STRING50  Chron_phone_1;
   	string6   Chron_dt_first_seen_1;		// **** added chronology dates
   	string6   Chron_dt_last_seen_1;			// **** added chronology dates
   	
   	STRING65  Chron_Address_2;
   	STRING25  Chron_City_2;
   	STRING2   Chron_St_2;
   	STRING5   Chron_Zip_2;
   	STRING4   Chron_Zip4_2;					// **** added zip4
   	STRING50  Chron_phone_2;
   	string6   Chron_dt_first_seen_2;		// **** added chronology dates
   	string6   Chron_dt_last_seen_2;			// **** added chronology dates
   	
   	STRING65  Chron_Address_3;
   	STRING25  Chron_City_3;
   	STRING2   Chron_St_3;
   	STRING5   Chron_Zip_3;
       STRING4   Chron_Zip4_3;					// **** added zip4
   	STRING50  Chron_phone_3;
   	string6   Chron_dt_first_seen_3;		// **** added chronology dates
   	string6   Chron_dt_last_seen_3;			// **** added chronology dates
			// new fields added for the R1 2010 enhancement
		 	string1  Chron_addr_1_isBest;
   	string1  Chron_addr_2_isBest;
   	string1  Chron_addr_3_isBest;
		
		 	STRING60  Watchlist_Table_2;
   	STRING120 Watchlist_Program_2;
   	STRING10  Watchlist_Record_Number_2;
   	STRING20  Watchlist_fname_2;
   	STRING20  Watchlist_lname_2;
   	STRING65  Watchlist_address_2;
   	STRING25  Watchlist_city_2;
   	STRING2   Watchlist_state_2;
   	STRING5   Watchlist_zip_2;
   	STRING30  Watchlist_country_2;
   	STRING200 Watchlist_Entity_Name_2;
   	STRING60  Watchlist_Table_3;
   	STRING120 Watchlist_Program_3;
   	STRING10  Watchlist_Record_Number_3;
   	STRING20  Watchlist_fname_3;
   	STRING20  Watchlist_lname_3;
   	STRING65  Watchlist_address_3;
   	STRING25  Watchlist_city_3;
   	STRING2   Watchlist_state_3;
   	STRING5   Watchlist_zip_3;
   	STRING30  Watchlist_country_3;
   	STRING200 Watchlist_Entity_Name_3;
   	STRING60  Watchlist_Table_4;
   	STRING120 Watchlist_Program_4;
   	STRING10  Watchlist_Record_Number_4;
   	STRING20  Watchlist_fname_4;
   	STRING20  Watchlist_lname_4;
   	STRING65  Watchlist_address_4;
   	STRING25  Watchlist_city_4;
   	STRING2   Watchlist_state_4;
   	STRING5   Watchlist_zip_4;
   	STRING30  Watchlist_country_4;
   	STRING200 Watchlist_Entity_Name_4;
   	STRING60  Watchlist_Table_5;
   	STRING120 Watchlist_Program_5;
   	STRING10  Watchlist_Record_Number_5;
   	STRING20  Watchlist_fname_5;
   	STRING20  Watchlist_lname_5;
   	STRING65  Watchlist_address_5;
   	STRING25  Watchlist_city_5;
   	STRING2   Watchlist_state_5;
   	STRING5   Watchlist_zip_5;
   	STRING30  Watchlist_country_5;
   	STRING200 Watchlist_Entity_Name_5;
   	STRING60  Watchlist_Table_6;
   	STRING120 Watchlist_Program_6;
   	STRING10  Watchlist_Record_Number_6;
   	STRING20  Watchlist_fname_6;
   	STRING20  Watchlist_lname_6;
   	STRING65  Watchlist_address_6;
   	STRING25  Watchlist_city_6;
   	STRING2   Watchlist_state_6;
   	STRING5   Watchlist_zip_6;
   	STRING30  Watchlist_country_6;
   	STRING200 Watchlist_Entity_Name_6;
   	STRING60  Watchlist_Table_7;
   	STRING120 Watchlist_Program_7;
   	STRING10  Watchlist_Record_Number_7;
   	STRING20  Watchlist_fname_7;
   	STRING20  Watchlist_lname_7;
   	STRING65  Watchlist_address_7;
   	STRING25  Watchlist_city_7;
   	STRING2   Watchlist_state_7;
   	STRING5   Watchlist_zip_7;
   	STRING30  Watchlist_country_7;
   	STRING200 Watchlist_Entity_Name_7;
	  	// instantid enhancements 3/24/2011	
		string4  hri_7;
   	string100 hri_desc_7;
   	string4  hri_8;
   	string100 hri_desc_8;
   	string4  hri_9;
   	string100 hri_desc_9;
   	string4  hri_10;
   	string100 hri_desc_10;
   	string4  hri_11;
   	string100 hri_desc_11;
   	string4  hri_12;
   	string100 hri_desc_12;
   	string4  hri_13;
   	string100 hri_desc_13;
   	string4  hri_14;
   	string100 hri_desc_14;
   	string4  hri_15;
   	string100 hri_desc_15;
   	string4  hri_16;
   	string100 hri_desc_16;
   	string4  hri_17;
   	string100 hri_desc_17;
   	string4  hri_18;
   	string100 hri_desc_18;
   	string4  hri_19;
   	string100 hri_desc_19;
   	string4  hri_20;
   	string100 hri_desc_20;
   STRING10 ChronPrimRange1;
   	STRING2  ChronPreDir1;
   	STRING28 ChronPrimName1;
   	STRING4  ChronAddrSuffix1;
   	STRING2  ChronPostDir1;
   	STRING10 ChronUnitDesignation1;
   	STRING8  ChronSecRange1;
   	// parsed chronology address 2
   	STRING10 ChronPrimRange2;
   	STRING2  ChronPreDir2;
   	STRING28 ChronPrimName2;
   	STRING4  ChronAddrSuffix2;
   	STRING2  ChronPostDir2;
   	STRING10 ChronUnitDesignation2;
   	STRING8  ChronSecRange2;
   	// parsed chronology address 3
   	STRING10 ChronPrimRange3;
   	STRING2  ChronPreDir3;
   	STRING28 ChronPrimName3;
   	STRING4  ChronAddrSuffix3;
   	STRING2  ChronPostDir3;
   	STRING10 ChronUnitDesignation3;
   	STRING8  ChronSecRange3;
   	// parsed watchlist address 1
   	// STRING10 WatchlistPrimRange;
   	// STRING2  WatchlistPreDir;
   	// STRING28 WatchlistPrimName;
   	// STRING4  WatchlistAddrSuffix;
   	// STRING2  WatchlistPostDir;
   	// STRING10 WatchlistUnitDesignation;
   	// STRING8  WatchlistSecRange;
   	// parsed watchlist address 2
   	STRING10 WatchlistPrimRange2;
   	STRING2  WatchlistPreDir2;
   	STRING28 WatchlistPrimName2;
   	STRING4  WatchlistAddrSuffix2;
   	STRING2  WatchlistPostDir2;
   	STRING10 WatchlistUnitDesignation2;
   	STRING8  WatchlistSecRange2;
   	// parsed watchlist address 3
   	STRING10 WatchlistPrimRange3;
   	STRING2  WatchlistPreDir3;
   	STRING28 WatchlistPrimName3;
   	STRING4  WatchlistAddrSuffix3;
   	STRING2  WatchlistPostDir3;
   	STRING10 WatchlistUnitDesignation3;
   	STRING8  WatchlistSecRange3;
   	// parsed watchlist address 4
   	STRING10 WatchlistPrimRange4;
   	STRING2  WatchlistPreDir4;
   	STRING28 WatchlistPrimName4;
   	STRING4  WatchlistAddrSuffix4;
   	STRING2  WatchlistPostDir4;
   	STRING10 WatchlistUnitDesignation4;
   	STRING8  WatchlistSecRange4;
   	// parsed watchlist address 5
   	STRING10 WatchlistPrimRange5;
   	STRING2  WatchlistPreDir5;
   	STRING28 WatchlistPrimName5;
   	STRING4  WatchlistAddrSuffix5;
   	STRING2  WatchlistPostDir5;
   	STRING10 WatchlistUnitDesignation5;
   	STRING8  WatchlistSecRange5;
   	// parsed watchlist address 6
   	STRING10 WatchlistPrimRange6;
   	STRING2  WatchlistPreDir6;
   	STRING28 WatchlistPrimName6;
   	STRING4  WatchlistAddrSuffix6;
   	STRING2  WatchlistPostDir6;
   	STRING10 WatchlistUnitDesignation6;
   	STRING8  WatchlistSecRange6;
   	// parsed watchlist address 7
   	STRING10 WatchlistPrimRange7;
   	STRING2  WatchlistPreDir7;
   	STRING28 WatchlistPrimName7;
   	STRING4  WatchlistAddrSuffix7;
   	STRING2  WatchlistPostDir7;
   	STRING10 WatchlistUnitDesignation7;
   	STRING8  WatchlistSecRange7;
		STRING errorcode;
	 RiskProcessing.layout_internal_extras;
END;

Export NONFCRA_FraudPoint_V2_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
 
 string30 acctno;
	string30 AccountNumber;
   	Models.Layout_FraudAttributes.version2;	
   	
   	string3 FP_score;
   	string3 FP_reason;
   	string3 FP_reason2;
   	string3 FP_reason3;
   	string3 FP_reason4;
   	string3 FP_reason5;
   	string3 FP_reason6;
   	string1 StolenIdentityIndex;
   	string1 SyntheticIdentityIndex;
   	string1 ManipulatedIdentityIndex;
   	string1 VulnerableVictimIndex;
   	string1 FriendlyFraudIndex;
   	string1 SuspiciousActivityIndex;
   	string200 errorcode;
   	RiskProcessing.layout_internal_extras;
   	
END;		

Export NONFCRA_FraudPoint_V201_AmericanExpress_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  

	string30 acctno;
	string30 AccountNumber;
   	Models.Layout_FraudAttributes.version2;	
   	Models.Layout_FraudAttributes.version201;	
   	string3 FP_score;
   	string3 FP_reason;
   	string3 FP_reason2;
   	string3 FP_reason3;
   	string3 FP_reason4;
   	string3 FP_reason5;
   	string3 FP_reason6;
   	string1 StolenIdentityIndex;
   	string1 SyntheticIdentityIndex;
   	string1 ManipulatedIdentityIndex;
   	string1 VulnerableVictimIndex;
   	string1 FriendlyFraudIndex;
   	string1 SuspiciousActivityIndex;
   	string200 errorcode;
   	RiskProcessing.layout_internal_extras;
   	
END;		

Export NONFCRA_FraudPoint_V3_Global_Layout:=RECORD
	unsigned8 time_ms := 0;  
	string30 acctno;
	string30 AccountNumber;
   	Models.Layout_FraudAttributes.version2;	
   	string10 model_type; 
   	string3 FP_score;
   	string3 FP_reason;
   	string3 FP_reason2;
   	string3 FP_reason3;
   	string3 FP_reason4;
   	string3 FP_reason5;
   	string3 FP_reason6;
   	string1 StolenIdentityIndex;
   	string1 SyntheticIdentityIndex;
   	string1 ManipulatedIdentityIndex;
   	string1 VulnerableVictimIndex;
   	string1 FriendlyFraudIndex;
   	string1 SuspiciousActivityIndex;
   	string200 errorcode;
   	RiskProcessing.layout_internal_extras;
   	
END;		



Export NONFCRA_Chase_CBBL_Global_Layout:=RECORD
	// unsigned8 time_ms {xpath('_call_latency_mstime_ms')};  
	RiskWise.Layout_BC1O;
	STRING errorcode;
	 RiskProcessing.layout_internal_extras;
END;


Export NONFCRA_Chase_BNK4_Global_Layout:=RECORD
	// unsigned8 time_ms {xpath('_call_latency_mstime_ms')};
	RiskWise.Layout_BC1O;
	STRING errorcode;
	 RiskProcessing.layout_internal_extras;
END;

Export NONFCRA_Chase_PIO2_Global_Layout:=RECORD
	// unsigned8 time_ms {xpath('_call_latency_mstime_ms')};
 Riskwise.Layout_PRIO;
	STRING errorcode;
	 RiskProcessing.layout_internal_extras;
END;

Export NONFCRA_BusinessInstantId_Global_Layout:=RECORD

	string30 acctno;
	unsigned8 time_ms := 0;	
	business_risk.Layout_Final_Denorm - score - RepSSNValid - Attributes - BusRiskIndicators - RepRiskIndicators - bnap_indicator - bnas_indicator - bnat_indicator; 
	string1 bnap;
  string1 bnat;
  string1 bnas;
	string200 errorcode;
	 RiskProcessing.layout_internal_extras;
END;

Export NONFCRA_CHASE_BusinessInstantId_Global_Layout:=RECORD
	string30 acctno;
 	unsigned8 time_ms := 0;
 // business_risk.Layout_Final_Denorm - score - RepSSNValid - Attributes - BusRiskIndicators - RepRiskIndicators;  // requested to take the score field out of the layout during testprocessing because batch customers don't see it
	business_risk.Layout_Final_Denorm - bnap_indicator - bnas_indicator - bnat_indicator; 
	string3 fd_score1;
	string3 fd_score2;
	string3 fd_score3;
	string4	fd_Reason1;
	string100	fd_Desc1;
	string4	fd_Reason2;
	string100	fd_Desc2;
	string4	fd_Reason3;
	string100	fd_Desc3;
	string4	fd_Reason4;
	string100	fd_Desc4;
	// business_risk.extra_fields - recordcount - SEQ_NUMBERS;
	DATASET(Models.Layout_Model) models;
		STRING1 Rep_Lien_Unrel_Lvl := ''; // 0-5
	STRING1 Rep_Prop_Owner := ''; // 0-2
	STRING2 Rep_Prof_License_Category := ''; // (-1)-5
	STRING1 Rep_Accident_Count := ''; // 0-3
	STRING1 Rep_Paydayloan_Flag := ''; // Boolean (0-1)
	STRING2 Rep_Age_Lvl := ''; // 18, 25, 35, 45, 46
	STRING1 Rep_Bankruptcy_Count := ''; // 0-3
	STRING1 Rep_Ssns_Per_Adl := ''; // 0-4
	STRING1 Rep_Past_Arrest := ''; // Boolean (0-1)
	STRING3 Rep_Add1_Lres_Lvl := ''; // 0, 12, 24, 48, 72, 96, 192, 193
	STRING1 Rep_Criminal_Assoc_Lvl := ''; // 0, 1, 3, 4
	STRING1 Rep_Felony_Count := ''; // 0-2
	string1 bnap;
  string1 bnat;
  string1 bnas;
	string200 errorcode;
	 RiskProcessing.layout_internal_extras;
END;
Export NONFCRA_IT60_Paro_Global_Layout:=RECORD

 RiskWise.Layout_IT4O;
 string200 errorcode;
 RiskProcessing.layout_internal_extras;
END;

Export NONFCRA_IT61_Paro_Global_Layout:=RECORD
 string errorcode;
 RiskWise.Layout_IT4O;
 // RiskProcessing.layout_internal_extras;
END;

Export BocaShell_Global_Layout:=RECORD
	// unsigned8 time_ms := 0;
	// STRING AccountNumber;
	// risk_indicators.Layout_Boca_Shell - LnJ_datasets - ConsumerStatements ;
riskprocessing.layouts.layout_internal_shell_noDatasets;
// string errorcode;

 END;

Export RiskViewAttributes_v3 := RECORD
	unsigned8 time_ms := 0;	
	string20 acctno;

	string1 index11;
	string6 SSNFirstSeen;
	string8 DateLastSeen;
	string1 isRecentUpdate;
	string3 NumSources;
	string1 isPhoneFullNameMatch;
	string1 isPhoneLastNameMatch;
	string1 isSSNInvalid;
	string1 isPhoneInvalid;
	string1 isAddrInvalid;
	string1 isDLInvalid;
	string1 isNoVer;
	
	string1 isDeceased;
	string8 DeceasedDate;
	string1 isSSNValid;
	string1 isRecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 isNonUS;
	string1 isIssued3;
	string1 isIssuedAge5;

	string6 IADateFirstReported;
	string6 IADateLastReported;
	string3 IALenOfRes;
	string1 IADwellType;
	string1 IALandUseCode;
	string10 IAAssessedValue;
	string1 IAisOwnedBySubject;
	string1 IAisFamilyOwned;
	string1 IAisOccupantOwned;
	string8 IALastSaleDate;
	string10 IALastSaleAmount;
	string1 IAisNotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;

	string6 CADateFirstReported;
	string6 CADateLastReported;
	string3 CALenOfRes;
	string1 CADwellType;
	string1 CALandUseCode;
	string10 CAAssessedValue;
	string1 CAisOwnedBySubject;
	string1 CAisFamilyOwned;
	string1 CAisOccupantOwned;
	string8 CALastSaleDate;
	string10 CALastSaleAmount;
	string1 CAisNotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	
	string6 PADateFirstReported;
	string6 PADateLastReported;
	string3 PALenOfRes;
	string1 PADwellType;
	string1 PALandUseCode;
	string10 PAAssessedValue;
	string1 PAisOwnedBySubject;
	string1 PAisFamilyOwned;
	string1 PAisOccupantOwned;
	string8 PALastSaleDate;
	string10 PALastSaleAmount;
	string1 PAisNotPrimaryRes;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	
	string1 isInputCurrMatch;
	string4 DistInputCurr;
	string1 isDiffState;
	string10 AssessedDiff;
	string2 EcoTrajectory;
	
	string1 isInputPrevMatch;
	string4 DistCurrPrev;
	string1 isDiffState2;
	string10 AssessedDiff2;
	string2 EcoTrajectory2;
	
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string6 PADateFirstReported2;
	string6 NPADateFirstReported;
	string3 addrChanges30;
	string3 addrChanges90;
	string3 addrChanges180;
	string3 addrChanges12;
	string3 addrChanges24;
	string3 addrChanges36;
	string3 addrChanges60;
	
	string3 property_owned_total_v2;
	string13 property_owned_assessed_total_v2;
	string3 property_historically_owned_v2;
	string8 date_first_purchase_v2;
	string8 date_most_recent_purchase_v2;
	string8 date_most_recent_sale;
	string3 numPurchase30;
	string3 numPurchase90;
	string3 numPurchase180;
	string3 numPurchase12;
	string3 numPurchase24;
	string3 numPurchase36;
	string3 numPurchase60;
	string3 numSold30;
	string3 numSold90;
	string3 numSold180;
	string3 numSold12;
	string3 numSold24;
	string3 numSold36;
	string3 numSold60;
	string3 numWatercraft;
	string3 numWatercraft30;
	string3 numWatercraft90;
	string3 numWatercraft180;
	string3 numWatercraft12;
	string3 numWatercraft24;
	string3 numWatercraft36;
	string3 numWatercraft60;
	string3 numAircraft;
	string3 numAircraft30;
	string3 numAircraft90;
	string3 numAircraft180;
	string3 numAircraft12;
	string3 numAircraft24;
	string3 numAircraft36;
	string3 numAircraft60;
	string1 wealth_indicator;
	
	string3 total_number_derogs_v2;
	string8 date_last_derog_v2;
	string3 felonies;
	string8 date_last_conviction;
	string3 felonies30;
	string3 felonies90;
	string3 felonies180;
	string3 felonies12;
	string3 felonies24;
	string3 felonies36;
	string3 felonies60;
	string3 num_liens;
	string3 num_unreleased_liens;
	string8 date_last_unreleased;
	string3 num_unreleased_liens30;
	string3 num_unreleased_liens90;
	string3 num_unreleased_liens180;
	string3 num_unreleased_liens12;
	string3 num_unreleased_liens24;
	string3 num_unreleased_liens36;
	string3 num_unreleased_liens60;
	string3 num_released_liens;
	string8 date_last_released;
	string3 num_released_liens30;
	string3 num_released_liens90;
	string3 num_released_liens180;
	string3 num_released_liens12;
	string3 num_released_liens24;
	string3 num_released_liens36;
	string3 num_released_liens60;
	string3 bankruptcy_count;
	string8 date_last_bankruptcy;
	string1 filing_type;
	string35 disposition_v2;
	string3 bankruptcy_count30;
	string3 bankruptcy_count90;
	string3 bankruptcy_count180;
	string3 bankruptcy_count12;
	string3 bankruptcy_count24;
	string3 bankruptcy_count36;
	string3 bankruptcy_count60;
	string3 eviction_count;
	string8 date_last_eviction;
	string3 eviction_count30;
	string3 eviction_count90;
	string3 eviction_count180;
	string3 eviction_count12;
	string3 eviction_count24;
	string3 eviction_count36;
	string3 eviction_count60;

	string3 num_nonderogs;
	string3 num_nonderogs30;
	string3 num_nonderogs90;
	string3 num_nonderogs180;
	string3 num_nonderogs12;
	string3 num_nonderogs24;
	string3 num_nonderogs36;
	string3 num_nonderogs60;
	string3 num_proflic;
	string8 date_last_proflic;
	string60 proflic_type;
	string8 expire_date_last_proflic;
	string3 num_proflic30;
	string3 num_proflic90;
	string3 num_proflic180;
	string3 num_proflic12;
	string3 num_proflic24;
	string3 num_proflic36;
	string3 num_proflic60;
	string3 num_proflic_exp30;
	string3 num_proflic_exp90;
	string3 num_proflic_exp180;
	string3 num_proflic_exp12;
	string3 num_proflic_exp24;
	string3 num_proflic_exp36;
	string3 num_proflic_exp60;
	
	string1 isAddrHighRisk;
	string1 isPhoneHighRisk;
	string1 isAddrPrison;
	string1 isZipPOBox;
	string1 isZipCorpMil;
	string1 phoneStatus;
	string1 isPhonePager;
	string1 isPhoneMobile;
	string1 isPhoneZipMismatch;
	string4 phoneAddrDist;
	
	string1 correctedFlag;
	string1 disputeFlag;
	string1 securityFreeze;
	string1 securityAlert;
	string1 negativeAlert;
	string1 idTheftFlag;

	string3 AgeOldestRecord; 
	string3 AgeNewestRecord; 
	string3 IAAgeOldestRecord;
	string3 IAAgeNewestRecord;
	string3 IAAgeLastSale;
	string3 CAAgeOldestRecord;
	string3 CAAgeNewestRecord;
	string3 CAAgeLastSale;
	string3 PAAgeOldestRecord;
	string3 PAAgeNewestRecord;
	string3 PAAgeLastSale;
	string3 PropAgeOldestPurchase;
	string3 PropAgeNewestPurchase;
	string3 PropAgeNewestSale;
	string3 DerogAge;
	string3 FelonyAge;
	string3 LienFiledAge;
	string3 LienReleasedAge;
	string3 BankruptcyAge;
	string3 EvictionAge;
	string3 ProfLicAge;

	string1 SSNNotFound;
	string1 VerifiedName;
	string1 VerifiedSSN;
	string1 VerifiedPhone;
	string1 VerifiedAddress;
	string1 VerifiedDOB;
	string3 InferredMinimumAge;
	string3 BestReportedAge;
	string3 SubjectSSNCount;
	string3 SubjectAddrCount;
	string3 SubjectPhoneCount;
	string3 SubjectSSNRecentCount;
	string3 SubjectAddrRecentCount;
	string3 SubjectPhoneRecentCount;
	string3 SSNIdentitiesCount;
	string3 SSNAddrCount;
	string3 SSNIdentitiesRecentCount;
	string3 SSNAddrRecentCount;
	string3 InputAddrIdentitiesCount;
	string3 InputAddrSSNCount;
	string3 InputAddrPhoneCount;
	string3 InputAddrIdentitiesRecentCount;
	string3 InputAddrSSNRecentCount;
	string3 InputAddrPhoneRecentCount;
	string3 PhoneIdentitiesCount;
	string3 PhoneIdentitiesRecentCount;
	string1 SSNIssuedPriorDOB;
	
	string4 InputAddrTaxYr;
	string10 InputAddrTaxMarketValue;
	string10 InputAddrAVMTax;
	string10 InputAddrAVMSalesPrice;
	string10 InputAddrAVMHedonic;
	string10 InputAddrAVMValue;
	string3 InputAddrAVMConfidence;
	string5 InputAddrCountyIndex;
	string5 InputAddrTractIndex;
	string5 InputAddrBlockIndex;
	
	string4 CurrAddrTaxYr;
	string10 CurrAddrTaxMarketValue;
	string10 CurrAddrAVMTax;
	string10 CurrAddrAVMSalesPrice;
	string10 CurrAddrAVMHedonic;
	string10 CurrAddrAVMValue;
	string3 CurrAddrAVMConfidence;
	string5 CurrAddrCountyIndex;
	string5 CurrAddrTractIndex;
	string5 CurrAddrBlockIndex;
	
	string4 PrevAddrTaxYr;
	string10 PrevAddrTaxMarketValue;
	string10 PrevAddrAVMTax;
	string10 PrevAddrAVMSalesPrice;
	string10 PrevAddrAVMHedonic;
	string10 PrevAddrAVMValue;
	string3 PrevAddrAVMConfidence;
	string5 PrevAddrCountyIndex;
	string5 PrevAddrTractIndex;
	string5 PrevAddrBlockIndex;
	
	string1 EducationAttendedCollege;
	string1 EducationProgram2Yr;
	string1 EducationProgram4Yr;
	string1 EducationProgramGraduate;
	string1 EducationInstitutionPrivate;
	string1 EducationInstitutionRating;
	
	string10 PredictedAnnualIncome;
	
	string10 PropNewestSalePrice;
	string5 PropNewestSalePurchaseIndex;
	string5 PropNewestSaleTaxIndex;	// these 2 fields will not be populated, waiting on batch to say if they should be removed or not from the layout
	string5 PropNewestSaleAVMIndex;
	
	string3 SubPrimeSolicitedCount;
	string3 SubPrimeSolicitedCount01;
	string3 SubprimeSolicitedCount03;
	string3 SubprimeSolicitedCount06;
	string3 SubPrimeSolicitedCount12;
	string3 SubPrimeSolicitedCount24;
	string3 SubPrimeSolicitedCount36;
	string3 SubPrimeSolicitedCount60;
	
	string10 LienFederalTaxFiledTotal;
	string10 LienTaxOtherFiledTotal;
	string10 LienForeclosureFiledTotal;
	string10 LienPreforeclosureFiledTotal;
	string10 LienLandlordTenantFiledTotal;
	string10 LienJudgmentFiledTotal;
	string10 LienSmallClaimsFiledTotal;
	string10 LienOtherFiledTotal;
	string10 LienFederalTaxReleasedTotal;
	string10 LienTaxOtherReleasedTotal;
	string10 LienForeclosureReleasedTotal;
	string10 LienPreforeclosureReleasedTotal;
	string10 LienLandlordTenantReleasedTotal;
	string10 LienJudgmentReleasedTotal;
	string10 LienSmallClaimsReleasedTotal;
	string10 LienOtherReleasedTotal;
	
	string3 LienFederalTaxFiledCount;
	string3 LienTaxOtherFiledCount;
	string3 LienForeclosureFiledCount;
	string3 LienPreforeclosureFiledCount;
	string3 LienLandlordTenantFiledCount;
	string3 LienJudgmentFiledCount;
	string3 LienSmallClaimsFiledCount;
	string3 LienOtherFiledCount;
	string3 LienFederalTaxReleasedCount;
	string3 LienTaxOtherReleasedCount;
	string3 LienForeclosureReleasedCount;
	string3 LienPreforeclosureReleasedCount;
	string3 LienLandlordTenantReleasedCount;
	string3 LienJudgmentReleasedCount;
	string3 LienSmallClaimsReleasedCount;
	string3 LienOtherReleasedCount;
	
	string1 ProfLicTypeCategory;
	
	string3 PhoneEDAAgeOldestRecord;
	string3 PhoneEDAAgeNewestRecord;
	string3 PhoneOtherAgeOldestRecord;
	string3 PhoneOtherAgeNewestRecord;
	
	string1 PrescreenOptOut;
	
	string12 DID;  // internal field for troubleshooting and logging
	
	RiskProcessing.layout_internal_extras;
	string200 errorcode;
END;

Export AddressShell_Attributes_V1_BATCH_Generic_Global_Layout:=RECORD
      string acctno;
			unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  
	    Address_Shell.layoutPropertyCharacteristics;
			STRING errorcode;
END;

Export BusinessShell_Attributes_V2_XML_Generic_Global_Layout:=RECORD
      string acctno;
			unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  
	    Business_Risk_BIP.Layouts.OutputLayout;
			STRING errorcode;
END;

END;

