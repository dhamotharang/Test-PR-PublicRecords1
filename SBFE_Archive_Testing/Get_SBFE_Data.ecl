IMPORT Address,BIPV2,BIPV2_Company_Names,Business_Credit,BusinessCredit_Services;   

EXPORT Get_SBFE_Data(DATASET(SBFE_Archive_Testing.Layouts.combinedLayout) ds_in,
                     STRING8 twoYearsAgo) := 
  FUNCTION

    SBFE_Key_Tradeline  := 
      DISTRIBUTE(PULL(
        Business_Credit.Key_tradeline()),
        HASH64(sbfe_contributor_number,contract_account_number));

    SBFE_Key_Collateral :=
      DISTRIBUTE(PULL(
        Business_Credit.Key_Collateral()),
        HASH64(sbfe_contributor_number,contract_account_number));

    ds_inWithContribNum_sbfeDist := 
      DISTRIBUTE(
        ds_in,
        HASH64(sbfe_contributor_number,contract_account_number)):INDEPENDENT; 

    /* ******************************************************************* 
     * Prepare Name Address Variations for the Ult/Org/Sele triples      *
     *********************************************************************/
    Bipv2_commonBase := 
      DISTRIBUTE(PULL(
        BIPV2.CommonBase.DS_BASE),
        HASH64(ultid,orgid,seleid));

    ds_in_Linkids_dist :=
      DISTRIBUTE(
        ds_in(seleid != 0), 
        HASH64(ultid,orgid,seleid));

    // need to dedup because a company could have multiple accounts which would
    // all have the same linkids
    ds_in_LinkIdsDedup := 
      DEDUP(SORT(ds_in_Linkids_dist,ultid,orgid,seleid,LOCAL),
            ultid,orgid,seleid,LOCAL);

    // macro call to get cnp_names for the best records to use for deduping
    BIPV2_Company_Names.functions.mac_go(ds_in_LinkIdsDedup, ds_out, seleid, best_bus_name, false, false);

    ds_out_dist := 
      DISTRIBUTE(
        ds_out,
        HASH64(ultid,orgid,seleid));

    ds_bestNameVar :=
      PROJECT(ds_out_dist, 
        TRANSFORM(SBFE_Archive_Testing.Layouts.nameAddrVarLayout,
                  SELF.prim_range := LEFT.best_prim_range, 
                  SELF.prim_name := LEFT.best_prim_name,
                  SELF.v_city_name := LEFT.best_bus_city,                    
                  SELF.st := LEFT.best_bus_state,                          
                  SELF.zip := LEFT.best_bus_zip,                            
                  SELF.current := TRUE,
                  SELF.company_name_type_derived := SBFE_Archive_Testing.Constants.DERIVED_COMP_LEGAL,
                  SELF.isBest := TRUE,
                  SELF := LEFT, // cnp_name
                  SELF := []
                 ),
           LOCAL
           ):INDEPENDENT;

    ds_NameAddrVariations := 
      JOIN( Bipv2_commonBase, ds_bestNameVar,
            LEFT.ultid  = RIGHT.ultid AND 
            LEFT.orgid  = RIGHT.orgid AND 
            LEFT.seleid = RIGHT.seleid AND
            LEFT.source NOT IN SBFE_Archive_Testing.Constants.SET_EXCLUDED_SOURCES AND 
            LEFT.ingest_status != SBFE_Archive_Testing.Constants.INGEST_OLD,
            TRANSFORM(SBFE_Archive_Testing.Layouts.nameAddrVarLayout,
                      SELF.sortField := 
                        MAP(LEFT.current = TRUE AND 
                            LEFT.dt_last_seen >= (UNSIGNED4)twoYearsAgo AND 
                            LEFT.company_name_type_derived = SBFE_Archive_Testing.Constants.DERIVED_COMP_LEGAL 
                                 => 1,
                            LEFT.current = TRUE AND 
                            LEFT.dt_last_seen >= (UNSIGNED4)twoYearsAgo
                                 => 2,
                            LEFT.current = TRUE AND 
                            LEFT.company_name_type_derived = SBFE_Archive_Testing.Constants.DERIVED_COMP_LEGAL
                                 => 3,
                            LEFT.current = TRUE 
                                 => 4,
                                    5
                           ),
                      SELF := LEFT,
                      SELF := [] // variation fields
                     ),
            LOCAL
          );

    ds_nameAddrVarComb := 
      DISTRIBUTED(
        ds_bestNameVar + ds_NameAddrVariations,
        HASH64(ultid,orgid,seleid));

    ds_nameAddrVarDedup := 
      DEDUP(SORT(ds_nameAddrVarComb,ultid,orgid,seleid,cnp_name,prim_name,prim_range,  
                   v_city_name,st,zip,-isBest,-current,
                   IF(company_name_type_derived = SBFE_Archive_Testing.Constants.DERIVED_COMP_LEGAL, 
                      0, 1), 
                 LOCAL), 
            ultid,orgid,seleid,cnp_name,prim_name,prim_range,v_city_name,st,zip, LOCAL);

    ds_nameAddrVarDedupGrp := 
      TOPN(GROUP(SORT(ds_nameAddrVarDedup(isBest != TRUE ),
                      ultid, orgid, seleid, sortField, 
                      IF(sortField < 3, 
                         dt_first_seen,
                         -dt_last_seen),LOCAL),
                 ultid,orgid,seleid), 
           SBFE_Archive_Testing.Constants.NUM_NAME_ADDR_VARS,ultid,orgid,seleid); 

    SBFE_Archive_Testing.Layouts.nameAddrVarLayout RollRecs(SBFE_Archive_Testing.Layouts.nameAddrVarLayout l, 
                                                            DATASET(SBFE_Archive_Testing.Layouts.nameAddrVarLayout) allRows) := 
      TRANSFORM
        SELF.bus_name_1 := allRows[1].company_name,                    
        SELF.bus_streetaddress_1 := 
          Address.Addr1FromComponents(allRows[1].prim_range, 
                                      allRows[1].predir, 
                                      allRows[1].prim_name,
                                      allRows[1].addr_suffix, 
                                      allRows[1].postdir, 
                                      allRows[1].unit_desig, 
                                      allRows[1].sec_range),                 
        SELF.bus_city_1 := allRows[1].v_city_name,                            
        SELF.bus_state_1 := allRows[1].st,                          
        SELF.bus_zip_1 := allRows[1].zip,                            
        SELF.bus_fein_1 := allRows[1].company_fein,
        SELF.bus_phone10_1 := allRows[1].company_phone,  
        SELF.bus_name_2 := allRows[2].company_name,                    
        SELF.bus_streetaddress_2 := 
          Address.Addr1FromComponents(allRows[2].prim_range, 
                                      allRows[2].predir, 
                                      allRows[2].prim_name,
                                      allRows[2].addr_suffix, 
                                      allRows[2].postdir, 
                                      allRows[2].unit_desig, 
                                      allRows[2].sec_range),                 
        SELF.bus_city_2 := allRows[2].v_city_name,                            
        SELF.bus_state_2 := allRows[2].st,
        SELF.bus_zip_2 := allRows[2].zip,                            
        SELF.bus_fein_2 := allRows[2].company_fein,
        SELF.bus_phone10_2 := allRows[2].company_phone,
        SELF.bus_name_3 := allRows[3].company_name,                    
        SELF.bus_streetaddress_3 := 
          Address.Addr1FromComponents(allRows[3].prim_range, 
                                      allRows[3].predir, 
                                      allRows[3].prim_name,
                                      allRows[3].addr_suffix, 
                                      allRows[3].postdir, 
                                      allRows[3].unit_desig, 
                                      allRows[3].sec_range),                 
        SELF.bus_city_3 := allRows[3].v_city_name,                            
        SELF.bus_state_3 := allRows[3].st,                          
        SELF.bus_zip_3 := allRows[3].zip,                            
        SELF.bus_fein_3 := allRows[3].company_fein,
        SELF.bus_phone10_3 := allRows[3].company_phone,
        SELF.bus_name_4 := allRows[4].company_name,                    
        SELF.bus_streetaddress_4 := 
          Address.Addr1FromComponents(allRows[4].prim_range, 
                                      allRows[4].predir, 
                                      allRows[4].prim_name,
                                      allRows[4].addr_suffix, 
                                      allRows[4].postdir, 
                                      allRows[4].unit_desig, 
                                      allRows[4].sec_range),                 
        SELF.bus_city_4 := allRows[4].v_city_name,                            
        SELF.bus_state_4 := allRows[4].st,                          
        SELF.bus_zip_4 := allRows[4].zip,                            
        SELF.bus_fein_4 := allRows[4].company_fein,
        SELF.bus_phone10_4 := allRows[4].company_phone,
        SELF.bus_name_5 := allRows[5].company_name,                    
        SELF.bus_streetaddress_5 := 
          Address.Addr1FromComponents(allRows[5].prim_range, 
                                      allRows[5].predir, 
                                      allRows[5].prim_name,
                                      allRows[5].addr_suffix, 
                                      allRows[5].postdir, 
                                      allRows[5].unit_desig, 
                                      allRows[5].sec_range),                 
        SELF.bus_city_5 := allRows[5].v_city_name,                            
        SELF.bus_state_5 := allRows[5].st,                          
        SELF.bus_zip_5 := allRows[5].zip,                            
        SELF.bus_fein_5 := allRows[5].company_fein,
        SELF.bus_phone10_5 := allRows[5].company_phone,
        SELF.bus_name_6 := allRows[6].company_name,                    
        SELF.bus_streetaddress_6 := 
          Address.Addr1FromComponents(allRows[6].prim_range, 
                                      allRows[6].predir, 
                                      allRows[6].prim_name,
                                      allRows[6].addr_suffix, 
                                      allRows[6].postdir, 
                                      allRows[6].unit_desig, 
                                      allRows[6].sec_range),                 
        SELF.bus_city_6 := allRows[6].v_city_name,                            
        SELF.bus_state_6 := allRows[6].st,                          
        SELF.bus_zip_6 := allRows[6].zip,                            
        SELF.bus_fein_6 := allRows[6].company_fein,
        SELF.bus_phone10_6 := allRows[6].company_phone,
        SELF.bus_name_7 := allRows[7].company_name,                    
        SELF.bus_streetaddress_7 := 
          Address.Addr1FromComponents(allRows[7].prim_range, 
                                      allRows[7].predir, 
                                      allRows[7].prim_name,
                                      allRows[7].addr_suffix, 
                                      allRows[7].postdir, 
                                      allRows[7].unit_desig, 
                                      allRows[7].sec_range),                 
        SELF.bus_city_7 := allRows[7].v_city_name,                            
        SELF.bus_state_7 := allRows[7].st,                          
        SELF. bus_zip_7 := allRows[7].zip,                            
        SELF.bus_fein_7 := allRows[7].company_fein,
        SELF.bus_phone10_7 := allRows[7].company_phone,
        SELF.bus_name_8 := allRows[8].company_name,                    
        SELF.bus_streetaddress_8 := 
          Address.Addr1FromComponents(allRows[8].prim_range, 
                                      allRows[8].predir, 
                                      allRows[8].prim_name,
                                      allRows[8].addr_suffix, 
                                      allRows[8].postdir, 
                                      allRows[8].unit_desig, 
                                      allRows[8].sec_range),                 
        SELF.bus_city_8 := allRows[8].v_city_name,                            
        SELF.bus_state_8 := allRows[8].st,                          
        SELF.bus_zip_8 := allRows[8].zip,                            
        SELF.bus_fein_8 := allRows[8].company_fein,
        SELF.bus_phone10_8 := allRows[8].company_phone,
        SELF.bus_name_9 := allRows[9].company_name,                    
        SELF.bus_streetaddress_9 := 
          Address.Addr1FromComponents(allRows[9].prim_range, 
                                      allRows[9].predir, 
                                      allRows[9].prim_name,
                                      allRows[9].addr_suffix, 
                                      allRows[9].postdir, 
                                      allRows[9].unit_desig, 
                                      allRows[9].sec_range),                 
        SELF.bus_city_9 := allRows[9].v_city_name,                            
        SELF.bus_state_9 := allRows[9].st,                          
        SELF.bus_zip_9 := allRows[9].zip,                            
        SELF.bus_fein_9 := allRows[9].company_fein,
        SELF.bus_phone10_9 := allRows[9].company_phone,
        SELF := l
      END;

    ds_nmAddrVarsRolled := ROLLUP(ds_nameAddrVarDedupGrp,GROUP,RollRecs(LEFT,ROWS(LEFT)));

    /* ******************************************************************* 
     *           Get SBFE Trade Data                                     *
     *********************************************************************/
    ds_Trades := 
      JOIN(SBFE_Key_Tradeline,ds_inWithContribNum_sbfeDist,
           LEFT.Sbfe_Contributor_Number = RIGHT.Sbfe_Contributor_Number AND
           LEFT.Contract_Account_Number = RIGHT.Contract_Account_Number AND
           LEFT.Account_Type_Reported = RIGHT.Account_Type_Reported AND 
           (LEFT.Cycle_End_Date[1..6] < RIGHT.HistoryDate[1..6] AND 
            LEFT.Cycle_End_Date[1..6] >= ((STRING8)((UNSIGNED)RIGHT.HistoryDate - SBFE_Archive_Testing.Constants.TWO_YEARS_ADJ))[1..6]
           ),
           TRANSFORM(SBFE_Archive_Testing.Layouts.combinedLayout,      
                     SELF.AccountID := RIGHT.AccountID,
                     SELF.AmountOutstanding := LEFT.remaining_balance,
                     SELF.ChargeOffAmount := LEFT.amount_charged_off_by_creditor,
                     SELF.CurrentCreditLimit := LEFT.current_credit_limit,
                     SELF.HiCreditOrOrigLoanAmount := LEFT.highest_credit_used,
                     SELF.OriginalAmount := LEFT.original_credit_limit, 
                     SELF.PastDueAmount := LEFT.past_due_amount,
                     SELF.AccountOpenDate := LEFT.date_account_opened,
                     SELF.ChargeOffDate := LEFT.date_account_was_charged_off,
                     SELF.ChargeOffRecoveryAmount := LEFT.total_charge_off_recoveries_to_date,
                     SELF.AccountClosureDate := LEFT.date_account_closed,
                     SELF.GovernmentGuaranteed := LEFT.government_guarantee_flag,
                     SELF.NumberOfGuarantors := LEFT.number_of_guarantors,
                     SELF.LastPaymentAmount := LEFT.recent_payment_amount,
                     SELF.LastPaymentDate := LEFT.recent_payment_date,
                     SELF.ReportedDate := LEFT.Cycle_End_Date,
                     SELF.Remaining_Balance := LEFT.remaining_balance,
                     SELF.AmtPastDueCycle1 := LEFT.past_due_aging_amount_bucket_1,
                     SELF.AmtPastDueCycle2 := LEFT.past_due_aging_amount_bucket_2,
                     SELF.AmtPastDueCycle3 := LEFT.past_due_aging_amount_bucket_3,
                     SELF.AmtPastDueCycle4 := LEFT.past_due_aging_amount_bucket_4,
                     SELF.AmtPastDueCycle5 := LEFT.past_due_aging_amount_bucket_5,
                     SELF.AmtPastDueCycle6 := LEFT.past_due_aging_amount_bucket_6,
                     SELF.AmtPastDueCycle7 := LEFT.past_due_aging_amount_bucket_7,
                     SELF.PaymentAmountScheduled := LEFT.payment_amount_scheduled,
                     SELF.AccountExpirationDate := LEFT.account_expiration_date,
                     SELF.Cycle_End_Date := LEFT.Cycle_End_Date, 
                     SELF.Date_Account_Closed := LEFT.Date_Account_Closed, 
                     SELF.Date_Account_Opened := LEFT.Date_Account_Opened,
                     SELF.Account_Closure_Basis := LEFT.Account_Closure_Basis, 
                     SELF.Account_Status_1 := LEFT.Account_Status_1, 
                     SELF.Account_Status_2 := LEFT.Account_Status_2, 
                     SELF.Payment_Status_Category := LEFT.Payment_Status_Category,
                     SELF.charge_off_type_indicator := LEFT.charge_off_type_indicator,
                     SELF.GovernmentGuaranteedCategory := LEFT.government_guarantee_category,
                     SELF.payment_interval := LEFT.payment_interval,
                     SELF.version := LEFT.version,
                     SELF.Sbfe_Contributor_Number := RIGHT.Sbfe_Contributor_Number,
                     SELF.Contract_Account_Number := RIGHT.Contract_Account_Number,
                     SELF.Account_Type_Reported := RIGHT.Account_Type_Reported, 
                     SELF := RIGHT,
                     SELF := []
                     ),
           LOCAL);

     // When a trade record is updated for a cycle end date record; a new 
     // row is added with a new version date -- the follow ensures we are always
     // using the latest record
     // Added acctno to the sort to ensure that duplicate company names with 
     // different account numbers keep distinct results
     ds_Trades_sorted := 
       SORT(ds_Trades,acctno,Sbfe_Contributor_Number, Contract_Account_Number,
                      account_type_reported,
                      -Cycle_End_Date,-version, LOCAL);

						// grouping the accounts together (sbfe contrib#, act# & type) for the following rollup
      // used to calculate the two sets of history payments (previous 12 months, and 13-24 months)
      // Each month is used in a calculation for the status for the 12-month string representing the 
      // payment status for the respective year.
      ds_trades_group := 
        GROUP(ds_Trades_sorted,acctno,Sbfe_Contributor_Number, Contract_Account_Number,
                               account_type_reported, LOCAL);

						SBFE_Archive_Testing.Layouts.combinedLayout calculate_History(SBFE_Archive_Testing.Layouts.combinedLayout l, 
                                                                    DATASET(SBFE_Archive_Testing.Layouts.combinedLayout) allRows) := 
        TRANSFORM
          twelveMonthsBack := SBFE_Archive_Testing.Functions.getDate_xMonthsBack(l.HistoryDate, SBFE_Archive_Testing.Constants.MONTHS.TWELVE);
          twentyFourMonthsBack := SBFE_Archive_Testing.Functions.getDate_xMonthsBack(l.HistoryDate, SBFE_Archive_Testing.Constants.MONTHS.TWENTY_FOUR);
          SELF.PaymentHistory12MonthsText := 
            SBFE_Archive_Testing.Functions.getPaymentHistory(allRows(Cycle_End_Date[1..6] >= twelveMonthsBack[1..6]), 
                                                              SBFE_Archive_Testing.Constants.MONTHS.TWELVE, 
                                                              l.HistoryDate),  
          SELF.PaymentHistory24MonthsText := 
            SBFE_Archive_Testing.Functions.getPaymentHistory(allRows(Cycle_End_Date[1..6] >= twentyFourMonthsBack[1..6]  AND 
                                                                     Cycle_End_Date[1..6] < twelveMonthsBack[1..6]), 
                                                                     SBFE_Archive_Testing.Constants.MONTHS.TWENTY_FOUR,
                                                                     (STRING8)twelveMonthsBack), 
          SELF := l;  // keep the information from the most recent record
          SELF := [];
        END;

						ds_tradesWithHistoryText := ROLLUP(ds_trades_group,GROUP,calculate_History(LEFT,ROWS(LEFT)));
      ds_tradesWithHistoryText_dist := 
        DISTRIBUTE(
          ds_tradesWithHistoryText,
          HASH64(sbfe_contributor_number,contract_account_number)); 

      ds_tradesWithColl_org  := 
        JOIN(SBFE_Key_Collateral,ds_tradesWithHistoryText_dist,
             LEFT.Sbfe_Contributor_Number = RIGHT.Sbfe_Contributor_Number AND
             LEFT.Contract_Account_Number = RIGHT.Contract_Account_Number AND
             LEFT.Account_Type_Reported = RIGHT.Account_Type_Reported,
             TRANSFORM(SBFE_Archive_Testing.Layouts.combinedLayout,      
                       SELF.dt_vendor_last_reported := LEFT.dt_vendor_last_reported,
                       SELF.CollateralIndicator := CASE(LEFT.collateral_indicator, 
                                                        SBFE_Archive_Testing.Constants.YES => SBFE_Archive_Testing.Constants.SECURED,
                                                        SBFE_Archive_Testing.Constants.NO => SBFE_Archive_Testing.Constants.UNSECURED,
                                                               ''),
             SELF := RIGHT),
             RIGHT OUTER,
             LOCAL);    

      ds_tradesWithColl  := 
        DEDUP(SORT(ds_tradesWithColl_org,
                   acctno,Sbfe_Contributor_Number,Contract_Account_Number,
                   Account_Type_Reported,-dt_vendor_last_reported,LOCAL),
               acctno,Sbfe_Contributor_Number,Contract_Account_Number,
               Account_Type_Reported,LOCAL);    

      ds_RecsWithLookupFields := 
        PROJECT(ds_tradesWithColl,
          TRANSFORM(SBFE_Archive_Testing.Layouts.combinedLayout,
                    SELF.AccountComments1 := SBFE_Archive_Testing.Functions.getAcctComment(LEFT.Account_Status_1),
                    SELF.AccountTypeReportedCode := SBFE_Archive_Testing.Functions.getAcctTypeReported(LEFT.account_type_reported),
                    SELF.AccountStatus := 
                      BusinessCredit_Services.Functions.fn_CurrentAccountStatus (LEFT.Date_Account_Closed , LEFT.Payment_Status_Category),
                    SELF.ChargeOffType := SBFE_Archive_Testing.Functions.getChargeOffValue	(LEFT.charge_off_type_indicator),
                    SELF.GovernmentGuaranteedCategory := SBFE_Archive_Testing.Functions.getGovGuaranteeCat(LEFT.GovernmentGuaranteedCategory),
                    SELF.AccountClosureReason := SBFE_Archive_Testing.Functions.getAcctClosureReason(LEFT.Account_Closure_Basis),
                    SELF.PaymentFrequency := SBFE_Archive_Testing.Functions.getPaymentFreq(LEFT.payment_interval),
                    SELF.PaymentStatus :=
                      BusinessCredit_Services.Functions.fn_WorstStatus(LEFT.Date_Account_Closed, 
                                                                       LEFT.Account_Closure_Basis, 
                                                                       LEFT.Account_Status_1, 
                                                                       LEFT.Account_Status_2, 
                                                                       LEFT.Payment_Status_Category);
                    SELF.Contributor := SBFE_Archive_Testing.Functions.getContributorVal(LEFT.sbfe_Contributor_Number),
                    SELF.AccountComments2 := SBFE_Archive_Testing.Functions.getAcctComment(LEFT.Account_Status_2),
                    SELF := LEFT
                   ),
          LOCAL); 

      // combine batch service SBFE records with those records that got a hit in the 
      // BIP header only so those records can have the name/addr variations also
      ds_inRecsAcctnoDist := 
        DISTRIBUTE(
          ds_in,
          HASH64(acctno));
      
      ds_dedup_inRecs_byAcctno :=  
        DEDUP(SORT(ds_inRecsAcctnoDist,acctno,SBFE_Contributor_number, LOCAL),acctno, LOCAL);
    
      ds_sbfeRecs_acctnoDist := DISTRIBUTE(ds_recsWithLookupFields, HASH64(acctno));
      
      // We want to keep only those records from the input file that had a BIP header only hit 
      // or no header (BIP or SBFE) hit at all 
      ds_nonSBFErecs :=
        JOIN(ds_sbfeRecs_acctnoDist,ds_dedup_inRecs_byAcctno,
             LEFT.acctno = RIGHT.acctno,
             TRANSFORM(SBFE_Archive_Testing.Layouts.combinedLayout,
                       SELF := RIGHT),
             LOCAL,
             RIGHT ONLY);

      // The following TRIM on ds_nonSBFErecs removes those records where the header files returned a record
      // with an associated sbfe contributor number & contract number, but there were no associated hits
      // in the trades key within the history date window 
      // We want to keep only those records that had a header only hit and no associated SBFE data
      ds_RecsWithLookups_LinkIdsdist := 
        DISTRIBUTE(
          ds_recsWithLookupFields + ds_nonSBFErecs, 
          HASH64(ultid, orgid, seleid));

      ds_SBFE_withNmAddrVars :=
        JOIN(ds_RecsWithLookups_LinkIdsdist, ds_nmAddrVarsRolled,
             LEFT.ultid = RIGHT.ultid AND
             LEFT.orgid = RIGHT.orgid AND
             LEFT.seleid = RIGHT.seleid,
             TRANSFORM(SBFE_Archive_Testing.Layouts.FinalLayout,
                       SELF.HistoryDate := IF(LEFT.HistoryDate[7..8] = '00',
                                              LEFT.HistoryDate[1..6],
                                              LEFT.HistoryDate),
                       SELF.bus_name_1 := RIGHT.bus_name_1,
                       SELF.bus_streetaddress_1 := RIGHT.bus_streetaddress_1,
                       SELF.bus_city_1 := RIGHT.bus_city_1,
                       SELF.bus_state_1 := RIGHT.bus_state_1,
                       SELF.bus_zip_1 := RIGHT.bus_zip_1,
                       SELF.bus_fein_1 := RIGHT.bus_fein_1,
                       SELF.bus_phone10_1 := RIGHT.bus_phone10_1,
                       SELF.bus_name_2 := RIGHT.bus_name_2,
                       SELF.bus_streetaddress_2 := RIGHT.bus_streetaddress_2,
                       SELF.bus_city_2 := RIGHT.bus_city_2,
                       SELF.bus_state_2 := RIGHT.bus_state_2,
                       SELF.bus_zip_2 := RIGHT.bus_zip_2,
                       SELF.bus_fein_2 := RIGHT.bus_fein_2,
                       SELF.bus_phone10_2 := RIGHT.bus_phone10_2,
                       SELF.bus_name_3 := RIGHT.bus_name_3,
                       SELF.bus_streetaddress_3 := RIGHT.bus_streetaddress_3,
                       SELF.bus_city_3 := RIGHT.bus_city_3,
                       SELF.bus_state_3 := RIGHT.bus_state_3,
                       SELF.bus_zip_3 := RIGHT.bus_zip_3,
                       SELF.bus_fein_3 := RIGHT.bus_fein_3,
                       SELF.bus_phone10_3 := RIGHT.bus_phone10_3,
                       SELF.bus_name_4 := RIGHT.bus_name_4,
                       SELF.bus_streetaddress_4 := RIGHT.bus_streetaddress_4,
                       SELF.bus_city_4 := RIGHT.bus_city_4,
                       SELF.bus_state_4 := RIGHT.bus_state_4,
                       SELF.bus_zip_4 := RIGHT.bus_zip_4,
                       SELF.bus_fein_4 := RIGHT.bus_fein_4,
                       SELF.bus_phone10_4 := RIGHT.bus_phone10_4,
                       SELF.bus_name_5 := RIGHT.bus_name_5,
                       SELF.bus_streetaddress_5 := RIGHT.bus_streetaddress_5,
                       SELF.bus_city_5 := RIGHT.bus_city_5,
                       SELF.bus_state_5 := RIGHT.bus_state_5,
                       SELF.bus_zip_5 := RIGHT.bus_zip_5,
                       SELF.bus_fein_5 := RIGHT.bus_fein_5,
                       SELF.bus_phone10_5 := RIGHT.bus_phone10_5,
                       SELF.bus_name_6 := RIGHT.bus_name_6,
                       SELF.bus_streetaddress_6 := RIGHT.bus_streetaddress_6,
                       SELF.bus_city_6 := RIGHT.bus_city_6,
                       SELF.bus_state_6 := RIGHT.bus_state_6,
                       SELF.bus_zip_6 := RIGHT.bus_zip_6,
                       SELF.bus_fein_6 := RIGHT.bus_fein_6,
                       SELF.bus_phone10_6 := RIGHT.bus_phone10_6,
                       SELF.bus_name_7 := RIGHT.bus_name_7,
                       SELF.bus_streetaddress_7 := RIGHT.bus_streetaddress_7,
                       SELF.bus_city_7 := RIGHT.bus_city_7,
                       SELF.bus_state_7 := RIGHT.bus_state_7,
                       SELF.bus_zip_7 := RIGHT.bus_zip_7,
                       SELF.bus_fein_7 := RIGHT.bus_fein_7,
                       SELF.bus_phone10_7 := RIGHT.bus_phone10_7,
                       SELF.bus_name_8 := RIGHT.bus_name_8,
                       SELF.bus_streetaddress_8 := RIGHT.bus_streetaddress_8,
                       SELF.bus_city_8 := RIGHT.bus_city_8,
                       SELF.bus_state_8 := RIGHT.bus_state_8,
                       SELF.bus_zip_8 := RIGHT.bus_zip_8,
                       SELF.bus_fein_8 := RIGHT.bus_fein_8,
                       SELF.bus_phone10_8 := RIGHT.bus_phone10_8,
                       SELF.bus_name_9 := RIGHT.bus_name_9,
                       SELF.bus_streetaddress_9 := RIGHT.bus_streetaddress_9,
                       SELF.bus_city_9 := RIGHT.bus_city_9,
                       SELF.bus_state_9 := RIGHT.bus_state_9,
                       SELF.bus_zip_9 := RIGHT.bus_zip_9,
                       SELF.bus_fein_9 := RIGHT.bus_fein_9,
                       SELF.bus_phone10_9 := RIGHT.bus_phone10_9,
                       SELF := LEFT),
             LEFT OUTER,
             LOCAL);

      ds_allRecsSorted := SORT(ds_SBFE_withNmAddrVars, acctno, (UNSIGNED)accountId);
// OUTPUT(ds_Trades, NAMED('ds_Trades'));
// OUTPUT(ds_tradesWithHistoryText, NAMED('ds_tradesWithHistoryText'));
// OUTPUT(ds_tradesWithColl_org, NAMED('ds_tradesWithColl_org'));
// OUTPUT(ds_RecsWithLookupFields, NAMED('ds_RecsWithLookupFields'));
// OUTPUT(ds_nonSBFErecs, NAMED('ds_nonSBFErecs'));
OUTPUT(Choosen(DEDUP(SORT(ds_allRecsSorted, acctno),acctno),3000), named('uniqueAccts'));
OUTPUT(COUNT(DEDUP(SORT(ds_allRecsSorted, acctno),acctno)), named('count_uniqueAccts'));


     RETURN ds_allRecsSorted;
  END;