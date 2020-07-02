﻿IMPORT BIPV2, Business_Credit, Business_Credit_Scoring, BusinessCredit_Services, Codes,
       iesp, LNSmallBusiness, STD, ut;

EXPORT fn_getBuzCreditTrades (BusinessCredit_Services.Iparam.reportrecords inmod,
															DATASET(BusinessCredit_Services.Layouts.buzCredit_AccNo_Slim)	buzCreditHeader_recs,
															string8 bestCode
														  ) := MODULE

	SHARED todaysDate := std.Date.Today();
  // calculate the date one year
  SHARED unsigned_DateOneYearAgo := todaysDate - 10000;

	  SHARED BuzCreditScoringRecs := Business_Credit_Scoring.Key_ScoringIndex().kFetch2(inmod.BusinessIds, inmod.FetchLevel,,inmod.DataPermissionMask, BusinessCredit_Services.Constants.JOIN_LIMIT);

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
      nonblank_status := TRIM(LEFT.Account_Status_1) <> '' OR TRIM(LEFT.Account_Status_2) <> '';
      is_suspend := LEFT.Account_Status_1 = BusinessCredit_Services.Constants.Disaster_Suspend_Status OR
        LEFT.Account_Status_2 = BusinessCredit_Services.Constants.Disaster_Suspend_Status;

      SELF.isRemain_Bal_Changed  := (UNSIGNED)LEFT.Cycle_End_Date > unsigned_DateOneYearAgo,
      SELF.isRecent_Pmt_Not_Zero := (UNSIGNED)LEFT.recent_payment_amount != 0 AND (UNSIGNED)LEFT.Cycle_End_Date > unsigned_DateOneYearAgo,
      SELF.Disaster_Impact := LEFT.Account_Status_1 = BusinessCredit_Services.Constants.Disaster_Impact_Status OR
        LEFT.Account_Status_2 = BusinessCredit_Services.Constants.Disaster_Impact_Status;
      SELF.most_recent_status_dt := IF(nonblank_status, (UNSIGNED)LEFT.Cycle_End_Date, 0);
      SELF.most_recent_suspend_dt := IF(is_suspend, (UNSIGNED)LEFT.Cycle_End_Date, 0);
      SELF := LEFT));

  // The rollup needs to end up with only one record for each account as if deduped,
  // with the two new calculated fields based on the last 12 months.
  SHARED TradeRecs_dedup	 :=
    ROLLUP(TradeRecs_expandedLayout,
           LEFT.Sbfe_Contributor_Number  = RIGHT.Sbfe_Contributor_Number AND
				   LEFT.Contract_Account_Number  = RIGHT.Contract_Account_Number AND
				   LEFT.Account_Type_Reported 	 = RIGHT.Account_Type_Reported,
           TRANSFORM(BusinessCredit_Services.Layouts.rec_tradelineExpandedLayout,
              leftRecordWithinLastYear   := (UNSIGNED)LEFT.Cycle_End_Date  > unsigned_DateOneYearAgo;
              rightRecordWithinLastYear  := (UNSIGNED)RIGHT.Cycle_End_Date > unsigned_DateOneYearAgo;

              SELF.Cycle_End_Date        := LEFT.Cycle_End_Date;    // keep the most recent end date
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

              // a disaster impact is only reported if it exists on the most recent record in the account
              SELF.Disaster_Impact       := LEFT.Disaster_Impact;

              SELF.most_recent_status_dt := MAX(LEFT.most_recent_status_dt, RIGHT.most_recent_status_dt);
              SELF.most_recent_suspend_dt   := MAX(LEFT.most_recent_suspend_dt, RIGHT.most_recent_suspend_dt);
              SELF.Account_Closure_Basis := IF(LEFT.Account_Closure_Basis != '', LEFT.Account_Closure_Basis, RIGHT.Account_Closure_Basis),
              SELF                       := LEFT // always keep the most recent record
            ));
     // SBCREDIT ADD
	EXPORT TradeRecs_dedup_Count := COUNT(TradeRecs_dedup);
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

  TradeRecs_Raw_with_Status :=	PROJECT(TradeRecs_Raw,
    TRANSFORM(worst_status_rec,
      // RQ-13023
      SELF.worst_status := BusinessCredit_Services.Functions.fn_WorstStatus(LEFT.Date_Account_Closed, LEFT.Account_Closure_Basis, LEFT.Account_Status_1, LEFT.Account_Status_2, LEFT.Payment_Status_Category),
      SELF := LEFT));

	TradeRecs_Raw_with_Status_Sort := SORT(TradeRecs_Raw_with_Status, 	BusinessCredit_Services.Functions.fn_WorstStatus_sort_order(worst_status));

  // [RQ-20112] most_severe_status will indicate an impact by a natural disaster if the flag is present
  // in the most recent record for any of the accounts
  most_severe_status := BusinessCredit_Services.Functions.fn_appendDisasterStatus(
    TradeRecs_Raw_with_Status_Sort[1].worst_status,
    EXISTS(TradeRecs_dedup(disaster_impact)), false);

	AvgOpenBalance 		:= ROUND(Total_Current_Exposure / open_accounts, 2);

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

	// NEW LINE
	past_7_year_creditutil_tab_sortSlim := TOPN(GROUP(past_7_year_creditutil_tab_sort,  #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts())),
	                                                                                  BusinessCredit_Services.Constants.MAX_YEARLY_CREDIT_UTIL,  #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()));

	PaymentHistoryRecsBig := DEDUP(SORT(TradeRecs_Raw,#EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()) , -cycle_end_date), cycle_end_date);


	paymentHistoryRecsSlim := if (inmod.LimitPaymentHistory24Months,
	                             TOPN(GROUP(PaymentHistoryRecsBig, #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts())), BusinessCredit_Services.Constants.TWO_YR_PAYMENT_HISTORY,
		                       #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts())),

	                                                       TOPN(GROUP(PaymentHistoryRecsBig, #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts())), BusinessCredit_Services.Constants.MAX_PAYMENT_HISTORY,
		                                                 #EXPAND(BusinessCredit_Services.Macros.mac_ListBusAccounts()))
											);
	  paymentHistoryRecs := UNGROUP(paymentHistoryRecsSlim);

	   setofContributorIDs :=  Std.Str.SplitWords(inmod.SBFEContributorIds, BusinessCredit_Services.Constants.Delimiter); // creates a set of contributor IDs;

	iesp.businesscreditreport.t_BusinessCreditAccountDetail trans_AccDetail (TradeRecs_dedup L) := TRANSFORM
    // Not being used anywhere in the code
		// currentStatus 					:= BusinessCredit_Services.Functions.fn_WorstStatus(L.Date_Account_Closed, L.Account_Closure_Basis, L.Account_Status_1, L.Payment_Status_Category);
		PaymentStatusCategory 	:= BusinessCredit_Services.Functions.fn_PaymentStatusCategory(L.Payment_Status_Category);

		CollateralRec						:= CollateralRecs_Raw(Sbfe_Contributor_Number = L.Sbfe_Contributor_Number AND
																									Contract_Account_Number = L.Contract_Account_Number AND
																									Account_Type_Reported 	= L.Account_Type_Reported)[1];
		CollateralIndicator			:= CollateralRec.Collateral_Indicator = 'Y';
		TypeOfCollateralSecured := BusinessCredit_Services.Functions.fn_CollateralType(CollateralRec.Type_Of_Collateral_Secured_For_This_Account);

    // in order to consider the account suspended due to a natural disaster, the most recent non-blank
    // account status must contain '021' (disaster suspended) and that flag must be present less than
    // 180 days from the most recent account date
    IsDisasterSuspend := L.most_recent_suspend_dt > 0 AND
      L.most_recent_suspend_dt >= L.most_recent_status_dt AND
      STD.Date.DaysBetween(L.most_recent_suspend_dt, (UNSIGNED)L.Cycle_End_Date) < 180;

		SELF.BusinessContributorNumber 		:= 	L.Sbfe_Contributor_Number;
		SELF.BusinessAccountNumber 				:= 	L.Contract_Account_Number;
		SELF.AccountTypeReportedCode 			:= 	L.Account_Type_Reported;
		SELF.AccountTypeReportedDesc 			:=	BusinessCredit_Services.Functions.fn_AccountTypeDescription(L.Account_Type_Reported);
		SELF.AccountStatus					 			:=	BusinessCredit_Services.Functions.fn_CurrentBizAccountStatus(L.Date_Account_Closed,
      L.Account_Closure_Basis, L.Payment_Status_Category, L.Cycle_End_Date,
      L.isRemain_Bal_Changed, L.isRecent_Pmt_Not_Zero, unsigned_DateOneYearAgo,
      L.Account_Status_1, L.Account_Status_2, L.Disaster_Impact, IsDisasterSuspend);
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

		 SELF.ChargedOff  :=    if ( L.Account_Status_1 IN BusinessCredit_Services.Constants.SET_CHARGEOFF_STATUS OR
                                                             L.Account_Status_2 IN BusinessCredit_Services.Constants.SET_CHARGEOFF_STATUS OR
											  (UNSIGNED) L.amount_charged_off_by_creditor > 0 OR
											  (UNSIGNED) L.total_charge_off_recoveries_to_date > 0 OR
											  (UNSIGNED) L.Charge_Off_Type_Indicator > 0 OR
						( ((UNSIGNED)L. date_account_was_charged_off != 0 AND (UNSIGNED4) TRIM(L.date_account_was_charged_off,LEFT,RIGHT) <= todaysDate)),
						                             'Y','N');
           SELF.ChargedOffDate :=      iesp.ecl2esp.ToDateString8(L.Date_account_was_charged_Off);
		SELF.ChargedOffAmount := L.Amount_charged_off_by_creditor;
		SELF.ChargedOffType.Code := L.charge_off_type_indicator;
		SELF.ChargedOffType.Description:= Map(L.charge_off_type_indicator = '001' => BusinessCredit_Services.Constants.PrincipalOnly,
												                     L.charge_off_type_indicator = '002' => BusinessCredit_Services.Constants.PrincipalAndInterest,
												                     L.charge_off_type_indicator = '003' => BusinessCredit_Services.Constants.AmountEqualToBadDebtReserve,
												            '');
          SELF.TotalChargedOffRecoveries :=  L.total_charge_off_recoveries_to_date;

           SELF.UniqueAccountDetailNumber := hash64(L.Sbfe_Contributor_Number, L.Contract_Account_Number,  L.Account_Type_Reported);

					                                                   // since this rollup based on initial value of TradeRecs_dedup which is already rolledup
														   // on these 3 fields (L.Sbfe_Contributor_Number, L.Contract_Account_Number,  L.Account_Type_Reported,)

			   SELF.ContributedByInquirer := IF (EXISTS(setofContributorIDs),
				                                                         IF (L.Sbfe_Contributor_Number in setofContributorIDs, 'Y', 'N'),
													        '');  // need to keep this as a string so that it can be Y or N or '' (roxie no output tag if null)
															// so then esp will not  output tag.

			SELF := [];
	END;

	tempAccDetail_Recs 				         := PROJECT(TradeRecs_dedup , trans_AccDetail(LEFT));

	// start new code #2

	rolledYearlyCreditUtils := record
	dataset(iesp.businesscreditreport.t_BusinessYearlyCreditUtilized) tmpYearlyCreditUtils;
	string30 BusinessContributorNumber;
	string50 BusinessAccountNumber;
	 string3 AccountTypeReportedCode;
	 end;

	 rolledYearlyCreditUtils   FillYearlyCreditUtils(  recordof(past_7_year_creditutil_tab_sortSlim) Le,
	                                                                                       dataset(RECORDOF(past_7_year_creditutil_tab_sortSlim)) allrows ) := TRANSFORM


		SELF.BusinessContributorNumber 		:= 	Le.sbfe_contributor_number;
		SELF.BusinessAccountNumber 				:= 	Le.contract_account_number;
		SELF.AccountTypeReportedCode 			:= 	Le.account_type_reported;

		self.tmpYearlyCreditUtils :=  CHOOSEN(PROJECT(allrows,  iesp.businesscreditreport.t_BusinessYearlyCreditUtilized), BusinessCredit_Services.Constants.MAX_YEARLY_CREDIT_UTIL);

		END;

		TEMP2AccDetail_YearCreditUtils  := rollup( group(past_7_year_creditutil_tab_sortSlim,
	                                                                     Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported),
														group,
														FillYearlyCreditUtils(left, rows(left)));

	        tempAcctDetail_RecsYearlyCreditUtils := Join(tempAccDetail_Recs, TEMP2AccDetail_YearCreditUtils,
	                                                                                LEFT.BusinessContributorNumber = RIGHT.BusinessContributorNumber and
																LEFT.BusinessAccountNumber = RIGHT.BusinessAccountNumber and
																LEFT.AccountTypeReportedCode = RIGHT.AccountTypeReportedCode,
																TRANSFORM(RECORDOF(LEFT),
																SELF.YearlyCreditUtils := RIGHT.TmpYearlyCreditUtils;
																SELF := LEFT), LEFT OUTER); // important to do left outer here as not every set of
                                                   //  xml path businessContributorNumbor/BusinessAccountNumber/AccountTypeReportedCode has this structure of yearCreditUtils

	// end new code #2

	// START new CODE #1

	rolledPaymentHistory := record
	dataset(iesp.businesscreditreport.t_BusinessCreditAccountPaymentHistory) tmpAccountPaymentHistory;
	string30 BusinessContributorNumber;
	string50 BusinessAccountNumber;
	 string3 AccountTypeReportedCode;
	 end;

	rolledPaymentHistory  FillPaymentHIstory( recordof (PaymentHistoryRecs) Le ,
                                                                                    dataset(recordof(PaymentHistoryRecs)) allrows )
																 := TRANSFORM
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

		SELF.BusinessContributorNumber 		:= 	Le.sbfe_contributor_number;
		SELF.BusinessAccountNumber 				:= 	Le.contract_account_number;
		SELF.AccountTypeReportedCode 			:= 	Le.account_type_reported;
	     tmpAccountPaymentHistory := Project(Allrows, trans_paymentHistory(left));
	     self.tmpaccountpaymentHistory  := if (inmod.LimitPaymentHistory24Months,
													CHOOSEN(tmpAccountPaymentHistory,BusinessCredit_Services.Constants.TWO_YR_PAYMENT_HISTORY),
													CHOOSEN(tmpAccountPaymentHistory, BusinessCredit_Services.Constants.MAX_PAYMENT_HISTORY)
													);
	END;

	TEMP2AccDetail_Recs  := rollup( group(PaymentHistoryRecs,
	                                                                     Sbfe_Contributor_Number,Contract_Account_Number,Account_Type_Reported),
														group,
														FillPaymentHIstory(left, rows(left)));

		AccDetail_Recs :=  JOIN(tempAcctDetail_RecsYearlyCreditUtils,  TEMP2AccDetail_Recs,
										  LEFT.BusinessContributorNumber = RIGHT.BusinessContributorNumber and
						                  LEFT.BusinessAccountNumber = RIGHT.BusinessAccountNumber and
									  LEFT.AccountTypeReportedCode = RIGHT.AccountTypeReportedCode,
										 TRANSFORM(RECORDOF(LEFT),
										   self.AccountPaymentHistory := right.tmpAccountPaymentHistory;
											  SELF.PaymentStatus :=  right.tmpAccountPaymentHistory[1].PaymentStatus;
										  SELF := LEFT), LEFT OUTER); // left outer here is just to make sure  as accountPaymentHistory seems to be on each set of
                                                              // xml path businessContributorNumbor/BusinessAccountNumber/AccountTypeReportedCode


		 // ** END new code #1
	  // logic added here to get a max 50 of recs with chargedOff = 'Y' to top. always get at least 10 if available and keep at top.  If more than 10 then if any left after
		// (50- non charge off recs ) put that set of recs at bottom
		//   If there are no recs = chargeoff ='N' then just output as many chargeoff = 'Y' as possible up to 50.
	  AccDetail_recsChargedOff := sort (AccDetail_Recs(ChargedOff = 'Y'), -AccountReportedDate, RECORD);
	  AccDetail_recsNoChargedOff := sort(AccDetail_Recs(ChargedOff = 'N'), BusinessCredit_Services.Functions.fn_AccountStatus_sort_orderCreditTrades(AccountStatus),
																											  -AccountReportedDate);
	  AccDetail_recsNumChargedOffToKeep := IF (COUNT(AccDetail_recsChargedOff) < BusinessCredit_Services.Constants.TOTALTRADELINECOUNT,
		                                                              COUNT(AccDetail_recsChargedOff), BusinessCredit_Services.Constants.TOTALTRADELINECOUNT);
       countNonChargeOffRecs := Count(AccDetail_recsNoChargedOff);
	   MoreThanTenChargeOffs := AccDetail_recsNumChargedOffToKeep > BusinessCredit_Services.Constants.topchargeoffCount;

	  AccDetail_recsNumNoChargedOffToKeep :=   IF (EXISTS(AccDetail_recsChargedOff),
		                                                                                 IF ( (AccDetail_recsNumChargedOffToKeep <= BusinessCredit_Services.Constants.TOTALTRADELINECOUNT)  AND (~(MoreThanTenChargeOffs)),
																			     (BusinessCredit_Services.Constants.TOTALTRADELINECOUNT - AccDetail_recsNumChargedOffToKeep),
																					 IF  (MoreThanTenChargeOffs,
																							countNonChargeOffRecs,
																						0)
																	    ),
																	BusinessCredit_Services.Constants.TOTALTRADELINECOUNT
																 );

          NumChargeOffsToPutOnEnd :=  IF (MoreThanTenChargeOffs AND (AccDetail_recsNumNoChargedOffToKeep >=  (BusinessCredit_Services.Constants.TOTALTRADELINECOUNT -  BusinessCredit_Services.Constants.topchargeoffCount)),
														0,
													               IF ( MoreThanTenChargeOffs  AND (AccDetail_recsNumNoChargedOffToKeep < (BusinessCredit_Services.Constants.TOTALTRADELINECOUNT -  BusinessCredit_Services.Constants.topchargeoffCount)),
                                                                                             BusinessCredit_Services.Constants.TOTALTRADELINECOUNT -  AccDetail_recsNumNoChargedOffToKeep - BusinessCredit_Services.Constants.topchargeoffCount,
																	0)
															);

           ChargeOffsRecsToPutOnEnd :=  if (MoreThanTenChargeOffs,
					                                              JOIN(CHOOSEN(AccDetail_recsChargedOff,BusinessCredit_Services.Constants.TOTALTRADELINECOUNT),
					                                                   CHOOSEN(AccDetail_recsChargedOff,BusinessCredit_Services.Constants.topchargeoffCount),
														    LEFT.UniqueAccountDetailNumber = RIGHT.UniqueAccountDetailNumber,
														   TRANSFORM(iesp.businesscreditreport.t_BusinessCreditAccountDetail,
															     SELF := LEFT), LEFT ONLY)
													       ,
														dataset ([], iesp.businesscreditreport.t_BusinessCreditAccountDetail)
														);

		// still need to sort within here by status
		 FinalAccDetail_recs := if ( ~(MoreThanTenChargeOffs),
		                                                   CHOOSEN(SORT(AccDetail_recsChargedOff,  -AccountReportedDate, RECORD),AccDetail_recsNumChargedOffToKeep) &
		                                                   CHOOSEN(SORT(AccDetail_recsNoChargedOff,  BusinessCredit_Services.Functions.fn_AccountStatus_sort_orderCreditTrades(AccountStatus),
																											  -AccountReportedDate, RECORD),
																											 AccDetail_recsNumNoChargedOffToKeep),
											// else case
											CHOOSEN(SORT(AccDetail_recsChargedOff,  -AccountReportedDate, RECORD),BusinessCredit_Services.Constants.topchargeoffCount) &
											CHOOSEN(SORT(AccDetail_recsNoChargedOff, BusinessCredit_Services.Functions.fn_AccountStatus_sort_orderCreditTrades(AccountStatus),
																											  -AccountReportedDate, RECORD), AccDetail_recsNumNoChargedOffToKeep) &
                                                          CHOOSEN(SORT(ChargeOffsRecsToPutOnEnd, -AccountReportedDate),		NumChargeOffsToPutOnEnd)
														);



             // c_AccDetail_recsChargedOff := count(AccDetail_recsChargedOff);
		   // c_AccDetail_recsNoChargedOff := count(AccDetail_recsNoChargedOff);
            // output(MoreThanTenChargeOffs, named('MoreThanTenChargeOffs'));
						// output(AccDetail_recsNumNoChargedOffToKeep, named('AccDetail_recsNumNoChargedOffToKeep'));
						// output(NumChargeOffsToPutOnEnd ,named('NumChargeOffsToPutOnEnd'));
						// output(c_AccDetail_recsChargedOff, named('c_AccDetail_recsChargedOff'));
						// output(c_AccDetail_recsNoChargedOff, named('count_AccDetail_recsNoChargedOff'));
		// output(count(PaymentHistoryRecsBig), named('PaymentHistoryRecsBig_count'));
		// output(count(paymentHistoryRecs), named('paymentHistoryRecs_count'));
           // output(CHOOSEN(AccDetail_recsChargedOff,50), named('first3'));
		// output(CHOOSEN(AccDetail_recsChargedOff,2), named('first2'));
		// output(ChargeOffsRecsToPutOnEnd, named('ChargeOffsRecsToPutOnEnd'));
	 // added coding for pushing chargeoff recs to top of heap..
	 //output(past_7_year_creditutil_tab_sort, named('past_7_year_creditutil_tab_sort'));
   // output(tempAccDetail_Recs, named('tempAccDetail_Recs'));
   // output(past_7_year_creditutil_tab_sort, named('past_7_year_creditutil_tab_sort'));
	 // output(past_7_year_creditutil_tab_sortSlim, named('past_7_year_creditutil_tab_sortSlim'));

   // output(TEMP2AccDetail_YearCreditUtils, named('TEMP2AccDetail_YearCreditUtils'));
   // output(tempAcctDetail_RecsYearlyCreditUtils, named('tempAcctDetail_RecsYearlyCreditUtils'));
   // output(TEMP2AccDetail_Recs, named('TEMP2AccDetail_Recs'));
   // output(AccDetail_Recs, named('AccDetail_Recs'));

  // output(TradeRecs_Raw, named('fn_getBuzCreditTrades__TradeRecs_Raw'));
  // output(TradeRecs_dedup, named('fn_getBuzCreditTrades__TradeRecs_dedup'));
  // output(TradeRecs_Raw_with_Status_Sort, named('fn_getBuzCreditTrades__TradeRecs_Raw_with_Status_Sort'));
  // output(TradeRecs_with_Status_Rolled, named('fn_getBuzCreditTrades__TradeRecs_with_Status_Rolled'));
  // output(most_severe_status, named('fn_getBuzCreditTrades__most_severe_status'));

	EXPORT   AccDetail_Recs_Combined :=   CHOOSEN( FinalAccDetail_recs,  iesp.Constants.BusinessCredit.MaxTradelines);							            
END;