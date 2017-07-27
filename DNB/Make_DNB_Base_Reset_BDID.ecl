IMPORT ut, Business_Header, Business_Header_SS, did_add;

#workunit('name', 'D&B Base Reset BDID ' + DNB.DNB_Reset_Date);

//************************************************************
// BDID the D&B Records
//************************************************************

DNB_Base := DNB.File_DNB_Base;

Layout_DNB_Temp := record
DNB.Layout_DNB_Base;
string34 source_group;
string90  clean_business_name;
end;

Layout_DNB_Temp InitDBNtoBDID(DNB.Layout_DNB_Base l) := transform
self.source_group := if(l.active_duns_number = 'Y', l.duns_number, 'D' + l.duns_number + '-' + stringlib.stringtouppercase(l.business_name));
self.clean_business_name := if(l.trade_style = '' or (l.trade_style <> '' and l.parent_duns_number = '' and l.ultimate_duns_number = ''),
                                Stringlib.StringToUpperCase(l.business_name),
                                Stringlib.StringToUpperCase(l.trade_style));
self := l;
end;

DNB_Base_ToBDID := project(DNB_Base, InitDBNtoBDID(left));


// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(DNB_Base_ToBDID, DNB_Base_BDID_Init,
                        FALSE, bdid,
                        FALSE, 'D',
                        TRUE, source_group,
                        clean_business_name,
                        prim_range, prim_name, sec_range, zip,
                        TRUE, telephone_number,
                        FALSE, fein_field,
						TRUE, source_group)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

DNB_Base_BDID_Match := DNB_Base_BDID_Init(bdid <> 0);
DNB_Base_BDID_NoMatch := DNB_Base_BDID_Init(bdid = 0);


Business_Header_SS.MAC_Add_BDID_Flex(DNB_Base_BDID_NoMatch,
                                  BDID_Matchset,
                                  clean_business_name,
                                  prim_range, prim_name, zip,
                                  sec_range, st,
                                  telephone_number, fein_field,
                                  bdid, Layout_DNB_Temp,
                                  FALSE, BDID_score_field,
                                  DNB_Base_BDID_Rematch)

DNB_Base_BDID_All := DNB_Base_BDID_Match + DNB_Base_BDID_Rematch;

DNB.Layout_DNB_Base FormatOutput(Layout_DNB_Temp L) := TRANSFORM
SELF := L;
END;

DNB_Base_BDID_Out := PROJECT(DNB_Base_BDID_All, FormatOutput(LEFT));

//output(DNB_Base_BDID_Out,,'BASE::DNB_Companies_' + DNB.DNB_Reset_Date, overwrite);
ut.MAC_SF_BuildProcess(dnb_base_bdid_out,'~thor_data400::base::dnb_companies',do1,2);
do1;
