IMPORT ut, Business_Header, Business_Header_SS, DID_Add;

UCC_Debtor_Secured_Dist := UCC.UCC_Debtor_Secured_Temp;
UCC_Dropped_Parties_Dist := UCC.UCC_Dropped_Parties;
UCC_Parties_Last_Dist := UCC.UCC_Last_Parties;

COUNT(UCC_Debtor_Secured_Dist);

// Update the Current Flag identifying all records that are part of the last filing
UCC.Layout_UCC_Initial_Party_Master UpdateCurrentFlag(UCC.Layout_UCC_Initial_Party_Master L, UCC.Layout_UCC_Parties_Slim R) := TRANSFORM
SELF.current_flag := IF(R.RecordID <> 0, 'Y', L.current_flag);
SELF := L;
END;

UCC_Parties_Current := JOIN(UCC_Debtor_Secured_Dist,
                            UCC_Parties_Last_Dist,
                            LEFT.file_state = RIGHT.file_state AND
                              LEFT.orig_filing_num = RIGHT.orig_filing_num AND
                              LEFT.party_type = RIGHT.party_type AND
                              ut.CleanCompany(LEFT.name) = RIGHT.name,
                            UpdateCurrentFlag(LEFT, RIGHT),
                            LEFT OUTER,
                            LOCAL);

UCC_Parties_Current_Sort := SORT(UCC_Parties_Current, RecordID, -current_flag, LOCAL);
UCC_Parties_Current_Dedup := DEDUP(UCC_Parties_Current_Sort, RecordID, LOCAL);

COUNT(UCC_Parties_Current_Dedup);
COUNT(UCC_Parties_Current_Dedup(current_flag='Y'));

// Group and keep current on only most recent record
UCC_Parties_Current_Sort_1 := SORT(UCC_Parties_Current_Dedup(current_flag='Y'), file_state, orig_filing_num,
                                    party_type, ut.CleanCompany(name), zip5, prim_name, prim_range, -fk_filing_date, LOCAL);
UCC_Parties_Current_Grpd := GROUP(UCC_Parties_Current_Sort_1, file_state, orig_filing_num,
                                    party_type, ut.CleanCompany(name), zip5, prim_name, prim_range, LOCAL);

UCC.Layout_UCC_Initial_Party_Master ResetCurrentFlag(UCC.Layout_UCC_Initial_Party_Master L, UCC.Layout_UCC_Initial_Party_Master R) := TRANSFORM
SELF.current_flag := IF(L.RecordID = 0, R.current_flag, 'N');
SELF := R;
END;

UCC_Parties_Current_Final := GROUP(ITERATE(UCC_Parties_Current_Grpd, ResetCurrentFlag(LEFT, RIGHT)));

COUNT(UCC_Parties_Current_Final(current_flag='Y'));

// Combine the Orignal, Changed, New, and Dropped Parties
UCC_Parties_Combined_All := UCC_Parties_Current_Dedup(current_flag<>'Y') + UCC_Parties_Current_Final + UCC_Dropped_Parties_Dist;
COUNT(UCC_Parties_Combined_All);

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

UCC_Parties_Combined_BDID := UCC_Parties_BDID_Match + UCC_Parties_BDID_Rematch;

COUNT(UCC_Parties_Combined_BDID(bdid <> 0));

COUNT(UCC_Parties_Combined_BDID(party_type='D'));
COUNT(UCC_Parties_Combined_BDID(party_type<>'D'));

UCC.Layout_UCC_Initial_Party_Master FormatCombined(Layout_UCC_BDID L) := TRANSFORM
SELF := L;
END;

EXPORT UCC_Parties_Combined := PROJECT(UCC_Parties_Combined_BDID, FormatCombined(LEFT)) : PERSIST('TEMP::UCC_Parties_Combined');