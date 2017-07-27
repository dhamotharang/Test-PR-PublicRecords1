// Exclude Bad Oklahoma Filings until new file is processed
UCC_Filings_Dist := DISTRIBUTE(UCC.UCC_Updated_Filing_Fixed(UCC.Check_Valid_State_Filing_Date(file_state, filing_date)),
                    HASH(file_state, orig_filing_num));

// Project File to Filing Event Format
UCC.Layout_UCC_Event InitFilingEvents(UCC.Layout_UCC_Expanded_Filing L) := TRANSFORM
SELF.contrib_num1 := L.contrib_num;
SELF.contrib_num2 := '';
SELF.contrib_num3 := '';
SELF.filed_place := '';
SELF.debtor_change := 'N';
SELF.secured_change := 'N';
SELF := L;
END;

// Include all filing events, including original
UCC_Filing_Events_Init := PROJECT(UCC_Filings_Dist, InitFilingEvents(LEFT));

// Dedup Identical Filing Events with Different Contributor Numbers
UCC_Filing_Events_Sort := SORT(UCC_Filing_Events_Init, file_state, orig_filing_num,
                                 filing_date, orig_filing_date, filing_type, document_num, -collateral_code, contrib_num1, LOCAL);

UCC.Layout_UCC_Event RollupFilingEvents(UCC.Layout_UCC_Event L, UCC.Layout_UCC_Event R) := TRANSFORM
SELF.contrib_num1 := IF(L.contrib_num1 = '',
                        R.contrib_num1,
                        L.contrib_num1);
SELF.contrib_num2 := IF(L.contrib_num1 <> ''
                          AND L.contrib_num2 = ''
                          AND L.contrib_num1 <> R.contrib_num1,
                        R.contrib_num1,
                        L.contrib_num2);
SELF.contrib_num3 := IF(L.contrib_num2 <> ''
                          AND L.contrib_num3 = ''
                          AND L.contrib_num1 <> R.contrib_num1
                          AND L.contrib_num2 <> R.contrib_num1,
                        R.contrib_num1,
                        L.contrib_num3);

SELF := L;
END;

UCC_Filing_Events_Rollup := ROLLUP(UCC_Filing_Events_Sort,
                                   LEFT.file_state = RIGHT.file_state AND
                                   LEFT.orig_filing_num = RIGHT.orig_filing_num AND
                                     LEFT.filing_date = RIGHT.filing_date AND
                                     LEFT.orig_filing_date = RIGHT.orig_filing_date AND
                                     LEFT.filing_type = RIGHT.filing_type AND
                                     LEFT.document_num = RIGHT.document_num,
                                    RollupFilingEvents(LEFT, RIGHT),
                                    LOCAL);

COUNT(UCC_Filing_Events_Rollup);

// Add filed place information
Layout_UCC_Party_Slim := RECORD
STRING2   file_state;
STRING18  orig_filing_num;
STRING15  filed_place;
STRING8   fk_orig_filing_date;
STRING18  fk_document_num;
STRING4   fk_filing_type;
STRING8   fk_filing_date;
END;

Layout_UCC_Party_Slim SlimParties(UCC.Layout_UCC_Expanded_Party L) := TRANSFORM
SELF := L;
END;


UCC_Party_Slim := PROJECT(UCC.UCC_Updated_Party_Fixed, SlimParties(LEFT));
UCC_Party_Slim_Dedup := DEDUP(UCC_Party_Slim, file_state, orig_filing_num, fk_filing_date,
                                fk_orig_filing_date, fk_filing_type,  fk_filing_type, fk_document_num, ALL);

UCC_Party_Slim_Dist := DISTRIBUTE(UCC_Party_Slim_Dedup, HASH(file_state, orig_filing_num));

UCC.Layout_UCC_Event UpdateFiledPlace(UCC.Layout_UCC_Event L, Layout_UCC_Party_Slim R) := TRANSFORM
SELF.filed_place := R.filed_place;
SELF := L;
END;

UCC_Filing_Events_Place := JOIN(UCC_Filing_Events_Rollup,
                                UCC_Party_Slim_Dist,
                                LEFT.file_state = RIGHT.file_state AND
                                  LEFT.orig_filing_num = RIGHT.orig_filing_num AND
                                  LEFT.filing_date = RIGHT.fk_filing_date AND
                                  LEFT.orig_filing_date = RIGHT.fk_orig_filing_date AND
                                  LEFT.filing_type = RIGHT.fk_filing_type AND
                                  LEFT.document_num = RIGHT.fk_document_num,
                                UpdateFiledPlace(LEFT, RIGHT),
                                LEFT OUTER,
                                LOCAL);

COUNT(UCC_Filing_Events_Place);

EXPORT UCC_Filing_Events_Temp := UCC_Filing_Events_Place : PERSIST('TEMP::UCC_Filing_Events_Temp');