IMPORT BankruptcyV3, DueDiligence;


/*
	Following Keys being used:
      BankruptcyV3.key_bankruptcyV3_did
      BankruptcyV3.key_bankruptcyv3_search_full_bip
*/
EXPORT getBankruptcy(DATASET(DueDiligence.v3Layouts.InternalPerson.SlimPersonDetails) inData) := FUNCTION

    DEBTOR := 'D';    
    EMPTY_STRING_SET := ['', '0'];


    bankKeys := JOIN(inData, BankruptcyV3.key_bankruptcyV3_did(FALSE),
                      KEYED(LEFT.inquiredDID = RIGHT.did),
                      TRANSFORM(DueDiligence.v3Layouts.InternalShared.Bankruptcies,
                                SELF.did := LEFT.inquiredDID;
                                SELF.tmsid := RIGHT.tmsid;
                                SELF.historyDate := LEFT.historyDate;
                                SELF := [];),
                      ATMOST(DueDiligence.Constants.MAX_1000));
                                  
                                  
    bankcruptyDetails := JOIN(bankKeys, BankruptcyV3.key_bankruptcyv3_search_full_bip(FALSE),
                               LEFT.tmsid <> DueDiligence.Constants.EMPTY AND
                               KEYED(LEFT.tmsid = RIGHT.tmsid) AND
                               RIGHT.name_type[1] = DEBTOR,
                               TRANSFORM(DueDiligence.v3Layouts.InternalShared.Bankruptcies,
                                          SELF.dateFirstSeen := (UNSIGNED4)IF(RIGHT.date_first_seen IN EMPTY_STRING_SET, RIGHT.date_vendor_first_reported, RIGHT.date_first_seen);
                                          SELF.dateLastSeen := (UNSIGNED4)IF(RIGHT.date_last_seen IN EMPTY_STRING_SET, RIGHT.date_vendor_last_reported, RIGHT.date_last_seen);
                                          SELF.filingDate := (UNSIGNED4)RIGHT.date_filed;
                                          SELF.disposition := RIGHT.disposition;
                                          SELF.dismissed := StringLib.StringFind(StringLib.StringToUpperCase(RIGHT.disposition), 'DISMISS', 1) > 0;
                                          SELF.caseNumber := RIGHT.case_number;
                                          SELF := LEFT;),
                               ATMOST(DueDiligence.Constants.MAX_1000));
                               
                               
                          
    cleanDates := DueDiligence.Common.CleanDatasetDateFields(bankcruptyDetails, 'dateFirstSeen, dateLastSeen, filingDate');
    
    transAfterClean := PROJECT(cleanDates, TRANSFORM(DueDiligence.v3Layouts.InternalShared.Bankruptcies, SELF := LEFT;));
    
    filterData := DueDiligence.CommonDate.FilterRecordsSingleDate(transAfterClean, dateFirstSeen);
    
    

    uniqueBankruptcies := DEDUP(SORT(filterData, did, tmsid, caseNumber, -dismissed, -dateFirstSeen, -dateLastSeen, -filingDate), did, tmsid, caseNumber);



    // OUTPUT(bankKeys, NAMED('bankKeys'));
    // OUTPUT(bankcruptyDetails, NAMED('bankcruptyDetails'));
    // OUTPUT(uniqueBankruptcies, NAMED('uniqueBankruptcies'));

    RETURN uniqueBankruptcies;
END;