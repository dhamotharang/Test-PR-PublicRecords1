IMPORT AutoKeyI, iesp, LNSmallBusiness, risk_indicators, Seed_Files, STD;

EXPORT getCorteraTestSeedData (	DATASET(LNSmallBusiness.BIP_Layouts.Input) inRecs,
											          STRING20 dataset_name):= 
FUNCTION
 
  // -----------------------------------------------------------------------------------------
  // ---------------------- LN-Only (Cortera) B2B Trade Seed Data ----------------------------
  // -----------------------------------------------------------------------------------------
 
  getHashValue( LNSmallBusiness.BIP_Layouts.Input inRec ) := 
    Seed_Files.Hash_InstantID(STD.Str.ToUpperCase(TRIM(inRec.Rep_1_First_Name)),   // fname,
                              STD.Str.ToUpperCase(TRIM(inRec.Rep_1_Last_Name)),    // lname,
                              risk_indicators.nullstring,                          // ssn -- not used in business products,
                              STD.Str.ToUpperCase(TRIM(inRec.Bus_FEIN)),           // fein,
                              STD.Str.ToUpperCase(TRIM(inRec.Bus_Zip)), // zip,
                              STD.Str.ToUpperCase(TRIM(inRec.Bus_Phone10)),        // phone,
                              STD.Str.ToUpperCase(TRIM(inRec.Bus_Company_Name)));  // company_name);

  
  ds_corteraResults := 
    JOIN(inRecs, Seed_Files.BusinessCreditReport_keys.CorteraB2B,
         KEYED(dataset_name = RIGHT.dataset_name AND 
               getHashValue(LEFT) = RIGHT.hashvalue),
      TRANSFORM(RIGHT),
      INNER, KEEP(1), ATMOST(2)  
     );
 
  iesp.businesscreditreport.t_BusinessCreditTradeSummary getCorteraTradeSummary() := 
  TRANSFORM
    SELF.OpenAccountsCount := ds_corteraResults[1].tradesumm_openaccountscount;
    SELF.AccountOpenDate := iesp.ECL2ESP.toDatestring8(ds_corteraResults[1].tradesumm_accountopendate);
    SELF.TotalOverdue := ds_corteraResults[1].tradesumm_totaloverdue;
    SELF.MostSevereStatus := ds_corteraResults[1].tradesumm_mostseverestatus;
    SELF.HighestCredit := ds_corteraResults[1].tradesumm_highestcredit;
    SELF.TotalCurrentExposure := ds_corteraResults[1].tradesumm_totalcurrentexposure;
    SELF.MedianBalance := ds_corteraResults[1].tradesumm_medianbalance;
    SELF.AvgOpenBalance := ds_corteraResults[1].tradesumm_avgopenbalance;
    SELF.ChargeOffRecorded := ds_corteraResults[1].tradesumm_chargeoffrecorded;
    SELF.AccountsWithGuarantor := ds_corteraResults[1].tradesumm_accountswithguarantor;
  END;
  ds_tradeSummary :=  ROW(getCorteraTradeSummary());

  iesp.businesscreditreport.t_BusinessCreditPaymentSummary getCorteraCurPmtSummary() := 
  TRANSFORM
    SELF.TotalCurrentExposure := ds_corteraResults[1].currpaysumm_totalcurrentexposure;
	  SELF.WithinTermsPercent := ds_corteraResults[1].currpaysumm_withintermspercent;
	  SELF.PastDueAgingAmount01to30Percent := ds_corteraResults[1].currpaysumm_pastdueagingamount01to30percent;
	  SELF.PastDueAgingAmount31to60Percent := ds_corteraResults[1].currpaysumm_pastdueagingamount31to60percent;
	  SELF.PastDueAgingAmount61to90Percent := ds_corteraResults[1].currpaysumm_pastdueagingamount61to90percent;
	  SELF.PastDueAgingAmount91PlusPercent := ds_corteraResults[1].currpaysumm_pastdueagingamount91pluspercent;  
  END;
  ds_corteraCurPmtSummary :=  ROW(getCorteraCurPmtSummary());

  iesp.smallbusinessbipcombinedreport.t_DatedPaymentSummaryEx getCorteraPmtSummaryEx() := 
  TRANSFORM
    SELF.TotalCurrentExposure := ds_corteraResults[1].paysumm_totalcurrentexposure;
    SELF.WithinTermsPercent := ds_corteraResults[1].paysumm_withintermspercent;
    SELF.PastDueAgingAmount01to30Percent := ds_corteraResults[1].paysumm_pastdueagingamount01to30percent;
    SELF.PastDueAgingAmount31to60Percent := ds_corteraResults[1].paysumm_pastdueagingamount31to60percent;
    SELF.PastDueAgingAmount61to90Percent := ds_corteraResults[1].paysumm_pastdueagingamount61to90percent;
    SELF.PastDueAgingAmount91PlusPercent := ds_corteraResults[1].paysumm_pastdueagingamount91pluspercent;   
    SELF.DateReported := iesp.ECL2ESP.toDatestring8(ds_corteraResults[1].paysumm_datereported);
    SELF.ProviderCount := ds_corteraResults[1].paysumm_providercount;
    SELF.WithinTermsTotal := ds_corteraResults[1].paysumm_withintermstotal;
    SELF.PastDueAgingAmount01to30Total := ds_corteraResults[1].paysumm_pastdueagingamount01to30total;
    SELF.PastDueAgingAmount31to60Total := ds_corteraResults[1].paysumm_pastdueagingamount31to60total;
    SELF.PastDueAgingAmount61to90Total := ds_corteraResults[1].paysumm_pastdueagingamount61to90total;
    SELF.PastDueAgingAmount91PlusTotal := ds_corteraResults[1].paysumm_pastdueagingamount91plustotal;
  END;
  ds_corteraPmtSummaryEx := ROW(getCorteraPmtSummaryEx());

  iesp.smallbusinessbipcombinedreport.t_DatedPaymentSummary getCorteraPmt24MthHist() := 
  TRANSFORM
    SELF.TotalCurrentExposure := ds_corteraResults[1].pay24mth_totalcurrentexposure;
    SELF.WithinTermsPercent := ds_corteraResults[1].pay24mth_withintermspercent;
    SELF.PastDueAgingAmount01to30Percent := ds_corteraResults[1].pay24mth_pastdueagingamount01to30percent;
    SELF.PastDueAgingAmount31to60Percent := ds_corteraResults[1].pay24mth_pastdueagingamount31to60percent;
    SELF.PastDueAgingAmount61to90Percent := ds_corteraResults[1].pay24mth_pastdueagingamount61to90percent;
    SELF.PastDueAgingAmount91PlusPercent := ds_corteraResults[1].pay24mth_pastdueagingamount91pluspercent;
    SELF.DateReported := iesp.ECL2ESP.toDatestring8(ds_corteraResults[1].pay24mth_datereported);
  END;
  ds_corteraPmt24MthHist := ROW(getCorteraPmt24MthHist());

  iesp.smallbusinessbipcombinedreport.t_SegmentPaymentSummary getCorteraIndustrySegments(Seed_Files.BusinessCreditReport_keys.CorteraB2B L, INTEGER C) := 
  TRANSFORM
    SELF.IndustrySegment := CHOOSE(C,L.industryseg1_industrysegment,L.industryseg2_industrysegment);
    SELF.ProviderCount := CHOOSE(C,L.industryseg1_providercount,L.industryseg2_providercount);
    SELF.AverageBalance := CHOOSE(C,L.industryseg1_averagebalance,L.industryseg2_averagebalance);
    SELF.AverageDBT := CHOOSE(C,L.industryseg1_averagedbt,L.industryseg2_averagedbt);
    SELF.HighestBalance := CHOOSE(C,L.industryseg1_highestbalance,L.industryseg2_highestbalance);
    SELF.PastDueAgingAmount31to60Percent := CHOOSE(C,L.industryseg1_pastdueagingamount31to60percent,
                                                     L.industryseg2_pastdueagingamount31to60percent);
    SELF.PastDueAgingAmount61to90Percent := CHOOSE(C,L.industryseg1_pastdueagingamount61to90percent,
                                                     L.industryseg2_pastdueagingamount61to90percent);
    SELF.PastDueAgingAmount91PlusPercent := CHOOSE(C,L.industryseg1_pastdueagingamount91pluspercent,
                                                     L.industryseg2_pastdueagingamount91pluspercent);
  END;
  ds_corteraIndustrySegments := NORMALIZE(ds_corteraResults, 2, getCorteraIndustrySegments(LEFT, COUNTER));


  iesp.smallbusinessbipcombinedreport.t_AccountPaymentHistory xfm_acctPmtHist(STRING12 inTotalCurrentExposure,
                                                                              STRING3  inWithinTermsTotal,
                                                                              STRING3  inPastDueAgingAmount01to30Percent,
                                                                              STRING3  inPastDueAgingAmount31to60Percent,
                                                                              STRING3  inPastDueAgingAmount61to90Percent,
                                                                              STRING3  inPastDueAgingAmount91PlusPercent,
                                                                              STRING8  inDateReported) := 
  TRANSFORM
                                                                              
    SELF.DateReported := iesp.ECL2ESP.toDatestring8(inDateReported);
    SELF.TotalCurrentExposure := inTotalCurrentExposure;
    SELF.WithinTermsTotal := inWithinTermsTotal;
    SELF.PastDueAgingAmount01to30Total := inPastDueAgingAmount01to30Percent;
    SELF.PastDueAgingAmount31to60Total := inPastDueAgingAmount31to60Percent;
    SELF.PastDueAgingAmount61to90Total := inPastDueAgingAmount61to90Percent;
    SELF.PastDueAgingAmount91PlusTotal := inPastDueAgingAmount91PlusPercent;
  END;

  fn_getAcctDetailPmtHist(Seed_Files.BusinessCreditReport_keys.CorteraB2B L, INTEGER C) := 
  FUNCTION
    ds_acctDetPmtHist := CHOOSE(C,(DATASET([xfm_AcctPmtHist(L.AcctDet1_1_TotalCurrentExposure,
                                                            L.AcctDet1_1_WithinTermsTotal,
                                                            L.AcctDet1_1_PastDueAgingAmount01to30Percent,
                                                            L.AcctDet1_1_PastDueAgingAmount31to60Percent,
                                                            L.AcctDet1_1_PastDueAgingAmount61to90Percent,
                                                            L.AcctDet1_1_PastDueAgingAmount91PlusPercent,
                                                            L.AcctDet1_1_DateReported)]) 
                                   + 
                                   DATASET([xfm_acctPmtHist(L.AcctDet1_2_TotalCurrentExposure,
                                                            L.AcctDet1_2_WithinTermsTotal,
                                                            L.AcctDet1_2_PastDueAgingAmount01to30Percent,
                                                            L.AcctDet1_2_PastDueAgingAmount31to60Percent,
                                                            L.AcctDet1_2_PastDueAgingAmount61to90Percent,
                                                            L.AcctDet1_2_PastDueAgingAmount91PlusPercent,
                                                            L.AcctDet1_2_DateReported)]))
                                  ,
                                  (DATASET([xfm_AcctPmtHist(L.AcctDet2_1_TotalCurrentExposure,
                                                            L.AcctDet2_1_WithinTermsTotal,
                                                            L.AcctDet2_1_PastDueAgingAmount01to30Percent,
                                                            L.AcctDet2_1_PastDueAgingAmount31to60Percent,
                                                            L.AcctDet2_1_PastDueAgingAmount61to90Percent,
                                                            L.AcctDet2_1_PastDueAgingAmount91PlusPercent,
                                                            L.AcctDet2_1_DateReported)]) 
                                   + 
                                   DATASET([xfm_acctPmtHist(L.AcctDet2_2_TotalCurrentExposure,
                                                            L.AcctDet2_2_WithinTermsTotal,
                                                            L.AcctDet2_2_PastDueAgingAmount01to30Percent,
                                                            L.AcctDet2_2_PastDueAgingAmount31to60Percent,
                                                            L.AcctDet2_2_PastDueAgingAmount61to90Percent,
                                                            L.AcctDet2_2_PastDueAgingAmount91PlusPercent,
                                                            L.AcctDet2_2_DateReported)])));    
    RETURN ds_acctDetPmtHist;                                         
  END;

  iesp.smallbusinessbipcombinedreport.t_B2BTradeAcctDetail xfm_getCorteraTradeAcctDetail(Seed_Files.BusinessCreditReport_keys.CorteraB2B L, INTEGER C) := 
  TRANSFORM
    SELF.AccountNo  := CHOOSE(C,L.acctdet1_accountno,L.acctdet2_accountno);
    SELF.Status  := CHOOSE(C,L.acctdet1_status,L.acctdet2_status);
    SELF.IndustrySegment := CHOOSE(C,L.acctdet1_industrysegment,L.acctdet2_industrysegment);
    SELF.DateReported := iesp.ECL2ESP.toDatestring8(CHOOSE(C,L.acctdet1_accountdatereported,
                                                             L.acctdet2_accountdatereported));
    SELF.AmountOutstanding := CHOOSE(C,L.acctdet1_amountoutstanding,L.acctdet2_amountoutstanding); 
    SELF.paymentHistory := fn_getAcctDetailPmtHist(L, C);
  END;
  ds_corteraTradeAcctDetail := NORMALIZE(ds_corteraResults, 2, xfm_getCorteraTradeAcctDetail(LEFT, COUNTER));

  iesp.smallbusinessbipcombinedreport.t_B2BTradeData getB2BTradeData:= 
  TRANSFORM
    // temp pending test seed update
    SELF.RecentTradeDate := iesp.ECL2ESP.toDatestring8(ds_corteraResults[1].recenttradedate);
    SELF.TradeSummary := ds_tradeSummary;
    SELF.CurrentPaymentSummary := ds_corteraCurPmtSummary;
    SELF.PaymentSummary := ds_corteraPmtSummaryEx;
    SELF.Payment24MonthHistory := ds_corteraPmt24MthHist;
    SELF.IndustrySegments := ds_corteraIndustrySegments;
    SELF.AccountDetails := ds_corteraTradeAcctDetail;
    SELF.StatusCode := '0';     // StatusCode 0 indicates successful data hit
    SELF.StatusDescription := '';  // only needed with "no hit" 
  END;

  iesp.smallbusinessbipcombinedreport.t_B2BTradeData getBlankTradesData:= 
  TRANSFORM
    SELF.RecentTradeDate := ROW([], iesp.share.t_Date);
    SELF.TradeSummary := ROW([],iesp.businesscreditreport.t_BusinessCreditTradeSummary);
    SELF.CurrentPaymentSummary := ROW([],iesp.businesscreditreport.t_BusinessCreditPaymentSummary);
    SELF.PaymentSummary := ROW([],iesp.smallbusinessbipcombinedreport.t_DatedPaymentSummaryEx);
    SELF.Payment24MonthHistory := ROW([],iesp.smallbusinessbipcombinedreport.t_DatedPaymentSummary);
    SELF.IndustrySegments := DATASET([],iesp.smallbusinessbipcombinedreport.t_SegmentPaymentSummary);
    SELF.AccountDetails := DATASET([],iesp.smallbusinessbipcombinedreport.t_B2BTradeAcctDetail);
    SELF.StatusCode := (STRING)AutoKeyI.errorcodes._codes.NO_RECORDS;
    SELF.StatusDescription := 'No Tradeline Data Available';  
  END;

  ds_B2BTradeData := IF(~EXISTS(ds_corteraResults) OR TRIM(ds_corteraResults[1].statuscode, LEFT, RIGHT) = '301',
                         DATASET([getBlankTradesData]),
                         DATASET([getB2BTradeData]));
 
  RETURN ds_B2BTradeData;

END;