﻿
import risk_indicators, models, std, Profilebooster;
IMPORT LUCI, ut, STD;
IMPORT HCSE_GE_18_LUCI_MODEL;
IMPORT HCSE_LT_18_LUCI_MODEL;


export Healthcare_SocioEconomic_Core(isCoreRequestValid ,batch_in, DPPAPurpose_in, GLBPurpose_in, DataRestrictionMask_in, DataPermissionMask_in, Options_in, CoreResults) := MACRO
	
	boolean isCoreRequest_Valid := isCoreRequestValid;
	DATASET(Models.Layouts_Healthcare_Core.Layout_SocioEconomic_Batch_In) batchin := batch_in;
	//batchin := dataset([],Models.Layouts_Healthcare_Core.Layout_SocioEconomic_Batch_In);
	unsigned1 prep_dppa := DPPAPurpose_in;
	unsigned1 glb := GLBPurpose_in;
	string DataRestriction := DataRestrictionMask_in;
	string50 DataPermission := DataPermissionMask_in;
	String Options := (string)Options_in;

	gateways := Gateway.Constants.void_gateway;
	//IF(prep_dppa <> Models.Healthcare_Constants_Core.authorized_DPPA OR glb <> Models.Healthcare_Constants_Core.authorized_GLBA, FAIL('Supplied Permissible Purpose Settings (GLBPurpose and/or DPPAPurpose) are invalid')); //This will now be performed in a step prior to calling the core.

	string5   industry_class_val := '';
	boolean   isUtility := false;
	boolean   ofac_Only := false;


	unsigned3 history_date := 999999; //Default if input is 0

	unsigned1 dppa := prep_dppa; //Remove DNC filter if(~DisableDoNotMailFilter, 0, prep_dppa);
	LeadIntegrityVersion := Models.Healthcare_Constants_Core.default_LeadIntegrity_Version;//We want version 4
	bsVersion := Models.Healthcare_Constants_Core.default_BocaShell_Version; //We want version 4.1

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
	BOOLEAN   ofacSearching := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	UNSIGNED1 ofacVersion := IF(LeadIntegrityVersion >= 4, 2, 1);
	BOOLEAN   includeAdditionalWatchlists := IF(LeadIntegrityVersion >= 4, TRUE, FALSE);
	BOOLEAN   excludeWatchlists := IF(LeadIntegrityVersion >= 4, FALSE, TRUE); // Attributes 4.1 return a watchlist hit, so don't exclude watchlists
	// For ITA we can't use FARES Data
	BOOLEAN filterOutFares := TRUE;
	append_best := if(LeadIntegrityVersion >= 4, 2, 0 );

	unsigned8 BSOptions := IF(LeadIntegrityVersion >= 4, risk_indicators.iid_constants.BSOptions.IncludeDoNotMail + 
																											risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity,
																											risk_indicators.iid_constants.BSOptions.IncludeDoNotMail);

/* ***************************************
	 *     Gather Boca Shell Results:      *
   *************************************** */
	iid := Risk_Indicators.InstantID_Function(cleanIn, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, ofacSearching, includeAdditionalWatchlists,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission);
	iidHist12 := Risk_Indicators.InstantID_Function(cleanInHist12, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, ofacSearching, includeAdditionalWatchlists,
																						in_BSversion := bsVersion, in_runDLverification:=IncludeDLverification, in_DataRestriction := DataRestriction, in_append_best := append_best, in_BSOptions := BSOptions, in_DataPermission := DataPermission);
	iidHist24 := Risk_Indicators.InstantID_Function(cleanInHist24, gateways, DPPA, GLB, isUtility, isLn, ofac_Only, 
																						suppressNearDups, require2Ele, fromBIID, isFCRA, excludeWatchlists, fromIT1O, ofacVersion, ofacSearching, includeAdditionalWatchlists,
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
						self := right; self := left;),left outer, keep(1000), atmost(1));
	rawResults12 := join(batchinseq, LeadIntegrityHist12, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_attributes_combined,
						self.acctno := left.acctno;
						self := right),keep(1000), atmost(1));
	rawResults24 := join(batchinseq, LeadIntegrityHist24, left.seq=(unsigned)right.seq, transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_attributes_combined,
						self.acctno := left.acctno;
						self := right),keep(1000), atmost(1));

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
								left outer, keep(1000), atmost(1));
	rawResults_append12 := join(rawResults_appendInput,rawResults12,(integer)left.seq=(integer)right.seq,
								transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_attributes_combined,
									self.v4_CurrAddrBurglaryIndex12 := right.version4.CurrAddrBurglaryIndex;
									self.v4_EstimatedAnnualIncome12 := right.version4.EstimatedAnnualIncome;
									self.v4_PropOwnedTaxTotal12 := right.version4.PropOwnedTaxTotal;
									self.v4_SFDUAddrIdentitiesCount12 := right.version4.SFDUAddrIdentitiesCount;
									self:=left;), 
								left outer, keep(1000), atmost(1));
	rawResults_final := dedup(sort(join(rawResults_append12,rawResults24,(integer)left.seq=(integer)right.seq,
								transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_attributes_combined,
									self.v4_CurrAddrBurglaryIndex24 := right.version4.CurrAddrBurglaryIndex;
									self.v4_EstimatedAnnualIncome24 := right.version4.EstimatedAnnualIncome;
									self.v4_PropOwnedTaxTotal24 := right.version4.PropOwnedTaxTotal;
									self.v4_SFDUAddrIdentitiesCount24 := right.version4.SFDUAddrIdentitiesCount;
									self:=left;), 
								left outer, keep(1000), atmost(1)),record),record);

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
					self := left; self := right;),left outer, keep(1000), atmost(1));
	
	/********Flattening the combined Lead Integrity and Profile Booster attributes*********/
	Combined_LI_PB_Attributes_flat := project(Combined_LI_PB_Attributes, Models.Healthcare_SocioEconomic_Transforms_Core.FlattenLIPB(LEFT));

	//Preparing the data for Pre Processing i.e. substituting crosswalk values, history attributes etc.
	Combined_LI_PB_Prep_Pre_Proc := project(Combined_LI_PB_Attributes_flat, Models.Healthcare_SocioEconomic_Transforms_Core.Prep_For_Pre_Processing_Xform(LEFT));
	
	//******************************************************************SE HS**************************************************************************************//
	
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
		self := right;),left outer, keep(1000), atmost(1));
	LT_18_Prediction_Post_Proc := Join(Patterns_Applied_LT_18, LT_18_LUCI_results_base, left.seq=(integer)right.TransactionID, transform(Models.Layouts_Healthcare_Core.PostProcessing_Layout_LUCI_Model,
		self.Score := MAX((Real8)right.Score, left.AG_Pred_5K_under18 * 0.2);
		self.seq := (integer)right.TransactionID;
		self.acctno := (string) left.acctno;
		self := right;),left outer, keep(1000), atmost(1));
	
	SeHs_GE_LT_Predictions := GE_18_Prediction_Post_Proc +  LT_18_Prediction_Post_Proc;	
	
//****************************************************SE RS*********************************************************************************************//

	SeRs_PreProc_Patterns_Applied := Models.Healthcare_SocioEconomic_Transforms_Core.SeRs_Preprocessing_and_Patterns_M0_M1(Combined_LI_PB_Prep_Pre_Proc,Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed);
	SeRs_PreProc_Patterns_Validated := join(SeRs_PreProc_Patterns_Applied,icdkey.key().ref_icd10_diag_key.qa,
											keyed(STD.Str.ToUpperCase(std.Str.FilterOut(left.admit_diagnosis_code, '.')) = right.diag_cd),
											Transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed,
											self.isSeRsInvalidDiag := if(right.desc_short<>'',0,1);
											self := left;
											), left outer, atmost(1));

	SeRs_PreProc_Patterns_Filtered := SeRs_PreProc_Patterns_Validated(isSeRsExcludedDiag =0 and isSeRsMinor =0 
																	and Models.Healthcare_SocioEconomic_Functions_Core.DOBCleaner(ADMIT_DATE)<>'');
		
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
 //TODO:
 	M0_SeRs_Prediction_Post_Proc := Join(M0_SeRs_PreProc_Patterns_Filtered_Validated_Mapped, M0_SeRs_LUCI_results_base, left.seq=(integer)right.TransactionID, transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed,
		self.SeRs_Raw_Score := (string) right.score;
		DECIMAL5_2 vScore :=  TRUNCATE((real8)right.score*10000)/100;
		self.SeRs_Score := (string) vScore;
		self.seq := (integer)right.TransactionID;
		self := left;),left outer, keep(1000), atmost(1));
	M1_SeRs_Prediction_Post_Proc := Join(M1_Xwalked, M1_SeRs_LUCI_results_base, left.seq=(integer)right.TransactionID, transform(Models.Layouts_Healthcare_Core.layout_SocioEconomic_LI_PB_flat_typed,
		self.SeRs_Raw_Score := (string) right.score;
		DECIMAL5_2 vScore := TRUNCATE((real8)right.score*10000)/100;
		self.SeRs_Score := (string) vScore;
		self.seq := (integer)right.TransactionID;
		self := left;),left outer, keep(1000), atmost(1));

	SeRs_Combined_M0_M1_results := M0_SeRs_Prediction_Post_Proc + M1_SeRs_Prediction_Post_Proc + SeRs_PreProc_Patterns_Excluded;

//*******************************SE MA*******************************************************//
/*
M0_SeMA_PreProc_Xwalked_Mapped := Models.Healthcare_SocioEconomic_Transforms_Core.SeMA_M0_Xwalk_PreProc_Mapping(Combined_LI_PB_Prep_Pre_Proc, Models.Layouts_Healthcare_Core.SeMA_M0_Model_Typed_Input_Layout);
// output(M0_SeMA_PreProc_Xwalked_Mapped, NAMED('M0_SeMA_PreProc_Xwalked_Mapped'));
M0_SeMA_LUCI_results_base := HCSE_SEMA_PDC_GBM_M0_V1_model_LUCI.AsResults(M0_SeMA_PreProc_Xwalked_Mapped(isSEMA_Minor<>1)).Base();
// output(M0_SeMA_LUCI_results_base, NAMED('M0_SeMA_LUCI_results_base'));
M0_SeMA_results_Post_Proc := PROJECT(M0_SeMA_LUCI_results_base, TRANSFORM(Models.Layouts_Healthcare_Core.SeMA_Model_Output_Layout, 
																		SELF.seq := (integer)LEFT.TransactionID;
																		SELF.SeMA_Raw_Score := (string) LEFT.score;
																		DECIMAL5_2 vScore :=  TRUNCATE((real8)LEFT.score*10000)/100;
																		self.SeMA_Score := (string) vScore;
																		SELF := LEFT));
// output(M0_SeMA_results_Post_Proc, NAMED('M0_SeMA_results_Post_Proc'));
*/
//************* OPTION 1 *****************//
	Results_Attributes_Only := project(Combined_LI_PB_Attributes_flat, Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_1_SE_A(LEFT));					

	Results_Attributes_Only_ADL := Join(Results_Attributes_Only, iid, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.Final_Output_Layout,
						self.ADLScore := (string)right.score;
						self := left;),left outer, keep(1000), atmost(1));

//************* OPTION 2 *****************// 
	Results_OPTION_2_SE_RS := project(SeRs_Combined_M0_M1_results, Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_2_SE_RS(LEFT));					

	Results_OPTION_2_SE_RS_ADL := Join(Results_OPTION_2_SE_RS, iid, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.Final_Output_Layout,
						self.ADLScore := (string)right.score;
						self := left;),left outer, keep(1000), atmost(1));

//************* OPTION 3 *****************// 
	Results_OPTION_3_SE_HS := project(SeHs_GE_LT_Predictions, Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_3_SE_HS(LEFT));					

	Results_OPTION_3_SE_HS_ADL := Join(Results_OPTION_3_SE_HS, iid, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.Final_Output_Layout,
						self.ADLScore := (string)right.score;
						self.LexID    := (string)right.did;
						self := left;),left outer, keep(1000), atmost(1));

//************* OPTION 4 *****************// 
	Results_OPTION_4_SE_HS_RS := Join(Results_OPTION_3_SE_HS, SeRs_Combined_M0_M1_results, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.Final_Output_Layout,
						SELF.SeRs_Score                   := (String) IF(right.SeRs_Score<>'',right.SeRs_Score, 'N/A');
						SELF.SeRs_Raw_Score               := (String) IF(right.SeRs_Raw_Score<>'',right.SeRs_Raw_Score, 'N/A');
						SELF.isSeRsInvalidDiag            := (String) right.isSeRsInvalidDiag;
						SELF.isSeRsInvalidPatientType     := (String) right.isSeRsInvalidPatientType;
						SELF.isSeRsInvalidFinancialClass  := (String) right.isSeRsInvalidFinancialClass;
						self.LexID   						 				 := (string) right.LexID;
						self.seq                 := (string) left.seq;
						self.acctno              := (string) left.acctno;
				  SELF.Score               := (String) left.Score; //Or you can have self := left and remove seq and score
						self := [];),left outer, keep(1000), atmost(1));

	Results_OPTION_4_SE_HS_RS_ADL := Join(Results_OPTION_4_SE_HS_RS, iid, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.Final_Output_Layout,
						self.ADLScore := (string)right.score;
						self := left;),left outer, keep(1000), atmost(1));

//************* OPTION 5 *****************// 
	Results_OPTION_5_SE_A_RS := Join(Combined_LI_PB_Attributes_flat, SeRs_Combined_M0_M1_results, (string)left.seq=(string)right.seq, 
									Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_5_SE_A_RS(LEFT, RIGHT),left outer, keep(1000), atmost(1));
	Results_OPTION_5_SE_A_RS_ADL := Join(Results_OPTION_5_SE_A_RS, iid, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.Final_Output_Layout,
						self.ADLScore := (string)right.score;
						self := left;),left outer, keep(1000), atmost(1));

//************* OPTION 6 *****************// 
	Results_OPTION_6_SE_A_HS := Join(Combined_LI_PB_Attributes_flat, SeHs_GE_LT_Predictions, (string)left.seq=(string)right.seq, 
									Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_6_SE_A_HS(LEFT, RIGHT),left outer, keep(1000), atmost(1));
	Results_OPTION_6_SE_A_HS_ADL := Join(Results_OPTION_6_SE_A_HS, iid, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.Final_Output_Layout,
						self.ADLScore := (string)right.score;
						self := left;),left outer, keep(1000), atmost(1));

//************* OPTION 7 *****************// 
	Results_OPTION_7_SE_A_HS_RS := Join(Combined_LI_PB_Attributes_flat, Results_OPTION_4_SE_HS_RS, (string)left.seq=(string)right.seq, 
										Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_7_SE_A_HS_RS(LEFT, RIGHT),left outer, keep(1000), atmost(1));
	Results_OPTION_7_SE_A_HS_RS_ADL := Join(Results_OPTION_7_SE_A_HS_RS, iid, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.Final_Output_Layout,
						self.ADLScore := (string)right.score;
						self := left;),left outer, keep(1000), atmost(1));

//************* OPTION 8 *****************//
	Results_OPTION_8_SE_HS_RS := Join(SeHs_GE_LT_Predictions, SeRs_Combined_M0_M1_results, (string) left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.Final_Output_Layout,
										SELF.SeRs_Score                   := (String) IF(right.SeRs_Score<>'',right.SeRs_Score, 'N/A');
										SELF.SeRs_Raw_Score               := (String) IF(right.SeRs_Raw_Score<>'',right.SeRs_Raw_Score, 'N/A');
										SELF.isSeRsInvalidDiag            := (String) right.isSeRsInvalidDiag;
										SELF.isSeRsInvalidPatientType     := (String) right.isSeRsInvalidPatientType;
										SELF.isSeRsInvalidFinancialClass  := (String) right.isSeRsInvalidFinancialClass;
										self.LexID                        := (string) right.LexID;
										SELF.FINANCIAL_CLASS              := (String) Right.FINANCIAL_CLASS;
										SELF.PATIENT_TYPE                 := (String) Right.PATIENT_TYPE;
										SELF.GENDER                       := (String) Right.GENDERstr;
										SELF.RSMemberAge                  := (String) Right.RSMemberAge;
										SELF.AGE_GROUP                    := (String) Right.AGE_GROUP;
										SELF.ADMIT_DIAG                   := (String) Right.ADMIT_DIAG;
										SELF.READMIT_DIAG                 := (String) Right.READMIT_DIAG;
										SELF.READMIT_LIFT                 := (String) Right.READMIT_LIFT;
										SELF.isSeRsExcludedDiag           := (String) Right.isSeRsExcludedDiag;
										SELF.isSeRsMinor                  := (String) Right.isSeRsMinor;
										SELF.isSeRsM1ModelUsed            := (String) Right.isSeRsM1ModelUsed;
										self.seq                 := (string) left.seq;
										SELF.Score               := (String) left.Score;
										self := [];),
									left outer, keep(1000), atmost(1));

	Results_OPTION_8_SE_DEBUG := Join(Combined_LI_PB_Attributes_flat, Results_OPTION_8_SE_HS_RS, (string)left.seq=(string)right.seq, 
									  Models.Healthcare_SocioEconomic_Transforms_Core.OPTION_8_SE_DEBUG(LEFT, RIGHT),left outer, keep(1000), atmost(1));
	Results_OPTION_8_SE_DEBUG_ADL := Join(Results_OPTION_8_SE_DEBUG, iid, left.seq=(string)right.seq, transform(Models.Layouts_Healthcare_Core.Final_Output_Layout,
						self.ADLScore := (string)right.score;
						self := left;),left outer, keep(1000), atmost(1));

/*	//SEMA Option M
	Bat_inp := PROJECT(batchinseq, TRANSFORM(Models.Layouts_Healthcare_Core.Final_Output_Layout, 
																		SELF.seq := (string)LEFT.seq;
																		SELF.acctno := (string) LEFT.acctno;
																		SELF := [])); //To get accountno
	SeMA_Inp_LexID_ADLScore :=  Models.Healthcare_SocioEconomic_Transforms_Core.Add_LexID_ADLScore(Bat_inp, iid,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	Results_OPTION_M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score(SeMA_Inp_LexID_ADLScore, M0_SeMA_results_Post_Proc,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_M, NAMED('Results_OPTION_M'));

	Results_OPTION_1M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score(Results_Attributes_Only_ADL, M0_SeMA_results_Post_Proc,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_1M, NAMED('Results_OPTION_1M'));
	Results_OPTION_2M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score(Results_OPTION_2_SE_RS_ADL, M0_SeMA_results_Post_Proc,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_2M, NAMED('Results_OPTION_2M'));
	Results_OPTION_3M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score(Results_OPTION_3_SE_HS_ADL, M0_SeMA_results_Post_Proc,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_3M, NAMED('Results_OPTION_3M'));
	Results_OPTION_4M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score(Results_OPTION_4_SE_HS_RS_ADL, M0_SeMA_results_Post_Proc,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_4M, NAMED('Results_OPTION_4M'));
	Results_OPTION_5M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score(Results_OPTION_5_SE_A_RS_ADL, M0_SeMA_results_Post_Proc,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_5M, NAMED('Results_OPTION_5M'));
	Results_OPTION_6M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score(Results_OPTION_6_SE_A_HS_ADL, M0_SeMA_results_Post_Proc,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_6M, NAMED('Results_OPTION_6M'));
	Results_OPTION_7M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score(Results_OPTION_7_SE_A_HS_RS_ADL, M0_SeMA_results_Post_Proc,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_7M, NAMED('Results_OPTION_7M'));
	Results_OPTION_8M := Models.Healthcare_SocioEconomic_Transforms_Core.Add_SEMA_Score(Results_OPTION_8_SE_DEBUG_ADL, M0_SeMA_results_Post_Proc,Models.Layouts_Healthcare_Core.Final_Output_Layout);
	// output(Results_OPTION_8M, NAMED('Results_OPTION_8M'));
	*/

	validCoreResults := MAP(Options = '1' => Results_Attributes_Only_ADL,
					Options = '2' => Results_OPTION_2_SE_RS_ADL,
					Options = '3' => Results_OPTION_3_SE_HS_ADL,
					Options = '4' => Results_OPTION_4_SE_HS_RS_ADL,
					Options = '5' => Results_OPTION_5_SE_A_RS_ADL,
					Options = '6' => Results_OPTION_6_SE_A_HS_ADL,
					Options = '7' => Results_OPTION_7_SE_A_HS_RS_ADL,
					Options = '8' => Results_OPTION_8_SE_DEBUG_ADL,
					// Options = 'M' => Results_OPTION_M,
					// Options = '1M' => Results_OPTION_1M,
					// Options = '2M' => Results_OPTION_2M,
					// Options = '3M' => Results_OPTION_3M,
					// Options = '4M' => Results_OPTION_4M,
					// Options = '5M' => Results_OPTION_5M,
					// Options = '6M' => Results_OPTION_6M,
					// Options = '7M' => Results_OPTION_7M,
					// Options = '8M' => Results_OPTION_8M,
					Results_Attributes_Only_ADL);

	EmptyCoreResults := dataset([], Models.Layouts_Healthcare_Core.Final_Output_Layout);

	CoreResults := IF(isCoreRequest_Valid, validCoreResults, EmptyCoreResults);

ENDMACRO;
