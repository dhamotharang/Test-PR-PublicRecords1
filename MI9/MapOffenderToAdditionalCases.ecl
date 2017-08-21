

import crim_common;
import crim_cp_ln;
import hygenics_soff;

Layout_Case_Master_and_soff_out_main := RECORD
CM_CASE_NUM := MapPrimOffenderToCaseMaster.CASE_NUM_C ;
INTEGER ecl_cade_id;
hygenics_soff.Layout_Out_Main_cross;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
END;

Layout_Case_Master_and_soff_out_main tr_Attach_CM_Case_Num(MapPrimOffenderToCaseMaster L, Distribute_File_Primary_Offender_ECL_Cade_id R) := TRANSFORM
SELF.CM_CASE_NUM := L.CASE_NUM_C;
SELF := R;
END;
                                                                                                                                         
ds_File_Primary_Offender_ECL_Cade_id_CaseNum := JOIN(MapPrimOffenderToCaseMaster,Distribute_File_Primary_Offender_ECL_Cade_id,
																																													LEFT.ecl_cade_id=RIGHT.ecl_cade_id,
																																													 tr_Attach_CM_Case_Num(LEFT,RIGHT));


Layout_Normalize_Additional_Cases_Bucket_Fields := RECORD
INTEGER ecl_cade_id;
hygenics_soff.layout_out_main_cross.Seisint_Primary_Key; 
crim_cp_ln.Layout_cross_additional_cases.case_id;
crim_cp_ln.Layout_cross_additional_cases.case_description;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
end;

Layout_Normalize_Additional_Cases_Bucket_Fields  tr_Normalize_Layout_Normalize_Additional_Cases_Bucket_Fields
                                                                                      (ds_File_Primary_Offender_ECL_Cade_id_CaseNum L, INTEGER C) := TRANSFORM, 
																																																  SKIP(L.scars_marks_tattoos  + 
																																																					L.build_type +
																																																					L.ethnicity = '')  																					 
	build_and_ethnicity := TRIM(
																		 IF(LENGTH(TRIM(L.build_type))> 0,'BUILD: ' + TRIM(L.build_type) +', ','')
																		  + IF(LENGTH(TRIM(L.ethnicity))> 0,'ETHNICITY: ' + TRIM(L.ethnicity) +', ','')
																		 )
																				 [1..LENGTH(TRIM(
																					 IF(LENGTH(TRIM(L.build_type))> 0,'BUILD: ' + TRIM(L.build_type) +', ','')
																		        + IF(LENGTH(TRIM(L.ethnicity))> 0,'ETHNICITY: ' + TRIM(L.ethnicity) +', ','')
																							 ))-1];
																					               
	comments :=  L.addl_comments_1   + ' ' +  L.addl_comments_2;                                                                                                                   	                                                                                                                                            
																											 
																												 
  SELF.ecl_cade_id := L.ecl_cade_id;
	SELF.Seisint_Primary_Key := L.Seisint_Primary_Key;
	SELF.case_id := L.CM_CASE_NUM;
	SELF.case_description:=
	                 CHOOSE(C, IF(LENGTH(TRIM(L.scars_marks_tattoos))>0,TRIM(L.scars_marks_tattoos,LEFT,RIGHT),''),									                  
																			  IF(LENGTH(TRIM(build_and_ethnicity))>0,TRIM(build_and_ethnicity,LEFT,RIGHT),''),
																				   IF(LENGTH(TRIM(comments))>0,TRIM(comments,LEFT,RIGHT),'')
																			     );
																					
  SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD_C;
  SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C; 
end;						

ds_NormAddtionalCases := NORMALIZE(ds_File_Primary_Offender_ECL_Cade_id_CaseNum,3,
                                                        tr_Normalize_Layout_Normalize_Additional_Cases_Bucket_Fields(LEFT,COUNTER));
																												
Layout_additional_cases_Offender_key := Layout_additional_cases_cp;

Layout_additional_cases_Offender_key  tr_OffenderAdditionalCases(ds_NormAddtionalCases L)
                                                                             := TRANSFORM, SKIP(L.case_description = '')																																						 
																																					
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.OFFENDER_KEY := L.Seisint_Primary_Key;
//SELF.ADCA_ID := '';   
SELF.CASE_ID := L.case_id;
SELF.CASE_DESCRIPTION := L.case_description;
SELF.CADE_CADE_ID := '';   
SELF.CREATED_BY := 'HPCCLOAD';  
SELF.CREATION_DT := StringLib.GetDateYYYYMMDD();
SELF.LAST_UPDATED_BY := '';  
SELF.LAST_UPDATE_DT := '';  
SELF.RECORD_SUPPLIER_CD := L.RECORD_SUPPLIER_CD_C;
SELF.BATCH_NUMBER := '';  
SELF.OLD_RECORD_SUPPLIER_CD := L.OLD_RECORD_SUPPLIER_CD_C;
SELF := [];
END;
		
ds_AddtionalCases := PROJECT(ds_NormAddtionalCases,tr_OffenderAdditionalCases(LEFT));

export MapOffenderToAdditionalCases := SORT(ds_AddtionalCases,ecl_cade_id)																												
																											           : persist ('~thor_data400::persist::out::crim::cross_soff::MapOffenderToAdditionalCases');   
																																						 
																																						 