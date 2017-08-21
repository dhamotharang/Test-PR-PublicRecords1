


////////////////////////////////  Join MapCreateMasterKeys with mi7.File_references_tables

ds_get_source_UID := join(mi7.MapCreateCaseMasterKeys , File_references_tables,
																		left.SOURCE_UID_C = right.court_id and
																		left.OLD_RECORD_SUPPLIER_CD_C =  right.RECORD_SUPPLIER_CD,
																		LEFT OUTER,lookup);
																																	
//output(ds_get_source_UID);			


Layout_CaseMaster_Offender_key := mi7.Layout_case_master_cp;

Layout_CaseMaster_Offender_key Get_source_UID(ds_get_source_UID L) := TRANSFORM
Self.SOURCE_UID_C := Map(l.prso_source_uid <> '' and l.remarks = '' =>l.prso_source_uid,
                                l.prso_source_uid = '' => trim(l.SOURCE_UID_C) + ': Error: ' + 'Source UID, State, County and District UID Missing ', trim(l.SOURCE_UID_C) + ': Error:  ' +  l.Remarks);
																
SELF.SOURCE_STATE_CD_C := Map(l.prso_source_uid <> '' and l.remarks = '' => l.stat_state_cd, l.SOURCE_STATE_CD_C);
SELF.SOURCE_COUNTY_CD_C := Map(l.prso_source_uid <> '' and l.remarks = '' => l.county_cd, l.SOURCE_COUNTY_CD_C);
SELF.SOURCE_COUNTY_NAME_C := Map(l.prso_source_uid <> '' and l.remarks = '' => l.county_name, l.SOURCE_COUNTY_NAME_C);
SELF.DISTRICT_NAME_UID := Map(l.prso_source_uid <> '' and l.remarks = '' => l.dina_dina_id, l.DISTRICT_NAME_UID);	
SELF := L;
END;

ds_case_master_source_uid_validation := PROJECT(ds_get_source_UID,Get_source_UID(LEFT));


export MapSourceUIDValidation := ds_case_master_source_uid_validation
                        : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::MapSourceUIDValidation');


