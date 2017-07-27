IMPORT ut, Business_Header, Business_Header_SS, DID_Add;

#workunit('name', 'BusReg Company & Contacts Reset BDID ' + BusReg.BusReg_Reset_Date);

//Assign BDID
Layout_4_BDID := RECORD
BusReg.Layout_BusReg_Company;
UNSIGNED4 fein;
STRING34  company_source_group;
END;

Layout_4_BDID InitForBDID(BusReg.Layout_BusReg_Company L) := TRANSFORM
SELF.fein := MAP(L.co_fei=''=>0,
				 L.co_fei[1]='N'=>0,
				 L.co_fei[3] != '-' => (UNSIGNED4)L.co_fei,
				 (UNSIGNED4)(L.co_fei[1..2] + L.co_fei[4..10]));
SELF.company_source_group := IF(L.filing_num <> '',
                               (STRING34)(trim(L.filing_num)+trim(L.company_name)),
                               '');
SELF := L;
END;

Base_ToBDID := PROJECT(Busreg.File_BusReg_Company, InitForBDID(LEFT));

// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(Base_ToBDID, Base_BDID_Init,
                        FALSE, bdid,
                        FALSE, 'BR',
                        TRUE, company_source_group,
                        company_name,
                        mail_prim_range, mail_prim_name, mail_sec_range, mail_zip,
                        TRUE, company_phone10,
                        TRUE, fein)

// Then do a standard BDID match for the records which did not BDID,
// since the Corporate file may be newer than the Business Headers
BDID_Matchset := ['A'];

Base_BDID_Match := Base_BDID_Init(bdid <> 0);
Base_BDID_NoMatch := Base_BDID_Init(bdid = 0);

Business_Header_SS.MAC_Add_BDID_Flex(Base_BDID_NoMatch,
                                  BDID_Matchset,
                                  company_name,
                                  mail_prim_range, mail_prim_name, mail_zip,
								  mail_sec_range, mail_st,
                                  company_phone10, fein,
                                  bdid, Layout_4_BDID,
                                  FALSE, BDID_score_field,
                                  Base_BDID_Rematch)

Base_BDID_All := Base_BDID_Match + Base_BDID_Rematch;

BusReg.Layout_BusReg_Company FormatOutput(Layout_4_BDID L) := TRANSFORM
SELF := L;
END;

Company_BDID := PROJECT(Base_BDID_All, FormatOutput(LEFT));

// Assign BDIDs
Layout_Company_BDID_List := RECORD
UNSIGNED6 bdid;
UNSIGNED6 br_id; 
END;

Layout_Company_BDID_List InitBDIDList(BusReg.Layout_BusReg_Company L) := TRANSFORM
SELF := L;
END;

Company_BDID_List_Init := PROJECT(Company_BDID(bdid <> 0, br_id <> 0), InitBDIDList(LEFT));
Company_BDID_List_Dedup := DEDUP(Company_BDID_List_Init, br_id, ALL);

Company_BDID_List_Dist := DISTRIBUTE(Company_BDID_List_Dedup, HASH(br_id));
Company_Contacts_DID_Dist := DISTRIBUTE(BusReg.File_BusReg_Contact, HASH(br_id));

BusReg.Layout_BusReg_Contact AssignBDID(BusReg.Layout_BusReg_Contact L, Layout_Company_BDID_List R) := TRANSFORM
SELF.bdid := R.bdid;
SELF := L;
END;

Contacts_BDID := JOIN(Company_Contacts_DID_Dist,
                      Company_BDID_List_Dist,
                      LEFT.br_id = RIGHT.br_id,
                      AssignBDID(LEFT, RIGHT),
                      LEFT OUTER,
                      LOCAL);

OUTPUT(Company_BDID,,'BASE::BusReg_Company_' + Busreg.BusReg_Reset_Date, OVERWRITE);
OUTPUT(Contacts_BDID,,'BASE::BusReg_Contact_' + Busreg.BusReg_Reset_Date, OVERWRITE);