import ut, Business_Header, Business_Header_SS, did_add,mdr;

#workunit('name', 'D&B Companies Base Creation ' + DNB.version);

companies_in := DNB.File_DNB_Base_In;

DNB_Base_Init := project(companies_in(delete_record_indicator=''), DNB.TRA_Format_Input(left));
DNB_Base_Init_Dist := distribute(DNB_Base_Init, hash(duns_number));

// Process delete records
layout_delete_list := record
companies_in.duns_number;
end;

DNB_Delete_List := table(companies_in(delete_record_indicator<>''), layout_delete_list);
DNB_Delete_List_Dist := distribute(DNB_Delete_List, hash(duns_number));
DNB_Delete_List_Sort := sort(DNB_Delete_List_Dist, duns_number, local);
DNB_Delete_List_Dedup := dedup(DNB_Delete_List_Sort, duns_number, local);

DNB.Layout_DNB_Base_Temp UpdateDelete(DNB.Layout_DNB_Base_Temp l, layout_delete_list r) := transform
self.active_duns_number := if(r.duns_number <> '', 'N', l.active_duns_number);
self := l;
end;

DNB_Base_Updated := join(DNB_Base_Init_Dist,
                         DNB_Delete_List_Dedup,
                         left.duns_number = right.duns_number,
                         UpdateDelete(left, right),
                         left outer,
                         local);

//************************************************************
// Group and Iterate to Set Current/Historical Indicator
//************************************************************

// Record Type has been initialized to historical 'H'
DNB_Base_Updated_Sort := sort(DNB_Base_Updated, duns_number, local);
DNB_Base_Updated_Grpd := group(DNB_Base_Updated_Sort, duns_number, local);
DNB_Base_Updated_Grpd_Sort := sort(DNB_Base_Updated_Grpd, -date_last_seen, -date_first_seen);

DNB.Layout_DNB_Base_Temp SetRecordType(DNB.Layout_DNB_Base_Temp l, DNB.Layout_DNB_Base_Temp r) := transform
self.record_type := if(l.record_type = '' and r.active_duns_number = 'Y', 'C', r.record_type);
self := r;
END;

DNB_Base_ToBDID := group(iterate(DNB_Base_Updated_Grpd_Sort, SetRecordType(left, right)));

// First do a direct source match to the current Business Headers
Business_Header.MAC_Source_Match(DNB_Base_ToBDID, DNB_Base_BDID_Init,
                        FALSE, bdid,
                        FALSE, MDR.sourceTools.src_Dunn_Bradstreet,
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
                                  bdid, DNB.Layout_DNB_Base_Temp,
                                  FALSE, BDID_score_field,
                                  DNB_Base_BDID_Rematch)

DNB_Base_BDID_All := DNB_Base_BDID_Match + DNB_Base_BDID_Rematch;

DNB.Layout_DNB_Base FormatOutput(DNB.Layout_DNB_Base_Temp L) := TRANSFORM
SELF := L;
END;

DNB_Base_BDID_Out := PROJECT(DNB_Base_BDID_All, FormatOutput(LEFT));

//output(DNB_Base_BDID_Out,,'BASE::DNB_Companies_' + DNB.version, overwrite);
ut.MAC_SF_BuildProcess(DNB_Base_BDID_Out,'~thor_data400::base::dnb_companies',do1,2);
do1;
