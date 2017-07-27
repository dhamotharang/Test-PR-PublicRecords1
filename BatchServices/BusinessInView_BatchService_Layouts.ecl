import iesp;
export BusinessInView_BatchService_Layouts := module

export EFX_batch_input := record
	
	STRING30  acctno;
	STRING120 comp_name;
	STRING10  prim_range;
	STRING2   predir;
	STRING28  prim_name;
	STRING4   addr_suffix;
	STRING2   postdir;
	STRING10  unit_desig;
	STRING8   sec_range;
	STRING25  p_city_name;
	STRING2   st;
	STRING5   z5;
	STRING4   zip4;
	STRING3   mileradius;
	STRING16  workphone;
	STRING9   fein;
	STRING15  bdid;
	STRING3   max_results;
	unsigned8   seq := 0;
	STRING9		duns_num;
	
end;

//intermediate layouts;

export layout_header_in := record
		STRING20   acctno;
		qSTRING120 comp_name;
		qSTRING10  prim_range;
		qSTRING2   predir;
		qSTRING28  prim_name;
		qSTRING4   addr_suffix;
		qSTRING2   postdir;
		qSTRING10  unit_desig;
		qSTRING8   sec_range;
		qSTRING25  p_city_name;
		qSTRING2   st;
		qSTRING5   z5;
		qSTRING4   zip4;
		qSTRING3   mileradius;
		qSTRING16  workphone;
		qSTRING9   fein;
		qSTRING15  bdid;
		qSTRING3   max_results;
	end;						

	
	export layout_input_gateway :=  record
	  layout_header_in;
		qSTRING9	duns_num;
		STRING85  urlBusHeader;
		string39  FAX;
		string11  Ticker_Symbol;
		string12  Net_Worth;
		string15  SalesBusHeader;
		string9   feinBusHeader;
		boolean   includebusinesscreditrisk;
	  boolean   includebusinessfailurerisklevel;
	  boolean   includecustombcir;		
		integer count_ucc; 
		integer count_jandl;
		integer count_bk;		
		qSTRING120 In_comp_name;
		qSTRING10  In_prim_range;
		qSTRING2   In_predir;
		qSTRING28  In_prim_name;
		qSTRING4   In_addr_suffix;
		qSTRING2   In_postdir;
		qSTRING10  In_unit_desig;
		qSTRING8   In_sec_range;
		qSTRING25  In_p_city_name;
		qSTRING2   In_st;
		qSTRING5   In_z5;
		qSTRING4   In_zip4;
		qSTRING3   In_mileradius;
		qSTRING16  In_workphone;
		qSTRING9   In_fein;
		qSTRING15  in_bdid;
		qSTRING9   in_duns_num;
		
	end;

export Final_layout := record
  string30  acctno;
	string120 CompanyName;
	string120 UltimateParent; // company name
	
	string60 PrimAddrStreetAddress1;	
	string25 PrimAddrCity;
	string2 PrimAddrState;	
	string10 PrimAddrPostalCode;

	string    RecentSinceDate;
	STRING50  url;
	string10 phone;
	STRING9   fein;	
	string39  FAX;
	string11  Ticker_Symbol;
	string12  Net_Worth;
	string15  Sales; 	//in dollar amounts.
	unsigned4 count_ucc; 
	unsigned4 count_jandL; 
	unsigned4 count_bk;
	// each of next 3 DS numerations will need to match the value of the constants associated
	// with each group.  Inquiries  -- iesp.Constants.INVIEW_EQUIFAX.INV_INQUIRIES_MAX_COUNT
  string InqueriesDate1;
	string InqueriesIndustry1;
	string InqueriesDate2;
	string InqueriesIndustry2;
	string InqueriesDate3;
	string InqueriesIndustry3;
	string InqueriesDate4;
	string InqueriesIndustry4;
	string InqueriesDate5;
	string InqueriesIndustry5;
	string InqueriesDate6;
	string InqueriesIndustry6;

 // iesp.Constants.INVIEW_EQUIFAX.INV_ALERTS_MAX_COUNT
	integer AlertCode1;
	string  AlertDescription1;
	integer AlertCode2;
	string  AlertDescription2;
	integer AlertCode3;
	string  AlertDescription3;
	integer AlertCode4;
	string  AlertDescription4;
	integer AlertCode5;
	string  AlertDescription5;
	integer AlertCode6;
	string  AlertDescription6;
	
  // iesp.Constants.INVIEW_EQUIFAX.INV_EFX_AVGDBTS_MAX_COUNT
	string AvgDBTsdateDBT1;
	integer AvgDBTsDBT1;
	string AvgDBTsdateDBT2;
	integer AvgDBTsDBT2;
	string AvgDBTsdateDBT3;
	integer AvgDBTsDBT3;
	string AvgDBTsdateDBT4;
	integer AvgDBTsDBT4;
	string AvgDBTsdateDBT5;
	integer AvgDBTsDBT5;
	string AvgDBTsdateDBT6;
	integer AvgDBTsDBT6;
	
	string YearsInBusiness;
	string YearStarted; 

	integer NumberOfActiveTrades; 
	integer CurrentCreditLimitTotals; 
	integer HiCreditOrOrigLoanAmtTotals; 
	integer BalanceTotals;
	integer PastDueAmtTotals; 
	integer NewDelinquencies; 
	integer NewAccounts; 
	integer NewInquiries; 
	integer NewUpdates; 
	integer NumberOfAccounts; 
	integer NumberOfChargeOffs;
	string  CreditActiveSince;
	integer TotalPastDue;
	string  MostSevereStatus;
	integer HighestCredit; 
	integer TotalExposure; 
	integer AverageOpenBalance;
	integer MedianBalance; 
	string  MostSevereStatus24Months; 
	string  AcctOpen;
	string  NewAcctClosed;
	string  NonChargeOffDel; 
	string  NewChargeOffAmt; 
	string  NewMostSevStatus; 
	string  HiCreditExt36Mo; 
	string  NumClosed; 
	string  NewChargeOffAccts;

	string ChargeOffAmtCurrency;
	string ChargeOffAmtContent;
	string TotBalCurrency;
	string TotBalContent;
	string BalDueCurrency;
	string BalDueContent;
  string AtRiskBalCurrency;
	string AtRiskBalContent;
	
	integer OpenTotalPastDue; 
	integer NewHiCreditExt;
	integer NewNonChargeOffDel;
	// the next DS numerations will need to match the value of constants associated
	// with the line below this. iesp.Constants.INVIEW_EQUIFAX.INV_DECISIONTOOLS_MAX_COUNT
	string ScoreName_1;
	string score_1 ;
	string reasonCode1_1 ;
	string reasonScore1_1 ;
	string reasonContent1_1;
	string reasonCode1_2;
	string reasonScore1_2;
	string reasonContent1_2;
	string reasonCode1_3;
  string reasonScore1_3;
	string reasonContent1_3;
	string reasonCode1_4;
  string reasonScore1_4;
	string reasonContent1_4;
	string reasonCode1_5;
  string reasonScore1_5;
	string reasonContent1_5;
	string reasonCode1_6;
	string reasonScore1_6;
	string reasoncontent1_6;
	
	string ScoreName_2;
	string score_2 ;
	string reasonCode2_1 ;
	string reasonScore2_1 ;
	string reasonContent2_1;
	string reasonCode2_2;
	string reasonScore2_2;
	string reasonContent2_2;
	string reasonCode2_3;
  string reasonScore2_3;
	string reasonContent2_3;
	string reasonCode2_4;
  string reasonScore2_4;
	string reasonContent2_4;
	string reasonCode2_5;
  string reasonScore2_5;
	string reasonContent2_5;
	string reasonCode2_6;
	string reasonScore2_6;
	string reasoncontent2_6;
	//
	qSTRING120 In_comp_name;
	qSTRING10  In_prim_range;
	qSTRING2   In_predir;
	qSTRING28  In_prim_name;
	qSTRING4   In_addr_suffix;
	qSTRING2   In_postdir;
	qSTRING10  In_unit_desig;
	qSTRING8   In_sec_range;
	qSTRING25  In_p_city_name;
	qSTRING2   In_st;
	qSTRING5   In_z5;
	qSTRING4   In_zip4;
	qSTRING3   In_mileradius;
	qSTRING16  In_workphone;
	qSTRING9   In_fein;
	qSTRING15  in_bdid;
	qSTRING9   in_duns_num;
end;

export t_InviewReportRequest_acctno := record
  string30 acctno;
	STRING50  urlBusHeader;
	STRING9   feinBusHeader;	
	string39  FAX;
	string11  Ticker_Symbol;
	string12  Net_Worth;
	string15  SalesBusHeader; 
	integer count_ucc;
	integer  count_jandL; 
	integer  count_bk;
	iesp.gateway_inviewreport.t_InviewReportRequest;
	
	qSTRING120 In_comp_name;
		qSTRING10  In_prim_range;
		qSTRING2   In_predir;
		qSTRING28  In_prim_name;
		qSTRING4   In_addr_suffix;
		qSTRING2   In_postdir;
		qSTRING10  In_unit_desig;
		qSTRING8   In_sec_range;
		qSTRING25  In_p_city_name;
		qSTRING2   In_st;
		qSTRING5   In_z5;
		qSTRING4   In_zip4;
		qSTRING3   In_mileradius;
		qSTRING16  In_workphone;
		qSTRING9   In_fein;
		qSTRING15  in_bdid;
		qSTRING9   in_duns_num;
		
end;

export t_InviewReportResponse_acctno := record
  string30 acctno;
	STRING50  urlBusHeader;
	STRING9   feinBusHeader;	
	string39  FAX;
	string11  Ticker_Symbol;
	string12  Net_Worth;
	string15  SalesBusHeader; 
	integer count_ucc;
	integer count_jandL; 
	integer  count_bk;
	iesp.gateway_inviewreport.t_inviewReportResponse;
	qSTRING120 In_comp_name;
		qSTRING10  In_prim_range;
		qSTRING2   In_predir;
		qSTRING28  In_prim_name;
		qSTRING4   In_addr_suffix;
		qSTRING2   In_postdir;
		qSTRING10  In_unit_desig;
		qSTRING8   In_sec_range;
		qSTRING25  In_p_city_name;
		qSTRING2   In_st;
		qSTRING5   In_z5;
		qSTRING4   In_zip4;
		qSTRING3   In_mileradius;
		qSTRING16  In_workphone;
		qSTRING9   In_fein;
		qSTRING15  in_bdid;
		qSTRING9   in_duns_num;
end;

end;

