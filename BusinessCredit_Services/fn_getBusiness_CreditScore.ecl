IMPORT Address, AutoStandardI, BIPV2, Business_Credit_Scoring, BusinessCredit_Services, Business_Risk_BIP, Doxie, iesp, LNSmallBusiness, ut, std;

EXPORT fn_getBusiness_CreditScore (BusinessCredit_Services.Iparam.reportrecords inmod,
																		DATASET(BusinessCredit_Services.Layouts.TopBusiness_BestSection) topBusiness_bestRecs,
																		DATASET(doxie.layout_best) AuthRepBestRec,
																		DATASET(RECORDOF(Business_Credit_Scoring.Key_ScoringIndex().kFetch2(DATASET([],BIPV2.IDlayouts.l_xlink_ids2)))) ScoringInfokfetch
																		) := MODULE

	
	SHARED BuzCreditScoringRecs := ScoringInfokfetch;

	// Adding min input check for Business & AuthRep. we only wanted to suppliment information from best file to analytics fxn when below check is not satisfied in the search.
	// this is done to fix Score Mismatch between CreditReport and Analytics Score service
	MinimumInputForBizSearch := (inmod.CompanyName != '' AND  inmod.Tin != '') OR 
															(inmod.CompanyName != '' AND  inmod.Company_StreetAddress1 != '' AND inmod.Company_Zip != '' ) OR 
															(inmod.CompanyName != '' AND  inmod.Company_StreetAddress1 != '' AND inmod.Company_City != '' AND inmod.Company_State != '');

	MinimumInputForAuthRep := (inmod.LastName != '' AND inmod.FirstName != '' AND inmod.SSN != '')  OR 
														(inmod.LastName != '' AND inmod.FirstName != '' AND inmod.AuthRep_StreetAddress1 != '' AND inmod.AuthRep_Zip != '' ) OR 
														(inmod.LastName != '' AND inmod.FirstName != '' AND inmod.AuthRep_StreetAddress1 != '' AND inmod.AuthRep_City != '' AND inmod.AuthRep_State != ''); 

	set_model := IF(inmod.did != '' OR MinimumInputForAuthRep, BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED, BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT);

	input_options := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
		EXPORT UNSIGNED1	DPPA_Purpose 								:= AutoStandardI.InterfaceTranslator.dppa_purpose.val(inmod);
		EXPORT UNSIGNED1	GLBA_Purpose 								:= AutoStandardI.InterfaceTranslator.glb_purpose.val(inmod);
		EXPORT STRING50		DataRestrictionMask					:= inmod.DataRestrictionMask;
		EXPORT STRING50		DataPermissionMask					:= inmod.DataPermissionMask;
		EXPORT STRING10		IndustryClass								:= Business_Risk_BIP.Constants.Default_IndustryClass;
		EXPORT UNSIGNED1	LinkSearchLevel							:= Business_Risk_BIP.Constants.LinkSearch.Default;
		EXPORT UNSIGNED1	BusShellVersion							:= Business_Risk_BIP.Constants.Default_BusShellVersion;
		EXPORT UNSIGNED1	MarketingMode								:= Business_Risk_BIP.Constants.Default_MarketingMode;
		EXPORT STRING50		AllowedSources							:= Business_Risk_BIP.Constants.Default_AllowedSources;
		EXPORT UNSIGNED1	BIPBestAppend								:= Business_Risk_BIP.Constants.BIPBestAppend.Default;
		EXPORT UNSIGNED1	OFAC_Version								:= Business_Risk_BIP.Constants.Default_OFAC_Version;
		EXPORT REAL				Global_Watchlist_Threshold	:= Business_Risk_BIP.Constants.Default_Global_Watchlist_Threshold;
		EXPORT BOOLEAN    DoNotUseAuthRepInBIPAppend  := TRUE;
	END;
	
	Business_Risk_BIP.Layouts.Input prepare_input() := TRANSFORM
		SELF.Seq            		:= 1;
		SELF.AcctNo         		:= '1';
		SELF.HistoryDate    		:= (INTEGER)Business_Risk_BIP.Constants.NinesDate;
		SELF.HistoryDateTime		:= (INTEGER)Business_Risk_BIP.Constants.NinesDateTime;
		SELF.CompanyName    		:= IF(MinimumInputForBizSearch, inmod.CompanyName , topBusiness_bestrecs[1].BestSection.CompanyName);
		SELF.Prim_Range 				:= IF(MinimumInputForBizSearch, inmod.Company_StreetNumber , topBusiness_bestrecs[1].BestSection.Address.StreetNumber);
		SELF.PreDir 						:= IF(MinimumInputForBizSearch, inmod.Company_StreetPreDirection , topBusiness_bestrecs[1].BestSection.Address.StreetPreDirection);
		SELF.Prim_Name 					:= IF(MinimumInputForBizSearch, inmod.Company_StreetName , topBusiness_bestrecs[1].BestSection.Address.StreetName);
		SELF.Addr_Suffix 				:= IF(MinimumInputForBizSearch, inmod.Company_StreetSuffix , topBusiness_bestrecs[1].BestSection.Address.StreetSuffix);
		SELF.PostDir 						:= IF(MinimumInputForBizSearch, inmod.Company_StreetPostDirection , topBusiness_bestrecs[1].BestSection.Address.StreetPostDirection);
		SELF.Unit_Desig 				:= IF(MinimumInputForBizSearch, inmod.Company_UnitDesignation , topBusiness_bestrecs[1].BestSection.Address.UnitDesignation);
		SELF.Sec_Range 					:= IF(MinimumInputForBizSearch, inmod.Company_UnitNumber , topBusiness_bestrecs[1].BestSection.Address.UnitNumber);
		SELF.StreetAddress1 		:= IF(MinimumInputForBizSearch, inmod.Company_StreetAddress1 , topBusiness_bestrecs[1].BestSection.Address.StreetAddress1);
		SELF.City           		:= IF(MinimumInputForBizSearch, inmod.Company_City , topBusiness_bestrecs[1].BestSection.Address.City);
		SELF.State         			:= IF(MinimumInputForBizSearch, inmod.Company_State , topBusiness_bestrecs[1].BestSection.Address.State);
		SELF.Zip          			:= IF(MinimumInputForBizSearch, inmod.Company_Zip , topBusiness_bestrecs[1].BestSection.Address.Zip5);		
		SELF.FEIN          			:= IF(MinimumInputForBizSearch, inmod.Tin , topBusiness_bestrecs[1].BestSection.Tin);		
		SELF.Phone10    				:= IF(MinimumInputForBizSearch, inmod.Company_Phone, topBusiness_bestrecs[1].BestSection.PhoneInfo.Phone10);
		SELF.SeleID  						:= inmod.BusinessIds[1].SeleID;
		SELF.OrgID   						:= inmod.BusinessIds[1].OrgID;
		SELF.UltID   						:= inmod.BusinessIds[1].UltID;
		//authorized rep
		SELF.Rep_FirstName 			:= IF(MinimumInputForAuthRep, inmod.FirstName, AuthRepBestRec[1].fname);
		SELF.Rep_MiddleName 		:= IF(MinimumInputForAuthRep, inmod.MiddleName, AuthRepBestRec[1].mname);
		SELF.Rep_LastName 			:= IF(MinimumInputForAuthRep, inmod.LastName, AuthRepBestRec[1].lname);
		Authrep_best_address 		:=  Address.Addr1FromComponents(	AuthRepBestRec[1].prim_range,
																															AuthRepBestRec[1].predir,
																															AuthRepBestRec[1].prim_name,
																															AuthRepBestRec[1].suffix,
																															AuthRepBestRec[1].postdir,
																															AuthRepBestRec[1].unit_desig,
																															AuthRepBestRec[1].sec_range);
		SELF.Rep_StreetAddress1 := IF(MinimumInputForAuthRep, inmod.AuthRep_StreetAddress1 , Authrep_best_address);
		SELF.Rep_City 					:= IF(MinimumInputForAuthRep, inmod.AuthRep_City , AuthRepBestRec[1].city_name);
		SELF.Rep_State 					:= IF(MinimumInputForAuthRep, inmod.AuthRep_State , AuthRepBestRec[1].st);
		SELF.Rep_Zip 						:= IF(MinimumInputForAuthRep, inmod.AuthRep_Zip , AuthRepBestRec[1].zip);
		SELF.Rep_SSN 						:= IF(MinimumInputForAuthRep, inmod.SSN , AuthRepBestRec[1].SSN);
		SELF.Rep_Phone10 				:= IF(MinimumInputForAuthRep, (STRING)inmod.AuthRep_Phone , (STRING)AuthRepBestRec[1].phone);
		SELF.Rep_DLNumber 			:= IF(MinimumInputForAuthRep, inmod.DLNumber, '');
		SELF.Rep_DLState 				:= IF(MinimumInputForAuthRep, inmod.DLState , '');
		SELF         						:= [];
	END;

	Business_Risk_BIP.Layouts.Input prepare_input_for_Combined_service() := TRANSFORM
		SELF.Seq            		:= 1;
		SELF.AcctNo         		:= '1';
		SELF.HistoryDate    		:= (INTEGER)Business_Risk_BIP.Constants.NinesDate;
		SELF.HistoryDateTime		:= (INTEGER)Business_Risk_BIP.Constants.NinesDateTime;
		SELF.CompanyName    		:= inmod.CompanyName;
		SELF.Prim_Range 				:= inmod.Company_StreetNumber;
		SELF.PreDir 						:= inmod.Company_StreetPreDirection;
		SELF.Prim_Name 					:= inmod.Company_StreetName;
		SELF.Addr_Suffix 				:= inmod.Company_StreetSuffix;
		SELF.PostDir 						:= inmod.Company_StreetPostDirection;
		SELF.Unit_Desig 				:= inmod.Company_UnitDesignation;
		SELF.Sec_Range 					:= inmod.Company_UnitNumber;
		SELF.StreetAddress1 		:= inmod.Company_StreetAddress1;
		SELF.City           		:= inmod.Company_City;
		SELF.State         			:= inmod.Company_State;
		SELF.Zip          			:= inmod.Company_Zip;		
		SELF.FEIN          			:= inmod.Tin;		
		SELF.Phone10    				:= inmod.Company_Phone;
		SELF.SeleID  						:= 0;
		SELF.OrgID   						:= 0;
		SELF.UltID   						:= 0;
		//authorized rep
		SELF.Rep_FirstName 			:= inmod.FirstName;
		SELF.Rep_MiddleName 		:= inmod.MiddleName;
		SELF.Rep_LastName 			:= inmod.LastName;
		Authrep_best_address 		:= Address.Addr1FromComponents(	AuthRepBestRec[1].prim_range,
																														AuthRepBestRec[1].predir,
																														AuthRepBestRec[1].prim_name,
																														AuthRepBestRec[1].suffix,
																														AuthRepBestRec[1].postdir,
																														AuthRepBestRec[1].unit_desig,
																														AuthRepBestRec[1].sec_range);
		SELF.Rep_StreetAddress1 := inmod.AuthRep_StreetAddress1;
		SELF.Rep_City 					:= inmod.AuthRep_City;
		SELF.Rep_State 					:= inmod.AuthRep_State;
		SELF.Rep_Zip 						:= inmod.AuthRep_Zip;
		SELF.Rep_SSN 						:= inmod.SSN;
		SELF.Rep_Phone10 				:= (STRING)inmod.AuthRep_Phone;
		SELF.Rep_DLNumber 			:= inmod.DLNumber;
		SELF.Rep_DLState 				:= inmod.DLState;
		SELF         						:= [];	
	END;
	
	input_rec				:= IF( inmod.UseInputDataAsIs, DATASET([prepare_input_for_Combined_service()]), DATASET([prepare_input()]) );
	SHARED results	:= LNSmallBusiness.fn_SmallBusiness_getScores(input_rec, input_options, set_model);

	model_results	:= NORMALIZE(results, LEFT.modelresults, TRANSFORM(RIGHT));
	
	iesp.businesscreditreport.t_BusinessCreditScore score_trans(RECORDOF(model_results) L) := TRANSFORM  
		SELF.ScoreType		 	:=	CASE(L.ModelName,
                                 BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL	 => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT,
                                 BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO	 => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT,
																 BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL => BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED,
																 BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB  => BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED,
																''
																);
		SELF.MinScoreRange 	:=	(integer)L.MinRange;
		SELF.MaxScoreRange 	:=	(integer)L.MaxRange;
		SELF.Score					:= 	(integer)L.Score;
		SELF.ScoreRiskLevel	:=	L.risklevel;
		SELF.ScoreReasons		:=	CHOOSEN(PROJECT(L.reasoncodes, 
																			TRANSFORM (iesp.businesscreditreport.t_BusinessCreditScoreReason, 
																				SELF.Sequence 	 := (integer)LEFT.SeqNo,
																				SELF.ReasonCode	 := LEFT.ReasonCode,
																				SELF.Description := LEFT.ReasonCodeDesc )), BusinessCredit_Services.Constants.MAX_CREDIT_SCORE_REASON);
		SELF := [];
	END;
	
	_curr_Scores	:= PROJECT(model_results , score_trans(LEFT));

	iesp.businesscreditreport.t_BusinessCreditScoring trans_CurrScores() := TRANSFORM
		SELF.DateScored 									:= iesp.ECL2ESP.toDatestring8((STRING8)Std.Date.Today()),
		SELF.CurrentPriorFlag 						:= LNSmallBusiness.Constants.CURRENT_FLAG,
		SELF.Scores 											:= PROJECT(_curr_Scores , TRANSFORM(LEFT)), 
		SELF															:= [];
	END;
	
	curr_Scores := DATASET([trans_CurrScores()]);

	//get current historical scores using index.
	BuzCreditScoringRecs_srt := SORT(BuzCreditScoringRecs, UltID, OrgID, SeleID, -Version);
	
	hist_scores		:= CHOOSEN(PROJECT(BuzCreditScoringRecs_srt, 
														TRANSFORM(iesp.businesscreditreport.t_BusinessCreditScoring,
															SELF.DateScored 									:= iesp.ECL2ESP.toDatestring8(LEFT.version),
															SELF.CurrentPriorFlag							:= LNSmallBusiness.Constants.HISTORICAL_FLAG,
															SELF.PrimaryIndustryCode					:= LEFT.Classification_Code,
															SELF.PrimaryIndustryDescription		:= LEFT.Classification_Code_Description,
															SELF.IndustryScore								:= (INTEGER)LEFT.Industry_Score_Avg,
															SELF.Scores												:= CHOOSEN(PROJECT(LEFT.Scores , 
																																						TRANSFORM(iesp.businesscreditreport.t_BusinessCreditScore,
																																							SELF.ScoreType		 	:=	LEFT.Score_Name; 
																																							SELF.MinScoreRange 	:=	LEFT.Min_Score_Range;
																																							SELF.MaxScoreRange 	:=	LEFT.Max_Score_Range;
																																							SELF.Score					:= 	LEFT.Score;
																																							SELF.ScoreRiskLevel	:=	MAP(
																																																					(UNSIGNED)SELF.Score BETWEEN 501 AND 650 => LNSmallBusiness.Constants.RISK_LEVEL_HIGH,
																																																					(UNSIGNED)SELF.Score BETWEEN 651 AND 750 => LNSmallBusiness.Constants.RISK_LEVEL_MEDIUM,
																																																					(UNSIGNED)SELF.Score BETWEEN 751 AND 900 => LNSmallBusiness.Constants.RISK_LEVEL_LOW,
																																																					(UNSIGNED)SELF.Score = 222               => LNSmallBusiness.Constants.RISK_LEVEL_NO_HIT,
																																																					/* default...........................: */   LNSmallBusiness.Constants.RISK_LEVEL_DEFAULT
																																																			); //Logic to determine High/Med/Low scores given by scoring team.
																																							SELF.ScoreReasons		:= 	CHOOSEN(PROJECT(LEFT.ScoreReasons, iesp.businesscreditreport.t_BusinessCreditScoreReason),BusinessCredit_Services.Constants.MAX_CREDIT_SCORE_REASON);
																																						)), iesp.constants.BusinessCredit.MaxScores);
													)), BusinessCredit_Services.Constants.Max_Historical_Scores);

	EXPORT final_scores 	:= SORT(curr_Scores + hist_scores, -(CurrentPriorFlag = LNSmallBusiness.Constants.CURRENT_FLAG), -DateScored);
	SBA_Phone_Sources 		:= NORMALIZE(results, LEFT.PhoneSources, TRANSFORM(RIGHT));
	EXPORT Phone_Sources	:= PROJECT(SBA_Phone_Sources, TRANSFORM(iesp.businesscreditreport.t_BusinessCreditPhoneSources,
																																SELF.DateFirstSeen:= iesp.ECL2ESP.toDatestring8(LEFT.DateFirstSeen+'00'),
																																SELF.DateLastSeen	:= iesp.ECL2ESP.toDatestring8(LEFT.DateLastSeen+'00'),
																																SELF							:= LEFT));
	EXPORT BIPID_Weight := results[1].Weight;
END;