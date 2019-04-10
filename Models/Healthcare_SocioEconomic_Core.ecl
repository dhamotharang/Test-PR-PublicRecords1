﻿
import risk_indicators, models, std, Profilebooster;
IMPORT LUCI, ut, STD;
IMPORT HCSE_GE_18_LUCI_MODEL;
IMPORT HCSE_LT_18_LUCI_MODEL;


export Healthcare_SocioEconomic_Core(isCoreRequestValid ,batch_in, DPPAPurpose_in, GLBPurpose_in, DataRestrictionMask_in, DataPermissionMask_in, Options_in, ofac_version_in, gateways_in_ds, CoreResults) := MACRO
	
	boolean isCoreRequest_Valid := isCoreRequestValid;
	DATASET(Models.Layouts_Healthcare_Core.Layout_SocioEconomic_Batch_In) batchin := batch_in;
	unsigned1 prep_dppa := DPPAPurpose_in;
	unsigned1 glb := GLBPurpose_in;
	string DataRestriction := DataRestrictionMask_in;
	string50 DataPermission := DataPermissionMask_in;
	String Options := (string)Options_in;
	unsigned1 ofac_version_ := ofac_version_in; //Pass OFACVersion value here

	string5   industry_class_val := '';
	boolean   isUtility := false;
	boolean   ofac_Only := false;

	unsigned3 history_date := 999999; //Default if input is 0

	unsigned1 dppa := prep_dppa; //Remove DNC filter if(~DisableDoNotMailFilter, 0, prep_dppa);
	LeadIntegrityVersion := Models.Healthcare_Constants_Core.default_LeadIntegrity_Version;//We want version 4
	bsVersion := Models.Healthcare_Constants_Core.default_BocaShell_Version; //We want version 4.1

	gateways_in := gateways_in_ds; //Pass Gateway.Configuration.Get() value here;
	Gateway.Layouts.Config gw_switch(gateways_in le) := transform
		self.servicename := if(ofac_version_ = 4 and LeadIntegrityVersion >= 4 and le.servicename = 'bridgerwlc', le.servicename, '');
		self.url := if(ofac_version_ = 4 and LeadIntegrityVersion >= 4 and le.servicename = 'bridgerwlc', le.url, ''); 		
		self := le;
	end;
	gateways := project(gateways_in, gw_switch(left));
	// gateways := Gateway.Constants.void_gateway;

	batchinseq := project(batchin, Models.Healthcare_SocioEconomic_Transforms_Core.AddSeq(left,counter));
	cleanIn := project(batchinseq(goodInput), Models.Healthcare_SocioEconomic_Transforms_Core.CleanBatch(left,history_date));
	cleanInHist12 := project(cleanIn, Models.Healthcare_SocioEconomic_Transforms_Core.AddHistDate(left,12));
	cleanInHist24 := project(cleanIn, Models.Healthcare_SocioEconomic_Transforms_Core.AddHistDate(left,24));

	// set variables for passing to bocashell function
	BOOLEAN includeDLverification := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	boolean   require2ele := false;
	boolean   isLn := false;	// not needed anymore
	boolean   doRelatives := true;
	boolean   doDL := false;
	boolean   doVehicle := false;
	boolean   doDerogs := true;
	boolean   suppressNearDups := false;
	boolean   fromBIID := false;
	boolean   isFCRA := false;
	boolean   fromIT1O := false;
	boolean   doScore := false;
	boolean   nugen := true;	
	BOOLEAN   include_ofac := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	UNSIGNED1 ofacVersion := map(LeadIntegrityVersion >= 4 and ofac_version_ = 4 => 4,
                               LeadIntegrityVersion >= 4 => 2, 
                                                            1);
	BOOLEAN   includeAdditionalWatchlists := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	REAL      global_watchlist_threshold := if(ofacVersion in [1, 2, 3], 0.84, 0.85);
	BOOLEAN   excludeWatchlists := IF(LeadIntegrityVersion >= 4, FALSE, TRUE); // Attributes 4.1 return a watchlist hit, so don't exclude watchlists
	// For ITA we can't use FARES Data
	BOOLEAN filterOutFares := TRUE;
	append_best := if(LeadIntegrityVersion >= 4, 2, 0 );

	unsigned8 BSOptions := IF(LeadIntegrityVersion >= 4, risk_indicators.iid_constants.BSOptions.IncludeDoNotMail + 
																											risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
																											risk_indicators.iid_constants.BSOptions.IncludeDoNotMail);
	if(ofacVersion = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

/* ***************************************
	 *     Gather Boca Shell Results:      *
   *************************************** */
	iid := Risk_Indicators.InstantID_Function(cleanIn, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, include_ofac, includeAdditionalWatchlists, global_watchlist_threshold,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission);
	iidHist12 := Risk_Indicators.InstantID_Function(cleanInHist12, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, include_ofac, includeAdditionalWatchlists, global_watchlist_threshold,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission);
	iidHist24 := Risk_Indicators.InstantID_Function(cleanInHist24, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, include_ofac, includeAdditionalWatchlists, global_watchlist_threshold,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission);

	clam := Risk_Indicators.Boca_Shell_Function(iid, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																							doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																							BSOptions := BsOptions, DataPermission := DataPermission);
	clamHist12 := Risk_Indicators.Boca_Shell_Function(iidHist12, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																							doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																							BSOptions := BsOptions, DataPermission := DataPermission);
	clamHist24 := Risk_Indicators.Boca_Shell_Function(iidHist24, gateways, DPPA, GLB, isUtility, isLn, doRelatives, doDL, 
																							doVehicle, doDerogs, bsVersion, doScore, nugen, filterOutFares, DataRestriction := DataRestriction,
																							BSOptions := BsOptions, DataPermission := DataPermission);

	LeadIntegrity := Models.get_LeadIntegrity_Attributes(clam,LeadIntegrityVersion);
	LeadIntegrityHist12 := Models.get_LeadIntegrity_Attributes(clamHist12,LeadIntegrityVersion);
	LeadIntegrityHist24 := Models.get_LeadIntegrity_Attributes(clamHist24,LeadIntegrityVersion);

	rawResults := join(batchinseq, LeadIntegrity, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_attributes_combined,
						self.acctno := left.acctno;
						self.seq := if(right.seq <>'',right.seq,left.acctno);
						self.membergender := 0;
						self := right; self := left;),left outer, keep(1), atmost(1));
	rawResults12 := join(batchinseq, LeadIntegrityHist12, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_attributes_combined,
						self.acctno := left.acctno;
						self := right),keep(1), atmost(1));
	rawResults24 := join(batchinseq, LeadIntegrityHist24, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_attributes_combined,
						self.acctno := left.acctno;
						self := right),keep(1), atmost(1));

	rawResults_appendInput := join(rawResults,batchinseq,(integer)left.seq=(integer)right.seq,
								transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_attributes_combined,
									ageRefYYYYMMDD := if((string)left.HistorydateYYYYMM = '999999', (string)Std.Date.Today(), 
														 (string)left.HistorydateYYYYMM+(string2)Models.Healthcare_SocioEconomic_Functions_Core.calcDaysInMonth((string)left.HistorydateYYYYMM));
									self.MemberAge := Models.Healthcare_SocioEconomic_Functions_Core.calcAgeInYears(right.DOB,(string)ageRefYYYYMMDD);
									//Do other crosswalks.....
									gender:=STD.Str.ToUpperCase(right.MemberGender);
									self.GenderStr := gender; //Needed for Model  as Gender attribute
									self.MemberGender := map(gender='M'=>0,
															 gender='F'=>1,
															 (integer)gender);
									self.CrosswalkState := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkState(right.St);
									self.CrosswalkAddrRecentEconTrajectory := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkAddrRecentEconTrajectory(left.version4.AddrRecentEconTrajectory);
									self.CrosswalkBankruptcyStatus := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkBankruptcyStatus(left.version4.BankruptcyStatus);
									self.CrosswalkBankruptcyType := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkBankruptcyType(left.version4.BankruptcyType);
									self.CrosswalkCurrAddrDwellType := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkCurrAddrDwellType(left.version4.CurrAddrDwellType);
									self.CrosswalkInputAddrDwellType := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkInputAddrDwellType(left.version4.InputAddrDwellType);
									self.CrosswalkInputAddrValidation := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkInputAddrValidation(left.version4.InputAddrValidation);
									self.CrosswalkInputPhoneType := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkInputPhoneType(left.version4.InputPhoneType);
									self.CrosswalkPrevAddrDwellType := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkPrevAddrDwellType(left.version4.PrevAddrDwellType);
									self.CrosswalkSsnIssueState := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkSsnIssueState(left.version4.SSNIssueState);
									self.CrosswalkStatusMostRecent := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkStatusMostRecent(left.version4.StatusMostRecent);
									self.CrosswalkStatusNextPrevious := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkStatusNextPrevious(left.version4.StatusNextPrevious);
									self.CrosswalkStatusPrevious := Models.Healthcare_SocioEconomic_Functions_Core.CrosswalkStatusPrevious(left.version4.StatusPrevious);
									self:=left;), 
								left outer, keep(1), atmost(1));
	rawResults_append12 := join(rawResults_appendInput,rawResults12,(integer)left.seq=(integer)right.seq,
								transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_attributes_combined,
									self.v4_CurrAddrBurglaryIndex12 := right.version4.CurrAddrBurglaryIndex;
									self.v4_EstimatedAnnualIncome12 := right.version4.EstimatedAnnualIncome;
									self.v4_PropOwnedTaxTotal12 := right.version4.PropOwnedTaxTotal;
									self.v4_SFDUAddrIdentitiesCount12 := right.version4.SFDUAddrIdentitiesCount;
									self:=left;), 
								left outer, keep(1), atmost(1));
	rawResults_final := dedup(sort(join(rawResults_append12,rawResults24,(integer)left.seq=(integer)right.seq,
								transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_attributes_combined,
									self.v4_CurrAddrBurglaryIndex24 := right.version4.CurrAddrBurglaryIndex;
									self.v4_EstimatedAnnualIncome24 := right.version4.EstimatedAnnualIncome;
									self.v4_PropOwnedTaxTotal24 := right.version4.PropOwnedTaxTotal;
									self.v4_SFDUAddrIdentitiesCount24 := right.version4.SFDUAddrIdentitiesCount;
									self:=left;), 
								left outer, keep(1), atmost(1)),record),record);

	//Preparing Profile Booster Input with LexID
	Profilebooster_Input := project(batchin, Models.Healthcare_SocioEconomic_Transforms_Core.AddSeq_ProfileBooster(left,counter));

	Profilebooster_In_With_LexID := project(Profilebooster_Input, TRANSFORM(Profilebooster.Layouts.Layout_PB_In,
									SELF := LEFT)); 	
 	//Profile Booster Search Function Contants
	Profilebooster_AttributesVersionRequest := Models.Healthcare_Constants_Core.default_Profilebooster_AttributesVersionRequest;
	onThor := Models.Healthcare_Constants_Core.default_onThor;

	//Calling Profile Booster Search Function and fetching the attributes
	pb_attributes := ProfileBooster.Search_Function(Profilebooster_In_With_LexID, DataRestriction, DataPermission, Profilebooster_AttributesVersionRequest);  
	//Combining Lead Integrity and Profile Booster attributes
	Combined_LI_PB_Attributes := 	Join(rawResults_final, pb_attributes, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_combined,
					self.acctno := left.acctno;
					self.pb_attributes := right.attributes;
					self := left; self := right;),left outer, keep(1), atmost(1));
	
	/********Flattening the combined Lead Integrity and Profile Booster attributes*********/
	Combined_LI_PB_Attributes_flat := project(Combined_LI_PB_Attributes, Models.Healthcare_SocioEconomic_Transforms_Core.FlattenLIPB(LEFT));

	//Preparing the data for Pre Processing i.e. substituting crosswalk values, history attributes etc.
	Combined_LI_PB_Prep_Pre_Proc := project(Combined_LI_PB_Attributes_flat, Models.Healthcare_SocioEconomic_Transforms_Core.Prep_For_Pre_Processing_Xform(LEFT));
	
	/*===============================================================================
	=            Begin - Steps for Total Cost Health Score a.k.a "Score"            =
	===============================================================================*/

	//Run Pre Processing Transform to generate derived attributes
	Pre_Proc_Out := Project(Combined_LI_PB_Prep_Pre_Proc, Models.Healthcare_SocioEconomic_Transforms_Core.Pre_Processing_Xform(LEFT));
	
	//Run Patterns Transforms for both GE_18 and LT_18 Datasets while splitting the datasets based on Age_In_Years
	Patterns_Applied_GE_18 := Models.Healthcare_SocioEconomic_Transforms_Core.GE_18_Patterns(Pre_Proc_Out(AGE_IN_YEARS >= 18), Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed);
	Patterns_Applied_LT_18 := Models.Healthcare_SocioEconomic_Transforms_Core.LT_18_Patterns0(Pre_Proc_Out(AGE_IN_YEARS < 18 AND ProfileBooster_missing=0 ), Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed)
													+ Models.Healthcare_SocioEconomic_Transforms_Core.LT_18_Patterns1(Pre_Proc_Out(AGE_IN_YEARS < 18 AND ProfileBooster_missing=1), Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed);
	
	//Run Mapper provided by Modelers to shift base values etc.
	Patterns_Applied_Mapped_GE_18 := Models.Healthcare_SocioEconomic_Transforms_Core.GE_18_doMapping(Patterns_Applied_GE_18,Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed);
	Patterns_Applied_Mapped_LT_18 := Models.Healthcare_SocioEconomic_Transforms_Core.LT_18_doMapping(Patterns_Applied_LT_18,Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed);
	
	//Run LUCI Models on transform data that contains do_Model1 and TransactionID, which are needed by the LUCI model to run
	Patterns_Applied_Mapped_GE_18_Model_Input := PROJECT(Patterns_Applied_Mapped_GE_18, TRANSFORM(Models.Layouts_Healthcare_Core.Model_Input_Layout, SELF.do_Model1 := TRUE,SELF.TransactionID := (string)LEFT.SEQ, SELF := LEFT));
	GE_18_LUCI_results_base := HCSE_GE_18_LUCI_MODEL.AsResults(Patterns_Applied_Mapped_GE_18_Model_Input).Base();
	Patterns_Applied_Mapped_LT_18_Model_Input := PROJECT(Patterns_Applied_Mapped_LT_18, TRANSFORM(Models.Layouts_Healthcare_Core.Model_Input_Layout, SELF.do_Model1 := TRUE,SELF.TransactionID := (string)LEFT.SEQ, SELF := LEFT));
	LT_18_LUCI_results_base := HCSE_LT_18_LUCI_MODEL.AsResults(Patterns_Applied_Mapped_LT_18_Model_Input).Base();
	
	//Run Post Processing transform to adjust the predicted score
	GE_18_Prediction_Post_Proc := Join(Patterns_Applied_GE_18, GE_18_LUCI_results_base, left.seq=(integer)right.TransactionID, transform(Models.Layouts_Healthcare_Core.PostProcessing_Layout_LUCI_Model,
		self.Score := MAX((Real8)right.Score, left.PMPM_13_05K_AGPred * 0.2);
		self.seq := (integer)right.TransactionID;
		self.acctno := (string) left.acctno;
		self := right;),left outer, keep(1), atmost(1));
	LT_18_Prediction_Post_Proc := Join(Patterns_Applied_LT_18, LT_18_LUCI_results_base, left.seq=(integer)right.TransactionID, transform(Models.Layouts_Healthcare_Core.PostProcessing_Layout_LUCI_Model,
		self.Score := MAX((Real8)right.Score, left.AG_Pred_5K_under18 * 0.2);
		self.seq := (integer)right.TransactionID;
		self.acctno := (string) left.acctno;
		self := right;),left outer, keep(1), atmost(1));
	
	SeHs_GE_LT_Predictions := GE_18_Prediction_Post_Proc +  LT_18_Prediction_Post_Proc;

	/*=====  End of Total Cost Health Score  ======*/
	
	/*=========================================================
	=            Begin - Readmission Score Section            =
	=========================================================*/
	
	SeRs_PreProc_Patterns_Applied := Models.Healthcare_SocioEconomic_Transforms_Core.SeRs_Preprocessing_and_Patterns_M0_M1(Combined_LI_PB_Prep_Pre_Proc,Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed);
	
	SeRs_PreProc_Patterns_Validated := join(SeRs_PreProc_Patterns_Applied,icdkey.key().ref_icd10_diag_key.qa,
											keyed(STD.Str.ToUpperCase(std.Str.FilterOut(left.admit_diagnosis_code, '.')) = right.diag_cd),
											Transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed,
											self.isSeRsInvalidDiag := if(right.desc_short<>'',0,1);
											self := left;
											), left outer, atmost(1));
	// OUTPUT(SeRs_PreProc_Patterns_Validated, NAMED('SeRs_PreProc_Patterns_Validated'));

	// TODO: Make sure to rollback the following 
	// SeRs_PreProc_Patterns_Validated := SeRs_PreProc_Patterns_Applied; //Temporarily disabling diag code validation.

	SeRs_PreProc_Patterns_Filtered := SeRs_PreProc_Patterns_Validated(isSeRsExcludedDiag =0 and isSeRsMinor =0 
																	and Models.Healthcare_SocioEconomic_Functions_Core.DOBCleaner(ADMIT_DATE)<>'');
	// and Models.Healthcare_SocioEconomic_Functions_Core.DOBCleaner(ADMIT_DATE)<>''
		
	SeRs_PreProc_Patterns_Excluded := SeRs_PreProc_Patterns_Validated(isSeRsExcludedDiag =1 or isSeRsMinor =1 or Models.Healthcare_SocioEconomic_Functions_Core.DOBCleaner(ADMIT_DATE) ='');
	
	
	M0_SeRs_PreProc_Patterns_Filtered_Validated_Mapped := Models.Healthcare_SocioEconomic_Transforms_Core.SeRs_M0_doMapping(SeRs_PreProc_Patterns_Filtered(isSeRsM1ModelUsed < 1));
 
 	M1_Xwalked := Models.Healthcare_SocioEconomic_Transforms_Core.SeRs_M1_Xwalk(SeRs_PreProc_Patterns_Filtered(isSeRsM1ModelUsed = 1), Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed);
 
 	M1_SeRs_PreProc_Patterns_Filtered_Validated_Mapped := Models.Healthcare_SocioEconomic_Transforms_Core.SeRs_M1_doMapping(M1_Xwalked, Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed_mapped);
	
	//Run LUCI Models on transform data that contains do_Model1 and TransactionID, which are needed by the LUCI model to run
	M0_SeRs_Model_Input := PROJECT(M0_SeRs_PreProc_Patterns_Filtered_Validated_Mapped, TRANSFORM(Models.Layouts_Healthcare_Core.SeRs_M0_Model_Input_Layout, SELF.do_Model1 := TRUE,SELF.TransactionID := (string)LEFT.SEQ, SELF := LEFT));
	M0_SeRs_LUCI_results_base := HCSE_SERA_GBM_M0_V1_model_LUCI.AsResults(M0_SeRs_Model_Input).Base();
	M1_SeRs_Model_Input := PROJECT(M1_SeRs_PreProc_Patterns_Filtered_Validated_Mapped, TRANSFORM(Models.Layouts_Healthcare_Core.SeRs_M1_Model_Input_Layout, SELF.do_Model1 := TRUE,SELF.TransactionID := (string)LEFT.SEQ, SELF := LEFT));
	M1_SeRs_LUCI_results_base := HCSE_SERA_GBM_M1_V1_model_LUCI.AsResults(M1_SeRs_Model_Input).Base();
 
 	//We have a chance to project into a smaller layout with only the required fields and flags
 	M0_SeRs_Prediction_Post_Proc := Join(M0_SeRs_PreProc_Patterns_Filtered_Validated_Mapped, M0_SeRs_LUCI_results_base, left.seq=(integer)right.TransactionID, transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed,
		self.SeRs_Raw_Score := (string) right.score;
		DECIMAL7_4 vScore :=  TRUNCATE((real8)right.score*1000000)/10000;
		self.SeRs_Score := (string) vScore;
		self.seq := (integer)right.TransactionID;
		self := left;),left outer, keep(1), atmost(1));
	M1_SeRs_Prediction_Post_Proc := Join(M1_Xwalked, M1_SeRs_LUCI_results_base, left.seq=(integer)right.TransactionID, transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed,
		self.SeRs_Raw_Score := (string) right.score;
		DECIMAL7_4 vScore := TRUNCATE((real8)right.score*1000000)/10000;
		self.SeRs_Score := (string) vScore;
		self.seq := (integer)right.TransactionID;
		self := left;),left outer, keep(1), atmost(1));

	SeRs_Combined_M0_M1_results := M0_SeRs_Prediction_Post_Proc + M1_SeRs_Prediction_Post_Proc + SeRs_PreProc_Patterns_Excluded;

	SeRs_Combined_M0_M1_results_no_exclusions := M0_SeRs_Prediction_Post_Proc + M1_SeRs_Prediction_Post_Proc;
	
	SeRS_RD_Input := PROJECT(SeRs_Combined_M0_M1_results_no_exclusions, TRANSFORM(Models.Layouts_Healthcare_Core.SeRs_M0_M1_Model_ValdationFile_Layout,
																		SELF.SeRS_Raw_Score := (REAL8)LEFT.SeRS_Raw_Score;
																		SELF := LEFT;
																		SELF := []));
	// OUTPUT(SeRS_RD_Input, NAMED('SeRS_RD_Input'));
	SeRS_RD_Results := Models.Healthcare_SocioEconomic_Transforms_Core.getSeRS_M0_M1_RiskDrivers(SeRS_RD_Input);
	// OUTPUT(SeRS_RD_Results, NAMED('SeRS_RD_Results'));

	SeRs_Combined_M0_M1_results_RD := Join(SeRs_Combined_M0_M1_results, SeRS_RD_Results, left.seq=right.seq, 
										transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed,
										self.RAR_Driver_Hi1 := right.RAR_Driver_Hi1;
										self.RAR_Driver_Hi2 := right.RAR_Driver_Hi2;
										self.RAR_Driver_Hi3 := right.RAR_Driver_Hi3;
										self.RAR_Driver_Lo1 := right.RAR_Driver_Lo1;
										self.RAR_Driver_Lo2 := right.RAR_Driver_Lo2;
										self.RAR_Driver_Lo3 := right.RAR_Driver_Lo3;
										self := left;),left outer, keep(1), atmost(1));
	// OUTPUT(SeRs_Combined_M0_M1_results_RD, NAMED('SeRs_Combined_M0_M1_results_RD'));

	/*=====  End of Readmission Score  ======*/
	
	/*==========================================================
	=            Begin - Medication Adherence Score            =
	==========================================================*/
	
	M0_SeMA_PreProc_Xwalked_Mapped := Models.Healthcare_SocioEconomic_Transforms_Core.SeMA_M0_Xwalk_PreProc_Mapping(Combined_LI_PB_Prep_Pre_Proc, Models.Layouts_Healthcare_Core.SeMA_M0_Model_Typed_Input_Layout);
	// output(M0_SeMA_PreProc_Xwalked_Mapped, NAMED('M0_SeMA_PreProc_Xwalked_Mapped'));
	M0_SeMA_LUCI_results_base := HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.AsResults(M0_SeMA_PreProc_Xwalked_Mapped(isSEMA_Minor<>1)).Base();
	// output(M0_SeMA_LUCI_results_base, NAMED('M0_SeMA_LUCI_results_base'));
	M0_SeMA_results_Post_Proc := PROJECT(M0_SeMA_LUCI_results_base, TRANSFORM(Models.Layouts_Healthcare_Core.SeMA_Model_Output_Layout, 
																			SELF.seq := (integer)LEFT.TransactionID;
																			SELF.SeMA_Raw_Score := (string) LEFT.score;
																			DECIMAL7_4 vScore :=  TRUNCATE((real8)LEFT.score*1000000)/10000; //4 decimal places needed
																			self.SeMA_Score := (string) vScore;
																			SELF := LEFT));
	// output(M0_SeMA_results_Post_Proc, NAMED('M0_SeMA_results_Post_Proc'));
	M0_SeMA_Model_Input_And_Score := Join(M0_SeMA_PreProc_Xwalked_Mapped(isSEMA_Minor<>1), M0_SeMA_results_Post_Proc, left.seq=right.seq, transform(Models.Layouts_Healthcare_Core.SeMA_M0_Model_Typed_Input_And_Score_Layout,
							self.SeMA_Raw_Score := (REAL8)right.SeMA_Raw_Score;
							self := left;),left outer, keep(1), atmost(1));
	// OUTPUT(M0_SeMA_Model_Input_And_Score, NAMED('M0_SeMA_Model_Input_And_Score'));

	M0_SeMA_RD := Models.Healthcare_SocioEconomic_Transforms_Core.getSeMA_RiskDrivers(M0_SeMA_Model_Input_And_Score);
	// OUTPUT(M0_SeMA_RD, NAMED('M0_SeMA_RD'));

	M0_SeMA_Results_RD := Join(M0_SeMA_results_Post_Proc, M0_SeMA_RD, left.seq=right.seq, 
								transform(Models.Layouts_Healthcare_Core.SeMA_Post_Procs_Risk_Drivers_Layout,
								self.MA_Driver_Hi1 := right.MA_Driver_Hi1;
								self.MA_Driver_Hi2 := right.MA_Driver_Hi2;
								self.MA_Driver_Hi3 := right.MA_Driver_Hi3;
								self.MA_Driver_Lo1 := right.MA_Driver_Lo1;
								self.MA_Driver_Lo2 := right.MA_Driver_Lo2;
								self.MA_Driver_Lo3 := right.MA_Driver_Lo3;
								self := left;),left outer, keep(1), atmost(1));
	// OUTPUT(M0_SeMA_Results_RD, NAMED('M0_SeMA_Results_RD'));

	/*=====  End of Medication Adherence Score  ======*/

	/*================================================
	=            Begin - Motivation Score            =
	================================================*/
	
	SeMO_V1_PreProc_And_Patterns := Models.Healthcare_SocioEconomic_Transforms_Core.SeMO_V1_PreProc_And_Patterns(Combined_LI_PB_Prep_Pre_Proc, Models.Layouts_Healthcare_Core.SeMO_V1_Model_Typed_Input_Layout);
	// output(SeMO_V1_PreProc_And_Patterns, NAMED('SeMO_V1_PreProc_And_Patterns'));
  	
	SeMO_V1_LUCI_results_base := HCSE_SEMO_Model_V1_LUCI.AsResults(SeMO_V1_PreProc_And_Patterns(isSEMO_Minor<>1)).Base();
	// output(SeMO_V1_LUCI_results_base, NAMED('SeMO_V1_LUCI_results_base'));
	
	SeMO_V1_results_Post_Proc := PROJECT(SeMO_V1_LUCI_results_base, TRANSFORM(Models.Layouts_Healthcare_Core.SeMO_Model_Output_Layout, 
																			SELF.seq := (integer)LEFT.TransactionID;
																			SELF.SeMO_Raw_Score := (string) LEFT.score;
																			post_proc_score := MIN(((real8)LEFT.score-70)/60, 1);
																			DECIMAL7_4 vScore :=  TRUNCATE(post_proc_score*1000000)/10000; //4 decimal places needed
																			self.SeMO_Score := (string) vScore;
																			SELF := LEFT));
	// output(SeMO_V1_results_Post_Proc, NAMED('SeMO_V1_results_Post_Proc'));
	SeMO_V1_Model_Input_And_Score := Join(SeMO_V1_PreProc_And_Patterns(isSEMO_Minor<>1), SeMO_V1_results_Post_Proc, left.seq=right.seq, transform(Models.Layouts_Healthcare_Core.SeMO_V1_Model_Typed_Input_And_Score_Layout,
							self.SeMO_Raw_Score := (REAL8)right.SeMO_Raw_Score;
							self := left;),left outer, keep(1), atmost(1));
	// OUTPUT(SeMO_V1_Model_Input_And_Score, NAMED('SeMO_V1_Model_Input_And_Score'));

	SeMO_V1_RD := Models.Healthcare_SocioEconomic_Transforms_Core.getSeMO_RiskDrivers(SeMO_V1_Model_Input_And_Score); // Figure Out Risk Drivers
	// OUTPUT(SeMO_V1_RD, NAMED('SeMO_V1_RD'));

	SeMO_V1_Results_RD := Join(SeMO_V1_results_Post_Proc, SeMO_V1_RD, left.seq=right.seq, 
								transform(Models.Layouts_Healthcare_Core.SeMO_Post_Procs_Risk_Drivers_Layout,
								self.MO_Driver_Hi1 := right.MO_Driver_Hi1;
								self.MO_Driver_Hi2 := right.MO_Driver_Hi2;
								self.MO_Driver_Hi3 := right.MO_Driver_Hi3;
								self.MO_Driver_Lo1 := right.MO_Driver_Lo1;
								self.MO_Driver_Lo2 := right.MO_Driver_Lo2;
								self.MO_Driver_Lo3 := right.MO_Driver_Lo3;
								self := left;),left outer, keep(1), atmost(1));
	// OUTPUT(SeMO_V1_Results_RD, NAMED('SeMO_V1_Results_RD'));
	
	/*=====  End of Motivation Score  ======*/
	
	/*----------  OPTION '1' Attributes Only  ----------*/
	
	Results_Attributes_Only := project(Combined_LI_PB_Attributes_flat, Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_1_SE_A(LEFT));					
	Results_Attributes_Only_ADL := Models.Healthcare_SocioEconomic_Transforms_Core.Add_ADLScore(Results_Attributes_Only, iid, Models.Layouts_Healthcare_Core.Final_Output_Layout);

	/*----------  OPTION '2' Readmission Score Only  ----------*/
	
	Results_OPTION_2_SE_RS := project(SeRs_Combined_M0_M1_results_RD, Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_2_SE_RS(LEFT));					
	Results_OPTION_2_SE_RS_ADL := Models.Healthcare_SocioEconomic_Transforms_Core.Add_ADLScore(Results_OPTION_2_SE_RS, iid, Models.Layouts_Healthcare_Core.Final_Output_Layout);

	/*----------  OPTION '3' Health Score Only  ----------*/
	
	Results_OPTION_3_SE_HS := project(SeHs_GE_LT_Predictions, Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_3_SE_HS(LEFT));					
	Results_OPTION_3_SE_HS_ADL := Models.Healthcare_SocioEconomic_Transforms_Core.Add_LexID_ADLScore(Results_OPTION_3_SE_HS, iid, Models.Layouts_Healthcare_Core.Final_Output_Layout);

	/*----------  OPTION '4' Health Score and Readmission Score Only  ----------*/
	  
	Results_OPTION_4_SE_HS_RS := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SERS_Score_RD(Results_OPTION_3_SE_HS, SeRs_Combined_M0_M1_results_RD, Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_4_SE_HS_RS_ADL := Models.Healthcare_SocioEconomic_Transforms_Core.Add_ADLScore(Results_OPTION_4_SE_HS_RS, iid, Models.Layouts_Healthcare_Core.Final_Output_Layout);

	/*----------  OPTION '5' Attributes and Readmission Score Only  ----------*/
	
	Results_OPTION_5_SE_A_RS := Join(Combined_LI_PB_Attributes_flat, SeRs_Combined_M0_M1_results_RD, (string)left.seq=(string)right.seq, 
									Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_5_SE_A_RS(LEFT, RIGHT),left outer, keep(1), atmost(1));
	Results_OPTION_5_SE_A_RS_ADL := Models.Healthcare_SocioEconomic_Transforms_Core.Add_ADLScore(Results_OPTION_5_SE_A_RS, iid, Models.Layouts_Healthcare_Core.Final_Output_Layout);

	/*----------  OPTION '6' Attributes and Health Score Only  ----------*/
	
	Results_OPTION_6_SE_A_HS := Join(Combined_LI_PB_Attributes_flat, SeHs_GE_LT_Predictions, (string)left.seq=(string)right.seq, 
									Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_6_SE_A_HS(LEFT, RIGHT),left outer, keep(1), atmost(1));
	Results_OPTION_6_SE_A_HS_ADL := Models.Healthcare_SocioEconomic_Transforms_Core.Add_ADLScore(Results_OPTION_6_SE_A_HS, iid, Models.Layouts_Healthcare_Core.Final_Output_Layout);

	/*----------  OPTION '7' Attributes, Health Score and Readmission Score Only  ----------*/
	
	Results_OPTION_7_SE_A_HS_RS := Join(Combined_LI_PB_Attributes_flat, Results_OPTION_4_SE_HS_RS, (string)left.seq=(string)right.seq, 
										Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_7_SE_A_HS_RS(LEFT, RIGHT),left outer, keep(1), atmost(1));
	Results_OPTION_7_SE_A_HS_RS_ADL := Models.Healthcare_SocioEconomic_Transforms_Core.Add_ADLScore(Results_OPTION_7_SE_A_HS_RS, iid, Models.Layouts_Healthcare_Core.Final_Output_Layout);

	/*----------  OPTION '8' Attributes, Health Score, Readmission Score and DEBUG fields  ----------*/
	
	Results_OPTION_8_SE_HS_RS := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SERS_Score_RD_DEBUG(SeHs_GE_LT_Predictions, SeRs_Combined_M0_M1_results_RD, Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_8_SE_DEBUG := Join(Combined_LI_PB_Attributes_flat, Results_OPTION_8_SE_HS_RS, (string)left.seq=(string)right.seq, 
									  Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_8_SE_DEBUG(LEFT, RIGHT),left outer, keep(1), atmost(1));
	Results_OPTION_8_SE_DEBUG_ADL := Models.Healthcare_SocioEconomic_Transforms_Core.Add_ADLScore(Results_OPTION_8_SE_DEBUG, iid, Models.Layouts_Healthcare_Core.Final_Output_Layout);

	/* Prepping Results for Medication Adherence Only Option */
	Bat_inp := PROJECT(batchinseq, TRANSFORM(Models.Layouts_Healthcare_Core.Final_Output_Layout, 
																		SELF.seq := (string)LEFT.seq;
																		SELF.acctno := (string) LEFT.acctno;
																		SELF := [])); //To get accountno
	Batch_Inp_LexID_ADLScore :=  Models.Healthcare_SocioEconomic_Transforms_Core.Add_LexID_ADLScore(Bat_inp, iid,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	
	/*----------  Adding Medication Adherence to all eight options  ----------*/
	Results_OPTION_M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score_RD(Batch_Inp_LexID_ADLScore, M0_SeMA_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_M, NAMED('Results_OPTION_M'));
	Results_OPTION_1M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score_RD(Results_Attributes_Only_ADL, M0_SeMA_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_1M, NAMED('Results_OPTION_1M'));
	Results_OPTION_2M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score_RD(Results_OPTION_2_SE_RS_ADL, M0_SeMA_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_2M, NAMED('Results_OPTION_2M'));
	Results_OPTION_3M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score_RD(Results_OPTION_3_SE_HS_ADL, M0_SeMA_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_3M, NAMED('Results_OPTION_3M'));
	Results_OPTION_4M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score_RD(Results_OPTION_4_SE_HS_RS_ADL, M0_SeMA_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_4M, NAMED('Results_OPTION_4M'));
	Results_OPTION_5M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score_RD(Results_OPTION_5_SE_A_RS_ADL, M0_SeMA_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_5M, NAMED('Results_OPTION_5M'));
	Results_OPTION_6M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score_RD(Results_OPTION_6_SE_A_HS_ADL, M0_SeMA_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_6M, NAMED('Results_OPTION_6M'));
	Results_OPTION_7M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score_RD(Results_OPTION_7_SE_A_HS_RS_ADL, M0_SeMA_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_7M, NAMED('Results_OPTION_7M'));
	Results_OPTION_8M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score_RD(Results_OPTION_8_SE_DEBUG_ADL, M0_SeMA_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_8M, NAMED('Results_OPTION_8M'));

	Results_OPTION_O := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Batch_Inp_LexID_ADLScore, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_1O := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_Attributes_Only_ADL, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_2O := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_2_SE_RS_ADL, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_3O := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_3_SE_HS_ADL, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_4O := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_4_SE_HS_RS_ADL, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_5O := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_5_SE_A_RS_ADL, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_6O := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_6_SE_A_HS_ADL, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_7O := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_7_SE_A_HS_RS_ADL, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_8O := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_8_SE_DEBUG_ADL, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_MO := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_M, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_1MO := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_1M, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_2MO := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_2M, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_3MO := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_3M, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_4MO := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_4M, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_5MO := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_5M, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_6MO := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_6M, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_7MO := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_7M, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_8MO := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMO_Score_RD(Results_OPTION_8M, SeMO_V1_Results_RD,Models.Layouts_Healthcare_Core.Final_Output_Layout);

	/*----------  Mapping Options to various Results  ----------*/
	validCoreResults := MAP(Options = '1' => Results_Attributes_Only_ADL,
					Options = '2' => Results_OPTION_2_SE_RS_ADL,
					Options = '3' => Results_OPTION_3_SE_HS_ADL,
					Options = '4' => Results_OPTION_4_SE_HS_RS_ADL,
					Options = '5' => Results_OPTION_5_SE_A_RS_ADL,
					Options = '6' => Results_OPTION_6_SE_A_HS_ADL,
					Options = '7' => Results_OPTION_7_SE_A_HS_RS_ADL,
					Options = '8' => Results_OPTION_8_SE_DEBUG_ADL,
					Options = 'M' => Results_OPTION_M,
					Options = '1M' => Results_OPTION_1M,
					Options = '2M' => Results_OPTION_2M,
					Options = '3M' => Results_OPTION_3M,
					Options = '4M' => Results_OPTION_4M,
					Options = '5M' => Results_OPTION_5M,
					Options = '6M' => Results_OPTION_6M,
					Options = '7M' => Results_OPTION_7M,
					Options = '8M' => Results_OPTION_8M,
					Options = 'O'  => Results_OPTION_O,
					Options = '1O' => Results_OPTION_1O,
					Options = '2O' => Results_OPTION_2O,
					Options = '3O' => Results_OPTION_3O,
					Options = '4O' => Results_OPTION_4O,
					Options = '5O' => Results_OPTION_5O,
					Options = '6O' => Results_OPTION_6O,
					Options = '7O' => Results_OPTION_7O,
					Options = '8O' => Results_OPTION_8O,
					Options = 'MO' => Results_OPTION_MO,
					Options = '1MO' => Results_OPTION_1MO,
					Options = '2MO' => Results_OPTION_2MO,
					Options = '3MO' => Results_OPTION_3MO,
					Options = '4MO' => Results_OPTION_4MO,
					Options = '5MO' => Results_OPTION_5MO,
					Options = '6MO' => Results_OPTION_6MO,
					Options = '7MO' => Results_OPTION_7MO,
					Options = '8MO' => Results_OPTION_8MO,
					Results_Attributes_Only_ADL);

	EmptyCoreResults := dataset([], Models.Layouts_Healthcare_Core.Final_Output_Layout);

	CoreResults := IF(isCoreRequest_Valid, validCoreResults, EmptyCoreResults);

ENDMACRO;
