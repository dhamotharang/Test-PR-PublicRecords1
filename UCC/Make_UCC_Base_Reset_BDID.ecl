IMPORT ut, Business_Header, Business_Header_SS, DID_Add;

#workunit('name', 'UCC BASE RESET BDID ' + ucc.UCC_Reset_Date);

UCC_Parties_Combined_All := UCC.File_UCC_Debtor_Master + UCC.File_UCC_Secured_Master;

Layout_UCC_BDID := RECORD
UCC.Layout_UCC_Initial_Party_Master;
STRING34 vendor_id;
END;

Layout_UCC_BDID InitForBDID(UCC.Layout_UCC_Initial_Party_Master L) := TRANSFORM
SELF.vendor_id := L.file_state + L.orig_filing_num;
SELF := L;
END;

UCC_Parties_To_BDID := PROJECT(UCC_Parties_Combined_All, InitForBDID(LEFT));


// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(UCC_Parties_To_BDID,UCC_Parties_BDID_Init,
                        FALSE, bdid,
                        FALSE, 'U',
                        FALSE, source_group_field,
                        name,
                        prim_range, prim_name, sec_range, zip5,
                        FALSE, phone_field,
                        FALSE, fein_field,
						TRUE, vendor_id)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

UCC_Parties_BDID_Match := UCC_Parties_BDID_Init(bdid <> 0);
UCC_Parties_BDID_NoMatch := UCC_Parties_BDID_Init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(UCC_Parties_BDID_NoMatch,
                                  BDID_Matchset,
                                  name,
                                  prim_range, prim_name, zip5,
								  sec_range, state,
                                  phone_field, fein_field,
                                  bdid, Layout_UCC_BDID,
                                  FALSE, BDID_score_field,
                                  UCC_Parties_BDID_Rematch)

UCC.Layout_UCC_Initial_Party_Master FormatCombined(Layout_UCC_BDID L) := TRANSFORM
SELF := L;
END;

UCC_Parties_Combined_BDID := PROJECT(UCC_Parties_BDID_Match + UCC_Parties_BDID_Rematch, FormatCombined(LEFT));

COUNT(UCC_Parties_Combined_BDID(bdid <> 0));

// Create UCC_Debtor_Master
OUTPUT(UCC_Parties_Combined_BDID(party_type='D'),,'BASE::UCC_Debtor_Master_' + UCC.UCC_Reset_Date, OVERWRITE);

// Create UCC Secured Master
OUTPUT(UCC_Parties_Combined_BDID(party_type<>'D'),,'BASE::UCC_Secured_Master_' + UCC.UCC_Reset_Date, OVERWRITE);

// Copy other Masters to new Reset Date

OUTPUT(UCC.File_UCC_Expanded_Party,,'BASE::UCC_Expanded_Party_' + UCC.UCC_Reset_Date, OVERWRITE);
OUTPUT(UCC.File_UCC_Expanded_Filing,,'BASE::UCC_Expanded_Filing_' + UCC.UCC_Reset_Date, OVERWRITE);
OUTPUT(UCC.File_UCC_Filing_Events,,'BASE::UCC_Filing_Events_' + UCC.UCC_Reset_Date, OVERWRITE);
OUTPUT(UCC.File_UCC_Filing_Summary,,'BASE::UCC_Filing_Summary_' + UCC.UCC_Reset_Date, OVERWRITE);
OUTPUT(UCC.File_UCC_Filing_Place,,'BASE::UCC_Filing_Place_' + UCC.UCC_Reset_Date, OVERWRITE);