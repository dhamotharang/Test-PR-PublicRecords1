IMPORT ut;

UCC_Parties_Dist := UCC.UCC_Parties_Sequenced;

Layout_UCC_Parties_Slim SlimUCCPartiesRecord(UCC.Layout_UCC_Initial_Party_Master L) := TRANSFORM
SELF.name := ut.CleanCompany(L.name);  // Use Clean Company Name for Determining Adds and Drops
SELF := L;
END;

UCC_Parties_Slim_Dist := PROJECT(UCC_Parties_Dist, SlimUCCPartiesRecord(LEFT));

// Sort and group parties by original filing number and file state.  Grouping makes
// the series of sorts and dedups more efficient
UCC_Parties_Slim_Sort_1 := SORT(UCC_Parties_Slim_Dist, file_state, orig_filing_num, LOCAL);
UCC_Parties_Slim_Grpd := GROUP(UCC_Parties_Slim_Sort_1, file_state, orig_filing_num, LOCAL);

// Dedup to get last Filing Events from Parties by sorting in reverse filing date order
// Use highest event number for date
UCC_Parties_Sort_1 := SORT(UCC_Parties_Slim_Grpd, -fk_filing_date, IF(fk_filing_type<>'', 0, 1),
                            -fk_filing_type);

// First dedup will keep all party records associated with the last filing date and type
UCC_Parties_Dedup_1 := DEDUP(UCC_Parties_Sort_1,
                             (LEFT.fk_filing_date <> RIGHT.fk_filing_date OR
                              LEFT.fk_filing_type <> RIGHT.fk_filing_type));

// Second dedup discards multiple party type - name combinations which result
// from multiple contributors or document filings and keep lowest numbered
// document and contributor with ssn.  Keep unique addresses.
UCC_Parties_Sort_2 := SORT(UCC_Parties_Dedup_1, party_type, name,
                           zip5, prim_range, prim_name, IF(ssn<> '', 0, 1), fk_document_num, contrib_num);
UCC_Parties_Dedup_2 := DEDUP(UCC_Parties_Sort_2, party_type, name, zip5, prim_range, prim_name);

// Third dedup discards blank addresses where name exists with an address
UCC_Parties_Sort_3 := SORT(UCC_Parties_Dedup_2, party_type, name, IF(zip5 <> '', 0, 1));

UCC_Last_Parties_Dedup := GROUP(DEDUP(UCC_Parties_Sort_3,
                             LEFT.party_type = RIGHT.party_type AND
                             LEFT.name = RIGHT.name AND
                             RIGHT.zip5 = ''));

COUNT(UCC_Last_Parties_Dedup);

EXPORT UCC_Last_Parties := UCC_Last_Parties_Dedup : PERSIST('TEMP::UCC_Last_Parties');