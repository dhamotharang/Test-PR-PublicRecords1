// Append Experian Update file to current UCC Filings
UCC_Filing_Append := UCC.File_UCC_Expanded_Filing +
                     UCC.File_UCC_Filing_Update;

COUNT(UCC_Filing_Append);

UCC_Filing_Append_Dedup := DEDUP(UCC_Filing_Append(NOT Check_Fraudulent_Filing(file_state, orig_filing_num)),
                                 rec_code, contrib_num, value_2900, orig_filing_num,
                                 experian_rec_type, filing_type, document_num, filing_date,
                                 orig_filing_date, collateral_code, fk_debtor_orig_st,
                                 ALL);
COUNT(UCC_Filing_Append_Dedup);

EXPORT UCC_Updated_Filing := UCC_Filing_Append_Dedup : PERSIST('TEMP::UCC_Updated_Filing');