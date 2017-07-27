IMPORT ut, Business_Header, Business_header_SS, did_add;
#workunit('name', 'Build Yellow Pages Base ' + yellowpages.YellowPages_Build_Date);

// Combine Yellow Pages with Pseudo_Yellow Pages derived from Gong Business Listings
YellowPages_Base := YellowPages.YellowPages_Base_YP + YellowPages.YellowPages_Base_Gong;

// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(YellowPages_Base, YellowPages_Base_BDID_Init,
                        FALSE, bdid,
                        TRUE, source,
                        FALSE, source_group_field,
                        business_name,
                        prim_range, prim_name, sec_range, zip,
                        TRUE, phone10,
                        FALSE, fein_field)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

YellowPages_Base_BDID_Match := YellowPages_Base_BDID_Init(bdid <> 0);
YellowPages_Base_BDID_NoMatch := YellowPages_Base_BDID_Init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(YellowPages_Base_BDID_NoMatch,
                                  BDID_Matchset,
                                  business_name,
                                  prim_range, prim_name, zip,
                                  sec_range, st,
                                  phone10, fein_field,
                                  bdid, YellowPages.Layout_YellowPages_Base,
                                  FALSE, BDID_score_field,
                                  YellowPages_Base_BDID_Rematch)

YellowPages_Base_BDID_All := YellowPages_Base_BDID_Match + YellowPages_Base_BDID_Rematch;
COUNT(YellowPages_Base_BDID_All(bdid <> 0));

//OUTPUT(YellowPages_Base_BDID_All,,'BASE::YellowPages_' + YellowPages.YellowPages_Build_Date, OVERWRITE);
ut.MAC_SF_BuildProcess(yellowpages_base_bdid_all,'base::YellowPages',do_it,2)

ut.MAC_SK_BuildProcess_v2(yellowpages.key_yellowpages_bdid,'~thor_data400::key::yellowpages_bdid',do_2);

ut.MAC_SK_Move_v2('~thor_data400::key::yellowpages_bdid','Q',do_3,2);


sequential(do_it,do_2,do_3);
