// ================================================================================
// ===== RETURNS Experain CRDB Source Doc records in an ESP-COMPLIANT WAY			 ====
// ================================================================================
IMPORT iesp, BIPV2, Codes, TopBusiness_Services;

EXPORT ExperianCRDBSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for experian crdb to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get experian data
  exp_recs := TopBusiness_Services.Key_Fetches(DEDUP(in_docs_linkonly,ALL),
													                     inoptions.fetch_level
																							).ds_expcrdb_linkidskey_recs;

	// Keep most recent filing
	SHARED exp_recs_dedup := DEDUP(SORT(exp_recs,experian_bus_id,-latest_reported_date),experian_bus_id);
  // transforms for the iesp.bizcredit layout
 		
   iesp.share.t_CodeMap xform_demo5600_sic(recordof(exp_recs_dedup) L, integer C) := transform
		self.Code        := choose(C,L.Primary_SIC_Code_4_Digit,
																 L.Second_SIC_Code[1..4],
																 L.Third_SIC_Code[1..4],
																 L.Fourth_SIC_Code[1..4],
																 L.Fifth_SIC_Code[1..4],
																 L.Sixth_SIC_Code[1..4]);
																 
	  self.Description := choose(C,Codes.Key_SIC4(keyed(sic4_code = L.Primary_SIC_Code_4_Digit))[1].sic4_description,
																 Codes.Key_SIC4(keyed(sic4_code = L.Second_SIC_Code[1..4]))[1].sic4_description,
																 Codes.Key_SIC4(keyed(sic4_code = L.Third_SIC_Code[1..4]))[1].sic4_description,
																 Codes.Key_SIC4(keyed(sic4_code = L.Fourth_SIC_Code[1..4]))[1].sic4_description,
																 Codes.Key_SIC4(keyed(sic4_code = L.Fifth_SIC_Code[1..4]))[1].sic4_description,
																 Codes.Key_SIC4(keyed(sic4_code = L.Sixth_SIC_Code[1..4]))[1].sic4_description);
  end;

	iesp.share.t_CodeMap xform_demo5600_naic(recordof(exp_recs_dedup) L, integer C) := transform
		self.Code        := choose(C,L.Primary_NAICS_Code,
																 L.Second_NAICS_Code,
																 L.Third_NAICS_Code,
																 L.Fourth_NAICS_Code);
																 
	  self.Description := choose(C,Codes.Key_NAICS(keyed(naics_code = L.Primary_NAICS_Code))[1].naics_description,
															 	 Codes.Key_NAICS(keyed(naics_code = L.Second_NAICS_Code))[1].naics_description,
																 Codes.Key_NAICS(keyed(naics_code = L.Third_NAICS_Code))[1].naics_description,
																 Codes.Key_NAICS(keyed(naics_code = L.Fourth_NAICS_Code))[1].naics_description);
	end;
	
	iesp.bizcredit.t_BizCreditExecutive xform_exec(recordof(exp_recs_dedup) L) := transform
		self.Name  := iesp.ECL2ESP.SetName(L.fname,L.mname,L.lname,L.name_suffix,L.title);
	  self.Title	:= L.executive_title;
	end;
	
	format_amount(string sign, string amount) := function
			return(IF(sign='-',sign+amount,amount));
	end;
	
	iesp.bizcredit.t_BizCreditDemographic5600 xform_demo_5600(recordof(exp_recs_dedup) L) := transform
		// Create a dataset from the 6 siccode fields.
		self.SICs                  := normalize(dataset(L),iesp.Constants.BIZ_CREDIT.MAX_SIC,
		                                        xform_demo5600_sic(left, counter));
		// Create a dataset from the 4 naiccode fields.
		self.NAICs                 := normalize(dataset(L),iesp.Constants.BIZ_CREDIT.MAX_NAIC,
		                                        xform_demo5600_naic(left, counter));
	  self.YearsInBusiness       := L.Years_in_Business_Desc;
		self.YearBusinessStarted	 := L.Year_Business_Started;
	  self.Sales                 := L.Annual_Sales_Size_Desc;
	  self.SalesEstimated        := format_amount(L.Estimated_Annual_Sales_Amount_Sign,L.Estimated_Annual_Sales_Amount);
	  self.EmployeeSize          := L.Employee_Size_Desc;
	  self.EmployeeSizeActual    := (integer) L.Estimated_Number_of_Employees;
	  self.Location              := L.Location_Desc;
		self.ExecutiveCount				 := (integer) L.Executive_Count;
		self.Executives						 := PROJECT(L,xform_exec(left));
	  self.BusinessType          := L.Business_Type_Desc;
	  self.OwnerType             := L.Ownership_Code_Desc;
		self.CottageIndicator		 	 := L.Cottage_Indicator_Desc;
		self.NonProfitIndicator		 := L.NonProfit_Indicator_Desc;
		self := [];
  end;

	iesp.bizcredit.t_BizCreditDerogatory xform_derogatory(recordof(exp_recs_dedup) L) := transform
		self.Indicator  								:= L.Derogatory_Indicator;
	  self.FiledDate									:= iesp.ECL2ESP.toDatestring8(L.Recent_Derogatory_Filed_Date);
		self.LiabilityAmount 						:= format_amount(L.Derogatory_Liability_Amount_Sign,L.Derogatory_Liability_Amount);
		self.TotalNumberDerogatoryItems := (integer) L.Number_of_Derogatory_Legal_Items;
		self.TotalNumberLegalItems 			:= (integer) L.Number_of_Legal_Items;
		self.TotalLegalBalanceAmount 		:= format_amount(L.Legal_Balance_Sign,L.Legal_Balance_Amount);
	end;
	
	iesp.bizcredit.t_BizCreditBankruptcyTotal xform_bankruptcy(recordof(exp_recs_dedup) L) := transform
		self.FiledLast9Years9Months			:= L.Bankruptcy_filed;
		self.Filed  										:= (integer) L.BKC006;
		self.FiledLast24Months					:= (integer) L.BKC007;
	  self.NonFiled										:= (integer) L.BKC008;
		self.NonSatisfiedLast24Months		:= (integer) L.BKO009;
		self.LiabilityBalanceFiled 			:= format_amount(L.BKB001_Sign,L.BKB001);
		self.LiabilityBalanceNonFiled 	:= format_amount(L.BKB003_Sign,L.BKB003);
		self.MonthsSinceLastFiling 			:= (integer) L.BKO010;
		self.MonthsSinceLastNonFiling 	:= (integer) L.BKO011;
		self.PaymentReceived						:= (L.PMTKBankruptcy = 'Y');
	end;
	
	iesp.bizcredit.t_BizCreditJudgmentTotal xform_judgment(recordof(exp_recs_dedup) L) := transform
		self.Filed  										:= (integer) L.JDC010;
		self.FiledLast24Months					:= (integer) L.JDC011;
	  self.NonFiled										:= (integer) L.JDC012;
		self.LiabilityAmountFiled				:= L.JDB004;
		self.LiabilityAmountFiledLast24Months	:= L.JDB005;
		self.LiabilityAmountNonFiled 		:= L.JDB006;
		self.MonthsSinceLastFiling 			:= (integer) L.JDO013;
		self.MonthsSinceLastNonFiling 	:= (integer) L.JDO014;
		self.JudgmentAmount							:= L.JDB002;
		self.PercentJudgmentAmountToTradeBalance := L.JDP016;
		self.PaymentReceived						:= (L.PMTKJudgment = 'Y');
	end;

	iesp.bizcredit.t_BizCreditLienTotal xform_lien(recordof(exp_recs_dedup) L) := transform
		self.Filed  										:= (integer) L.TXC010;
		self.FiledLast24Months					:= (integer) L.TXC011;
	  self.LiabilityAmount						:= format_amount(L.TXB004_Sign,L.TXB004);
		self.MonthsSinceLastFiling 			:= (integer) L.TXO013;
		self.TaxAmountLast24Months			:= format_amount(L.TXB002_Sign,L.TXB002);
		self.PercentTaxAmountToTradeBalance := L.TXP016;
		self.PaymentReceived						:= (L.PMTKTaxlien = 'Y');
	end;
	
	iesp.bizcredit.t_BizCreditUCCTotal xform_ucc(recordof(exp_recs_dedup) L) := transform
		self.Filed											:= (integer) L.ucc_count;
		self.DetailsFiled								:= (integer) L.UCC001;
		self.SummariesFiled							:= (integer) L.UCC002;
	  self.UnsatisfiedLast24Months		:= (integer) L.UCC003;
		self.DataIndicator							:= L.UCC_Data_Indicator_Desc;
	end;
	
	iesp.bizcredit.t_BizCreditTradeInfo xform_tradeInfo(recordof(exp_recs_dedup) L) := transform
		self.HighestCredit  							:= format_amount(L.Recent_High_Credit_Sign,L.Recent_High_Credit);
		self.MedianCredit									:= format_amount(L.Median_Credit_Amount_Sign,L.Median_Credit_Amount);
	  self.NumberCombinedLines					:= L.Total_Combined_Trade_Lines_Count;
		self.CombinedDaysBeyondTermTotal	:= L.DBT_of_Combined_Trade_Totals;
		self.CombinedBalance							:= L.Combined_Trade_Balance;
		self.NumberAgedLines 							:= L.Aged_Trade_Lines;
		self.TotalAccountBalance 					:= format_amount(L.Total_Account_Balance_Sign,L.Total_Account_Balance);
		self.CombinedAccountBalance 			:= format_amount(L.Combined_Account_Balance_Sign,L.Combined_Account_Balance);
		self.CollectionCount							:= L.Collection_count;
		self.NumberAgedTradesDelinquentCurrent 	:= L.ATC021;
		self.NumberAgedTradesDelinquent1_30 		:= L.ATC022;
		self.NumberAgedTradesDelinquent31_60 		:= L.ATC023;
		self.NumberAgedTradesDelinquent61_90 		:= L.ATC024;
		self.NumberAgedTradesDelinquent91Plus 	:= L.ATC025;
		
		self.DaysBeyondTerm.CreditRating						:= L.Experian_Credit_Rating_Desc;
		self.DaysBeyondTerm.Quarter1AverageDBT			:= L.Quarter_1_Average_DBT;
		self.DaysBeyondTerm.Quarter2AverageDBT			:= L.Quarter_2_Average_DBT;
		self.DaysBeyondTerm.Quarter3AverageDBT			:= L.Quarter_3_Average_DBT;
		self.DaysBeyondTerm.Quarter4AverageDBT			:= L.Quarter_4_Average_DBT;
		self.DaysBeyondTerm.Quarter5AverageDBT			:= L.Quarter_5_Average_DBT;
		self.DaysBeyondTerm.CombinedDBT							:= L.Combined_DBT;
	end;
	
  // main iesp.bizcredit report record transform
  SHARED iesp.bizcredit.t_BizCreditReportRecord toOut (recordof(exp_recs_dedup) L) := transform
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)  //sets all 7 ids and also includes IdValue
	  self.FileNumber                         := L.Experian_Bus_Id;
	  self.BusinessHeader.DateFirstSeen       := iesp.ECL2ESP.toDate(L.dt_first_seen);
	  self.BusinessHeader.DateLastSeen        := iesp.ECL2ESP.toDate(L.dt_last_seen);
    self.BusinessHeader.LastUpdatedDate     := iesp.ECL2ESP.toDatestring8(L.Latest_Reported_Date);
		self.BusinessHeader.FileEstablishDate   := iesp.ECL2ESP.toDatestring8(L.Establish_Date); 
		self.BusinessHeader.YearsInFile					:= L.years_in_file;
		self.BusinessHeader.RecentUpdateDescription		:= L.Recent_Update_Desc;
		self.BusinessHeader.LastActivityDescription 	:= L.Last_Activity_Age_Desc; 
    self.BusinessHeader.BusinessDescription	:= L.Primary_SIC_Code_Industry_Class_Desc;
		self.BusinessHeader.SICCode     				:= L.Primary_SIC_Code_4_Digit;
	  self.BusinessHeader.CompanyName         := L.Company_Name;
		self.BusinessHeader.DBAName         		:= L.Clean_DBA_Name;
		self.BusinessHeader.PhoneNumber					:= L.clean_phone;
		self.BusinessHeader.MSADescription			:= L.MSA_Description;
		self.BusinessHeader.OrigAddress 				:= iesp.ECL2ESP.SetAddress ('','','','','','','',L.city,L.state,L.zip_code,L.zip_plus_4,
																																				L.county_name,'',L.address);
		SELF.BusinessHeader.Address							:= iesp.ECL2ESP.setAddress(
																										L.prim_name,L.prim_range,L.predir,L.postdir,L.addr_suffix,L.unit_desig,
																										L.sec_range,L.v_city_name,L.st,L.zip,L.zip4,L.county_name);
		self.BusinessHeader.URL									:= L.URL;

		self.Demographics5600       := project(L,xform_demo_5600(left));
		self.Derogatory 						:= project(L,xform_derogatory(left));
		self.BankruptcyTotals 			:= project(L,xform_bankruptcy(left));
		self.JudgmentTotals 				:= project(L,xform_judgment(left));
		self.LienTotals 						:= project(L,xform_lien(left));
		self.UCCTotals 							:= project(L,xform_ucc(left));
		self.TradeInfo 							:= project(L,xform_tradeInfo(left));
		self := []; 
  end;

	EXPORT SourceView_Recs := project(exp_recs_dedup, toOut(left));
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);
	
END;

