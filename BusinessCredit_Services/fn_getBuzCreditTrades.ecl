IMPORT BIPV2, Business_Credit, Business_Credit_Scoring, BusinessCredit_Services, Codes,  
       iesp, LNSmallBusiness, STD, ut;

EXPORT fn_getBuzCreditTrades (BusinessCredit_Services.Iparam.reportrecords inmod, 
															DATASET(BusinessCredit_Services.Layouts.buzCredit_AccNo_Slim)	buzCreditHeader_recs,
															DATASET(recordof(Business_Credit_Scoring.Key_ScoringIndex().kFetch2(dataset([],BIPV2.IDlayouts.l_xlink_ids2)))) ScoringInfokfetch
															, string8 bestCode
														  ) := MODULE

	SHARED todaysDate := std.Date.Today();
  // calculate the date one year  
  SHARED unsigned_DateOneYearAgo := todaysDate - 10000;
  
  SHARED  BuzCreditScoringRecs := ScoringInfokfetch;
	// credit util 1.2.8/1.3.6
	SHARED TradeRecs_Raw 		:=	JOIN(	buzCreditHeader_recs, Business_Credit.key_tradeline(), 
																BusinessCredit_Services.Macros.mac_JoinBusAccounts(),
																TRANSFORM(RIGHT), 
																LIMIT(BusinessCredit_Services.Constants.KFETCH_MAX_LIMIT, SKIP));
	
  // Sort latest Record in each account to the top 
  TradeRecs_sorted := SORT(TradeRecs_Raw, #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()), -cycle_end_date); 
     
  // expand the layout to allow for the new calculations for Open accounts and account status
  TradeRecs_expandedLayout := PROJECT(TradeRecs_sorted,
                                      TRANSFORM(BusinessCredit_Services.Layouts.rec_tradelineExpandedLayout,
                                                SELF.isRemain_Bal_Changed  := (UNSIGNED)LEFT.Cycle_End_Date > unsigned_DateOneYearAgo,
                                                SELF.isRecent_Pmt_Not_Zero := (UNSIGNED)LEFT.recent_payment_amount != 0 AND (UNSIGNED)LEFT.Cycle_End_Date > unsigned_DateOneYearAgo,
                                                SELF                       := LEFT));
  
  // The rollup needs to end up with only one record for each account as if deduped, 
  // with the two new calculated fields based on the last 12 months.
  // SHARED TradeRecs_dedup	 := 
  SHARED TradeRecs_dedup	 := 
    ROLLUP(TradeRecs_expandedLayout, 
           LEFT.Sbfe_Contributor_Number  = RIGHT.Sbfe_Contributor_Number AND
				   LEFT.Contract_Account_Number  = RIGHT.Contract_Account_Number AND
				   LEFT.Account_Type_Reported 	 = RIGHT.Account_Type_Reported,
           TRANSFORM(BusinessCredit_Services.Layouts.rec_tradelineExpandedLayout,
                     leftRecordWithinLastYear   := (UNSIGNED)LEFT.Cycle_End_Date  > unsigned_DateOneYearAgo;
                     rightRecordWithinLastYear  := (UNSIGNED)RIGHT.Cycle_End_Date > unsigned_DateOneYearAgo;
                     SELF.isRemain_Bal_Changed  := leftRecordWithinLastYear AND 
                                                  (LEFT.isRemain_Bal_Changed  OR (rightRecordWithinLastYear AND LEFT.remaining_balance != RIGHT.remaining_balance)),
                     SELF.isRecent_Pmt_Not_Zero := leftRecordWithinLastYear AND 
                                                   (LEFT.isRecent_Pmt_Not_Zero OR (rightRecordWithinLastYear AND ((UNSIGNED)LEFT.recent_payment_amount != 0 OR (UNSIGNED)RIGHT.recent_payment_amount != 0))),
                     SELF.Account_Status_1      := MAP( LEFT.Account_Status_1 IN BusinessCredit_Services.Constants.SET_CHARGEOFF_STATUS        => LEFT.Account_Status_1,
                                                        RIGHT.Account_Status_1 IN BusinessCredit_Services.Constants.SET_CHARGEOFF_STATUS       => RIGHT.Account_Status_1,
                                                        LEFT.Account_Status_1 IN BusinessCredit_Services.Constants.Closed_Account_Status_Codes => LEFT.Account_Status_1,
                                                        RIGHT.Account_Status_1),
                     SELF.Account_Status_2      := MAP( LEFT.Account_Status_2 IN BusinessCredit_Services.Constants.SET_CHARGEOFF_STATUS        => LEFT.Account_Status_2,
                                                        RIGHT.Account_Status_2 IN BusinessCredit_Services.Constants.SET_CHARGEOFF_STATUS       => RIGHT.Account_Status_2,
                                                        LEFT.Account_Status_2 IN BusinessCredit_Services.Constants.Closed_Account_Status_Codes => LEFT.Account_Status_2,
                                                        RIGHT.Account_Status_2),
                     SELF.Account_Closure_Basis := IF(LEFT.Account_Closure_Basis != '', LEFT.Account_Closure_Basis, RIGHT.Account_Closure_Basis),
                     SELF                       := LEFT // always keep the most recent record
                    ));
	
 	SHARED TradeRecs_Active := TradeRecs_dedup(recent_activity_indicator = 'Y');
	SHARED TradeRecs_Active_AC_Open := TradeRecs_dedup(date_account_closed = '' AND
                                      // RQ-13023
                                      Account_Closure_Basis = '' AND
                                      Account_Status_1 NOT IN BusinessCredit_Services.Constants.Closed_Account_Status_Codes AND
                                      Account_Status_2 NOT IN BusinessCredit_Services.Constants.Closed_Account_Status_Codes AND
                                      (UNSIGNED)cycle_end_date > unsigned_DateOneYearAgo AND
                                      isRemain_Bal_Changed);
                            
  SHARED open_accounts := COUNT(TradeRecs_Active_AC_Open);
  
  // RQ-13023
	SHARED Total_Current_Exposure := SUM(TradeRecs_Active_AC_Open,(INTEGER)TradeRecs_Active_AC_Open.remaining_balance);
	
	SHARED worst_status_rec := RECORD
		RECORDOF(TradeRecs_Raw);
		string worst_status;
	END;

	SHARED TradeRecs_Raw_with_Status :=	PROJECT(TradeRecs_Raw, 
																				TRANSFORM(worst_status_rec,
																					SELF := LEFT,
                                          // RQ-13023
																					SELF.worst_status := BusinessCredit_Services.Functions.fn_WorstStatus(LEFT.Date_Account_Closed, LEFT.Account_Closure_Basis, LEFT.Account_Status_1, LEFT.Account_Status_2, LEFT.Payment_Status_Category)));

	SHARED TradeRecs_Raw_with_Status_Sort := SORT(TradeRecs_Raw_with_Status, 	BusinessCredit_Services.Functions.fn_WorstStatus_sort_order(worst_status));
	SHARED most_severe_status 						:= TradeRecs_Raw_with_Status_Sort[1].worst_status;
	
	SHARED AvgOpenBalance 		:= ROUND(Total_Current_Exposure / open_accounts, 2);
  
  // RQ-13023
	BusinessCredit_Services.Macros.Mac_Median(TradeRecs_Active_AC_Open, Median_Balance, remaining_balance);
	
	iesp.businesscreditreport.t_BusinessCreditTradeSummary trans_tradesummary := TRANSFORM
		SELF.OpenAccountsCount			:= open_accounts;
		SELF.AccountOpenDate				:= iesp.ECL2ESP.toDatestring8(MIN(TradeRecs_dedup(date_account_opened <> '') , date_account_opened));
		SELF.TotalOverdue						:= (STRING)SUM(TradeRecs_Active_AC_Open,(INTEGER)TradeRecs_Active.Past_Due_Amount);
		SELF.MostSevereStatus				:= most_severe_status;
		SELF.HighestCredit					:= (STRING)MAX(TradeRecs_Raw , (INTEGER)TradeRecs_Raw.Highest_Credit_Used);
    // RQ-13023
		SELF.TotalCurrentExposure		:= (STRING)Total_Current_Exposure;
		SELF.MedianBalance					:= (STRING)Median_Balance; 
		SELF.AvgOpenBalance					:= (STRING)AvgOpenBalance;
		SELF.ChargeOffRecorded			:= COUNT(TradeRecs_dedup((UNSIGNED)Charge_Off_Type_Indicator > 0 OR 
                                                          Account_Status_1 IN BusinessCredit_Services.Constants.SET_CHARGEOFF_STATUS OR
                                                          Account_Status_2 IN BusinessCredit_Services.Constants.SET_CHARGEOFF_STATUS OR
                                                          ((UNSIGNED)date_account_was_charged_off != 0 AND 
                                                           (UNSIGNED4)TRIM(date_account_was_charged_off,LEFT,RIGHT) <= todaysDate) OR
                                                          (UNSIGNED)amount_charged_off_by_creditor > 0 OR
                                                          (UNSIGNED)total_charge_off_recoveries_to_date > 0 ));

		SELF.AccountsWithGuarantor	:= COUNT(TradeRecs_Active_AC_Open(Guarantors_Indicator = 'Y' OR Government_Guarantee_Flag = 'Y'));
	END;
	
	EXPORT TradeSummary := ROW(trans_tradesummary); 

	// credit util 1.2.9
  // RQ-13023
	CreditUtil_recs_curr_raw		:= TradeRecs_Active_AC_Open(Account_Type_Reported IN BusinessCredit_Services.Constants.set_allowed_account AND Account_Status_1 = '');

	iesp.businesscreditreport.t_BusinessCreditUtilized transform_CreditUtilCurr() := TRANSFORM
		CreditLimit_curr					:= SUM(CreditUtil_recs_curr_raw, (INTEGER)CreditUtil_recs_curr_raw.Current_Credit_Limit);  
		CreditUtilized_curr				:= SUM(CreditUtil_recs_curr_raw, (INTEGER)CreditUtil_recs_curr_raw.Remaining_Balance);
		SELF.CreditLimit 					:= (STRING) CreditLimit_curr;
		SELF.CreditUtilized 			:= (STRING) CreditUtilized_curr;
		SELF.AvailableCredit 			:= (STRING) (CreditLimit_curr - CreditUtilized_curr);
		SELF.CreditUtilizedPercent:= (STRING) ROUND(CreditUtilized_curr *100 / CreditLimit_curr);
		SELF.CurrentPriorFlag 		:= LNSmallBusiness.Constants.CURRENT_FLAG;
		SELF.ScoreCalculatedDate	:= iesp.ECL2ESP.toDate(todaysDate);
	END;

	SHARED CreditUtil_recs_curr := DATASET([transform_CreditUtilCurr()]);

	SHARED rec_CreditUtil_Slim := RECORD
		STRING6  Cycle_end_date;
		STRING12 CreditLimit;
		STRING12 CreditUtilized;
	END; 

	SHARED CreditUtil_recs_hist_raw 		:= TradeRecs_Raw(Account_Type_Reported IN BusinessCredit_Services.Constants.set_allowed_account AND recent_activity_indicator = 'Y' AND Account_Status_1 = '');
	SHARED CreditUtil_recs_hist_dedup 	:= DEDUP(SORT(CreditUtil_recs_hist_raw , 
																							 #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()) , -cycle_end_date),
																				 #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()) , cycle_end_date);
 	SHARED CreditUtil_recs_hist_Slim 	:= PROJECT(CreditUtil_recs_hist_dedup , 
																					TRANSFORM(rec_CreditUtil_Slim , 
																						SELF.Cycle_end_date := LEFT.Cycle_end_date[1..6], 
																						SELF.CreditLimit :=	LEFT.Current_Credit_Limit,
																						SELF.CreditUtilized := LEFT.Remaining_Balance));

	SHARED CreditUtilSum_recs := RECORD
		 CreditUtil_recs_hist_Slim.Cycle_end_date;
		 STRING12 CreditLimit 			:= (STRING)SUM(GROUP, (integer)CreditUtil_recs_hist_Slim.CreditLimit);
		 STRING12 CreditUtilized		:= (STRING)SUM(GROUP, (integer)CreditUtil_recs_hist_Slim.CreditUtilized);
		 STRING12 AvailableCredit		:= (STRING)(SUM(GROUP, (integer)CreditUtil_recs_hist_Slim.CreditLimit) - SUM(GROUP, (integer)CreditUtil_recs_hist_Slim.CreditUtilized));
	END;

	SHARED CreditUtil_recs_hist	:= TABLE(CreditUtil_recs_hist_Slim, CreditUtilSum_recs,Cycle_end_date);	 
	CreditUtil_recs_hist_srt 		:= SORT(CreditUtil_recs_hist , -Cycle_end_date);
	
	CreditUtil_recs_hist_1 			:= PROJECT(CreditUtil_recs_hist_srt(Cycle_end_date >= ut.getDateOffset(BusinessCredit_Services.Constants.PAST24MONTHSInDays) and 
																					((UNSIGNED)Cycle_end_date < (UNSIGNED)(STRING)todaysDate[1..6])), 
																					TRANSFORM(iesp.businesscreditreport.t_BusinessCreditUtilized, 
																						SELF.CurrentPriorFlag 	:= LNSmallBusiness.Constants.HISTORICAL_FLAG,
																						SELF.ScoreCalculatedDate:= iesp.ECL2ESP.toDatestring8(LEFT.Cycle_end_date),
																						SELF.CreditUtilizedPercent := (STRING) ROUND((INTEGER) LEFT.CreditUtilized *100 / (INTEGER)LEFT.CreditLimit),
																						SELF := LEFT,
																						SELF := []));
															
	EXPORT CreditUtil_recs_combined := SORTED(CreditUtil_recs_curr + CreditUtil_recs_hist_1, -(CurrentPriorFlag = 'C'), -ScoreCalculatedDate);

	SHARED previousYear 		 := (integer)((STRING)todaysDate[1..4]) - 1;
	SHARED prevYearStartDate := (string)(previousYear) + '0101';
	SHARED prevYearEndDate 	 := (string)(previousYear) + '1231';

	// Requirement 1.2.10
	TradeRecs_dbt 		:=	TradeRecs_Active(DBT <> '');
	prevYearDBT_AVG 	:= 	ROUND(AVE(BuzCreditScoringRecs(version >= prevYearStartDate and version <= prevYearEndDate), (integer)BuzCreditScoringRecs.DBT),2);

	//IndustryCode 			:=	BusinessCredit_Services.fn_getPrimaryIndustry(inmod.BusinessIds , inmod.DataPermissionMask , inmod.Include_BusinessCredit).bestIndustryCode[1].Best_Code;
	industryCode              := bestCode;
	SIC_Desc					:=	Codes.Key_SIC4(keyed(SIC4_Code = IndustryCode))[1].sic4_description;
	NAICS_Desc				:= 	Codes.Key_NAICS(keyed(naics_code = IndustryCode))[1].naics_description;
	IndustryDesc			:=	IF(SIC_Desc <> '' , SIC_Desc , NAICS_Desc);

	iesp.businesscreditreport.t_BusinessCreditDBT	trans_curr_dbt() := TRANSFORM
		SELF.DBTCalculatedDate					:= iesp.ECL2ESP.toDate(todaysDate);
		SELF.DBTMinRange								:= BusinessCredit_Services.Constants.DBT_MIN_RANGE;
		SELF.DBTMaxRange								:= BusinessCredit_Services.Constants.DBT_MAX_RANGE;
		SELF.DBT												:= (string) ROUND(AVE(TradeRecs_dbt , (integer)TradeRecs_dbt.dbt));
		SELF.CurrentPriorFlag						:= LNSmallBusiness.Constants.CURRENT_FLAG;
		SELF.PrimaryIndustryCode				:= IndustryCode;
		SELF.PrimaryIndustryDescription	:= IndustryDesc;
		SELF.PriorYear									:= (string) previousYear;
		SELF.PriorYearDBTAverage				:= (string) prevYearDBT_AVG;
		SELF.IndustryDBTAverage					:= ''; // Industry DBT Avg not to be calculated for current record.
		SELF														:= [];
	END;												

	SHARED curr_dbt := ROW(trans_curr_dbt()); 

	SHARED BuzCreditScoringRecs_srt := SORT(BuzCreditScoringRecs, UltID, ORgID, SeleID, -Version);
	SHARED hist_dbt := CHOOSEN(PROJECT(BuzCreditScoringRecs_srt, 
															TRANSFORM(iesp.businesscreditreport.t_BusinessCreditDBT,
																SELF.DBTCalculatedDate					:= iesp.ECL2ESP.toDatestring8(LEFT.version),
																SELF.DBTMinRange								:= BusinessCredit_Services.Constants.DBT_MIN_RANGE,
																SELF.DBTMaxRange								:= BusinessCredit_Services.Constants.DBT_MAX_RANGE,
																SELF.DBT												:= LEFT.dbt,
																SELF.CurrentPriorFlag						:= LNSmallBusiness.Constants.HISTORICAL_FLAG,
																SELF.PrimaryIndustryCode				:= LEFT.Classification_Code,
																SELF.PrimaryIndustryDescription	:= LEFT.Classification_Code_Description,
																SELF.IndustryDBTAverage					:= LEFT.Industry_Score_Avg,
																SELF														:= [])), BusinessCredit_Services.Constants.MAX_HISTORICAL_DBT);

	EXPORT DBT_Recs := SORT((curr_dbt + hist_dbt), -(CurrentPriorFlag = LNSmallBusiness.Constants.CURRENT_FLAG), -DBTCalculatedDate);

	// Requirement 1.3.7
	iesp.businesscreditreport.t_BusinessCreditPaymentSummary trans_paymentsummary := TRANSFORM
		PastDueAgingAmount01to30Percent	:= ROUND(SUM(TradeRecs_Active_AC_Open, (INTEGER)TradeRecs_Active_AC_Open.Past_Due_Aging_Amount_Bucket_1)*100/Total_Current_Exposure);
		PastDueAgingAmount31to60Percent	:= ROUND(SUM(TradeRecs_Active_AC_Open, (INTEGER)TradeRecs_Active_AC_Open.Past_Due_Aging_Amount_Bucket_2)*100/Total_Current_Exposure);
		PastDueAgingAmount61to90Percent	:= ROUND(SUM(TradeRecs_Active_AC_Open, (INTEGER)TradeRecs_Active_AC_Open.Past_Due_Aging_Amount_Bucket_3)*100/Total_Current_Exposure);
		PastDueAgingAmount91PlusPercent	:= ROUND((SUM(TradeRecs_Active_AC_Open,(INTEGER)TradeRecs_Active_AC_Open.Past_Due_Aging_Amount_Bucket_4)
																							+ SUM(TradeRecs_Active_AC_Open,(INTEGER)TradeRecs_Active_AC_Open.Past_Due_Aging_Amount_Bucket_5) 
																							+ SUM(TradeRecs_Active_AC_Open,(INTEGER)TradeRecs_Active_AC_Open.Past_Due_Aging_Amount_Bucket_6) 
																							+ SUM(TradeRecs_Active_AC_Open,(INTEGER)TradeRecs_Active_AC_Open.Past_Due_Aging_Amount_Bucket_7) 
																							)*100/Total_Current_Exposure);
		
		SELF.TotalCurrentExposure 						:= (STRING)Total_Current_Exposure;
		SELF.PastDueAgingAmount01to30Percent	:= (STRING)PastDueAgingAmount01to30Percent;
		SELF.PastDueAgingAmount31to60Percent	:= (STRING)PastDueAgingAmount31to60Percent;
		SELF.PastDueAgingAmount61to90Percent	:= (STRING)PastDueAgingAmount61to90Percent;
		SELF.PastDueAgingAmount91PlusPercent	:= (STRING)PastDueAgingAmount91PlusPercent;
		SELF.WithInTermsPercent								:= (STRING)ROUND((100 - (PastDueAgingAmount01to30Percent + PastDueAgingAmount31to60Percent +
																															PastDueAgingAmount61to90Percent + PastDueAgingAmount91PlusPercent)));
	END;
	
	EXPORT PaymentSummary := ROW(trans_paymentsummary);

	// Requirement 1.3.8 / 1.3.9

	CollateralRecs_Raw :=	JOIN(	buzCreditHeader_recs, Business_Credit.Key_Collateral(),
																			BusinessCredit_Services.Macros.mac_JoinBusAccounts(),
																			TRANSFORM(RIGHT), 
																			LIMIT(BusinessCredit_Services.Constants.JOIN_LIMIT, SKIP));

	//Past 7 Year Credit Utilization
	past7YearStartDate		 := (string)(previousYear-6) + '0101';
	past_7_year_trade_recs := TradeRecs_Raw(Cycle_end_date >= past7YearStartDate AND Cycle_end_date <= prevYearEndDate AND Account_Type_Reported IN BusinessCredit_Services.Constants.SET_ALLOWED_ACCOUNT);

	past_7_year_trade_recs_srt:= SORT(past_7_year_trade_recs, #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()), -Cycle_end_date);
	past_7_year_trade_recs_credit_limit := past_7_year_trade_recs_srt((integer)Current_Credit_Limit > 0 );

	yearlyCreditUtil := RECORD
			STRING4 year := past_7_year_trade_recs_srt.Cycle_end_date[1..4];
			past_7_year_trade_recs_srt.Sbfe_Contributor_Number;
			past_7_year_trade_recs_srt.Contract_Account_Number;
			past_7_year_trade_recs_srt.Account_Type_Reported;
			STRING12 HighestCreditLimitOfYear := (STRING)MAX(GROUP, (integer)past_7_year_trade_recs_srt.Current_Credit_Limit);
			STRING12 HighestOutstandingAmountOfYear	:= (STRING)MAX(GROUP, (integer)past_7_year_trade_recs_srt.Remaining_Balance);
			STRING3 AvgCreditUtilizedPercent := (STRING)ROUND(AVE(GROUP, ((INTEGER) past_7_year_trade_recs_credit_limit.Remaining_Balance *100 / (INTEGER)past_7_year_trade_recs_credit_limit.Current_Credit_Limit)));
	END;

	past_7_year_creditutil_tab := TABLE(past_7_year_trade_recs_srt, yearlyCreditUtil, Sbfe_Contributor_Number,Contract_Account_Number, Account_Type_Reported, Cycle_end_date[1..4]);

	past_7_year_creditutil_tab_sort := SORT(past_7_year_creditutil_tab, #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()), -year);

	PaymentHistoryRecs := DEDUP(SORT(TradeRecs_Raw,#EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()) , -cycle_end_date), cycle_end_date);
	
	iesp.businesscreditreport.t_BusinessCreditAccountPaymentHistory trans_paymenthistory (PaymentHistoryRecs L ) := TRANSFORM

		paymentStatus := BusinessCredit_Services.Functions.fn_WorstStatus(L.Date_Account_Closed, L.Account_Closure_Basis, L.Account_Status_1, L.Account_Status_2, L.Payment_Status_Category);
		SELF.ReportedDate				:= iesp.ECL2ESP.toDatestring8(L.Cycle_End_Date);
		SELF.ClosureDate				:= iesp.ECL2ESP.toDatestring8(L.Date_Account_Closed);
		SELF.ClosureReason			:= BusinessCredit_Services.Functions.fn_AccountClosureReason(L.Account_Closure_Basis);
		SELF.CurrentCreditLimit	:= L.Current_Credit_Limit;
		SELF.AmountOutstanding	:= L.Remaining_Balance;
		SELF.PaymentStatus			:= paymentStatus;
		SELF.PastDueAmount			:= L.Past_Due_Amount;
		SELF.IsExtendedOverdue	:= L.Cycle_End_Date BETWEEN ut.getDateOffset(BusinessCredit_Services.Constants.PAST84MONTHSInDays) 
																										AND ut.getDateOffset(BusinessCredit_Services.Constants.PAST24MONTHSInDays) 
																										AND STD.Str.Contains(paymentStatus, 'Overdue', TRUE);
	END;

	iesp.businesscreditreport.t_BusinessCreditAccountDetail trans_AccDetail (TradeRecs_dedup L) := TRANSFORM
    // Not being used anywhere in the code
		// currentStatus 					:= BusinessCredit_Services.Functions.fn_WorstStatus(L.Date_Account_Closed, L.Account_Closure_Basis, L.Account_Status_1, L.Payment_Status_Category);
		PaymentStatusCategory 	:= BusinessCredit_Services.Functions.fn_PaymentStatusCategory(L.Payment_Status_Category);
		
		CollateralRec						:= CollateralRecs_Raw(Sbfe_Contributor_Number = L.Sbfe_Contributor_Number AND 
																									Contract_Account_Number = L.Contract_Account_Number AND
																									Account_Type_Reported 	= L.Account_Type_Reported)[1];
		CollateralIndicator			:= CollateralRec.Collateral_Indicator = 'Y';
		TypeOfCollateralSecured := BusinessCredit_Services.Functions.fn_CollateralType(CollateralRec.Type_Of_Collateral_Secured_For_This_Account);
		
		SELF.BusinessContributorNumber 		:= 	L.Sbfe_Contributor_Number;
		SELF.BusinessAccountNumber 				:= 	L.Contract_Account_Number;
		SELF.AccountTypeReportedCode 			:= 	L.Account_Type_Reported;
		SELF.AccountTypeReportedDesc 			:=	BusinessCredit_Services.Functions.fn_AccountTypeDescription(L.Account_Type_Reported);
		SELF.AccountStatus					 			:=	BusinessCredit_Services.Functions.fn_CurrentBizAccountStatus(L.Date_Account_Closed, L.Account_Closure_Basis, L.Payment_Status_Category, L.Cycle_End_Date, L.isRemain_Bal_Changed, L.isRecent_Pmt_Not_Zero, unsigned_DateOneYearAgo, L.Account_Status_1, L.Account_Status_2);
		SELF.AccountOpenDate							:= 	iesp.ECL2ESP.toDatestring8(L.Date_Account_Opened);
		SELF.AccountReportedDate					:=	iesp.ECL2ESP.toDatestring8(L.Cycle_End_Date);
		SELF.AccountClosureDate						:=	iesp.ECL2ESP.toDatestring8(L.Date_Account_Closed);
		SELF.AccountClosureReason					:=	BusinessCredit_Services.Functions.fn_AccountClosureReason(L.Account_Closure_Basis);
		SELF.OriginalAmount								:= 	L.Original_Credit_Limit;
		SELF.AmountOutstanding						:= 	L.Remaining_Balance;
		SELF.CollateralIndicator					:=	CollateralIndicator;
		SELF.TypeOfCollateral							:= 	IF(CollateralIndicator , TypeOfCollateralSecured , '');
		SELF.Overdue											:= 	IF(L.Payment_Status_Category = '000' , 'No' , PaymentStatusCategory);
		SELF.PastDueAmount								:=	L.Past_Due_Amount;
		SELF.AccountExpirationDate 				:=	iesp.ECL2ESP.toDatestring8(L.Account_Expiration_Date);
		SELF.PaymentAmountScheduled 			:=	L.Payment_Amount_Scheduled;
		SELF.PaymentFrequency 						:=	BusinessCredit_Services.Functions.fn_PaymentFreqDesc(L.Payment_Interval);
		SELF.PaymentTypeCode	 						:=	L.Payment_Category;
		SELF.PaymentTypeDesc	 						:=	BusinessCredit_Services.Functions.fn_PaymentTypeDesc(L.Payment_Category);
		SELF.LastPaymentAmount	 					:=	L.Recent_Payment_Amount;
		SELF.LastPaymentDate							:=	iesp.ECL2ESP.toDatestring8(L.Recent_Payment_Date);
		SELF.DelinquencyDate							:=	iesp.ECL2ESP.toDatestring8(L.Delinquency_Date);
		SELF.GovernmentGuaranteed	 				:=	IF(L.Government_Guarantee_Flag = 'Y' , TRUE, FALSE);
		SELF.GovernmentGuaranteedCategory :=	BusinessCredit_Services.Functions.fn_GovernmentGuaranteedCategoryDesc(L.Government_Guarantee_Category);
		SELF.NumberOfGuarantors						:=	L.Number_Of_Guarantors;
		SELF.YearlyCreditUtils						:=	CHOOSEN(PROJECT(past_7_year_creditutil_tab_sort(Sbfe_Contributor_Number = L.Sbfe_Contributor_Number and 
																																													Contract_Account_Number = L.Contract_Account_Number and
																																													Account_Type_Reported 	= L.Account_Type_Reported), 
																									iesp.businesscreditreport.t_BusinessYearlyCreditUtilized), BusinessCredit_Services.Constants.MAX_YEARLY_CREDIT_UTIL);
		SELF.AccountPaymentHistory				:= 	CHOOSEN(PROJECT(PaymentHistoryRecs (Sbfe_Contributor_Number = L.Sbfe_Contributor_Number and 
																																							Contract_Account_Number = L.Contract_Account_Number and
																																							Account_Type_Reported = L.Account_Type_Reported) ,
																																							trans_paymenthistory(LEFT)), BusinessCredit_Services.Constants.MAX_PAYMENT_HISTORY);
	END;

	AccDetail_Recs 				         := PROJECT(TradeRecs_dedup , trans_AccDetail(LEFT));
	EXPORT AccDetail_Recs_Combined := 
    CHOOSEN(SORT(AccDetail_Recs, 
                 BusinessCredit_Services.Functions.fn_AccountStatus_sort_order(AccountStatus), 
                 -AccountReportedDate , RECORD), 
            iesp.Constants.BusinessCredit.MaxTradelines); 

END;