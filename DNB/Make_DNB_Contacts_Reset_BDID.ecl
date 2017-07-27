IMPORT ut, Business_Header, Business_Header_SS, did_add, DNB;

#workunit('name', 'D&B Contacts Base Reset BDID ' + DNB.DNB_Reset_Date);

//************************************************************
// BDID the D&B Contact Records
//************************************************************

DNB_Contacts_Base := DNB.File_DNB_Contacts_Base;

Layout_DNB_Contacts_Temp := record
DNB.Layout_DNB_Contacts_Base;
string34 source_group;
string90  clean_business_name;
end;

Layout_DNB_Contacts_Temp InitDNBContactstoBDID(DNB.Layout_DNB_Contacts_Base l) := transform
self.source_group := if(l.active_duns_number = 'Y', l.duns_number, 'D' + l.duns_number + '-' + l.company_name);
self.clean_business_name := Stringlib.StringToUpperCase(l.company_name);
self := l;
end;

DNB_Contacts_Base_ToBDID := project(DNB_Contacts_Base, InitDNBContactstoBDID(left));


// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(DNB_Contacts_Base_ToBDID, DNB_Contacts_Base_BDID_Init,
                        FALSE, bdid,
                        FALSE, 'D',
                        TRUE, source_group,
                        clean_business_name,
                        company_prim_range, company_prim_name, company_sec_range, company_zip,
                        TRUE, company_phone10,
                        FALSE, fein_field,
						TRUE, source_group)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

DNB_Contacts_Base_BDID_Match := DNB_Contacts_Base_BDID_Init(bdid <> 0);
DNB_Contacts_Base_BDID_NoMatch := DNB_Contacts_Base_BDID_Init(bdid = 0);


Business_Header_SS.MAC_Add_BDID_Flex(DNB_Contacts_Base_BDID_NoMatch,
                                  BDID_Matchset,
                                  clean_business_name,
                                  company_prim_range, company_prim_name, company_zip,
                                  company_sec_range, company_st,
                                  company_phone10, fein_field,
                                  bdid, Layout_DNB_Contacts_Temp,
                                  FALSE, BDID_score_field,
                                  DNB_Contacts_Base_BDID_Rematch)

DNB_Contacts_Base_BDID_All := DNB_Contacts_Base_BDID_Match + DNB_Contacts_Base_BDID_Rematch;

DNB.Layout_DNB_Contacts_Base FormatOutput(Layout_DNB_Contacts_Temp L) := TRANSFORM
SELF := L;
END;

DNB_Contacts_Base_BDID_Out := PROJECT(DNB_Contacts_Base_BDID_All, FormatOutput(LEFT));

//output(DNB_Contacts_Base_BDID_Out,,'BASE::DNB_Contacts_' + DNB.DNB_Reset_Date, overwrite);
ut.MAC_SF_BuildProcess(DNB_Contacts_Base_BDID_Out,'~thor_data400::base::dnb_contacts',do1,2)
do1;
