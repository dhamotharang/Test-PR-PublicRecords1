// *****************************************************************************************************************
// RUN THIS SCRIPT ON 400 WAY THOR TO OPTIMIZE PERFORMANCE
// 1.  COPY ALL PUBLIC RECORD KEYS THAT PROFILE BOOSTER USES TO THE THOR400_STA CLUSTER
// 2.  MAKE SURE UT.FOREIGN_PROD IS SANDBOXED TO '~' SO YOU'RE READING ALL DATA LOCALLY
// 3.  IF YOU ALREADY HAVE A ProfileBooster 1.0 FILE, THEN JUST RUN bwr_ProfileBooster11_THOR_append.ecl instead
// 4.  onThor is set in _Control.Environment.onThor -- toggle this value as necessary.
// 5.  VehicleV2.Key_Vehicle_linkids needs to be sandboxed to BIPV2.IDmacros.mac_IndexWithXLinkIDs(BipParty, k, VehicleV2.Constant.str_linkid_keyname + 'QA');
// *****************************************************************************************************************

import ProfileBooster, _Control, Address, Risk_Indicators, STD;
onThor := _Control.Environment.onThor;

#workunit('name', 'profile booster 11 ' + 	if(onThor, 'thor ', 'roxie ') );
#stored('did_add_force', if(onThor, 'thor', 'roxi') );  // this option is the stored parameter used inside the DID append macro to determine which version of the macro to use
#OPTION('multiplePersistInstances', TRUE); // doesn't rename the persist files for each job
// The following options are for running KEL on THOR
#OPTION('expandSelectCreateRow', true);
#OPTION('outputLimit', 2000);
#OPTION('outputLimitMb', 1000);
#OPTION('splitterSpill', 1);
#OPTION('defaultSkewError', 1);

	eyeball_count := 10;

	layout_file_input := RECORD
		STRING Account;//PID
		STRING POwner;
		STRING SID;
		STRING SOwner;
		STRING FirstName;
		// STRING MiddleName;
		STRING LastName;
		STRING StreetAddress;
		STRING StreetAddress2; //Suite
		STRING City;
		STRING State;
		STRING Zip;
		// string EMAIL;  
		// STRING HomePhone;
		// STRING SSN;
		// STRING DateOfBirth;
		// STRING WorkPhone;
		// STRING income;  
		// string DLNumber;
		// string DLState;													
		// string BALANCE; 
		// string CHARGEOFFD;  
		// string FormerName;
		
		// string employername;
		// string historydate;
		// unsigned did;// pass in the DID to shorten up the workunit processing time
	END;
							
	test_file_name := 'bhg-ln_sample_20191209.txt';
						
	ds_in_temp := dataset('~pb11::in::'+test_file_name, layout_file_input, csv(heading(single), quote('"')));	
	output(choosen(ds_in_temp, eyeball_count), named('sample1_input_records'));
	ds_in := ds_in_temp;
	
	/*
	NOTE: THE FOLLOWING FUNCTION IS USED TO CONVERT HISTORYDATES ON A FILE WITH MULTIPLE HISTORYDATES 
	IF THERE IS MORE THAN 1 HISTORYDATE IN THE FILE, THEN ds_in CAN BE COMMENTED OUT ABOVE AND 
	ALL OF THE LINES BELOW UP TO ds_in CAN BE UNCOMMENTED OUT
  ***THIS ASSUMES THAT ALL OF THE HISTORYDATES ARE USING THE SAME YYYY.  UPDATE THE YEAR ON THE HISTORYDATE1 THRU HISTORYDATE4 VARIABLES BELOW IF RUNNING A DIFFERENT YEAR
  ***RUN THIS SCRIPT 4 TIMES, ONCE FOR EACH HISTORYDATE BY CHANGING LINE 79 (history_dateYYYYMMDD := historyDate3;)
  ***APPEND ALL OF THE RESULTS TOGETHER FOR A FINAL FILE
	*/
	//START OF HISTORYDATE CONVERSION CODE
				// convertDateToQuarter(inDate) := FUNCTIONMACRO
					// quarter := MAP(
													// (INTEGER)inDate[5..6] <= 3  => inDate[1..4]+'0101',
													// (INTEGER)inDate[5..6] <= 6  => inDate[1..4]+'0401',
													// (INTEGER)inDate[5..6] <= 9  => inDate[1..4]+'0701',
													// (INTEGER)inDate[5..6] <= 12 => inDate[1..4]+'1001',
													// inDate[1..4]+'0101');
					// return quarter;									
				// ENDMACRO;
				// historyDate1 := '20190101'; 
				// historyDate2 := '20190401'; 
				// historyDate3 := '20190701'; 
				// historyDate4 := '20191001'; 
				// history_dateYYYYMMDD := historyDate3;
history_dateYYYYMMDD := (STRING)STD.Date.Today();
				// ds_in_pre := PROJECT(ds_in_temp, TRANSFORM(RECORDOF(LEFT), 
																						// SELF.historydate := convertDateToQuarter(StringLib.StringFilter(StringLib.StringToUpperCase(LEFT.historydate), '1234567890'));
																						// SELF := LEFT;));
				// output(choosen(ds_in_pre, eyeball_count), named('sample2_input_records'));
				// ds_in := ds_in_pre(historydate=history_dateYYYYMMDD);
	//END OF HISTORYDATE CONVERSION CODE	
	
	dist_ds := distribute(ds_in, random());
	batch_in := project(dist_ds, transform(ProfileBooster.Layouts.Layout_PB_In, 
			self.HistoryDate := (unsigned3)history_dateYYYYMMDD[1..6];  //use this line when running a file with multiple history dates or no history date at all
			// self.HistoryDate := (unsigned3)left.historydate[1..6];  //use the history date in the file if they are all the same value
			self.AcctNo := left.account;
			// self.SSN := left.ssn;
			self.Name_First := left.firstname;
			self.Name_Last := left.lastname;
			// self.DOB := left.DateOfBirth;
			self.street_addr := TRIM(left.streetaddress+' '+left.StreetAddress2);
			self.City_name := left.city;	
			self.St := left.state;
			self.Z5 := left.zip;
			// self.phone10 := left.homephone;
			// self.LexID := left.did;  // pass in the DID to shorten up the workunit processing time
			self := [];
			));

	output(choosen(batch_in, eyeball_count), named('batch_in_sample'));
	
	string5 	IndustryClassVal 					:= '';
	STRING50 	DataRestriction						:= '00000000000000000000000000000000000000000000000000';
	string50 	DataPermission 						:= '11111111111111111111111111111111111111111111111111';
	string9   AttributesVersionRequest	:= 'PBATTRV1'; 
	
	PB_wseq := project( batch_in, transform( ProfileBooster.Layouts.Layout_PB_In, 
																	self.seq := counter; 
																	cleaned_name := address.CleanPerson73(left.Name_Full);
																	boolean valid_cleaned := left.Name_Full <> '';
																	self.Name_First  := stringlib.stringtouppercase(if(left.Name_First='' AND valid_cleaned, cleaned_name[6..25], left.Name_First));
																	self.Name_Last 	 := stringlib.stringtouppercase(if(left.Name_Last='' AND valid_cleaned, cleaned_name[46..65], left.Name_Last));
																	self.Name_Middle := stringlib.stringtouppercase(if(left.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], left.Name_Middle));
																	self.Name_Suffix := stringlib.stringtouppercase(if(left.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], left.Name_Suffix));	
																	self.Name_Title  := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[1..5],''));
																	street_address := risk_indicators.MOD_AddressClean.street_address(left.street_addr, left.streetnumber, left.streetpredirection, left.streetname, left.streetsuffix, left.streetpostdirection, left.unitdesignation, left.unitnumber);
																	self.street_addr := street_address;
																	self := left ) );
	attributes := ProfileBooster.Search_Function(PB_wseq, DataRestriction, DataPermission, AttributesVersionRequest, false, '', 'PB11_1');  
	output(choosen(attributes, eyeball_count), named('Search_Function_attributes'));
		 
	ProfileBooster.Layouts.Layout_PB_BatchOutFlat addAcct(attributes le, PB_wSeq ri) := transform
		self.AcctNo 																	:= ri.AcctNo;
		self.seq																			:= le.seq;
		self.LexID 																		:= le.LexID;
		self.v1_DoNotMail	 														:= le.attributes.version1.DoNotMail;
		self.v1_VerifiedProspectFound									:= le.attributes.version1.VerifiedProspectFound;
		self.v1_VerifiedName													:= le.attributes.version1.VerifiedName;
		self.v1_VerifiedSSN														:= le.attributes.version1.VerifiedSSN;
		self.v1_VerifiedPhone													:= le.attributes.version1.VerifiedPhone;
		self.v1_VerifiedCurrResMatchIndex							:= le.attributes.version1.VerifiedCurrResMatchIndex;
		self.v1_ProspectTimeOnRecord									:= le.attributes.version1.ProspectTimeOnRecord;
		self.v1_ProspectTimeLastUpdate								:= le.attributes.version1.ProspectTimeLastUpdate;
		self.v1_ProspectLastUpdate12Mo								:= le.attributes.version1.ProspectLastUpdate12Mo;
		self.v1_ProspectAge														:= le.attributes.version1.ProspectAge;
		self.v1_ProspectGender												:= le.attributes.version1.ProspectGender;
		self.v1_ProspectMaritalStatus									:= le.attributes.version1.ProspectMaritalStatus;
		self.v1_ProspectEstimatedIncomeRange					:= le.attributes.version1.ProspectEstimatedIncomeRange;
		self.v1_ProspectDeceased											:= le.attributes.version1.ProspectDeceased;
		self.v1_ProspectCollegeAttending							:= le.attributes.version1.ProspectCollegeAttending;
		self.v1_ProspectCollegeAttended								:= le.attributes.version1.ProspectCollegeAttended;
		self.v1_ProspectCollegeProgramType						:= le.attributes.version1.ProspectCollegeProgramType;
		self.v1_ProspectCollegePrivate								:= le.attributes.version1.ProspectCollegePrivate;
		self.v1_ProspectCollegeTier										:= le.attributes.version1.ProspectCollegeTier;
		self.v1_ProspectBankingExperience							:= le.attributes.version1.ProspectBankingExperience;
		self.v1_AssetCurrOwner												:= le.attributes.version1.AssetCurrOwner;
		self.v1_PropCurrOwner													:= le.attributes.version1.PropCurrOwner;
		self.v1_PropCurrOwnedCnt											:= le.attributes.version1.PropCurrOwnedCnt;
		self.v1_PropCurrOwnedAssessedTtl							:= le.attributes.version1.PropCurrOwnedAssessedTtl;
		self.v1_PropCurrOwnedAVMTtl										:= le.attributes.version1.PropCurrOwnedAVMTtl;
		self.v1_PropTimeLastSale											:= le.attributes.version1.PropTimeLastSale;
		self.v1_PropEverOwnedCnt											:= le.attributes.version1.PropEverOwnedCnt;
		self.v1_PropEverSoldCnt												:= le.attributes.version1.PropEverSoldCnt;
		self.v1_PropSoldCnt12Mo												:= le.attributes.version1.PropSoldCnt12Mo;
		self.v1_PropSoldRatio													:= le.attributes.version1.PropSoldRatio;
		self.v1_PropPurchaseCnt12Mo										:= le.attributes.version1.PropPurchaseCnt12Mo;
		self.v1_PPCurrOwner														:= le.attributes.version1.PPCurrOwner;
		self.v1_PPCurrOwnedCnt												:= le.attributes.version1.PPCurrOwnedCnt;
		self.v1_PPCurrOwnedAutoCnt										:= le.attributes.version1.PPCurrOwnedAutoCnt;
		self.v1_PPCurrOwnedMtrcycleCnt								:= le.attributes.version1.PPCurrOwnedMtrcycleCnt;
		self.v1_PPCurrOwnedAircrftCnt									:= le.attributes.version1.PPCurrOwnedAircrftCnt;
		self.v1_PPCurrOwnedWtrcrftCnt									:= le.attributes.version1.PPCurrOwnedWtrcrftCnt;
		self.v1_LifeEvTimeLastMove										:= le.attributes.version1.LifeEvTimeLastMove;
		self.v1_LifeEvNameChange											:= le.attributes.version1.LifeEvNameChange;
		self.v1_LifeEvNameChangeCnt12Mo								:= le.attributes.version1.LifeEvNameChangeCnt12Mo;
		self.v1_LifeEvTimeFirstAssetPurchase					:= le.attributes.version1.LifeEvTimeFirstAssetPurchase;
		self.v1_LifeEvTimeLastAssetPurchase						:= le.attributes.version1.LifeEvTimeLastAssetPurchase;
		self.v1_LifeEvEverResidedCnt									:= le.attributes.version1.LifeEvEverResidedCnt;
		self.v1_LifeEvLastMoveTaxRatioDiff						:= le.attributes.version1.LifeEvLastMoveTaxRatioDiff;
		self.v1_LifeEvEconTrajectory									:= le.attributes.version1.LifeEvEconTrajectory;
		self.v1_LifeEvEconTrajectoryIndex							:= le.attributes.version1.LifeEvEconTrajectoryIndex;
		self.v1_ResCurrOwnershipIndex									:= le.attributes.version1.ResCurrOwnershipIndex;
		self.v1_ResCurrAVMValue												:= le.attributes.version1.ResCurrAVMValue;
		self.v1_ResCurrAVMValue12Mo										:= le.attributes.version1.ResCurrAVMValue12Mo;
		self.v1_ResCurrAVMRatioDiff12Mo								:= le.attributes.version1.ResCurrAVMRatioDiff12Mo;
		self.v1_ResCurrAVMValue60Mo										:= le.attributes.version1.ResCurrAVMValue60Mo;
		self.v1_ResCurrAVMRatioDiff60Mo								:= le.attributes.version1.ResCurrAVMRatioDiff60Mo;
		self.v1_ResCurrAVMCntyRatio										:= le.attributes.version1.ResCurrAVMCntyRatio;
		self.v1_ResCurrAVMTractRatio									:= le.attributes.version1.ResCurrAVMTractRatio;
		self.v1_ResCurrAVMBlockRatio									:= le.attributes.version1.ResCurrAVMBlockRatio;
		self.v1_ResCurrDwellType											:= le.attributes.version1.ResCurrDwellType;
		self.v1_ResCurrDwellTypeIndex									:= le.attributes.version1.ResCurrDwellTypeIndex;
		self.v1_ResCurrMortgageType										:= le.attributes.version1.ResCurrMortgageType;
		self.v1_ResCurrMortgageAmount									:= le.attributes.version1.ResCurrMortgageAmount;
		self.v1_ResCurrBusinessCnt										:= le.attributes.version1.ResCurrBusinessCnt;
		self.v1_ResInputOwnershipIndex								:= le.attributes.version1.ResInputOwnershipIndex;
		self.v1_ResInputAVMValue											:= le.attributes.version1.ResInputAVMValue;
		self.v1_ResInputAVMValue12Mo									:= le.attributes.version1.ResInputAVMValue12Mo;
		self.v1_ResInputAVMRatioDiff12Mo							:= le.attributes.version1.ResInputAVMRatioDiff12Mo;
		self.v1_ResInputAVMValue60Mo									:= le.attributes.version1.ResInputAVMValue60Mo;
		self.v1_ResInputAVMRatioDiff60Mo							:= le.attributes.version1.ResInputAVMRatioDiff60Mo;
		self.v1_ResInputAVMCntyRatio									:= le.attributes.version1.ResInputAVMCntyRatio;
		self.v1_ResInputAVMTractRatio									:= le.attributes.version1.ResInputAVMTractRatio;
		self.v1_ResInputAVMBlockRatio									:= le.attributes.version1.ResInputAVMBlockRatio;
		self.v1_ResInputDwellType											:= le.attributes.version1.ResInputDwellType;
		self.v1_ResInputDwellTypeIndex								:= le.attributes.version1.ResInputDwellTypeIndex;
		self.v1_ResInputMortgageType									:= le.attributes.version1.ResInputMortgageType;
		self.v1_ResInputMortgageAmount								:= le.attributes.version1.ResInputMortgageAmount;
		self.v1_ResInputBusinessCnt										:= le.attributes.version1.ResInputBusinessCnt;
		self.v1_CrtRecCnt															:= le.attributes.version1.CrtRecCnt;
		self.v1_CrtRecCnt12Mo													:= le.attributes.version1.CrtRecCnt12Mo;
		self.v1_CrtRecTimeNewest											:= le.attributes.version1.CrtRecTimeNewest;
		self.v1_CrtRecFelonyCnt												:= le.attributes.version1.CrtRecFelonyCnt;
		self.v1_CrtRecFelonyCnt12Mo										:= le.attributes.version1.CrtRecFelonyCnt12Mo;
		self.v1_CrtRecFelonyTimeNewest								:= le.attributes.version1.CrtRecFelonyTimeNewest;
		self.v1_CrtRecMsdmeanCnt											:= le.attributes.version1.CrtRecMsdmeanCnt;
		self.v1_CrtRecMsdmeanCnt12Mo									:= le.attributes.version1.CrtRecMsdmeanCnt12Mo;
		self.v1_CrtRecMsdmeanTimeNewest								:= le.attributes.version1.CrtRecMsdmeanTimeNewest;
		self.v1_CrtRecEvictionCnt											:= le.attributes.version1.CrtRecEvictionCnt;
		self.v1_CrtRecEvictionCnt12Mo									:= le.attributes.version1.CrtRecEvictionCnt12Mo;
		self.v1_CrtRecEvictionTimeNewest							:= le.attributes.version1.CrtRecEvictionTimeNewest;
		self.v1_CrtRecLienJudgCnt											:= le.attributes.version1.CrtRecLienJudgCnt;
		self.v1_CrtRecLienJudgCnt12Mo									:= le.attributes.version1.CrtRecLienJudgCnt12Mo;
		self.v1_CrtRecLienJudgTimeNewest							:= le.attributes.version1.CrtRecLienJudgTimeNewest;
		self.v1_CrtRecLienJudgAmtTtl									:= le.attributes.version1.CrtRecLienJudgAmtTtl;
		self.v1_CrtRecBkrptCnt												:= le.attributes.version1.CrtRecBkrptCnt;
		self.v1_CrtRecBkrptCnt12Mo										:= le.attributes.version1.CrtRecBkrptCnt12Mo;
		self.v1_CrtRecBkrptTimeNewest									:= le.attributes.version1.CrtRecBkrptTimeNewest;
		self.v1_CrtRecSeverityIndex										:= le.attributes.version1.CrtRecSeverityIndex;
		self.v1_OccProfLicense												:= le.attributes.version1.OccProfLicense;
		self.v1_OccProfLicenseCategory								:= le.attributes.version1.OccProfLicenseCategory;
		self.v1_OccBusinessAssociation								:= le.attributes.version1.OccBusinessAssociation;
		self.v1_OccBusinessAssociationTime						:= le.attributes.version1.OccBusinessAssociationTime;
		self.v1_OccBusinessTitleLeadership						:= le.attributes.version1.OccBusinessTitleLeadership;
		self.v1_InterestSportPerson										:= le.attributes.version1.InterestSportPerson;
		self.v1_HHTeenagerMmbrCnt											:= le.attributes.version1.HHTeenagerMmbrCnt;
		self.v1_HHYoungAdultMmbrCnt										:= le.attributes.version1.HHYoungAdultMmbrCnt;
		self.v1_HHMiddleAgemmbrCnt										:= le.attributes.version1.HHMiddleAgemmbrCnt;
		self.v1_HHSeniorMmbrCnt												:= le.attributes.version1.HHSeniorMmbrCnt;
		self.v1_HHElderlyMmbrCnt											:= le.attributes.version1.HHElderlyMmbrCnt;
		self.v1_HHCnt																	:= le.attributes.version1.HHCnt;
		self.v1_HHEstimatedIncomeRange								:= le.attributes.version1.HHEstimatedIncomeRange;
		self.v1_HHCollegeAttendedMmbrCnt							:= le.attributes.version1.HHCollegeAttendedMmbrCnt;
		self.v1_HHCollege2yrAttendedMmbrCnt						:= le.attributes.version1.HHCollege2yrAttendedMmbrCnt;
		self.v1_HHCollege4yrAttendedMmbrCnt						:= le.attributes.version1.HHCollege4yrAttendedMmbrCnt;
		self.v1_HHCollegeGradAttendedMmbrCnt					:= le.attributes.version1.HHCollegeGradAttendedMmbrCnt;
		self.v1_HHCollegePrivateMmbrCnt								:= le.attributes.version1.HHCollegePrivateMmbrCnt;
		self.v1_HHCollegeTierMmbrHighest							:= le.attributes.version1.HHCollegeTierMmbrHighest;
		self.v1_HHPropCurrOwnerMmbrCnt								:= le.attributes.version1.HHPropCurrOwnerMmbrCnt;
		self.v1_HHPropCurrOwnedCnt										:= le.attributes.version1.HHPropCurrOwnedCnt;
		self.v1_HHPropCurrAVMHighest									:= le.attributes.version1.HHPropCurrAVMHighest;
		self.v1_HHPPCurrOwnedCnt											:= le.attributes.version1.HHPPCurrOwnedCnt;
		self.v1_HHPPCurrOwnedAutoCnt									:= le.attributes.version1.HHPPCurrOwnedAutoCnt;
		self.v1_HHPPCurrOwnedMtrcycleCnt							:= le.attributes.version1.HHPPCurrOwnedMtrcycleCnt;
		self.v1_HHPPCurrOwnedAircrftCnt								:= le.attributes.version1.HHPPCurrOwnedAircrftCnt;
		self.v1_HHPPCurrOwnedWtrcrftCnt								:= le.attributes.version1.HHPPCurrOwnedWtrcrftCnt;
		self.v1_HHCrtRecMmbrCnt												:= le.attributes.version1.HHCrtRecMmbrCnt;
		self.v1_HHCrtRecMmbrCnt12Mo										:= le.attributes.version1.HHCrtRecMmbrCnt12Mo;
		self.v1_HHCrtRecFelonyMmbrCnt									:= le.attributes.version1.HHCrtRecFelonyMmbrCnt;
		self.v1_HHCrtRecFelonyMmbrCnt12Mo							:= le.attributes.version1.HHCrtRecFelonyMmbrCnt12Mo;
		self.v1_HHCrtRecMsdmeanMmbrCnt								:= le.attributes.version1.HHCrtRecMsdmeanMmbrCnt;
		self.v1_HHCrtRecMsdmeanMmbrCnt12Mo						:= le.attributes.version1.HHCrtRecMsdmeanMmbrCnt12Mo;
		self.v1_HHCrtRecEvictionMmbrCnt								:= le.attributes.version1.HHCrtRecEvictionMmbrCnt;
		self.v1_HHCrtRecEvictionMmbrCnt12Mo						:= le.attributes.version1.HHCrtRecEvictionMmbrCnt12Mo;
		self.v1_HHCrtRecLienJudgMmbrCnt								:= le.attributes.version1.HHCrtRecLienJudgMmbrCnt;
		self.v1_HHCrtRecLienJudgMmbrCnt12Mo						:= le.attributes.version1.HHCrtRecLienJudgMmbrCnt12Mo;
		self.v1_HHCrtRecLienJudgAmtTtl								:= le.attributes.version1.HHCrtRecLienJudgAmtTtl;
		self.v1_HHCrtRecBkrptMmbrCnt									:= le.attributes.version1.HHCrtRecBkrptMmbrCnt;
		self.v1_HHCrtRecBkrptMmbrCnt12Mo							:= le.attributes.version1.HHCrtRecBkrptMmbrCnt12Mo;
		self.v1_HHCrtRecBkrptMmbrCnt24Mo							:= le.attributes.version1.HHCrtRecBkrptMmbrCnt24Mo;
		self.v1_HHOccProfLicMmbrCnt										:= le.attributes.version1.HHOccProfLicMmbrCnt;
		self.v1_HHOccBusinessAssocMmbrCnt							:= le.attributes.version1.HHOccBusinessAssocMmbrCnt;
		self.v1_HHInterestSportPersonMmbrCnt					:= le.attributes.version1.HHInterestSportPersonMmbrCnt;
		self.v1_RaATeenageMmbrCnt											:= le.attributes.version1.RaATeenageMmbrCnt;
		self.v1_RaAYoungAdultMmbrCnt									:= le.attributes.version1.RaAYoungAdultMmbrCnt;
		self.v1_RaAMiddleAgeMmbrCnt										:= le.attributes.version1.RaAMiddleAgeMmbrCnt;
		self.v1_RaASeniorMmbrCnt											:= le.attributes.version1.RaASeniorMmbrCnt;
		self.v1_RaAElderlyMmbrCnt											:= le.attributes.version1.RaAElderlyMmbrCnt;
		self.v1_RaAHHCnt															:= le.attributes.version1.RaAHHCnt;
		self.v1_RaAMmbrCnt														:= le.attributes.version1.RaAMmbrCnt;
		self.v1_RaAMedIncomeRange											:= le.attributes.version1.RaAMedIncomeRange;
		self.v1_RaACollegeAttendedMmbrCnt							:= le.attributes.version1.RaACollegeAttendedMmbrCnt;
		self.v1_RaACollege2yrAttendedMmbrCnt					:= le.attributes.version1.RaACollege2yrAttendedMmbrCnt;
		self.v1_RaACollege4yrAttendedMmbrCnt					:= le.attributes.version1.RaACollege4yrAttendedMmbrCnt;
		self.v1_RaACollegeGradAttendedMmbrCnt					:= le.attributes.version1.RaACollegeGradAttendedMmbrCnt;
		self.v1_RaACollegePrivateMmbrCnt							:= le.attributes.version1.RaACollegePrivateMmbrCnt;
		self.v1_RaACollegeTopTierMmbrCnt							:= le.attributes.version1.RaACollegeTopTierMmbrCnt;
		self.v1_RaACollegeMidTierMmbrCnt							:= le.attributes.version1.RaACollegeMidTierMmbrCnt;
		self.v1_RaACollegeLowTierMmbrCnt							:= le.attributes.version1.RaACollegeLowTierMmbrCnt;
		self.v1_RaAPropCurrOwnerMmbrCnt								:= le.attributes.version1.RaAPropCurrOwnerMmbrCnt;
		self.v1_RaAPropOwnerAVMHighest								:= le.attributes.version1.RaAPropOwnerAVMHighest;
		self.v1_RaAPropOwnerAVMMed										:= le.attributes.version1.RaAPropOwnerAVMMed;
		self.v1_RaAPPCurrOwnerMmbrCnt									:= le.attributes.version1.RaAPPCurrOwnerMmbrCnt;
		self.v1_RaAPPCurrOwnerAutoMmbrCnt							:= le.attributes.version1.RaAPPCurrOwnerAutoMmbrCnt;
		self.v1_RaAPPCurrOwnerMtrcycleMmbrCnt					:= le.attributes.version1.RaAPPCurrOwnerMtrcycleMmbrCnt;
		self.v1_RaAPPCurrOwnerAircrftMmbrCnt					:= le.attributes.version1.RaAPPCurrOwnerAircrftMmbrCnt;
		self.v1_RaAPPCurrOwnerWtrcrftMmbrCnt					:= le.attributes.version1.RaAPPCurrOwnerWtrcrftMmbrCnt;
		self.v1_RaACrtRecMmbrCnt											:= le.attributes.version1.RaACrtRecMmbrCnt;
		self.v1_RaACrtRecMmbrCnt12Mo									:= le.attributes.version1.RaACrtRecMmbrCnt12Mo;
		self.v1_RaACrtRecFelonyMmbrCnt								:= le.attributes.version1.RaACrtRecFelonyMmbrCnt;
		self.v1_RaACrtRecFelonyMmbrCnt12Mo						:= le.attributes.version1.RaACrtRecFelonyMmbrCnt12Mo;
		self.v1_RaACrtRecMsdmeanMmbrCnt								:= le.attributes.version1.RaACrtRecMsdmeanMmbrCnt;
		self.v1_RaACrtRecMsdmeanMmbrCnt12Mo						:= le.attributes.version1.RaACrtRecMsdmeanMmbrCnt12Mo;
		self.v1_RaACrtRecEvictionMmbrCnt							:= le.attributes.version1.RaACrtRecEvictionMmbrCnt;
		self.v1_RaACrtRecEvictionMmbrCnt12Mo					:= le.attributes.version1.RaACrtRecEvictionMmbrCnt12Mo;
		self.v1_RaACrtRecLienJudgMmbrCnt							:= le.attributes.version1.RaACrtRecLienJudgMmbrCnt;
		self.v1_RaACrtRecLienJudgMmbrCnt12Mo					:= le.attributes.version1.RaACrtRecLienJudgMmbrCnt12Mo;
		self.v1_RaACrtRecLienJudgAmtMax								:= le.attributes.version1.RaACrtRecLienJudgAmtMax;
		self.v1_RaACrtRecBkrptMmbrCnt36Mo							:= le.attributes.version1.RaACrtRecBkrptMmbrCnt36Mo;
		self.v1_RaAOccProfLicMmbrCnt									:= le.attributes.version1.RaAOccProfLicMmbrCnt;
		self.v1_RaAOccBusinessAssocMmbrCnt						:= le.attributes.version1.RaAOccBusinessAssocMmbrCnt;
		self.v1_RaAInterestSportPersonMmbrCnt					:= le.attributes.version1.RaAInterestSportPersonMmbrCnt;
    self.v1_PPCurrOwnedAutoVIN                    := le.attributes.version1.PPCurrOwnedAutoVIN;
    self.v1_PPCurrOwnedAutoYear                   := le.attributes.version1.PPCurrOwnedAutoYear;
    self.v1_PPCurrOwnedAutoMake                   := le.attributes.version1.PPCurrOwnedAutoMake;
    self.v1_PPCurrOwnedAutoModel                  := le.attributes.version1.PPCurrOwnedAutoModel;
    self.v1_PPCurrOwnedAutoSeries                 := le.attributes.version1.PPCurrOwnedAutoSeries;
    self.v1_PPCurrOwnedAutoType                   := le.attributes.version1.PPCurrOwnedAutoType;
	end;	
			 
	search_function_with_acctno := join(attributes, PB_wSeq, 
								left.seq = right.seq,
								addAcct(left, right)); 
								
	output(choosen(search_function_with_acctno, eyeball_count), named('search_function_with_acctno'));
	output(search_function_with_acctno,, '~thor400::out::profile_booster10_attributes_' + if(onThor, 'thor_', 'roxie_') + test_file_name + '_' + thorlib.wuid(), 
	csv(heading(single), quote('"')));		
	//RUN KEL Profile Booster v11 Attributes and append to file
	pb11result := ProfileBooster.getProfileBooster11Attrs(search_function_with_acctno, 
																history_dateYYYYMMDD, 
																80,
																1,
																3,
																DataRestriction,
																DataPermission																
																);
	//Update defaults for PB11 where lexID was missing	
	PB11_Layout := RECORD
		ProfileBooster.Layouts.Layout_PB_BatchOutFlat;
		ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutPersonPB11 -LexID -G_ProcUID -P_InpAcct;
	END;
	PB11_Layout xfm_Final(pb11result l) := TRANSFORM
			SELF.PurchNewAmt := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchTotEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchOldMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchItemCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.PurchAmtAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoCarCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEliteCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoExpCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoLuxuryCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoOrigOwnCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoSUVCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoTruckCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoVanCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAuto2ndFreqMake := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.AstVehAuto2ndFreqMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoFreqMake := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA;
			SELF.AstVehAutoFreqMakeCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoNewTypeIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgPriceAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgPriceDiff := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgPriceMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoNewPrice := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgAgeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgAgeMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgAgeMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgSpanAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoLastAgeAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoLastAgeMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoLastAgeMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoTimeOwnSpanAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherATVCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherCamperCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherCommCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherMtrCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherOrigOwnCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherScooterCntEv := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherNewMsnc := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherNewTypeIndx := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherNewPrice := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherPriceAvg := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherPriceMax := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehOtherPriceMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF.AstVehAutoEmrgPriceMin := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA_INT;
			SELF := l;
	END;
	PB11 := pb11result(lexid<>0);
	PB11Corrected := PROJECT(pb11result(lexid=0 and seq<>0),xfm_Final(LEFT));
	finalResult := PB11+PB11Corrected;
	
	output(choosen(finalResult, eyeball_count), named('finalResult'));
	output(finalResult,, '~thor400::out::profile_booster11_attributes_' + if(onThor, 'thor_', 'roxie_') + test_file_name + '_' + thorlib.wuid(),csv(heading(single), quote('"')));