IMPORT Business_Header, Business_Header_SS, DID_Add, ut, FBN;

#workunit ('name', 'Build FBN_' + FBN.FBN_Build_Date);

FBN_Enhanced := FBN.FBN_enhance2;
COUNT(FBN_Enhanced);

Layout_FBN_BDID := RECORD
FBN.Layout_FBN;
STRING34 vendor_id;
END;

// Remove Bad Data based on bad key list
Layout_FBN_BDID SelectFBN(FBN.Layout_FBN L, FBN.Layout_Key_List R) := TRANSFORM
SELF.vendor_id := L.file_st + L.filing_num + L.filing_dt;
SELF := L;
END;

FBN_Base_ToBDID := JOIN(FBN_Enhanced,
                        FBN.File_FBN_Bad_Key_List,
                        LEFT.file_st = RIGHT.file_st AND
                          LEFT.filing_num = RIGHT.filing_num AND
                          LEFT.filing_dt = RIGHT.filing_dt,
                        SelectFBN(LEFT, RIGHT),
                        LEFT ONLY,
                        LOOKUP);

COUNT(FBN_Base_ToBDID);

// BDID the Companies
// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(FBN_Base_ToBDID, FBN_Base_BDID_Init,
                        FALSE, bdid,
                        FALSE, 'F',
                        FALSE, source_group_field,
                        display_name,
                        prim_range, prim_name, sec_range, zip5,
                        TRUE, phone10,
                        FALSE, fein_field,
						TRUE, vendor_id)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

FBN_Base_BDID_Match := FBN_Base_BDID_Init(bdid <> 0);
FBN_Base_BDID_NoMatch := FBN_Base_BDID_Init(bdid = 0);


Business_Header_SS.MAC_Add_BDID_Flex(FBN_Base_BDID_NoMatch,
                                  BDID_Matchset,
                                  display_name,
                                  prim_range, prim_name, zip5,
								  sec_range, st,
                                  phone10, fein_field,
                                  bdid, Layout_FBN_BDID,
                                  FALSE, BDID_score_field,
                                  FBN_Base_BDID_Rematch)

FBN.Layout_FBN FormatFBN(Layout_FBN_BDID L) := TRANSFORM
SELF := L;
END;

FBN_Base_BDID_All := PROJECT(FBN_Base_BDID_Match + FBN_Base_BDID_Rematch, FormatFBN(LEFT));

//OUTPUT(FBN_Base_BDID_All,,'BASE::FBN_' + FBN.FBN_Build_Date, OVERWRITE);
ut.MAC_SF_BuildProcess(fbn_base_bdid_all,'~thor_data400::base::fbn',do1,2);
do1;
