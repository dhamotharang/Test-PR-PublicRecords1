/*--SOAP--
<message name="Profile Booster">
	<part name="ProfileBoosterRequest" type="tns:XmlDataSet" cols="80" rows="50"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
  <part name="DataRestrictionMask" type="xsd:string"/>
  <part name="DataPermissionMask" type="xsd:string"/>
 </message>
*/

IMPORT iesp, Risk_indicators, Riskwise, address,std;

EXPORT Search_Service := MACRO

	// Get XML input 
	requestIn   := dataset([], iesp.profileboosterattributes.t_ProfileBoosterRequest)  	: stored('ProfileBoosterRequest', few);
  firstRow 		:= requestIn[1] : INDEPENDENT; // Since this is realtime and not batch, should only have one row on input.
	optionsIn 	:= GLOBAL(firstRow.options);
	userIn 			:= GLOBAL(firstRow.user);
	search 			:= GLOBAL(firstRow.SearchBy);
	
  BOOLEAN DEBUG := False;
  
	/* **********************************************
		 *  Fields needed for improved Scout Logging  *
		 **********************************************/
		string32 _LoginID               := ''	: STORED('_LoginID');
		outofbandCompanyID							:= '' : STORED('_CompanyID');
		string20 CompanyID              := if(userIn.CompanyId != '', userIn.CompanyId, outofbandCompanyID);
		string20 FunctionName           := '' : STORED('_LogFunctionName');
		string50 ESPMethod              := '' : STORED('_ESPMethodName');
		string10 InterfaceVersion       := '' : STORED('_ESPClientInterfaceVersion');
		string5 DeliveryMethod          := '' : STORED('_DeliveryMethod');
		string5 DeathMasterPurpose      := '' : STORED('__deathmasterpurpose');
		outofbandssnmask                := '' : STORED('SSNMask');
		string10 SSN_Mask               := if(userIn.SSNMask != '', userIn.SSNMask, outofbandssnmask);
		outofbanddobmask                := '' : STORED('DOBMask');
		string10 DOB_Mask               := if(userIn.DOBMask != '', userIn.DOBMask, outofbanddobmask);
		BOOLEAN DL_Mask                 := userIn.DLMask;
		BOOLEAN ExcludeDMVPII           := userIn.ExcludeDMVPII;
		BOOLEAN DisableOutcomeTracking  := False : STORED('OutcomeTrackingOptOut');
		BOOLEAN ArchiveOptIn            := False : STORED('instantidarchivingoptin');
    
		//Look up the industry by the company ID.
		Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.ProfileBooster__Search_Service);
	/* ************* End Scout Fields **************/
	
	string6  outOfBandHistoryDate := '' : STORED('HistoryDateYYYYMM');
	HistoryDateYYYYMM 						:= StringLib.StringToUpperCase(optionsIn.HistoryDateYYYYMM);
	HistoryDateInput							:= if(HistoryDateYYYYMM <> '', HistoryDateYYYYMM, outOfBandHistoryDate);	
	
	STRING50 outOfBandDataRestriction   := AutoStandardI.GlobalModule().DataRestrictionMask;
	// Check to see if the default from GlobalModule() is used, if so overwrite it to our default data restriction.  Our default doesn't include spaces.
  STRING50 DataRestriction := MAP(TRIM(userIn.DataRestrictionMask) <> '' 								=> userIn.DataRestrictionMask,
                                  TRIM(outOfBandDataRestriction) not in ['', '1    0'] 	=> outOfBandDataRestriction, //only use the OOB DRM if it's actually been provided (not the default)
																																													 Risk_Indicators.iid_constants.default_DataRestriction);

  STRING50 outOfBandDataPermission := AutoStandardI.GlobalModule().DataPermissionMask;
  STRING50 DataPermission := MAP(TRIM(userIn.DataPermissionMask) <> '' => userIn.DataPermissionMask,
                                 TRIM(outOfBandDataPermission) <> ''   => outOfBandDataPermission,
																																						Risk_Indicators.iid_constants.default_DataPermission);

	TestDataEnabled 			:= userIn.TestDataEnabled;
	TestDataTableName 		:= Trim(userIn.TestDataTableName);
	attributesVersion 		:= StringLib.StringToUpperCase(optionsIn.AttributesVersionRequest);
	
	industry_class_val 		:= (string)userIn.IndustryClass;

	fullname 							:= trim(search.name.full);
	cleanname 						:= address.CleanPerson73( fullname );
	title  								:= if(search.name.prefix='' and fullname!='', trim((cleanname[1..5]))  , trim(search.name.prefix));
	fname  								:= if(search.name.first ='' and fullname!='', trim((cleanname[6..25])) , trim(search.name.first));
	mname  								:= if(search.name.middle='' and fullname!='', trim((cleanname[26..45])), trim(search.name.middle));
	lname  								:= if(search.name.last  ='' and fullname!='', trim((cleanname[46..65])), trim(search.name.last));
	suffix 								:= if(search.name.suffix='' and fullname!='', trim((cleanname[66..70])), trim(search.name.suffix));

	streetName 						:= TRIM(search.Address.StreetName);
	streetNumber 					:= TRIM(search.Address.StreetNumber);
	streetPreDirection 		:= TRIM(search.Address.StreetPreDirection);
	streetPostDirection 	:= TRIM(search.Address.StreetPostDirection);
	streetSuffix 					:= TRIM(search.Address.StreetSuffix);
	UnitNumber 						:= TRIM(search.Address.UnitNumber);
	UnitDesig 						:= TRIM(search.Address.UnitDesignation);
	tempStreetAddr 				:= Address.Addr1FromComponents(streetNumber, StreetPreDirection,	streetName, StreetSuffix, StreetPostDirection, UnitDesig, UnitNumber);
	in_streetAddress1 		:= IF(search.Address.StreetAddress1='', TRIM(tempStreetAddr), TRIM(search.Address.StreetAddress1));
	in_streetAddress2 		:= TRIM(search.Address.StreetAddress2);
	streetAddr 						:= TRIM(in_streetAddress1 + ' ' + in_streetAddress2);

	boolean NameCheck		  := fname <> '' and lname <> '';
	boolean AddrCheck		  := in_streetAddress1 <> '';
	boolean ZipCheck			:= LENGTH(TRIM(search.address.zip5)) = 5;
	boolean SSNCheck			:= LENGTH(TRIM(search.SSN)) = 9;
	boolean InputOption1	:= NameCheck and AddrCheck and ZipCheck;
	boolean InputOption2	:= NameCheck and SSNCheck;
	boolean InputValid 		:= InputOption1 or InputOption2;
  
	boolean RequestValid 	:= attributesVersion in ProfileBooster.Constants.setValidAttributeVersions;  //version 1 is the initial version

	if(~InputValid and ~TestDataEnabled, FAIL( 'Please input the minimum required fields'));
	if(~RequestValid, FAIL('Invalid attributes version requested - eg PBAttrV1'));

	layout_acctseq := record
		integer4 seq;
		requestIn;
	end;
	wseq := project( requestIn, transform( layout_acctseq, self.seq := counter, self := left ) );

  setvalidmodels :=['PB1708_1'];
  ModelNames := optionsIn.IncludeModels.Names;
  custommodel_in := std.str.touppercase(Trim(ModelNames[1].value, ALL));
  domodel := custommodel_in IN setvalidmodels;

	ProfileBooster.Layouts.Layout_PB_In into(wseq l) := TRANSFORM
		self.seq 									:= l.seq;
		self.HistoryDate 					:= if((unsigned)HistoryDateInput=0, risk_indicators.iid_constants.default_history_date, (unsigned)HistoryDateInput);
		self.ssn 									:= l.SearchBy.ssn;
		self.dob 									:= l.SearchBy.dob.year + intformat((integer1)l.SearchBy.dob.month, 2, 1) + intformat((integer1)l.SearchBy.dob.day, 2, 1);
		self.Name_Full 						:= fullname;
		self.Name_Title  					:= title;
		self.Name_First  					:= fname;
		self.Name_Middle 					:= mname;
		self.Name_Last  					:= lname;
		self.Name_Suffix 					:= suffix;
		self.street_addr					:= streetAddr;
		self.streetnumber					:= streetnumber;
		self.streetpredirection		:= streetpredirection;
		self.streetname						:= streetname;
		self.streetsuffix					:= streetsuffix;
		self.streetpostdirection	:= streetpostdirection;
		self.unitdesignation			:= unitdesig;
		self.unitnumber						:= unitnumber;
		self.City_name         		:= search.address.city;
		self.st        						:= search.address.state;
		self.z5      							:= search.address.zip5;	
		self.phone10 			   			:= search.Phone;
		self.acctno 							:= userIn.AccountNumber;
		self											:= [];
	END;
	
	PB_Input := PROJECT(wseq, into(left));	

	Risk_Indicators.Layout_Input intoLayoutInput(Risk_Indicators.iid_constants.ds_Record le, INTEGER c) := TRANSFORM
		SELF.seq 				:= c;
		SELF.fname 			:= trim(stringlib.stringtouppercase(fname));
		SELF.lname 			:= trim(stringlib.stringtouppercase(lname));
		SELF.ssn 				:= trim(search.SSN);
		SELF.in_zipCode := trim(search.address.zip5);
		SELF.phone10 		:= trim(search.Phone);
		SELF 						:= [];
	END;

	packagedTestseedInput := PROJECT(Risk_Indicators.iid_constants.ds_Record, intoLayoutInput(LEFT, COUNTER));	

#IF(DEBUG)
  // temporary for testing on dev roxie when new key isn't available
  searchResults := ProfileBooster.Search_Function(PB_Input, DataRestriction, DataPermission, AttributesVersion, false, domodel, custommodel_in); // Realtime Values
  PBResults := searchResults;
  
#ELSE
	searchResults := IF(TestDataEnabled, 
											ProfileBooster.TestSeed_Function(packagedTestseedInput, TestDataTableName), // TestSeed Values
											ProfileBooster.Search_Function(PB_Input, DataRestriction, DataPermission, AttributesVersion, domodel, custommodel_in) // Realtime Values
										 );	
										   
										 

										

iesp.share.t_NameValuePair createrec(searchResults le, integer C) := TRANSFORM
			
			EstIncomeRangeAttribute := 'PBATTRV1HHEIR';

			self.Name:= MAP( 
					c <> 107 AND trim(stringlib.stringtouppercase(AttributesVersion)) = EstIncomeRangeAttribute => '',
					c = 1	 	=> 'DoNotMail',
					c = 2		=> 'VerifiedProspectFound',
					c = 3		=> 'VerifiedName',
					c = 4		=> 'VerifiedSSN',
					c = 5		=> 'VerifiedPhone',
					c = 6		=> 'VerifiedCurrResMatchIndex',
					c = 7		=> 'ProspectTimeOnRecord',
					c = 8		=> 'ProspectTimeLastUpdate',
					c = 9		=> 'ProspectLastUpdate12Mo',
					c = 10	=> 'ProspectAge',
					c = 11	=> 'ProspectGender',
					c = 12	=> 'ProspectMaritalStatus',
					c = 13	=> 'ProspectEstimatedIncomeRange',
					c = 14	=> 'ProspectDeceased',
					c = 15	=> 'ProspectCollegeAttending',
					c = 16	=> 'ProspectCollegeAttended',
					c = 17	=> 'ProspectCollegeProgramType',
					c = 18	=> 'ProspectCollegePrivate',
					c = 19	=> 'ProspectCollegeTier',
					c = 20	=> 'ProspectBankingExperience',
					c = 21	=> 'AssetCurrOwner',
					c = 22	=> 'PropCurrOwner',
					c = 23	=> 'PropCurrOwnedCnt',
					c = 24	=> 'PropCurrOwnedAssessedTtl',
					c = 25	=> 'PropCurrOwnedAVMTtl',
					c = 26	=> 'PropTimeLastSale',
					c = 27	=> 'PropEverOwnedCnt',
					c = 28	=> 'PropEverSoldCnt',
					c = 29	=> 'PropSoldCnt12Mo',
					c = 30	=> 'PropSoldRatio',
					c = 31	=> 'PropPurchaseCnt12Mo',
					c = 32	=> 'PPCurrOwner',
					c = 33	=> 'PPCurrOwnedCnt',
					c = 34	=> 'PPCurrOwnedAutoCnt',
					c = 35	=> 'PPCurrOwnedMtrcycleCnt',
					c = 36	=> 'PPCurrOwnedAircrftCnt',
					c = 37	=> 'PPCurrOwnedWtrcrftCnt',
					c = 38	=> 'LifeEvTimeLastMove',
					c = 39	=> 'LifeEvNameChange',
					c = 40	=> 'LifeEvNameChangeCnt12Mo',
					c = 41	=> 'LifeEvTimeFirstAssetPurchase',
					c = 42	=> 'LifeEvTimeLastAssetPurchase',
					c = 43	=> 'LifeEvEverResidedCnt',
					c = 44	=> 'LifeEvLastMoveTaxRatioDiff',
					c = 45	=> 'LifeEvEconTrajectory',
					c = 46	=> 'LifeEvEconTrajectoryIndex',
					c = 47	=> 'ResCurrOwnershipIndex',
					c = 48	=> 'ResCurrAVMValue',
					c = 49	=> 'ResCurrAVMValue12Mo',
					c = 50	=> 'ResCurrAVMRatioDiff12Mo',
					c = 51	=> 'ResCurrAVMValue60Mo',
					c = 52	=> 'ResCurrAVMRatioDiff60Mo',
					c = 53	=> 'ResCurrAVMCntyRatio',
					c = 54	=> 'ResCurrAVMTractRatio',
					c = 55	=> 'ResCurrAVMBlockRatio',
					c = 56	=> 'ResCurrDwellType',
					c = 57	=> 'ResCurrDwellTypeIndex',
					c = 58	=> 'ResCurrMortgageType',
					c = 59	=> 'ResCurrMortgageAmount',
					c = 60	=> 'ResCurrBusinessCnt',
					c = 61	=> 'ResInputOwnershipIndex',
					c = 62	=> 'ResInputAVMValue',
					c = 63	=> 'ResInputAVMValue12Mo',
					c = 64	=> 'ResInputAVMRatioDiff12Mo',
					c = 65	=> 'ResInputAVMValue60Mo',
					c = 66	=> 'ResInputAVMRatioDiff60Mo',
					c = 67	=> 'ResInputAVMCntyRatio',
					c = 68	=> 'ResInputAVMTractRatio',
					c = 69	=> 'ResInputAVMBlockRatio',
					c = 70	=> 'ResInputDwellType',
					c = 71	=> 'ResInputDwellTypeIndex',
					c = 72	=> 'ResInputMortgageType',
					c = 73	=> 'ResInputMortgageAmount',
					c = 74	=> 'ResInputBusinessCnt',					
					c = 75	=> 'CrtRecCnt',
					c = 76	=> 'CrtRecCnt12Mo',
					c = 77	=> 'CrtRecTimeNewest',
					c = 78	=> 'CrtRecFelonyCnt',
					c = 79	=> 'CrtRecFelonyCnt12Mo',
					c = 80	=> 'CrtRecFelonyTimeNewest',
					c = 81	=> 'CrtRecMsdmeanCnt',
					c = 82	=> 'CrtRecMsdmeanCnt12Mo',
					c = 83	=> 'CrtRecMsdmeanTimeNewest',
					c = 84	=> 'CrtRecEvictionCnt',
					c = 85	=> 'CrtRecEvictionCnt12Mo',
					c = 86	=> 'CrtRecEvictionTimeNewest',
					c = 87	=> 'CrtRecLienJudgCnt',
					c = 88	=> 'CrtRecLienJudgCnt12Mo',
					c = 89	=> 'CrtRecLienJudgTimeNewest',
					c = 90	=> 'CrtRecLienJudgAmtTtl',
					c = 91	=> 'CrtRecBkrptCnt',
					c = 92	=> 'CrtRecBkrptCnt12Mo',
					c = 93	=> 'CrtRecBkrptTimeNewest',
					c = 94	=> 'CrtRecSeverityIndex',
					c = 95	=> 'OccProfLicense',
					c = 96	=> 'OccProfLicenseCategory',
					c = 97	=> 'OccBusinessAssociation',
					c = 98	=> 'OccBusinessAssociationTime',
					c = 99	=> 'OccBusinessTitleLeadership',
					c = 100	=> 'InterestSportPerson',
					c = 101	=> 'HHTeenagerMmbrCnt',
					c = 102	=> 'HHYoungAdultMmbrCnt',
					c = 103	=> 'HHMiddleAgeMmbrCnt',
					c = 104	=> 'HHSeniorMmbrCnt',
					c = 105	=> 'HHElderlyMmbrCnt',
					c = 106	=> 'HHCnt',
					c = 107	=> 'HHEstimatedIncomeRange',
					c = 108	=> 'HHCollegeAttendedMmbrCnt',
					c = 109	=> 'HHCollege2yrAttendedMmbrCnt',
					c = 110	=> 'HHCollege4yrAttendedMmbrCnt',
					c = 111	=> 'HHCollegeGradAttendedMmbrCnt',
					c = 112	=> 'HHCollegePrivateMmbrCnt',
					c = 113	=> 'HHCollegeTierMmbrHighest',
					c = 114	=> 'HHPropCurrOwnerMmbrCnt',
					c = 115	=> 'HHPropCurrOwnedCnt',
					c = 116	=> 'HHPropCurrAVMHighest',
					c = 117	=> 'HHPPCurrOwnedCnt',
					c = 118	=> 'HHPPCurrOwnedAutoCnt',
					c = 119	=> 'HHPPCurrOwnedMtrcycleCnt',
					c = 120	=> 'HHPPCurrOwnedAircrftCnt',
					c = 121	=> 'HHPPCurrOwnedWtrcrftCnt',
					c = 122	=> 'HHCrtRecMmbrCnt',
					c = 123	=> 'HHCrtRecMmbrCnt12Mo',
					c = 124	=> 'HHCrtRecFelonyMmbrCnt',
					c = 125	=> 'HHCrtRecFelonyMmbrCnt12Mo',
					c = 126	=> 'HHCrtRecMsdmeanMmbrCnt',
					c = 127	=> 'HHCrtRecMsdmeanMmbrCnt12Mo',
					c = 128	=> 'HHCrtRecEvictionMmbrCnt',
					c = 129	=> 'HHCrtRecEvictionMmbrCnt12Mo',
					c = 130	=> 'HHCrtRecLienJudgMmbrCnt',
					c = 131	=> 'HHCrtRecLienJudgMmbrCnt12Mo',
					c = 132	=> 'HHCrtRecLienJudgAmtTtl',
					c = 133	=> 'HHCrtRecBkrptMmbrCnt',
					c = 134	=> 'HHCrtRecBkrptMmbrCnt12Mo',
					c = 135	=> 'HHCrtRecBkrptMmbrCnt24Mo',
					c = 136	=> 'HHOccProfLicMmbrCnt',
					c = 137	=> 'HHOccBusinessAssocMmbrCnt',
					c = 138	=> 'HHInterestSportPersonMmbrCnt',
					c = 139	=> 'RaATeenageMmbrCnt',
					c = 140	=> 'RaAYoungAdultMmbrCnt',
					c = 141	=> 'RaAMiddleAgeMmbrCnt',
					c = 142	=> 'RaASeniorMmbrCnt',
					c = 143	=> 'RaAElderlyMmbrCnt',
					c = 144	=> 'RaAHHCnt',
					c = 145	=> 'RaAMmbrCnt',
					c = 146	=> 'RaAMedIncomeRange',
					c = 147	=> 'RaACollegeAttendedMmbrCnt',
					c = 148	=> 'RaACollege2yrAttendedMmbrCnt',
					c = 149	=> 'RaACollege4yrAttendedMmbrCnt',
					c = 150	=> 'RaACollegeGradAttendedMmbrCnt',
					c = 151	=> 'RaACollegePrivateMmbrCnt',
					c = 152	=> 'RaACollegeTopTierMmbrCnt',
					c = 153	=> 'RaACollegeMidTierMmbrCnt',
					c = 154	=> 'RaACollegeLowTierMmbrCnt',
					c = 155	=> 'RaAPropCurrOwnerMmbrCnt',
					c = 156	=> 'RaAPropOwnerAVMHighest',
					c = 157	=> 'RaAPropOwnerAVMMed',
					c = 158	=> 'RaAPPCurrOwnerMmbrCnt',
					c = 159	=> 'RaAPPCurrOwnerAutoMmbrCnt',
					c = 160	=> 'RaAPPCurrOwnerMtrcycleMmbrCnt',
					c = 161	=> 'RaAPPCurrOwnerAircrftMmbrCnt',
					c = 162	=> 'RaAPPCurrOwnerWtrcrftMmbrCnt',
					c = 163	=> 'RaACrtRecMmbrCnt',
					c = 164	=> 'RaACrtRecMmbrCnt12Mo',
					c = 165	=> 'RaACrtRecFelonyMmbrCnt',
					c = 166	=> 'RaACrtRecFelonyMmbrCnt12Mo',
					c = 167	=> 'RaACrtRecMsdmeanMmbrCnt',
					c = 168	=> 'RaACrtRecMsdmeanMmbrCnt12Mo',
					c = 169	=> 'RaACrtRecEvictionMmbrCnt',
					c = 170	=> 'RaACrtRecEvictionMmbrCnt12Mo',
					c = 171	=> 'RaACrtRecLienJudgMmbrCnt',
					c = 172	=> 'RaACrtRecLienJudgMmbrCnt12Mo',
					c = 173	=> 'RaACrtRecLienJudgAmtMax',
					c = 174	=> 'RaACrtRecBkrptMmbrCnt36Mo',
					c = 175	=> 'RaAOccProfLicMmbrCnt',
					c = 176	=> 'RaAOccBusinessAssocMmbrCnt',
					c = 177	=> 'RaAInterestSportPersonMmbrCnt',
					
					c = 178	=> 'PPCurrOwnedAutoVIN',
					c = 179	=> 'PPCurrOwnedAutoYear',
					c = 180	=> 'PPCurrOwnedAutoMake',
					c = 181	=> 'PPCurrOwnedAutoModel',
					c = 182	=> 'PPCurrOwnedAutoSeries',
					c = 183	=> 'PPCurrOwnedAutoType',		
										 'Invalid');
			
			
			self.Value:=  MAP(			
					c <> 107 AND trim(stringlib.stringtouppercase(AttributesVersion)) = EstIncomeRangeAttribute => '',
					c = 1		=> le.attributes.version1.DoNotMail,
					c = 2		=> le.attributes.version1.VerifiedProspectFound,
					c = 3		=> le.attributes.version1.VerifiedName,
					c = 4		=> le.attributes.version1.VerifiedSSN,
					c = 5		=> le.attributes.version1.VerifiedPhone,
					c = 6		=> le.attributes.version1.VerifiedCurrResMatchIndex,
					c = 7		=> le.attributes.version1.ProspectTimeOnRecord,
					c = 8		=> le.attributes.version1.ProspectTimeLastUpdate,
					c = 9		=> le.attributes.version1.ProspectLastUpdate12Mo,
					c = 10	=> le.attributes.version1.ProspectAge,
					c = 11	=> le.attributes.version1.ProspectGender,
					c = 12	=> le.attributes.version1.ProspectMaritalStatus,
					c = 13	=> le.attributes.version1.ProspectEstimatedIncomeRange,
					c = 14	=> le.attributes.version1.ProspectDeceased,
					c = 15	=> le.attributes.version1.ProspectCollegeAttending,
					c = 16	=> le.attributes.version1.ProspectCollegeAttended,
					c = 17	=> le.attributes.version1.ProspectCollegeProgramType,
					c = 18	=> le.attributes.version1.ProspectCollegePrivate,
					c = 19	=> le.attributes.version1.ProspectCollegeTier,
					c = 20	=> le.attributes.version1.ProspectBankingExperience,
					c = 21	=> le.attributes.version1.AssetCurrOwner,
					c = 22	=> le.attributes.version1.PropCurrOwner,
					c = 23	=> le.attributes.version1.PropCurrOwnedCnt,
					c = 24	=> le.attributes.version1.PropCurrOwnedAssessedTtl,
					c = 25	=> le.attributes.version1.PropCurrOwnedAVMTtl,
					c = 26	=> le.attributes.version1.PropTimeLastSale,
					c = 27	=> le.attributes.version1.PropEverOwnedCnt,
					c = 28	=> le.attributes.version1.PropEverSoldCnt,
					c = 29	=> le.attributes.version1.PropSoldCnt12Mo,
					c = 30	=> le.attributes.version1.PropSoldRatio,
					c = 31	=> le.attributes.version1.PropPurchaseCnt12Mo,
					c = 32	=> le.attributes.version1.PPCurrOwner,
					c = 33	=> le.attributes.version1.PPCurrOwnedCnt,
					c = 34	=> le.attributes.version1.PPCurrOwnedAutoCnt,
					c = 35	=> le.attributes.version1.PPCurrOwnedMtrcycleCnt,
					c = 36	=> le.attributes.version1.PPCurrOwnedAircrftCnt,
					c = 37	=> le.attributes.version1.PPCurrOwnedWtrcrftCnt,
					c = 38	=> le.attributes.version1.LifeEvTimeLastMove,
					c = 39	=> le.attributes.version1.LifeEvNameChange,
					c = 40	=> le.attributes.version1.LifeEvNameChangeCnt12Mo,
					c = 41	=> le.attributes.version1.LifeEvTimeFirstAssetPurchase,
					c = 42	=> le.attributes.version1.LifeEvTimeLastAssetPurchase,
					c = 43	=> le.attributes.version1.LifeEvEverResidedCnt,
					c = 44	=> le.attributes.version1.LifeEvLastMoveTaxRatioDiff,
					c = 45	=> le.attributes.version1.LifeEvEconTrajectory,
					c = 46	=> le.attributes.version1.LifeEvEconTrajectoryIndex,
					c = 47	=> le.attributes.version1.ResCurrOwnershipIndex,
					c = 48	=> le.attributes.version1.ResCurrAVMValue,
					c = 49	=> le.attributes.version1.ResCurrAVMValue12Mo,
					c = 50	=> le.attributes.version1.ResCurrAVMRatioDiff12Mo,
					c = 51	=> le.attributes.version1.ResCurrAVMValue60Mo,
					c = 52	=> le.attributes.version1.ResCurrAVMRatioDiff60Mo,
					c = 53	=> le.attributes.version1.ResCurrAVMCntyRatio,
					c = 54	=> le.attributes.version1.ResCurrAVMTractRatio,
					c = 55	=> le.attributes.version1.ResCurrAVMBlockRatio,
					c = 56	=> le.attributes.version1.ResCurrDwellType,
					c = 57	=> le.attributes.version1.ResCurrDwellTypeIndex,
					c = 58	=> le.attributes.version1.ResCurrMortgageType,
					c = 59	=> le.attributes.version1.ResCurrMortgageAmount,
					c = 60	=> le.attributes.version1.ResCurrBusinessCnt,
					c = 61	=> le.attributes.version1.ResInputOwnershipIndex,
					c = 62	=> le.attributes.version1.ResInputAVMValue,
					c = 63	=> le.attributes.version1.ResInputAVMValue12Mo,
					c = 64	=> le.attributes.version1.ResInputAVMRatioDiff12Mo,
					c = 65	=> le.attributes.version1.ResInputAVMValue60Mo,
					c = 66	=> le.attributes.version1.ResInputAVMRatioDiff60Mo,
					c = 67	=> le.attributes.version1.ResInputAVMCntyRatio,
					c = 68	=> le.attributes.version1.ResInputAVMTractRatio,
					c = 69	=> le.attributes.version1.ResInputAVMBlockRatio,
					c = 70	=> le.attributes.version1.ResInputDwellType,
					c = 71	=> le.attributes.version1.ResInputDwellTypeIndex,
					c = 72	=> le.attributes.version1.ResInputMortgageType,
					c = 73	=> le.attributes.version1.ResInputMortgageAmount,
					c = 74	=> le.attributes.version1.ResInputBusinessCnt,					
					c = 75	=> le.attributes.version1.CrtRecCnt,
					c = 76	=> le.attributes.version1.CrtRecCnt12Mo,
					c = 77	=> le.attributes.version1.CrtRecTimeNewest,
					c = 78	=> le.attributes.version1.CrtRecFelonyCnt,
					c = 79	=> le.attributes.version1.CrtRecFelonyCnt12Mo,
					c = 80	=> le.attributes.version1.CrtRecFelonyTimeNewest,
					c = 81	=> le.attributes.version1.CrtRecMsdmeanCnt,
					c = 82	=> le.attributes.version1.CrtRecMsdmeanCnt12Mo,
					c = 83	=> le.attributes.version1.CrtRecMsdmeanTimeNewest,
					c = 84	=> le.attributes.version1.CrtRecEvictionCnt,
					c = 85	=> le.attributes.version1.CrtRecEvictionCnt12Mo,
					c = 86	=> le.attributes.version1.CrtRecEvictionTimeNewest,
					c = 87	=> le.attributes.version1.CrtRecLienJudgCnt,
					c = 88	=> le.attributes.version1.CrtRecLienJudgCnt12Mo,
					c = 89	=> le.attributes.version1.CrtRecLienJudgTimeNewest,
					c = 90	=> le.attributes.version1.CrtRecLienJudgAmtTtl,
					c = 91	=> le.attributes.version1.CrtRecBkrptCnt,
					c = 92	=> le.attributes.version1.CrtRecBkrptCnt12Mo,
					c = 93	=> le.attributes.version1.CrtRecBkrptTimeNewest,
					c = 94	=> le.attributes.version1.CrtRecSeverityIndex,
					c = 95	=> le.attributes.version1.OccProfLicense,
					c = 96	=> le.attributes.version1.OccProfLicenseCategory,
					c = 97	=> le.attributes.version1.OccBusinessAssociation,
					c = 98	=> le.attributes.version1.OccBusinessAssociationTime,
					c = 99	=> le.attributes.version1.OccBusinessTitleLeadership,
					c = 100	=> le.attributes.version1.InterestSportPerson,
					c = 101	=> le.attributes.version1.HHTeenagerMmbrCnt,
					c = 102	=> le.attributes.version1.HHYoungAdultMmbrCnt,
					c = 103	=> le.attributes.version1.HHMiddleAgeMmbrCnt,
					c = 104	=> le.attributes.version1.HHSeniorMmbrCnt,
					c = 105	=> le.attributes.version1.HHElderlyMmbrCnt,
					c = 106	=> le.attributes.version1.HHCnt,
					c = 107	=> le.attributes.version1.HHEstimatedIncomeRange,
					c = 108	=> le.attributes.version1.HHCollegeAttendedMmbrCnt,
					c = 109	=> le.attributes.version1.HHCollege2yrAttendedMmbrCnt,
					c = 110	=> le.attributes.version1.HHCollege4yrAttendedMmbrCnt,
					c = 111	=> le.attributes.version1.HHCollegeGradAttendedMmbrCnt,
					c = 112	=> le.attributes.version1.HHCollegePrivateMmbrCnt,
					c = 113	=> le.attributes.version1.HHCollegeTierMmbrHighest,
					c = 114	=> le.attributes.version1.HHPropCurrOwnerMmbrCnt,
					c = 115	=> le.attributes.version1.HHPropCurrOwnedCnt,
					c = 116	=> le.attributes.version1.HHPropCurrAVMHighest,
					c = 117	=> le.attributes.version1.HHPPCurrOwnedCnt,
					c = 118	=> le.attributes.version1.HHPPCurrOwnedAutoCnt,
					c = 119	=> le.attributes.version1.HHPPCurrOwnedMtrcycleCnt,
					c = 120	=> le.attributes.version1.HHPPCurrOwnedAircrftCnt,
					c = 121	=> le.attributes.version1.HHPPCurrOwnedWtrcrftCnt,
					c = 122	=> le.attributes.version1.HHCrtRecMmbrCnt,
					c = 123	=> le.attributes.version1.HHCrtRecMmbrCnt12Mo,
					c = 124	=> le.attributes.version1.HHCrtRecFelonyMmbrCnt,
					c = 125	=> le.attributes.version1.HHCrtRecFelonyMmbrCnt12Mo,
					c = 126	=> le.attributes.version1.HHCrtRecMsdmeanMmbrCnt,
					c = 127	=> le.attributes.version1.HHCrtRecMsdmeanMmbrCnt12Mo,
					c = 128	=> le.attributes.version1.HHCrtRecEvictionMmbrCnt,
					c = 129	=> le.attributes.version1.HHCrtRecEvictionMmbrCnt12Mo,
					c = 130	=> le.attributes.version1.HHCrtRecLienJudgMmbrCnt,
					c = 131	=> le.attributes.version1.HHCrtRecLienJudgMmbrCnt12Mo,
					c = 132	=> le.attributes.version1.HHCrtRecLienJudgAmtTtl,
					c = 133	=> le.attributes.version1.HHCrtRecBkrptMmbrCnt,
					c = 134	=> le.attributes.version1.HHCrtRecBkrptMmbrCnt12Mo,
					c = 135	=> le.attributes.version1.HHCrtRecBkrptMmbrCnt24Mo,
					c = 136	=> le.attributes.version1.HHOccProfLicMmbrCnt,
					c = 137	=> le.attributes.version1.HHOccBusinessAssocMmbrCnt,
					c = 138	=> le.attributes.version1.HHInterestSportPersonMmbrCnt,
					c = 139	=> le.attributes.version1.RaATeenageMmbrCnt,
					c = 140	=> le.attributes.version1.RaAYoungAdultMmbrCnt,
					c = 141	=> le.attributes.version1.RaAMiddleAgeMmbrCnt,
					c = 142	=> le.attributes.version1.RaASeniorMmbrCnt,
					c = 143	=> le.attributes.version1.RaAElderlyMmbrCnt,
					c = 144	=> le.attributes.version1.RaAHHCnt,
					c = 145	=> le.attributes.version1.RaAMmbrCnt,
					c = 146	=> le.attributes.version1.RaAMedIncomeRange,
					c = 147	=> le.attributes.version1.RaACollegeAttendedMmbrCnt,
					c = 148	=> le.attributes.version1.RaACollege2yrAttendedMmbrCnt,
					c = 149	=> le.attributes.version1.RaACollege4yrAttendedMmbrCnt,
					c = 150	=> le.attributes.version1.RaACollegeGradAttendedMmbrCnt,
					c = 151	=> le.attributes.version1.RaACollegePrivateMmbrCnt,
					c = 152	=> le.attributes.version1.RaACollegeTopTierMmbrCnt,
					c = 153	=> le.attributes.version1.RaACollegeMidTierMmbrCnt,
					c = 154	=> le.attributes.version1.RaACollegeLowTierMmbrCnt,
					c = 155	=> le.attributes.version1.RaAPropCurrOwnerMmbrCnt,
					c = 156	=> le.attributes.version1.RaAPropOwnerAVMHighest,
					c = 157	=> le.attributes.version1.RaAPropOwnerAVMMed,
					c = 158	=> le.attributes.version1.RaAPPCurrOwnerMmbrCnt,
					c = 159	=> le.attributes.version1.RaAPPCurrOwnerAutoMmbrCnt,
					c = 160	=> le.attributes.version1.RaAPPCurrOwnerMtrcycleMmbrCnt,
					c = 161	=> le.attributes.version1.RaAPPCurrOwnerAircrftMmbrCnt,
					c = 162	=> le.attributes.version1.RaAPPCurrOwnerWtrcrftMmbrCnt,
					c = 163	=> le.attributes.version1.RaACrtRecMmbrCnt,
					c = 164	=> le.attributes.version1.RaACrtRecMmbrCnt12Mo,
					c = 165	=> le.attributes.version1.RaACrtRecFelonyMmbrCnt,
					c = 166	=> le.attributes.version1.RaACrtRecFelonyMmbrCnt12Mo,
					c = 167	=> le.attributes.version1.RaACrtRecMsdmeanMmbrCnt,
					c = 168	=> le.attributes.version1.RaACrtRecMsdmeanMmbrCnt12Mo,
					c = 169	=> le.attributes.version1.RaACrtRecEvictionMmbrCnt,
					c = 170	=> le.attributes.version1.RaACrtRecEvictionMmbrCnt12Mo,
					c = 171	=> le.attributes.version1.RaACrtRecLienJudgMmbrCnt,
					c = 172	=> le.attributes.version1.RaACrtRecLienJudgMmbrCnt12Mo,
					c = 173	=> le.attributes.version1.RaACrtRecLienJudgAmtMax,
					c = 174	=> le.attributes.version1.RaACrtRecBkrptMmbrCnt36Mo,
					c = 175	=> le.attributes.version1.RaAOccProfLicMmbrCnt,
					c = 176	=> le.attributes.version1.RaAOccBusinessAssocMmbrCnt,
					c = 177	=> le.attributes.version1.RaAInterestSportPersonMmbrCnt,
					
					c = 178	=> le.attributes.version1.PPCurrOwnedAutoVIN,
					c = 179	=> le.attributes.version1.PPCurrOwnedAutoYear,
					c = 180	=> le.attributes.version1.PPCurrOwnedAutoMake,
					c = 181	=> le.attributes.version1.PPCurrOwnedAutoModel,
					c = 182	=> le.attributes.version1.PPCurrOwnedAutoSeries,
					c = 183	=> le.attributes.version1.PPCurrOwnedAutoType,		
					
										 'Invalid');
		
	END;
 	
	IndIndex := normalize(ungroup(searchResults), 183, createrec(LEFT,COUNTER ));
	
	iesp.ProfileBoosterAttributes.t_ProfileBoosterResponse IntoResults(wseq le, searchResults ri ) := Transform
    	self.InputEcho := le.SearchBy;	
			self.AttributesGroup.Name := attributesVersion;  
			SELF.AttributesGroup.attributes :=  IndIndex;
			self.UniqueId := (string)ri.LexID;
      	self.Models := project(ri, 
								transform(iesp.ProfileBoosterAttributes.t_ProfileBoosterModelHRI, 
								self.Name := custommodel_in; 
								self.scores := project(left,
                transform (iesp.ProfileBoosterAttributes.t_ProfileBoosterScoreHRI,
                self.value := (integer)left.attributes.version1.score1;
                // self.scorename1 := project(left,
                // transform (iesp.ProfileBoosterAttributes.t_ProfileBoosterScoreHRI,
                // self.type := (integer)left.attributes.version1.scorename1;
								
                
                self := [];  // RemoteLocations & ServiceLocations that we don't care about;//hidden[internal]
								))));
      
      
		  self := le;
			self := [];
	END;

  
  
  
	PBResults := join(wseq, searchResults,
	                     right.seq = left.seq,
											 IntoResults(LEFT, RIGHT));



	//Log to Deltabase
	Deltabase_Logging_prep := project(PBResults, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																									 self.company_id := (Integer)CompanyID,
																									 self.login_id := _LoginID,
																									 self.product_id := Risk_Reporting.ProductID.ProfileBooster__Search_Service,
																									 self.function_name := FunctionName,
																									 self.esp_method := ESPMethod,
																									 self.interface_version := InterfaceVersion,
																									 self.delivery_method := DeliveryMethod,
																									 self.date_added := (STRING8)Std.Date.Today(),
																									 self.death_master_purpose := DeathMasterPurpose,
																									 self.ssn_mask := SSN_Mask,
																									 self.dob_mask := DOB_Mask,
																									 self.dl_mask := (String)(Integer)DL_Mask,
																									 self.exclude_dmv_pii := (String)(Integer)ExcludeDMVPII,
																									 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																									 self.archive_opt_in := (String)(Integer)ArchiveOptIn,
                                                   self.glb := (Integer)userIn.GLBPurpose,
                                                   self.dppa := (Integer)userIn.DLPurpose,
																									 self.data_restriction_mask := DataRestriction,
																									 self.data_permission_mask := DataPermission,
																									 self.industry := Industry_Search[1].Industry,
																									 self.i_attributes_name := attributesVersion,
																									 self.i_ssn := search.SSN,
                                                   self.i_dob := Search.dob.year +
                                                                 intformat((integer1)Search.dob.month, 2, 1) +
                                                                 intformat((integer1)Search.dob.day, 2, 1),
                                                   self.i_name_full := search.Name.Full,
																									 self.i_name_first := search.Name.First,
																									 self.i_name_last := search.Name.Last,
																									 self.i_lexid := (Integer)search.UniqueId,
																									 self.i_address := streetAddr,
																									 self.i_city := search.address.City,
																									 self.i_state := search.address.State,
																									 self.i_zip := search.address.Zip5,
                                                   self.i_home_phone := search.phone,
																									 self.i_model_name_1 := custommodel_in,
																									 self.o_score_1    := (String)left.Models[1].Scores[1].Value,
																									 self.o_reason_1_1 := left.Models[1].Scores[1].ScoreReasons[1].ReasonCode,
																									 self.o_reason_1_2 := left.Models[1].Scores[1].ScoreReasons[2].ReasonCode,
																									 self.o_reason_1_3 := left.Models[1].Scores[1].ScoreReasons[3].ReasonCode,
																									 self.o_reason_1_4 := left.Models[1].Scores[1].ScoreReasons[4].ReasonCode,
																									 self.o_reason_1_5 := left.Models[1].Scores[1].ScoreReasons[5].ReasonCode,
																									 self.o_reason_1_6 := left.Models[1].Scores[1].ScoreReasons[6].ReasonCode,
																									 self.o_lexid := (Integer)left.UniqueId,
																									 self := left,
																									 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
	// #stored('Deltabase_Log', Deltabase_Logging);

	//Improved Scout Logging
	IF(~DisableOutcomeTracking and ~TestDataEnabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

#END
// output(historydate, NAMED('historydate'));
 //output(searchresults, NAMED('searchresults'));
// output(historydate, NAMED('historydate'));
  output(PBResults, NAMED('Results'));

ENDMACRO;

/*--HELP-- 
<pre>
&lt;PBRequest&gt;
 &lt;Row&gt;
  &lt;User&gt;
   &lt;GLBPurpose&gt;&lt;/GLBPurpose&gt; 
   &lt;DLPurpose&gt;&lt;/DLPurpose&gt; 
   &lt;DataRestrictionMask&gt;&lt;/DataRestrictionMask&gt; 
   &lt;DataPermissionMask&gt;&lt;/DataPermissionMask&gt; 
   &lt;IndustryClass&gt;&lt;/IndustryClass&gt; 
   &lt;TestDataEnabled&gt;false&lt;/TestDataEnabled&gt;
   &lt;TestDataTableName&gt;&lt;/TestDataTableName&gt;
  &lt;/User&gt; 
  &lt;Options&gt;
   &lt;AttributesVersionRequest&gt;&lt;/AttributesVersionRequest&gt;
   &lt;HistoryDateYYYYMM&gt;&lt;/HistoryDateYYYYMM&gt;
  &lt;/Options&gt;
  &lt;SearchBy&gt;
	 &lt;UniqueId&gt;&lt;/UniqueId&gt;
	 &lt;Name&gt;
    &lt;Full&gt;&lt;/Full&gt; 
    &lt;First&gt;&lt;/First&gt; 
    &lt;Middle&gt;&lt;/Middle&gt; 
    &lt;Last&gt;&lt;/Last&gt; 
    &lt;Suffix&gt;&lt;/Suffix&gt; 
    &lt;Prefix&gt;&lt;/Prefix&gt; 
   &lt;/Name&gt;
   &lt;Address&gt;
    &lt;StreetNumber&gt;&lt;/StreetNumber&gt; 
    &lt;StreetPreDirection&gt;&lt;/StreetPreDirection&gt; 
    &lt;StreetName&gt;&lt;/StreetName&gt; 
    &lt;StreetSuffix&gt;&lt;/StreetSuffix&gt; 
    &lt;StreetPostDirection&gt;&lt;/StreetPostDirection&gt; 
    &lt;UnitDesignation&gt;&lt;/UnitDesignation&gt; 
    &lt;UnitNumber&gt;&lt;/UnitNumber&gt; 
    &lt;StreetAddress1&gt;&lt;/StreetAddress1&gt; 
    &lt;StreetAddress2&gt;&lt;/StreetAddress2&gt; 
    &lt;City&gt;&lt;/City&gt; 
    &lt;State&gt;&lt;/State&gt; 
    &lt;Zip5&gt;&lt;/Zip5&gt;
    &lt;Zip4&gt;&lt;/Zip4&gt; 
    &lt;County&gt;&lt;/County&gt; 
    &lt;PostalCode&gt;&lt;/PostalCode&gt; 
    &lt;StateCityZip&gt;&lt;/StateCityZip&gt; 
   &lt;/Address&gt;
   &lt;Phone&gt;&lt;/Phone&gt;
   &lt;DOB&gt;
    &lt;Year&gt;0&lt;/Year&gt; 
    &lt;Month&gt;0&lt;/Month&gt; 
    &lt;Day&gt;0&lt;/Day&gt; 
   &lt;/DOB&gt;
   &lt;SSN&gt;&lt;/SSN&gt;
  &lt;/SearchBy&gt;
 &lt;/Row&gt;
&lt;/PBRequest&gt;
</pre>
*/
