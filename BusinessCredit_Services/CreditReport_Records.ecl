IMPORT BIPV2, Business_Credit, BusinessCredit_Services, Codes, Doxie, iesp, Suppress, Business_Credit_Scoring;

EXPORT CreditReport_Records(BusinessCredit_Services.Iparam.reportrecords inmod) := FUNCTION
		
		BOOLEAN buzCreditAccess			:= BusinessCredit_Services.Functions.fn_useBusinessCredit(inmod.DataPermissionMask , inmod.Include_BusinessCredit);
		BOOLEAN isBusinessIdExists	:= EXISTS(inmod.BusinessIds(UltID != 0 AND SeleID != 0 AND OrgID != 0));

          // orginal code:
       
		//GET BIP Header Records.    // this also does the filter of 2 experian sources.
		 busHeaderRecs 				      :=  BusinessCredit_Services.Functions.BipKfetch(inmod.BusinessIds,inmod.FetchLevel,BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT,inmod.DataPermissionMask).BIPBusHeaderRecsSlim;
		
		
		//GET SBFE Header Records.
          buzCreditHeader                       :=  BusinessCredit_Services.Functions.BipKfetch(inmod.BusinessIds, inmod.FetchLevel, BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT, inmod.DatapermissionMask).BusCreditHeaderRecs;  
		buzCreditHeader_ABOnly	:= buzCreditHeader(record_type = Business_Credit.Constants().AccountBase);
		buzCreditHeader_slim 		:= DEDUP(SORT(PROJECT(buzCreditHeader_ABOnly , BusinessCredit_Services.Layouts.buzCredit_AccNo_Slim),
																		#EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts())), 
															 #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()));
		buzCreditHeader_recs		:= IF(buzCreditAccess, buzCreditHeader_slim);
		
		buzCreditHeader_ISOnly	:= buzCreditHeader(record_type = Business_Credit.Constants().IndividualOwner);	
		ds_indOwnrGuarOnlyDids 	:= IF(buzCreditAccess, PROJECT(buzCreditHeader_ISOnly, doxie.layout_references));
																		
		//Business SmartLinx Data.
		topBusiness_recs_raw 	:= IF(isBusinessIdExists, BusinessCredit_Services.TopBusinessRecs_Raw(inmod, busHeaderRecs, buzCreditAccess), dataset([],BusinessCredit_Services.Layouts.TopBusinessRecord));
		 topBusinessRecs			 	:= PROJECT(topBusiness_recs_raw, iesp.businesscreditreport.t_BusinessCreditTopBusinessRecord);
          
   		//GET Person Best Records.
  in_did 								:= IF(inmod.did <> '', DATASET([(UNSIGNED6)inmod.did], Doxie.layout_references));
  authRep_BestRec 			:= IF(EXISTS(in_did), doxie.best_records(in_did,FALSE,inmod.DPPAPurpose, inmod.GLBPurpose));
   		
   		//GET All the Report Data.
			// efficiency added these 2 lines.
	IndustryCode :=	BusinessCredit_Services.fn_getPrimaryIndustry(inmod.BusinessIds , inmod.DataPermissionMask , inmod.Include_BusinessCredit).bestIndustryCode[1].Best_Code;	
     ownerInfokfetch := Business_Credit.Key_BusinessOwnerInformation().Kfetch2(inmod.BusinessIds, inmod.FetchLevel,,inmod.DataPermissionMask, BusinessCredit_Services.Constants.JOIN_LIMIT);
  // efficiency remove rest of topbusines sections not needed within fn_getBusiness_BestInformation
  BusBestInformation 		:= BusinessCredit_Services.fn_getBusiness_BestInformation(inmod, 
	                                                PROJECT(topBusiness_recs_raw,TRANSFORM(BusinessCredit_Services.Layouts.TopBusinessRecord,
																									 SELF.BestSection := LEFT.BestSection;
																									 SELF.INcorporationSection := LEFT.INcorporationSection;
																									 SELF.parentSection := LEFT.ParentSection;
																									 SELf := []
																									 ))
																									  , authRep_BestRec, buzCreditHeader_recs , buzCreditAccess, IndustryCode); 
   
  Suppress.MAC_Suppress(BusBestInformation,BusBestInformation_suppressSSN,inmod.ApplicationType,Suppress.Constants.LinkTypes.SSN,AuthRepSSN);
  Suppress.MAC_Suppress(BusBestInformation_suppressssn,BusBestInformation_suppressDID,inmod.ApplicationType,Suppress.Constants.LinkTypes.DID,UniqueId);
   			
  BusInquiries 					:= BusinessCredit_Services.fn_getBusInquiries(inmod);
   		
  buzCreditTradeLineMod	:= BusinessCredit_Services.fn_getBuzCreditTrades(inmod, buzCreditHeader_recs,IndustryCode); 
  tradeSummary					:= IF(buzCreditAccess, buzCreditTradeLineMod.TradeSummary,ROW([],iesp.businesscreditreport.t_BusinessCreditTradeSummary));
  paymentSummary				:= IF(buzCreditAccess, buzCreditTradeLineMod.PaymentSummary, ROW([],iesp.businesscreditreport.t_BusinessCreditPaymentSummary)); 
  accountDetails				:= IF(buzCreditAccess, buzCreditTradeLineMod.AccDetail_Recs_Combined, DATASET([],iesp.businesscreditreport.t_BusinessCreditAccountDetail));
  creditUtilRecs				:= IF(buzCreditAccess, buzCreditTradeLineMod.CreditUtil_recs_combined , DATASET([],iesp.businesscreditreport.t_BusinessCreditUtilized));
  dbtRecs								:= IF(buzCreditAccess, buzCreditTradeLineMod.DBT_Recs, DATASET([],iesp.businesscreditreport.t_BusinessCreditDBT));
   
  buzCreditSubsidiaries := IF(buzCreditAccess, BusinessCredit_Services.fn_getSubsidiaries(inmod, buzCreditAccess,ownerInfokfetch), 
	                                  DATASET([],iesp.businesscreditreport.t_BusinessCreditSubsidiary));
  buzCreditOwnerGuars 	:= IF(buzCreditAccess, BusinessCredit_Services.fn_getOwnersGuarantors(inmod, ds_indOwnrGuarOnlyDids, buzCreditAccess), 
	                                  DATASET([],iesp.businesscreditreport.t_BusinessCreditOwnerGuarantor));
	
   // efficiency reduce what is passed into function
  topBusiness_bestrecs 				:= PROJECT(topBusiness_recs_raw , TRANSFORM(BusinessCredit_Services.Layouts.TopBusiness_BestSection, SELF := [])); // line added here.	
  BusAdditionalInfo			:= BusinessCredit_Services.fn_getAdditionalInfo(inmod, 
	                                                                                                                                    topBusiness_recs_raw,
	                                                                                                                                      buzCreditHeader_recs);

 
  buzCreditScoreMod			:= BusinessCredit_Services.fn_getBusiness_CreditScore(inmod, topBusiness_recs_raw, authRep_BestRec);

	
  buzCreditScores				:= IF(buzCreditAccess AND inmod.IncludeScores, buzCreditScoreMod.final_scores, DATASET([],iesp.businesscreditreport.t_BusinessCreditScoring));
  PhoneSources0					:= IF(inmod.IncludeScores, buzCreditScoreMod.Phone_Sources, DATASET([],iesp.businesscreditreport.t_BusinessCreditPhoneSources));
		PhoneSources          := PhoneSources0(source not in BusinessCredit_Services.Constants.EXCLUDED_EXPERIAN_SRC); // restricting ER and Q3 experian sources
			
  SIC_NAICS_List 	:= BusinessCredit_Services.fn_getPrimaryIndustry(inmod.BusinessIds, inmod.DataPermissionMask, buzCreditAccess).recs_rollup_sort; 
   
  iesp.businesscreditreport.t_BusinessCreditCodeDescription activity_trans(STRING Activity_Code,STRING Activity_Desc) := TRANSFORM
   			SELF.Code 			:= Activity_Code;
   			SELF.Description:= Activity_Desc;
   			SELF						:= [];	
  END;
   
  SIC_LIST 				:= 	JOIN(SIC_NAICS_List((INTEGER)sic_code > 0) , Codes.Key_SIC4,
   															KEYED(LEFT.SIC_Code = RIGHT.sic4_code), 
   															activity_trans(LEFT.Sic_Code, RIGHT.sic4_description), 
                                 NOSORT,
                                 LIMIT(BusinessCredit_Services.Constants.JOIN_LIMIT) ); //SIC_NAICS_List is already SORTED.
   
  SIC_LIST_Final	:= CHOOSEN(PROJECT(SIC_LIST, 
   															TRANSFORM(iesp.businesscreditreport.t_BusinessCreditCodeDescription,
   																SELF.isPrimary 	:= COUNTER = 1,
   																SELF 						:= LEFT)), BusinessCredit_Services.Constants.MAX_ACTIVITIES);
   
  NAICS_List 			:= JOIN(SIC_NAICS_List((INTEGER)naics_code > 0) , Codes.Key_NAICS,
   															KEYED(LEFT.naics_code = RIGHT.naics_code),
   															activity_trans(LEFT.naics_code, RIGHT.naics_description), 
                                 NOSORT,
                                 LIMIT(BusinessCredit_Services.Constants.JOIN_LIMIT) ); //SIC_NAICS_List is already SORTED.
   											
  NAICS_LIST_Final:= CHOOSEN(PROJECT(NAICS_List, 
   																TRANSFORM(iesp.businesscreditreport.t_BusinessCreditCodeDescription,
   																	SELF.isPrimary 	:= COUNTER = 1,
   																	SELF 						:= LEFT)), BusinessCredit_Services.Constants.MAX_ACTIVITIES);
   																	
  iesp.businesscreditreport.t_BusinessCreditActivity sicnaics_list() := TRANSFORM
   			SELF.SicCodes := SIC_LIST_Final;
   			SELF.NaicsCodes := NAICS_LIST_Final;
  END;
   
  Activity := ROW(sicnaics_list());
   
  //---------------------------------------------------------------------------------------------------------------------------------    
  //            																	Combine each Sections to Final Output Layout   
  //---------------------------------------------------------------------------------------------------------------------------------    
   		
  iesp.businesscreditreport.t_BusinessCreditReportRecord pre_final_transform_t_BusinessCreditReportRecord() := TRANSFORM
   			SELF.BestInformation		:= BusBestInformation_suppressDID[1];
   			SELF.Scorings 					:= choosen(buzCreditScores, iesp.constants.BusinessCredit.MaxSection);
   			SELF.TradeSummary				:= tradeSummary;
   			SELF.PaymentSummary			:= paymentSummary;
   			SELF.AccountDetail			:= choosen(accountDetails, iesp.constants.BusinessCredit.MaxSection);
   			SELF.CreditUtils				:= choosen(creditUtilRecs, iesp.constants.BusinessCredit.MaxSection);
   			SELF.DBTs								:= choosen(dbtRecs, iesp.constants.BusinessCredit.MaxSection);
   			SELF.Inquiries					:= choosen(BusInquiries, iesp.constants.BusinessCredit.MaxSection);
   			SELF.Subsidiaries				:= choosen(buzCreditSubsidiaries, iesp.constants.BusinessCredit.MaxSection);
   			SELF.OwnerGuarantors		:= choosen(buzCreditOwnerGuars, iesp.constants.BusinessCredit.MaxSection);
   			SELF.TopBusinessRecord 	:= topBusinessRecs[1];
   			SELF.Activity						:= Activity; 
   			SELF.AdditionalInfo			:= BusAdditionalInfo;
   			SELF.PhoneSources				:= choosen(PhoneSources, iesp.constants.BusinessCredit.MaxSection);
   			SELF := [];
  END;
   
  CreditReport_Results := DATASET([pre_final_transform_t_BusinessCreditReportRecord()]) ;

  iesp.businesscreditreport.t_BusinessCreditReportRecord pre_final_transform_t_BusinessCreditReportNoHit() := TRANSFORM
   			SELF.Scorings  := buzCreditScores(CurrentPriorFlag = 'C'); // Omit historical Scores; current Scores indicate a no-hit.
   			SELF := [];
  END;
	
	CreditReport_Results_NoHit := DATASET([pre_final_transform_t_BusinessCreditReportNoHit()]) ;
   
  //---------------------------------------------------------------------------------------------------------------------------------  
   
  //---------------- TestSeed Input ----------------
  BusinessCredit_Services.Layouts.in_key intoTestSeedinput := TRANSFORM
   				SELF.dataset_name := '';
   				SELF.acctNo := '';
   				SELF.company_name := inmod.CompanyName;
   				SELF.company_zip := inmod.Company_Zip;
   				SELF.company_fein := inmod.Tin;
   				SELF.company_phone := inmod.Company_Phone;
   				SELF.authrep_first := inmod.FirstName;
   				SELF.authrep_last := inmod.LastName;
  END;
   
  TestseedInput := DATASET( [intoTestSeedinput] );
   
   		//------------------------------------------------
   	
  TestSeed_Results := BusinessCredit_Services.CreditReport_TestSeed_Function(TestseedInput, inmod.TestDataTableName);
   
  buzCreditReportRecords := 
		MAP(
			inmod.TestDataEnabled => TestSeed_Results, 
			buzCreditScoreMod.BIPID_Weight < BusinessCredit_Services.Constants.BIPID_WEIGHT_THRESHOLD AND NOT isBusinessIdExists => CreditReport_Results_NoHit,
			CreditReport_Results 
		);
		
	// OUTPUT( buzCreditScoreMod.BIPID_Weight, NAMED('MatchWeight_CR') );
	
  RETURN buzCreditReportRecords; 

END;