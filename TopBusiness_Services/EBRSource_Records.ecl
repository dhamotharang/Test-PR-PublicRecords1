// ================================================================================
// ======   RETURNS EBR DATA FOR A GIVEN FILE_NUMBER IN ESP-COMPLIANT WAY    ======
// ================================================================================
IMPORT EBR, EBR_Services, BIPV2, iesp, std, ut; 

EXPORT EBRSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
	
	SHARED ebr_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		ebr_services.Layout_EBR_Source;
	END;

	// For in_docids records that don't have SourceDocIds (file_number) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get ebr filing numbers from linkids
  ds_ebrkeys := PROJECT(EBR.Key_0010_Header_linkids.kFetch(in_docs_linkonly,inoptions.fetch_level),
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.file_number,
																					SELF := LEFT,
																					SELF := []));
																					
	ebr_keys_comb := in_docids+ds_ebrkeys;

	ebr_keys := PROJECT(ebr_keys_comb(IdValue != ''),TRANSFORM(EBR_Services.layout_file_number,SELF.file_number := LEFT.IdValue));
  
	ebr_keys_dedup := DEDUP(ebr_keys,ALL);
	
	// Get EBR raw "report_view" for the input ebr file_numbers
  ebr_sourceview := EBR_Services.ebr_raw.source_view.by_file_number(ebr_keys_dedup); 
	
	//drop records where no file number is returned in the header record or no history header recs exist
	// Needed since the raw.source_view always returns a record regardless if the file number existss
	// in the keys.
	ebr_sourcefilt := ebr_sourceview(curr_header_rec.file_number != '' or EXISTS(historical_header_recs));

	SHARED ebr_sourceview_wLinkIds := JOIN(ebr_sourcefilt,ebr_keys_comb,
																					LEFT.file_number = RIGHT.IdValue,
																					TRANSFORM(ebr_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					 KEEP(1));   // For cases in which a idvalue has multiple linkids
																					 
	
	// The following function was copied from ut.Date_YY_to_YYYY, which was never
	// moved to prod for some reason.
	//
  // Convert two-digit years to four digits, using a 100-year window
  // around the current year, as defined by a delta of the end of the
  // window relative to to the current year.
  //
  // Ex: In 2010 with a delta of 5, we return years from 1916-2015.
  //
	// NOTE: Pass yy<100 and delta<100 or craziness ensues
  unsigned Date_YY_to_YYYY(unsigned yy, unsigned delta=5) := function	  
		nowdate := Std.Date.Today();
	  high	:= (unsigned)((STRING)nowdate)[1..4] + delta;
	  test	:= yy + ((unsigned)((STRING)nowdate)[1..2]*100);
	  yyyy	:= if(test<=high, test, test-100);
	
	  return yyyy;
	  
  end;


  // transforms for the iesp.bizcredit child dataset layouts
	
  iesp.bizcredit.t_BizCreditExecutiveSummary xform_exec_sum(EBR_Services.Layout_1000_Executive_Summary_Expanded L) := transform
	  self.CurrentDaysBeyondTerms   := (integer) L.CURRENT_DBT;
    self.PredictedDaysBeyondTerms := (integer) L.PREDICTED_DBT;
	  self.DateOfPrediction         := iesp.ECL2ESP.toDate ((integer4) L.predicted_dbt_date);
	  self.AverageIndustryDBT       := (integer) L.AVERAGE_INDUSTRY_DBT;
	  self.IndustryDescription      := L.INDUSTRY_DESCRIPTION;
	  self.AverageAllIndustryDBT    := (integer) L.AVERAGE_ALL_INDUSTRIES_DBT;
	  self.ConfidencePercent        := (integer) L.CONF_PERCENT;
	  self.ConfidenceSlope          := (integer) L.CONF_SLOPE;
	  self.SixMonthLowBalance       := 0;  //vers2
	  self.SixMonthHighBalance      := 0;  //vers2
	  self.LowBalance               := (integer) L.LOW_BALANCE;   //vers2
	  self.HighBalance              := (integer) L.HIGH_BALANCE;  //vers2
	  self.CurrentBalance           := (integer) L.CURRENT_ACCOUNT_BALANCE;
	  self.HighestCreditExtended    := (integer) L.HIGH_CREDIT_EXTENDED;
	  self.MedianOfCreditExtended   := (integer) L.MEDIAN_CREDIT_EXTENDED;
	  self.PaymentPerformance       := L.PAYMENT_PERFORMANCE_DECODE;
	  self.PaymentTrend             := L.PAYMENT_TREND_DECODE;
		self := [];
	end;

  iesp.bizcredit.t_BizCreditTradePaymentDetail xform_trade_detail(ebr.Layout_2000_Trade_In L) := transform
	  self.BusinessCategory           := L.BUSINESS_CATEGORY_DESCRIPTION;
	  self.ReportedDate               := iesp.ECL2ESP.toDate ((integer4) L.date_reported);
	  self.ActivityDate               := iesp.ECL2ESP.toDate ((integer4) (L.date_last_sale + '00')); //L data format=yyyymm
	  self.PaymentTerms               := L.PAYMENT_TERMS;
    self.HighCreditMask             := L.HIGH_CREDIT_MASK;  //vers2
	  self.RecentHighCredit           := (integer) L.RECENT_HIGH_CREDIT;
    self.AccountBalanceMask         := L.ACCOUNT_BALANCE_MASK;  //vers2
	  self.Balance                    := 0; //vers2
	  self.MaskedAccountBalance       := (integer) L.MASKED_ACCOUNT_BALANCE; //vers2
	  self.DBTPercentages.Current     := (integer) L.CURRENT_PERCENT;
	  self.DBTPercentages.Day_01_30   := (integer) L.DEBT_01_30_PERCENT;
	  self.DBTPercentages.Day_31_60   := (integer) L.DEBT_31_60_PERCENT;
	  self.DBTPercentages.Day_61_90   := (integer) L.DEBT_61_90_PERCENT;
	  self.DBTPercentages.Day_91_Plus := (integer) L.DEBT_91_PLUS_PERCENT;
	  self.Comments                   := L.COMMENT_DESCRIPTION;
	  self.PaymentIndicator           := L.PAYMENT_INDICATOR;
    self.NewTradeFlag               := L.NEW_TRADE_FLAG;    //vers2
    self.TradeTypeDesc              := L.TRADE_TYPE_DESC;   //vers2
    self.DisputeIndicator           := L.DISPUTE_INDICATOR; //vers2
    self.DisputeCode                := l.DISPUTE_CODE;      //vers2
		self := [];
  end;
		
  iesp.bizcredit.t_BizCreditTradePaymentTotal xform_trade_total(ebr.Layout_2015_Trade_Payment_Totals_In L) := transform
	  self.RegularTrades.Count                := 0; //vers2
	  self.RegularTrades.TradeCount           := (integer) L.TRADE_COUNT1; //vers2
	  self.RegularTrades.Debt                 := (integer) L.DEBT1;
    self.RegularTrades.HighCreditMask       := L.HIGH_CREDIT_MASK2; //vers2
	  self.RegularTrades.RecentHighCredit     := (integer) L.RECENT_HIGH_CREDIT1;
    self.RegularTrades.AccountBalanceMask   := L.ACCOUNT_BALANCE_MASK1; //vers2
	  self.RegularTrades.Balance              := 0; //vers2
    self.RegularTrades.MaskedAccountBalance := (integer) L.MASKED_ACCOUNT_BALANCE1; //vers2
	  self.RegularTrades.DBTPercentages.Current     := (integer) L.CURRENT_BALANCE_PERCENT1;
	  self.RegularTrades.DBTPercentages.Day_01_30   := (integer) L.DEBT_01_30_PERCENT1;
	  self.RegularTrades.DBTPercentages.Day_31_60   := (integer) L.DEBT_31_60_PERCENT1;
	  self.RegularTrades.DBTPercentages.Day_61_90   := (integer) L.DEBT_61_90_PERCENT1;
	  self.RegularTrades.DBTPercentages.Day_91_Plus := (integer) L.DEBT_91_PLUS_PERCENT1;
	  self.RegularTrades.AgedCount    := 0; //vers2
		self.NewTrades.Count                := 0;  //vers2
	  self.NewTrades.TradeCount           := (integer) L.TRADE_COUNT2; //vers2
	  self.NewTrades.Debt                 := (integer) L.DEBT2;
    self.NewTrades.HighCreditMask       := L.HIGH_CREDIT_MASK2; //vers2
	  self.NewTrades.RecentHighCredit     := (integer) L.RECENT_HIGH_CREDIT2;
    self.NewTrades.AccountBalanceMask   := L.ACCOUNT_BALANCE_MASK2; //vers2
	  self.NewTrades.Balance              := 0; //vers2
    self.NewTrades.MaskedAccountBalance := (integer) L.MASKED_ACCOUNT_BALANCE2;
	  self.NewTrades.DBTPercentages.Current     := (integer) L.CURRENT_BALANCE_PERCENT2;
	  self.NewTrades.DBTPercentages.Day_01_30   := (integer) L.DEBT_01_30_PERCENT2;
	  self.NewTrades.DBTPercentages.Day_31_60   := (integer) L.DEBT_31_60_PERCENT2;
	  self.NewTrades.DBTPercentages.Day_61_90   := (integer) L.DEBT_61_90_PERCENT2;
	  self.NewTrades.DBTPercentages.Day_91_Plus := (integer) L.DEBT_91_PLUS_PERCENT2;
	  self.NewTrades.AgedCount            			:= 0; //vers1&2???
		self.CombinedTrades.Count                := 0;  //vers2
	  self.CombinedTrades.TradeCount           := (integer) L.TRADE_COUNT3; //vers2
	  self.CombinedTrades.Debt                 := (integer) L.DEBT3;
    self.CombinedTrades.HighCreditMask       := L.HIGH_CREDIT_MASK3; //vers2
	  self.CombinedTrades.RecentHighCredit     := (integer) L.RECENT_HIGH_CREDIT3;
    self.CombinedTrades.AccountBalanceMask   := L.ACCOUNT_BALANCE_MASK3; //vers2
	  self.CombinedTrades.Balance              := 0;  //vers2
    self.CombinedTrades.MaskedAccountBalance := (integer) L.MASKED_ACCOUNT_BALANCE3; //vers2
	  self.CombinedTrades.DBTPercentages.Current     := (integer) L.CURRENT_BALANCE_PERCENT3;
	  self.CombinedTrades.DBTPercentages.Day_01_30   := (integer) L.DEBT_01_30_PERCENT3;
	  self.CombinedTrades.DBTPercentages.Day_31_60   := (integer) L.DEBT_31_60_PERCENT3;
	  self.CombinedTrades.DBTPercentages.Day_61_90   := (integer) L.DEBT_61_90_PERCENT3;
	  self.CombinedTrades.DBTPercentages.Day_91_Plus := (integer) L.DEBT_91_PLUS_PERCENT3;
	  self.CombinedTrades.AgedCount            := 0;  //vers1&2???
	  self.HighestCreditMedian     := (integer) L.HIGHEST_CREDIT_MEDIAN; //vers2
    self.AgedTradesCount         := (integer) L.AGED_TRADES_COUNT;     //vers2	
	  self.AccountBalanceRegular   := (integer) L.account_balance_regular_tradelines;  //vers2
	  self.AccountBalanceNew       := (integer) L.account_balance_new;   //vers2
	  self.AccountBalanceCombined  := (integer) L.account_balance_combined;  //vers2
		self := [];
 end;

  iesp.bizcredit.t_BizCreditTradePaymentTrend	xform_trade_trend(ebr.Layout_2020_Trade_Payment_Trends_Base L) := transform
	  // Convert 2 char TREND_YY+TREND_MM into 8 char YYYYMMDD string
		string8 trend_yyyymmdd := ((string) Date_YY_to_YYYY((unsigned)L.TREND_YY)) + L.TREND_MM + '00';
	  self.Date  := iesp.ECL2ESP.toDate ((integer4) trend_yyyymmdd); 
	  self.Debt                       := (integer) L.DBT;        //vers2
    self.AccountBalanceMask         := L.ACCT_BAL_MASK;        //vers2
    self.Balance                    := 0; //vers2
	  self.AccountBalance             := (integer) L.ACCT_BAL; //vers2
	  self.DBTPercentages.Current     := (integer) L.CURRENT_BALANCE_PCT;
	  self.DBTPercentages.Day_01_30   := (integer) L.DBT_01_30_PCT;
	  self.DBTPercentages.Day_31_60   := (integer) L.DBT_31_60_PCT;
	  self.DBTPercentages.Day_61_90   := (integer) L.DBT_61_90_PCT;
	  self.DBTPercentages.Day_91_Plus := (integer) L.DBT_91_PLUS_PCT;
		self := [];
  end;

  iesp.bizcredit.t_BizCreditTradeQuarterlyAverage	xform_trade_qtrly_avg(ebr.Layout_2025_Trade_Quarterly_Averages_Base L) := transform
	  self.Quarter                    := (integer) L.QUARTER;
	  self.Year                       := (integer) L.QUARTER_YY;
	  self.Debt                       := (integer) L.DEBT;          //vers2
    self.AccountBalanceMask         := L.ACCOUNT_BALANCE_MASK;    //vers2
	  self.Balance                    := 0; //vers2
	  self.AccountBalance             := (integer) L.ACCOUNT_BALANCE; //vers2
	  self.DBTPercentages.Current     := (integer) L.CURRENT_BALANCE_PERCENT;
	  self.DBTPercentages.Day_01_30   := (integer) L.DEBT_01_30_PERCENT;
	  self.DBTPercentages.Day_31_60   := (integer) L.DEBT_31_60_PERCENT;
	  self.DBTPercentages.Day_61_90   := (integer) L.DEBT_61_90_PERCENT;
	  self.DBTPercentages.Day_91_Plus := (integer) L.DEBT_91_PLUS_PERCENT;
		self := [];
	end;

  iesp.bizcredit.t_BizCreditBankruptcy xform_bankruptcy(ebr.Layout_4010_Bankruptcy_In L) := transform
	  self._Type            := L.TYPE_DESC;
	  self.Action           := L.ACTION_DESC;
 	  self.DocumentNumber   := L.DOCUMENT_NUMBER;
	  self.LiabilityAmount  := (integer) L.LIABILITY_AMT;
		self.AssetAmount      := ''; //vers2
	  self.AssetAmount2     := (integer) L.ASSET_AMT; //vers2
    self.DisputeIndicator := L.DISPUTE_IND;  //vers2
    self.DisputeCode      := L.DISPUTE_CODE; //vers2
	  self.DateFiled        := iesp.ECL2ESP.toDate ((integer4) L.date_filed);
		self := [];
  end;

  iesp.bizcredit.t_BizCreditTaxLien xform_tax_lien(ebr.Layout_4020_Tax_Liens_In L) := transform
  	self._Type            := L.Type_Description;
	  self.Action           := L.Action_Description;
	  self.DocumentNumber   := L.Document_Number;
		self.FileLocation     := ''; //vers
	  self.FilingLocation   := L.Filing_Location; //vers2
	  self.LiabilityAmount  := (integer) L.Liability_Amount;
	  self.Description      := L.Tax_Lien_Description;
    self.DisputeIndicator := L.DISPUTE_INDICATOR; //vers2
    self.DisputeCode      := L.DISPUTE_CODE;      //vers2
	  self.DateFiled        := iesp.ECL2ESP.toDate ((integer4) L.date_filed);
		self := [];
   end;

  iesp.bizcredit.t_BizCreditJudgment xform_judgment(ebr.Layout_4030_Judgement_In L) := transform
  	self._Type            := L.Type_Description;
	  self.Action           := L.Action_Description;
	  self.DocumentNumber   := L.Document_Number;
	  self.FileLocation     := '';  //vers2
	  self.FilingLocation   := L.Filing_Location; //vers2
	  self.LiabilityAmount  := (integer) L.Liability_Amount;
	  self.CreditorName     := L.Plaintiff_Name;
    self.DisputeIndicator := L.DISPUTE_INDICATOR; //vers2
    self.DisputeCode      := l.DISPUTE_CODE;      //vers2
	  self.DateFiled        := iesp.ECL2ESP.toDate ((integer4) L.date_filed);
		self := [];
  end;
  
  iesp.share.t_CodeMap xform_ca_coll2(ebr.Layout_4500_Collateral_Accounts_In L, integer C) := transform
		self.Code        := choose(C,L.COLL_CODE1,L.COLL_CODE2,L.COLL_CODE3,L.COLL_CODE4,
		                             L.COLL_CODE5,L.COLL_CODE6,L.COLL_CODE7,L.COLL_CODE8,
		                             L.COLL_CODE9,L.COLL_CODE10,L.COLL_CODE11,L.COLL_CODE12);
	  self.Description := choose(C,L.COLL_DESC1,L.COLL_DESC2,L.COLL_DESC3,L.COLL_DESC4,
		                             L.COLL_DESC5,L.COLL_DESC6,L.COLL_DESC7,L.COLL_DESC8,
		                             L.COLL_DESC9,L.COLL_DESC10,L.COLL_DESC11,L.COLL_DESC12);
		self := [];
  end;

  iesp.bizcredit.t_BizCreditCollateralAccount xform_coll_acct(ebr.Layout_4500_Collateral_Accounts_In L) := transform
	  self.TotalUCCFiled  := (integer) L.TOTAL_UCC_FILED;
	  self.Count          := (integer) L.COLL_COUNT_UCC;
		// Create a dataset from the 12 L.COLL_DESC* fields.
		self.Collaterals    := []; //vers2
		self.Collaterals2   := normalize(dataset(L),iesp.Constants.BIZ_CREDIT.MAX_COLL_ACC,
		                                 xform_ca_coll2(left, counter));
	  self.AdditionalCode := L.ADDTNL_COLL_CODES;
		self := [];
  end;

  iesp.share.t_CodeMap xform_ucc_coll(ebr.Layout_4510_UCC_Filings_In L, integer C) := transform
		self.Code        := choose(C,L.COLL_CODE1,L.COLL_CODE2,L.COLL_CODE3,
		                             L.COLL_CODE4,L.COLL_CODE5,L.COLL_CODE6);
	  self.Description := choose(C,L.COLL_DESC1,L.COLL_DESC2,L.COLL_DESC3,
		                             L.COLL_DESC4,L.COLL_DESC5,L.COLL_DESC6);
		self := [];
  end;
	
  iesp.bizcredit.t_BizCreditUCCFiling xform_ucc(ebr.Layout_4510_UCC_Filings_In L) := transform
	  self._Type          := L.TYPE_DESC;
	  self.Action         := L.ACTION_DESC;
	  self.DocumentNumber := L.DOCUMENT_NUMBER;
	  self.FileLocation   := ''; //vers1
	  self.FilingLocation := L.Filing_Location;  //vers2
		// Create a dataset from the 6 sets of L.COLL_* fields.
		self.Collaterals    := normalize(dataset(L),iesp.Constants.BIZ_CREDIT.MAX_COLL_ACC,
		                                 xform_ucc_coll(left, counter));
	  self.AdditionalCollateralCodes := L.ADDTNL_COLL_CODES;
	  self.SecuredParty     := L.SECURED_PARTY;
	  self.Assignee         := L.ASSIGNEE;
	  self.FileState        := L.ORIG_FILE_STATE_DESC;
	  self.FileNumber       := L.ORIG_FILE_NUMBER;
    self.DisputeIndicator := L.DISPUTE_IND;  //vers2
    self.DisputeCode      := L.DISPUTE_CODE; //vers2
	  self.DateFiled        := iesp.ECL2ESP.toDate ((integer4) L.date_filed);
		self := [];
  end;

	iesp.bizcredit.t_BizCreditBankingDetail xform_bank_detail(EBR_Services.Layout_5000_Bank_Details_Expanded L) := transform
	  self.Name                        := L.NAME;
	  self.OrigAddress.StreetAddress1  := L.STREET_ADDRESS; //vers2
	  self.OrigAddress.City            := L.CITY;           //vers2
	  self.OrigAddress.State           := L.STATE_CODE;     //vers2
	  self.OrigAddress.Zip5            := L.ZIP_CODE;       //vers2
    self.OrigAddress                 := [];               //vers2
    self.StateName                   := L.STATE_DESC;     //vers2
	  self.Address.StreetNumber        := L.prim_range;
	  self.Address.StreetPreDirection  := L.predir;
	  self.Address.StreetName          := L.prim_name;
	  self.Address.StreetSuffix        := L.addr_suffix;
	  self.Address.StreetPostDirection := L.postdir;
	  self.Address.UnitDesignation     := L.unit_desig;
	  self.Address.UnitNumber          := L.sec_range;
	  self.Address.StreetAddress1      := '';
	  self.Address.StreetAddress2      := '';
	  self.Address.City                := L.p_city_name; 
	  self.Address.State               := L.st;
	  self.Address.Zip5                := L.zip;
	  self.Address.Zip4                := L.zip4;
	  self.Address.County              := L.county_name;
	  self.Address.PostalCode          := '';
	  self.Address.StateCityZip        := '';
	  self.PhoneNumber  := L.TELEPHONE;
	  self.TimeZone     := L.timezone;
	  self.Balance      := (integer) L.ACCT_BAL_TOTAL;
	  self.Relationship := L.RELATIONSHIP_DESC;
	  // Convert 6 char YYMMDD into 8 char YYYYMMDD string
		string8 date_opened_yyyymmdd := ((string) Date_YY_to_YYYY((unsigned)L.DATE_ACCT_OPENED_YMD[1..2])) + L.DATE_ACCT_OPENED_YMD[3..6];
		string8 date_closed_yyyymmdd := ((string) Date_YY_to_YYYY((unsigned)L.DATE_ACCT_CLOSED_YMD[1..2])) + L.DATE_ACCT_CLOSED_YMD[3..6];
	  self.DateOpened              := iesp.ECL2ESP.toDate ((integer4) date_opened_yyyymmdd);
	  self.DateClosed              := iesp.ECL2ESP.toDate ((integer4) date_closed_yyyymmdd);
    self.DisputeIndicator := L.DISPUTE_IND;  //vers2
    self.DisputeCode      := l.DISPUTE_CODE; //vers2
		self := [];
  end;
		
  iesp.share.t_CodeMap xform_demo5600_sic(EBR.Layout_5600_demographic_data_In L, integer C) := transform
		self.Code        := choose(C,L.SIC_1_CODE,L.SIC_2_CODE,L.SIC_3_CODE,L.SIC_4_CODE,'');
	  self.Description := choose(C,L.SIC_1_DESC,L.SIC_2_DESC,L.SIC_3_DESC,L.SIC_4_DESC,'');
		self := [];
  end;

	iesp.bizcredit.t_BizCreditDemographic5600 xform_demo_5600(ebr.Layout_5600_demographic_data_In L) := transform
		// Create a dataset from the 1-4 sets of L.SIC_*_CODE/DESC fields.
		numSics := MAP(L.SIC_4_CODE != '' => 4,
									 L.SIC_3_CODE != '' => 3,
									 L.SIC_2_CODE != '' => 2,
									 L.SIC_1_CODE != '' => 1,
									 0);
		self.SICs                  := normalize(dataset(L),numSics,xform_demo5600_sic(left, counter));
	  // set counter (---^) based upon if SIC_*_code or SIC_*_desc (*=4, 3, 2 ,1) are not empty???
	  self.YearsInBusiness       := L.YRS_IN_BUS_DESC;
	  self.YearsInBusinessActual := (integer) L.YRS_IN_BUS_ACTUAL;
	  self.Sales                 := L.SALES_DESC;
	  self.SalesAcutal           := (integer6)L.SALES_ACTUAL;
	  self.EmployeeSize          := L.EMPL_SIZE_DESC;
	  self.EmployeeSizeActual    := (integer) L.EMPL_SIZE_ACTUAL;
	  self.BusinessType          := L.BUS_TYPE_DESC;
	  self.OwnerType             := L.OWNER_TYPE_DESC;
	  self.Location              := L.LOCATION_DESC;
	  self.TimeZone              := '';
		self := [];
  end;

	iesp.bizcredit.t_BizCreditDemographic5610 xform_demo_5610(ebr.Layout_5610_demographic_data_Out L) := transform
	  self.FiscalYearEndMonth  := (integer) L.FISCAL_YR_END_MM;
	  self.ProfitRange         := L.PROFIT_RANGE_DESC;
	  self.ProfitRangeActual   := (integer) L.PROFIT_RANGE_ACTUAL;
	  self.NetWorth            := L.NET_WORTH_DESC;
    self.NetWorthActual      := (integer) L.NET_WORTH_ACTUAL;
	  self.InBuildingSinceYear := (integer) L.IN_BLDNG_SINCE_YY;
		self.OwnOrRent           := 0; //vers2
	  self.RentorOwn2          := L.OWN_OR_RENT_CODE;        //vers2
	  self.BuildingSquareFeet  := (integer) L.BLDNG_SQUARE_FEET;
	  self.ActiveCustomerCount := (integer) L.ACTIVE_CUST_COUNT;
	  self.Ownership           := L.OWNERSHIP_DESC;
	  self.CorporateName       := L.CORP_NAME;
	  self.CorporateCity       := L.CORP_CITY;
	  self.CorporateState      := L.CORP_STATE_CODE;
	  self.CorporateStateName  := L.CORP_STATE_DESC; //vers2
	  self.CorporatePhone      := L.CORP_PHONE;
	  self.TimeZone            := L.timezone;        //vers2
	  self.OfficerTitle        := L.OFFICER_TITLE;   //vers2
	  self.OrigOfficerName.Full    := '';                    //vers2
	  self.OrigOfficerName.First   := L.OFFICER_FIRST_NAME;  //vers2
	  self.OrigOfficerName.Middle  := L.OFFICER_M_I;         //vers2
	  self.OrigOfficerName.Last    := L.OFFICER_LAST_NAME;   //vers2
	  self.OrigOfficerName.Suffix  := '';                    //vers2
	  self.OrigOfficerName.Prefix  := '';                    //vers2
	  self.OfficerName.Full    := '';
	  self.OfficerName.First   := L.clean_officer_name.fname; 
	  self.OfficerName.Middle  := L.clean_officer_name.mname; 
	  self.OfficerName.Last    := L.clean_officer_name.lname; 
	  self.OfficerName.Suffix  := L.clean_officer_name.name_suffix; 
	  self.OfficerName.Prefix  := L.clean_officer_name.title,; 
    self.UniqueId            := (string12) L.did;  //vers2
		self.SSN                 := (string9) L.ssn;   //vers2
		self := [];
  end;

  iesp.bizcredit.t_BizCreditInquiryCount xform_inquiry_count(EBR_Services.Layout_6000_Inquiries_Base_Rolled.child L) := transform
	  // Convert 4 char YYMM into 8 char YYYYMMDD string
		string8 inq_yyyymmdd := ((string) Date_YY_to_YYYY((unsigned)L.INQ_YYMM[1..2])) + L.INQ_YYMM[3..4] + '00';
	  self.Date  := iesp.ECL2ESP.toDate ((integer4) inq_yyyymmdd);
	  self.Count := (integer) L.INQ_COUNT;
		//self := [];
  end;

	iesp.bizcredit.t_BizCreditInquiryItem xform_inquiry_item(EBR_Services.Layout_6000_Inquiries_Base_Rolled.parent L) := transform
	  self.InquiryType   := L.BUS_DESC; //inq type = bus desc? *.parent layout only has BUS_CODE & BUS_DESC fields???
	  self.InquiryCounts := project(choosen(L.Counts,iesp.Constants.BIZ_CREDIT.MAX_INQUIRY_COUNTS), 
		                              xform_inquiry_count(left));
		self := []; 
  end;
		
  iesp.bizcredit.t_BizCreditInquiry xform_inquiry(EBR_Services.Layout_6000_Inquiries_Base_Rolled.top_level  L):= transform
    // Convert 4 char INQ_YYMM_MIN & INQ_YYMM_MAX into 8 char YYYYMMDD strings
		string8 min_yyyymmdd := ((string) Date_YY_to_YYYY((unsigned)L.INQ_YYMM_MIN[1..2])) + L.INQ_YYMM_MIN[3..4] + '00';
		string8 max_yyyymmdd := ((string) Date_YY_to_YYYY((unsigned)L.INQ_YYMM_MAX[1..2])) + L.INQ_YYMM_MAX[3..4] + '00';
	  self.DateRange.StartDate := iesp.ECL2ESP.toDate ((integer4) min_yyyymmdd);
	  self.DateRange.EndDate   := iesp.ECL2ESP.toDate ((integer4) max_yyyymmdd);
    self.Inquiries           := project(choosen(L.Inquiries,
		                                            iesp.Constants.BIZ_CREDIT.MAX_INQUIRY), 
		                                    xform_inquiry_item(left));
		self := [];
  end;

	iesp.bizcredit.t_BizCreditGovernmentTrade xform_gov_trade(ebr.Layout_6500_Government_Trade_In L) := transform
 	  self.PaymentIndicator           := L.PAYMENT_IND;  //vers2
	  self.BusinessCategory           := L.BUS_CAT_DESC;
	  self.PaymentTerms               := L.PAYMENT_TERMS;
    self.HighCreditMask             := L.HIGH_CREDIT_MASK;           //vers2
	  self.RecentHighCredit           := (integer) L.RECENT_HIGH_CREDIT;
    self.AccountBalanceMask         := L.ACCT_BAL_MASK;              //vers2
	  self.MaskedAccountBalance       := (integer) L.MASKED_ACCT_BAL;  //vers2
	  self.DBTPercentages.Current     := (integer) L.CURRENT_PCT;
	  self.DBTPercentages.Day_01_30   := (integer) L.DBT_01_30_PCT;
	  self.DBTPercentages.Day_31_60   := (integer) L.DBT_31_60_PCT;
	  self.DBTPercentages.Day_61_90   := (integer) L.DBT_61_90_PCT;
	  self.DBTPercentages.Day_91_Plus := (integer) L.DBT_91_PLUS_PCT;
	  self.Comments     := L.COMMENT_DESC;
    self.NewTradeFlag               := L.NEW_TRADE_FLAG;  //vers2
	  self.TradeType    := L.TRADE_TYPE_DESC;
	  self.DateReported := iesp.ECL2ESP.toDate ((integer4) L.date_reported);
	  self.DateLastSale := iesp.ECL2ESP.toDate ((integer4) L.date_last_sale);
    self.DisputeIndicator := L.DISPUTE_IND;  //vers2
    self.DisputeCode      := l.DISPUTE_CODE; //vers2
		self := []; 
  end;

	iesp.bizcredit.t_BizCreditGovernmentDebarredContractor xform_gov_debar_contr(EBR_Services.Layout_6510_Government_Debarred_Contractor_Expanded L) := transform
	  self.Action                      := L.ACTION_DESC;
	  self.BusinessName                := L.CO_BUS_NAME; 
	  self.OrigAddress.StreetAddress1  := L.CO_BUS_ADDRESS;     //vers2
	  self.OrigAddress.City            := L.CO_BUS_CITY;        //vers2
	  self.OrigAddress.State           := L.CO_BUS_STATE_CODE;  //vers2
	  self.OrigAddress.Zip5            := L.CO_BUS_ZIP;         //vers2
    self.OrigAddress                 := [];                   //vers2
    self.StateName                   := L.CO_BUS_STATE_DESC;  //vers2
	  self.Address.StreetNumber        := L.clean_business_address.prim_range;
	  self.Address.StreetPreDirection  := L.clean_business_address.predir;
	  self.Address.StreetName          := L.clean_business_address.prim_name;
	  self.Address.StreetSuffix        := L.clean_business_address.addr_suffix;
	  self.Address.StreetPostDirection := L.clean_business_address.postdir;
	  self.Address.UnitDesignation     := L.clean_business_address.unit_desig;
	  self.Address.UnitNumber          := L.clean_business_address.sec_range;
	  self.Address.StreetAddress1      := '';
	  self.Address.StreetAddress2      := '';
	  self.Address.City                := L.clean_business_address.p_city_name; 
	  self.Address.State               := L.clean_business_address.st;
	  self.Address.Zip5                := L.clean_business_address.zip;
	  self.Address.Zip4                := L.clean_business_address.zip4;
	  self.Address.County              := L.county_name; 
	  self.Address.PostalCode          := '';
	  self.Address.StateCityZip        := '';
	  self.ExtentOfAction   := L.EXTENT_OF_ACTION;
	  self.Agency           := L.AGENCY_DESC;
    self.DisputeIndicator := L.DISPUTE_IND;   //vers2
    self.DisputeCode      := l.DISPUTE_CODE;  //vers2
	  self.DateFiled        := iesp.ECL2ESP.toDate ((integer4) L.date_filed);
	  self.DateReported     := iesp.ECL2ESP.toDate ((integer4) L.date_reported);;
		self := [];
  end;

	iesp.bizcredit.t_BizCredSNP xform_snp(EBR.Layout_7010_SNP_Data_In L) := transform
	  self.DataPrintLine := L.DATA_PRINT_LINE;
  end;

  iesp.bizcredit.t_BizCreditBusinessHeader xform_hist_comp(EBR_Services.Layout_0010_Header_Base_Expanded L) := transform
	  self.DateFirstSeen       := iesp.ECL2ESP.toDate ((integer4) L.date_first_seen);
	  self.DateLastSeen        := iesp.ECL2ESP.toDate ((integer4) L.date_last_seen);
    self.ExtractDate         := iesp.ECL2ESP.toDate ((integer4) L.extract_date); //vers2
	  self.LastUpdatedDate     := iesp.ECL2ESP.toDate ((integer4) L.process_date);
	  // Convert 6 char YYYYMM file_estab_date into 8 char YYYYMMDD string
		self.FileEstablishDate   := iesp.ECL2ESP.toDate ((integer4) (L.file_estab_date + '00')); 
    self.RecordType          := L.record_type;
	  self.CompanyName         := L.COMPANY_NAME;
	  self.BusinessDescription := L.BUSINESS_DESC;
    self.OrigAddress.StreetAddress1  := L.street_address;  
	  self.OrigAddress.City            := L.city;           
	  self.OrigAddress.State           := L.state_code;      
	  self.OrigAddress.Zip5            := L.orig_zip;        
	  self.OrigAddress.Zip4            := L.orig_zip_4;     
    self.OrigAddress                 := []; 
    self.StateName                   := L.state_name;  
	  self.Address.StreetNumber        := L.prim_range;
	  self.Address.StreetPreDirection  := L.predir;
	  self.Address.StreetName          := L.prim_name;
	  self.Address.StreetSuffix        := L.addr_suffix;
	  self.Address.StreetPostDirection := L.postdir;
	  self.Address.UnitDesignation     := L.unit_desig;
	  self.Address.UnitNumber          := L.sec_range;
	  self.Address.City                := L.p_city_name;
	  self.Address.State               := L.st;
	  self.Address.Zip5                := L.zip;
	  self.Address.Zip4                := L.zip4;
	  self.Address.County              := L.county_name;
	  self.PhoneNumber 								 := L.PHONE_NUMBER;
	  self.SICCode     								 := L.SIC_CODE;
    self.DisputeIndicator 					 := L.DISPUTE_IND;
		self := [];
  end;
	
  // main iesp.bizcredit report record transform
  SHARED iesp.bizcredit.t_BizCreditReportRecord toOut (ebr_layout_wLinkIds L) := transform
		IDmacros.mac_IespTransferLinkids()  //sets all 7 ids and also includes IdValue
	  self.FileNumber                         := L.file_number;
	  self.BusinessHeader.BusinessId          := (string) L.curr_header_rec.bdid; //old bdid, is this still needed in the output???
	  self.BusinessHeader.DateFirstSeen       := iesp.ECL2ESP.toDate ((integer4) L.curr_header_rec.date_first_seen);
	  self.BusinessHeader.DateLastSeen        := iesp.ECL2ESP.toDate ((integer4) L.curr_header_rec.date_last_seen);
    self.BusinessHeader.ExtractDate         := iesp.ECL2ESP.toDate ((integer4) L.curr_header_rec.extract_date); //vers2
	  self.BusinessHeader.LastUpdatedDate     := iesp.ECL2ESP.toDate ((integer4) L.curr_header_rec.process_date);
	  // Convert 6 char YYYYMM file_estab_date into 8 char YYYYMMDD string
		self.BusinessHeader.FileEstablishDate   := iesp.ECL2ESP.toDate ((integer4) (L.curr_header_rec.file_estab_date + '00')); 
    self.BusinessHeader.RecordType          := L.curr_header_rec.record_type; //vers2
	  self.BusinessHeader.CompanyName         := L.curr_header_rec.COMPANY_NAME;
	  self.BusinessHeader.BusinessDescription := L.curr_header_rec.BUSINESS_DESC;
    self.BusinessHeader.OrigAddress.StreetAddress1  := L.curr_header_rec.street_address;  //vers2
	  self.BusinessHeader.OrigAddress.City            := L.curr_header_rec.city;            //vers2
	  self.BusinessHeader.OrigAddress.State           := L.curr_header_rec.state_code;      //vers2
	  self.BusinessHeader.OrigAddress.Zip5            := L.curr_header_rec.orig_zip;        //vers2
	  self.BusinessHeader.OrigAddress.Zip4            := L.curr_header_rec.orig_zip_4;      //vers2
    self.BusinessHeader.OrigAddress                 := []; //added //to null unused iesp address fields //vers2
    self.BusinessHeader.StateName                   := L.curr_header_rec.state_name;      //vers2
	  self.BusinessHeader.Address.StreetNumber        := L.curr_header_rec.prim_range;
	  self.BusinessHeader.Address.StreetPreDirection  := L.curr_header_rec.predir;
	  self.BusinessHeader.Address.StreetName          := L.curr_header_rec.prim_name;
	  self.BusinessHeader.Address.StreetSuffix        := L.curr_header_rec.addr_suffix;
	  self.BusinessHeader.Address.StreetPostDirection := L.curr_header_rec.postdir;
	  self.BusinessHeader.Address.UnitDesignation     := L.curr_header_rec.unit_desig;
	  self.BusinessHeader.Address.UnitNumber          := L.curr_header_rec.sec_range;
	  self.BusinessHeader.Address.StreetAddress1      := '';
	  self.BusinessHeader.Address.StreetAddress2      := '';
	  self.BusinessHeader.Address.City                := L.curr_header_rec.p_city_name;
	  self.BusinessHeader.Address.State               := L.curr_header_rec.st;
	  self.BusinessHeader.Address.Zip5                := L.curr_header_rec.zip;
	  self.BusinessHeader.Address.Zip4                := L.curr_header_rec.zip4;
	  self.BusinessHeader.Address.County              := L.curr_header_rec.county_name;
	  self.BusinessHeader.Address.PostalCode          := '';
	  self.BusinessHeader.Address.StateCityZip        := '';
	  self.BusinessHeader.PhoneNumber := L.curr_header_rec.PHONE_NUMBER;
	  self.BusinessHeader.TimeZone    := L.curr_header_rec.timezone;
	  self.BusinessHeader.SICCode     := L.curr_header_rec.SIC_CODE;
    self.BusinessHeader.DisputeIndicator := L.curr_header_rec.DISPUTE_IND; //vers2

    // use project to create child datasets ---v
		HistCompRecs := PROJECT(L.historical_header_recs,xform_hist_comp(left));
		HistCompRecs_dedup := DEDUP(SORT(HistCompRecs,OrigAddress,CompanyName,BusinessDescription,PhoneNumber,SICCode),
											CompanyName,OrigAddress.StreetAddress1,OrigAddress.City,OrigAddress.State,OrigAddress.Zip5,
											BusinessDescription,PhoneNumber,SICCode);
		
		self.HistoricalCompanyInfo 	:= CHOOSEN(HistCompRecs_dedup,iesp.Constants.BIZ_CREDIT.MAX_HIST_COMPINFO);
	  self.ExecutiveSummaries     := project(choosen(L.executive_summary_recs,iesp.Constants.BIZ_CREDIT.MAX_EXEC_SUMMARY),
																					 xform_exec_sum(left)); 
	  self.TradePaymentDetails    := project(choosen(L.trade_recs,iesp.Constants.BIZ_CREDIT.MAX_PAY_DETAIL),  //??? ...MAX_TRADE),
		                                       xform_trade_detail(left));
	  self.TradePaymentTotal := []; 
		self.TradePaymentTotals     := project(choosen(L.trade_payment_total_recs,iesp.Constants.BIZ_CREDIT.MAX_TRADE_PAY_TOT),
   	                                       xform_trade_total(left)); //vers2
	  self.TradePaymentTrends     := project(choosen(L.trade_payment_trend_recs,iesp.Constants.BIZ_CREDIT.MAX_TRADE_PAY_TREND),
		                                       xform_trade_trend(left));
	  self.TradeQuarterlyAverages := project(choosen(L.trade_quarterly_average_recs,iesp.Constants.BIZ_CREDIT.MAX_TRADE_QTR_AVG),
		                                       xform_trade_qtrly_avg(left)); 
	  self.Bankruptcies           := project(choosen(L.bankruptcy_recs,iesp.Constants.BIZ_CREDIT.MAX_BANKRUPTCIES),
		                                       xform_bankruptcy(left)); 
	  self.TaxLiens               := project(choosen(L.tax_lien_recs,iesp.Constants.BIZ_CREDIT.MAX_TAXLIENS),
		                                       xform_tax_lien(left));
	  self.Judgments              := project(choosen(L.judgment_recs,iesp.Constants.BIZ_CREDIT.MAX_JUDGMENTS),
		                                       xform_judgment(left)); 
	  self.CollateralAccounts     := project(choosen(L.collateral_account_recs,iesp.Constants.BIZ_CREDIT.MAX_COLL_ACC),
		                                       xform_coll_acct(left));
	  self.UCCFilings             := project(choosen(L.ucc_filing_recs,iesp.Constants.BIZ_CREDIT.MAX_UCC_FILINGS),
		                                       xform_ucc(left));
	  self.BankingDetails         := project(choosen(L.bank_detail_recs,iesp.Constants.BIZ_CREDIT.MAX_BANK_DETAIL),
		                                       xform_bank_detail(left)); 
	  self.Demographics5600       := project(choosen(L.demographic_data_5600_recs,iesp.Constants.BIZ_CREDIT.MAX_DEMO_DATA),
		                                       xform_demo_5600(left));
		d5610Recs_dedup							:= DEDUP(SORT(L.demographic_data_5610_recs,file_number,clean_officer_name.lname,clean_officer_name.fname,clean_officer_name.mname,-process_date_last_seen)
																				,file_number,clean_officer_name.lname,clean_officer_name.fname,clean_officer_name.mname);
		
	  self.Demographics5610       := project(choosen(d5610Recs_dedup,iesp.Constants.BIZ_CREDIT.MAX_DEMO_DATA),
		                                       xform_demo_5610(left)); 
    self.InquiryRecords         := project(choosen(L.inquiry_recs,iesp.Constants.BIZ_CREDIT.MAX_INQUIRY),
		                                       xform_inquiry(left)); 
	  self.GovernmentTrades       := project(choosen(L.government_trade_recs,iesp.Constants.BIZ_CREDIT.MAX_GOVT_TRADE),
		                                       xform_gov_trade(left)); 
	  self.GovernmentDebarredContractors := project(choosen(L.government_debarred_contractor_recs,iesp.Constants.BIZ_CREDIT.MAX_GOVT_DEBARRED),
		                                              xform_gov_debar_contr(left)); 
    self.SNPs                   := project(choosen(L.snp_data_recs,iesp.Constants.BIZ_CREDIT.MAX_SNP),
		                                       xform_snp(left));  //vers2
		self := []; 
  end;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(ebr_layout_wLinkIds L) := TRANSFORM
			self.src			:= 'EBR';
			self.src_desc := 'Experian Business Data';
			self.hasName 	:= L.curr_header_rec.company_name<>'';
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= L.curr_header_rec.state_code<>'' or L.curr_header_rec.orig_zip<>'';
		  self.hasPhone := L.curr_header_rec.phone_number<>'';
			self.dt_first_seen := ut.NormDate((unsigned)L.curr_header_rec.date_first_seen);
			self.dt_last_seen := ut.NormDate((unsigned)L.curr_header_rec.date_last_seen);
			self := [];
	END;
	
	EXPORT SourceDetailInfo := project(ebr_sourceview_wLinkIds,xform_Details(LEFT));
	EXPORT SourceView_Recs := project(ebr_sourceview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(ebr_sourceview_wLinkIds);
	
END;
