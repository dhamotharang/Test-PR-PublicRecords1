// Query to compare UCC Court Codes for overlap between business_credit_old_code and
// lds_new court code

COUNT(UCC.File_UCC_Court_Codes(TRUE));

UCC_Court_Codes_New := UCC.File_UCC_Court_Codes(lds_new_court_code <> '',
                         business_credit_old_code <> lds_new_court_code);

COUNT(UCC_Court_Codes_New);

// Include all old codes
UCC_Court_Codes_Old := UCC.File_UCC_Court_Codes(business_credit_old_code <> '');

COUNT(UCC_Court_Codes_Old);


// First Dedup new codes to determine if there are duplicates
UCC_Court_Codes_New_Dedup := DEDUP(UCC_Court_Codes_New, lds_new_court_code, ALL);

COUNT(UCC_Court_Codes_New_Dedup);

// Next Dedup old codes to determine if there are duplicates
UCC_Court_Codes_Old_Dedup := DEDUP(UCC_Court_Codes_New, business_credit_old_code, ALL);

COUNT(UCC_Court_Codes_Old_Dedup);

// Now determine any overlap using inner join of old to new
UCC.Layout_UCC_Court_Codes CheckOverlap(UCC.Layout_UCC_Court_Codes L, UCC.Layout_UCC_Court_Codes R) := TRANSFORM
SELF := R;
END;

UCC_Court_Codes_Overlap := JOIN(UCC_Court_Codes_Old,
                                UCC_Court_Codes_New,
                                (STRING15)LEFT.business_credit_old_code = RIGHT.lds_new_court_code,
                                CheckOverlap(LEFT, RIGHT));

// This count should be 0 if there is no overlap
COUNT(UCC_Court_Codes_Overlap);