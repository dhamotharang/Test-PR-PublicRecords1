IMPORT address,BusinessCredit_Services,data_services,RiskWise,SBFE_Archive_Testing,STD;

EXPORT ProcessSoapCall(STRING fileNameToProcess, unsigned1 fileNumber,
                       STRING8 today, STRING wuid) := 
  FUNCTION
    
    ds_in := DATASET(fileNameToProcess, SBFE_Archive_Testing.Layouts.CustInputRec, csv(quote('"')));
    
    SBFE_Archive_Testing.Layouts.custInputPlusCounterRec 
      xmf_custInputAddCounter(SBFE_Archive_Testing.Layouts.custInputRec ds_in, 
                              INTEGER in_counter) :=
      TRANSFORM
        SELF.recCounter := in_counter;
        SELF            := ds_in;
      END;
      
    ds_run := ds_in; //CHOOSEN(ds_in,26270); //
    ds_in_withCounter := PROJECT(ds_run, xmf_custInputAddCounter(LEFT, COUNTER)) : INDEPENDENT;
    fileSize := COUNT(ds_run);
    NumGrps := filesize div SBFE_Archive_Testing.Constants.GROUP_SIZE + 1;

    SBFE_Archive_Testing.Layouts.Batch_InputRec xfm_cvsFileToBatch_Input(ds_in_withCounter L, integer cnt) := TRANSFORM
        cleanAddr := 
          Address.fn_AddressCleanBatch(DATASET([{l.Account, 
                                                 l.BizStreetAddress,
                                                 '', l.p_city_name, l.st, l.BizZip}], 
                                                 address.Layout_Batch_In))[1];
        SELF.groupNumber := cnt % NumGrps;
        SELF.acctno := l.Account;
        SELF.comp_name := l.BizName;
        SELF.prim_range := cleanAddr.prim_range;
        SELF.predir := cleanAddr.predir;
        SELF.prim_name := cleanAddr.prim_name;
        SELF.addr_suffix := cleanAddr.addr_suffix;
        SELF.postdir := cleanAddr.postdir;
        SELF.unit_desig := cleanAddr.unit_desig;
        SELF.sec_range := cleanAddr.sec_range;
        SELF.p_city_name := cleanAddr.p_city_name;
        SELF.st := cleanAddr.st;
        SELF.z5 := cleanAddr.zip;
        SELF.zip4 := cleanAddr.zip4;
        SELF.workphone := l.BizPhone;
        SELF.fein := l.fein;	
        SELF := [];
      END;
      
    ds_bizInput := PROJECT(ds_in_withCounter, xfm_cvsFileToBatch_Input (LEFT, COUNTER));
    ds_bizInputGrp := GROUP(SORT(ds_bizInput,groupNumber),groupNumber);

    SBFE_Archive_Testing.Layouts.BatchParent_InputRec RollRecs(SBFE_Archive_Testing.Layouts.Batch_InputRec l, DATASET(SBFE_Archive_Testing.Layouts.Batch_InputRec) allRows) := TRANSFORM
      SELF.ParentGroupNumber := l.groupNumber;
      SELF.BatchRecs := allRows;
    END;

    biz_parent := ROLLUP(ds_bizInputGrp,GROUP,RollRecs(LEFT,ROWS(LEFT)));

    SBFE_Archive_Testing.Layouts.Layout_BatchInput xfm_setBusinessSearchInput(SBFE_Archive_Testing.Layouts.BatchParent_InputRec l) := TRANSFORM
     SELF.Max_Search_Results_Per_Acct := SBFE_Archive_Testing.Constants.MAX_SEARCH_RESULTS_PER_ACCT;
      SELF.Max_Results_Per_Acct := SBFE_Archive_Testing.Constants.MAX_RESULTS_PER_ACCT;
      SELF.BIPFetchLevel := SBFE_Archive_Testing.Constants.FETCH_LEVEL;
      SELF.DataPermissionMask := SBFE_Archive_Testing.Constants.DPM;
      SELF.Include_BusHeader := SBFE_Archive_Testing.Constants.INCLUDE_BIZ_HDR;
      SELF.GLBPurpose := SBFE_Archive_Testing.Constants.GLB;
      SELF.DPPAPurpose := SBFE_Archive_Testing.Constants.DPPA;
      SELF.Batch_In := l.BatchRecs; 
    END;

    SBFE_Archive_Testing.Layouts.OutputLayout xfm_ErrX(SBFE_Archive_Testing.Layouts.Layout_BatchInput l) := TRANSFORM
          SELF.ErrorCode := FAILCODE + ' ' + FAILMESSAGE;
          SELF := l;
          SELF := [];
      END;
    
    ds_soapResults := 
        SOAPCALL(PROJECT(biz_parent,xfm_setBusinessSearchInput(LEFT)), 
                 SBFE_Archive_Testing.Constants.roxieIP,  
                 SBFE_Archive_Testing.Constants.service_name,
                 {PROJECT(biz_parent,xfm_setBusinessSearchInput(LEFT))}, 
                 DATASET(SBFE_Archive_Testing.Layouts.outputLayout),
                 ONFAIL(xfm_ErrX(LEFT))
                );	
    
    ds_inSortedWithCounter := 
      DISTRIBUTE(
        ds_in_withCounter,
        HASH64(account));

    ds_soapResultsSorted :=  
      DISTRIBUTE(
        ds_soapResults,
        HASH64(acctno));
    
    ds_results :=
      JOIN(ds_inSortedWithCounter, ds_soapResultsSorted,
           LEFT.account = RIGHT.acctno,
           TRANSFORM(SBFE_Archive_Testing.Layouts.combinedLayout, 
                     SELF.AccountID := IF(RIGHT.sbfe_Contributor_number != '' AND
                                          RIGHT.contract_account_number != '' AND
                                          RIGHT.account_type_reported != '',
                                          (STRING)HASH(RIGHT.sbfe_Contributor_number +
                                                       RIGHT.contract_account_number +
                                                       RIGHT.account_type_reported),
                                          ''),  // don't calc an accountid if biz header hit only
                     SELF.acctno := LEFT.account, 
                     SELF.HistoryDate := 
                       MAP(LENGTH(TRIM(LEFT.NewHistory,LEFT,RIGHT)) = 6 => TRIM(LEFT.NewHistory,LEFT,RIGHT) + '00',  // YYYYMM - add DD to shift for 1 & 2 yrs back calc
                           TRIM(LEFT.NewHistory,LEFT,RIGHT) != '' => LEFT.NewHistory,  // YYYYMMDD & YYYYMMDDTTT
                           today),
                     SELF.transaction_id := (STRING)wuid + '-' + (STRING)fileNumber + '-' + (STRING)LEFT.RecCounter,
                     SELF.best_bus_name := RIGHT.best_company_name,                    
                     SELF.best_bus_streetaddress1 := Address.Addr1FromComponents(RIGHT.best_prim_range, 
                                                                                 RIGHT.best_predir, 
                                                                                 RIGHT.best_prim_name,
                                                                                 RIGHT.best_addr_suffix, 
                                                                                 RIGHT.best_postdir, 
                                                                                 RIGHT.best_unit_desig, 
                                                                                 RIGHT.best_sec_range),                 
                     SELF.best_prim_range := RIGHT.best_prim_range,
                     SELF.best_prim_name := RIGHT.best_prim_name,
                     SELF.best_bus_city := RIGHT.best_city,                           
                     SELF.best_bus_state := RIGHT.best_state,                          
                     SELF.best_bus_zip := RIGHT.best_zip,                            
                     SELF.best_bus_fein := RIGHT.best_FEIN,
                     SELF.best_bus_phone10 := RIGHT.best_phone,
                     SELF.Account_Type_Reported := RIGHT.Account_Type_Reported,
                     SELF.Sbfe_Contributor_Number := RIGHT.Sbfe_Contributor_Number,
                     SELF.Contract_Account_Number := RIGHT.Contract_Account_Number,
                     SELF := LEFT,
                     SELF := RIGHT,
                     SELF := []
                   ),
            LEFT OUTER,
            LOCAL,
            LIMIT(0),
            KEEP(SBFE_Archive_Testing.Constants.MAX_RESULTS_PER_ACCT));

    RETURN ds_results;
  END;