// Append Experian Update file to current UCC parties
UCC_Party_Append := UCC.File_UCC_Expanded_Party +
                    UCC.File_UCC_Party_Update;

COUNT(UCC_Party_Append);

UCC_Party_Append_Dedup := DEDUP(UCC_Party_Append(NOT Check_Fraudulent_Filing(file_state, orig_filing_num)),
                                rec_code, contrib_num, value_2900, orig_filing_num,
                                experian_rec_type, party_type, orig_name, street_address,
                                city, orig_state, zip_code, insert_date, filed_code,
                                filed_place, ssn, fk_orig_filing_date, fk_document_num,
                                fk_filing_type, fk_filing_date, fk_debtor_orig_st,
                                ALL);
COUNT(UCC_Party_Append_Dedup);

EXPORT UCC_Updated_Party := UCC_Party_Append_Dedup : PERSIST('TEMP::UCC_Updated_Party');