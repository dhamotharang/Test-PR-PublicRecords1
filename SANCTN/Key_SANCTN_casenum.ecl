Import Data_Services, doxie_files, doxie,ut,lib_stringlib;


fin_sanctn := SANCTN.file_base_incident;
//modified according to bug #50821
SANCTN.layout_SANCTN_incident_clean tr(fin_sanctn l) := transform
self.CASE_NUMBER := lib_stringlib.stringlib.StringtoUpperCase(l.CASE_NUMBER);
self := l;
end;

f_sanctn := project(fin_sanctn,tr(LEFT));

slim_sanctn := record
   f_sanctn.CASE_NUMBER;
   f_sanctn.BATCH_NUMBER;
   f_sanctn.INCIDENT_NUMBER;
end;

tbl_casenum := table(f_sanctn,slim_sanctn,CASE_NUMBER,BATCH_NUMBER,INCIDENT_NUMBER,few);

KeyName 			:= 'thor_data400::key::sanctn::';

export key_sanctn_casenum := index(tbl_casenum(trim(CASE_NUMBER,left,right)<> '')
                                  ,{CASE_NUMBER}
																	,{BATCH_NUMBER,INCIDENT_NUMBER}
																	,Data_Services.Data_location.Prefix('sanctn')+keyname+'casenum_'+doxie.Version_SuperKey);
								  


