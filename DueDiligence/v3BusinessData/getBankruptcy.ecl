IMPORT BankruptcyV3, Business_Risk_BIP, DueDiligence;

/*
	Following Keys being used:
      BankruptcyV3.Key_BankruptcyV3_LinkIDs.kFetch2
*/
EXPORT getBankruptcy(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData,
                     DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION


    DEBTOR := 'D';
    EMPTY_STRING_SET := ['', '0'];



    options := DueDiligence.v3Common.DDBusiness.GetBusinessShellOptions(regulatoryAccess);


    rawBankruptcy := BankruptcyV3.Key_BankruptcyV3_LinkIDs.kFetch2(DueDiligence.v3Common.DDBusiness.GetKfetch2LinkIDs(inData),
                                                                    Business_Risk_BIP.Common.SetLinkSearchLevel(options.LinkSearchLevel),
                                                                    0, /*ScoreThreshold --> 0 = Give me everything*/
                                                                    DueDiligence.Constants.MAX_2000,
                                                                    options.KeepLargeBusinesses);


    //add our sequence number to the raw records found for this Business
    businessBankruptcyWithSeq := DueDiligence.v3Common.DDBusiness.AppendSeq(rawBankruptcy, inData, TRUE);
  

    //filter records similar to SmartLinx
    filteredBankruptcyData := businessBankruptcyWithSeq(name_type[1] = DEBTOR AND tmsid != DueDiligence.Constants.EMPTY);



    slimBankruptcy := PROJECT(filteredBankruptcyData, TRANSFORM(DueDiligence.v3Layouts.InternalShared.Bankruptcies,
                                                                SELF.ultID := LEFT.ultID;
                                                                SELF.orgID := LEFT.orgID;
                                                                SELF.seleID := LEFT.seleID;
                                                                SELF.historyDate := LEFT.historyDate;
                                                                SELF.dateFirstSeen := (UNSIGNED4)IF(LEFT.date_first_seen IN EMPTY_STRING_SET, LEFT.date_vendor_first_reported, LEFT.date_first_seen);
                                                                SELF.dateLastSeen := (UNSIGNED4)IF(LEFT.date_last_seen IN EMPTY_STRING_SET, LEFT.date_vendor_last_reported, LEFT.date_last_seen);
                                                                SELF.filingDate := (UNSIGNED4)LEFT.date_filed;
                                                                SELF.disposition := LEFT.disposition;
                                                                SELF.dismissed := StringLib.StringFind(StringLib.StringToUpperCase(LEFT.disposition), 'DISMISS', 1) > 0;
                                                                SELF.caseNumber := LEFT.case_number;
                                                                SELF.tmsid := LEFT.tmsid;
                                                                SELF := [];));


    cleanDates := DueDiligence.Common.CleanDatasetDateFields(slimBankruptcy, 'dateFirstSeen, dateLastSeen, filingDate');
    
    transAfterClean := PROJECT(cleanDates, TRANSFORM(DueDiligence.v3Layouts.InternalShared.Bankruptcies, SELF := LEFT;));
    
    filterData := DueDiligence.CommonDate.FilterRecordsSingleDate(transAfterClean, dateFirstSeen);
    

    uniqueBankruptcies := DEDUP(SORT(filterData, ultID, orgID, seleID, tmsid, caseNumber, -dismissed, -dateFirstSeen, -dateLastSeen, -filingDate), ultID, orgID, seleID, tmsid, caseNumber);



    // OUTPUT(rawBankruptcy, NAMED('rawBankruptcy'));
    // OUTPUT(businessBankruptcyWithSeq, NAMED('businessBankruptcyWithSeq'));
    // OUTPUT(filteredBankruptcyData, NAMED('filteredBankruptcyData'));
    // OUTPUT(slimBankruptcy, NAMED('slimBankruptcy'));
    // OUTPUT(uniqueBankruptcies, NAMED('uniqueBankruptcies'));

    RETURN uniqueBankruptcies;
END;