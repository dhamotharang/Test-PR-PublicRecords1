// Create the master UCC Filing Place table from the UCC Court Codes and locations
// Should validate there is no overlap in file before building this file with
// UCC.Query_UCC_Court_Codes

UCC_Court_Codes_New := UCC.File_UCC_Court_Codes(lds_new_court_code <> '',
                         business_credit_old_code <> lds_new_court_code);
COUNT(UCC_Court_Codes_New);

// Include all old code records
UCC_Court_Codes_Old := UCC.File_UCC_Court_Codes(business_credit_old_code <> '');
COUNT(UCC_Court_Codes_Old);

UCC.Layout_UCC_Filing_Place InitCourtCodesNew(UCC.Layout_UCC_Court_Codes L) := TRANSFORM
SELF.filing_place_id := L.lds_new_court_code;
SELF := L;
END;

UCC.Layout_UCC_Filing_Place InitCourtCodesOld(UCC.Layout_UCC_Court_Codes L) := TRANSFORM
SELF.filing_place_id := L.business_credit_old_code;
SELF := L;
END;

UCC_Filing_Place_New := PROJECT(UCC_Court_Codes_New, InitCourtCodesNew(LEFT));
UCC_Filing_Place_Old := PROJECT(UCC_Court_Codes_Old, InitCourtCodesOld(LEFT));

UCC_Filing_Place_Old_New := UCC_Filing_Place_Old + UCC_Filing_Place_New;

UCC_Filing_Place_Dedup := DEDUP(UCC_Filing_Place_Old_New, filing_place_id, ALL);

COUNT(UCC_Filing_Place_Dedup);

EXPORT UCC_Filing_Place := UCC_Filing_Place_Dedup : PERSIST('TEMP::UCC_Filing_Place');