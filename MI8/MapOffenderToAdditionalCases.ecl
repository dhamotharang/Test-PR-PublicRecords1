


import crim_common;
import Crim_CP_LN;

Layout_Case_Master_and_Moxie_Crim_Offender := RECORD
CM_CASE_NUM := MapPrimOffenderToCaseMaster.CASE_NUM_C ;
CM_DOB := MapPrimOffenderToCaseMaster.DOB;
CM_SSN := MapPrimOffenderToCaseMaster.SSN;
CM_NC_DOB := MapPrimOffenderToCaseMaster.NC_DOB;
INTEGER ecl_cade_id;
Crim_Common.Layout_Moxie_Crim_Offender2.previous; 

crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
END;

// Layout_additional_cases_Offender_key := RECORD
// INTEGER ecl_cade_id;
// crim_common.Layout_Moxie_Crim_Offender2.previous.offender_key;
// crim_cp_ln.Layout_cross_additional_cases;
// end;


//ds_offender_ECL_Cade_id := sort(File_Primary_Offender_ECL_Cade_id + File_Alias_Offender_ECL_Cade_id,ecl_cade_id,pty_typ);
ds_offender_ECL_Cade_id := File_Primary_Offender_ECL_Cade_id + File_Alias_Offender_ECL_Cade_id;
 
// ds_Offender_alias_dobs := ds_offender_ECL_Cade_id(
                                               // (dob_alias <> '' and dob <> dob_alias)
                                            // OR (pty_typ='2' and dob + dob_alias <> ''));   
																						
//add sort by ,ecl_cade_id,pty_typ?																						
ds_Offender_alias_dobs :=	ds_offender_ECL_Cade_id(pty_typ = '0' and dob_alias <> '' and dob_alias <> dob) + 
				                     ds_offender_ECL_Cade_id(pty_typ='2' and dob + dob_alias <> ''); 																						

// ds_offender_alias_ssn := ds_offender_ECL_Cade_id(
                                              // (orig_ssn + ssn <> ''
																						     // and orig_ssn <> ssn
																							    // and ssn <> ''and orig_ssn <> '') 
																							  // OR (pty_typ='2' and orig_ssn + ssn <> ''
																									// ));
																									
																									
ds_offender_alias_ssn := ds_offender_ECL_Cade_id(pty_typ='0' and ssn <> ''and orig_ssn <> '' and orig_ssn <> ssn) +
                            ds_offender_ECL_Cade_id(pty_typ='2' and orig_ssn + ssn <> '');															 
													 

Layout_Case_Master_and_Moxie_Crim_Offender tr_Attach_CM_Constants_Offender
                                                 (MapPrimOffenderToCaseMaster L, ds_Offender_alias_dobs R) := TRANSFORM
SELF.CM_CASE_NUM := L.CASE_NUM_C;
SELF.CM_DOB := L.DOB;																																	 
SELF.CM_SSN := L.SSN;
SELF.CM_NC_DOB := L.NC_DOB;
SELF := R;
END;


ds_CaseNumberAndOffenderAliasDobs := JOIN(MapPrimOffenderToCaseMaster,ds_Offender_alias_dobs,
																						LEFT.ecl_cade_id=RIGHT.ecl_cade_id,
																						  tr_Attach_CM_Constants_Offender(LEFT,RIGHT));
																					
														
ds_CaseNumberAndOffenderAliasSSN := JOIN(MapPrimOffenderToCaseMaster,ds_Offender_alias_ssn,
																						LEFT.ecl_cade_id=RIGHT.ecl_cade_id,
																						  tr_Attach_CM_Constants_Offender(LEFT,RIGHT));
																			 

ds_sorted_OffenderAliasDobs := SORT(ds_CaseNumberAndOffenderAliasDobs,ecl_cade_id,pty_typ);

ds_sorted_OffenderAliasSSN := SORT(ds_CaseNumberAndOffenderAliasSSN,ecl_cade_id,pty_typ);


Layout_Concat_DOB := RECORD
ds_sorted_OffenderAliasDobs.ecl_cade_id;
ds_sorted_OffenderAliasDobs.offender_key;
ds_sorted_OffenderAliasDobs.CM_CASE_NUM;
string650 CASE_DESCRIPTION:=     IF(ds_sorted_OffenderAliasDobs.pty_typ='0',ds_sorted_OffenderAliasDobs.dob_alias, 
																		 MAP(ds_sorted_OffenderAliasDobs.dob = ds_sorted_OffenderAliasDobs.dob_alias 
																				=> ds_sorted_OffenderAliasDobs.dob,
																						ds_sorted_OffenderAliasDobs.dob <> ds_sorted_OffenderAliasDobs.dob_alias
																						  and ds_sorted_OffenderAliasDobs.dob <> '' and ds_sorted_OffenderAliasDobs.dob_alias <> '' 
																						 => ds_sorted_OffenderAliasDobs.dob + '; ' + ds_sorted_OffenderAliasDobs.dob_alias,
																								 ds_sorted_OffenderAliasDobs.dob <>'' 
																									 => ds_sorted_OffenderAliasDobs.dob,
																											ds_sorted_OffenderAliasDobs.dob_alias));
ds_sorted_OffenderAliasDobs.OLD_RECORD_SUPPLIER_CD_C;
ds_sorted_OffenderAliasDobs.RECORD_SUPPLIER_CD_C;
end;



Layout_Concat_SSN := RECORD
ecl_cade_id_ssn := ds_sorted_OffenderAliasSSN.ecl_cade_id;
offender_key_ssn := ds_sorted_OffenderAliasSSN.offender_key;
CM_CASE_NUM_SSN := ds_sorted_OffenderAliasSSN.CM_CASE_NUM;
string650 CASE_DESCRIPTION_SSN :=  IF(ds_sorted_OffenderAliasSSN.pty_typ='0',ds_sorted_OffenderAliasSSN.SSN,
																				MAP(ds_sorted_OffenderAliasSSN.Orig_SSN = ds_sorted_OffenderAliasSSN.SSN
																				 => ds_sorted_OffenderAliasSSN.Orig_SSN,
																							ds_sorted_OffenderAliasSSN.Orig_SSN <> ds_sorted_OffenderAliasSSN.SSN
																							 and ds_sorted_OffenderAliasSSN.Orig_SSN <> '' and ds_sorted_OffenderAliasSSN.SSN <> ''  
																							 => ds_sorted_OffenderAliasSSN.Orig_SSN + '; ' + ds_sorted_OffenderAliasSSN.SSN,
																									ds_sorted_OffenderAliasSSN.Orig_SSN <>'' 
																									 => ds_sorted_OffenderAliasSSN.Orig_SSN,
																												ds_sorted_OffenderAliasSSN.SSN));
OLD_RECORD_SUPPLIER_CD_C_ssn := ds_sorted_OffenderAliasSSN.OLD_RECORD_SUPPLIER_CD_C;
RECORD_SUPPLIER_CD_C_ssn := ds_sorted_OffenderAliasSSN.RECORD_SUPPLIER_CD_C;
end;


ds_offenderAliasDobsCaseDesc := TABLE(ds_sorted_OffenderAliasDobs,Layout_Concat_DOB);
ds_Srt_offenderAliasDobsCaseDesc := SORT(ds_offenderAliasDobsCaseDesc,ecl_cade_id,CASE_DESCRIPTION);
ds_Dedup_offenderAliasDobsCaseDesc := DEDUP(ds_Srt_offenderAliasDobsCaseDesc,ecl_cade_id,CASE_DESCRIPTION,ALL);
ds_Sort_offenderAliasDobsCaseDesc := SORT(ds_Dedup_offenderAliasDobsCaseDesc,ecl_cade_id);	


ds_offenderAliasSSNCaseDesc := TABLE(ds_sorted_OffenderAliasSSN,Layout_Concat_SSN);
ds_Srt_offenderAliasSSNCaseDesc := SORT(ds_offenderAliasSSNCaseDesc,ecl_cade_id_ssn,CASE_DESCRIPTION_SSN);
ds_Dedup_offenderAliasSSNCaseDesc := DEDUP(ds_Srt_offenderAliasSSNCaseDesc,ecl_cade_id_ssn,CASE_DESCRIPTION_SSN,ALL);
ds_Sort_offenderAliasSSNCaseDesc := SORT(ds_Dedup_offenderAliasSSNCaseDesc,ecl_cade_id_ssn);	

Layout_Concat_DOB tr_ConcatenationByOffKeyDOB(Layout_Concat_DOB L,Layout_Concat_DOB R) := TRANSFORM
	SELF.ecl_cade_id := L.ecl_cade_id;
	SELF.offender_key := L.offender_key;
	SELF.CM_CASE_NUM := L.CM_CASE_NUM;
	SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD_C;
	SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD_C;
	SELF.CASE_DESCRIPTION := trim(L.CASE_DESCRIPTION) + '; ' + trim(R.CASE_DESCRIPTION);
END;



Layout_Concat_SSN tr_ConcatenationByOffKeySSN(Layout_Concat_SSN L,Layout_Concat_SSN R) := TRANSFORM
  SELF.ecl_cade_id_ssn := L.ecl_cade_id_ssn;
	SELF.offender_key_SSN := L.offender_key_SSN;
	SELF.CM_CASE_NUM_SSN := L.CM_CASE_NUM_SSN;
	SELF.OLD_RECORD_SUPPLIER_CD_C_ssn := L.OLD_RECORD_SUPPLIER_CD_C_ssn;
	SELF.RECORD_SUPPLIER_CD_C_ssn := L.RECORD_SUPPLIER_CD_C_ssn;
	SELF.CASE_DESCRIPTION_SSN := trim(L.CASE_DESCRIPTION_SSN) + '; ' + trim(R.CASE_DESCRIPTION_SSN);
END;


ds_Rollup_AdditionalCasesAliasDOB := ROLLUP(ds_Sort_offenderAliasDobsCaseDesc,
																			    LEFT.ecl_cade_id=RIGHT.ecl_cade_id, 
																				   tr_ConcatenationByOffKeyDOB(LEFT,RIGHT));	

ds_Rollup_AdditionalCasesSSN := ROLLUP(ds_Sort_offenderAliasSSNCaseDesc,
																	    LEFT.ecl_cade_id_ssn=RIGHT.ecl_cade_id_ssn,  
																	     tr_ConcatenationByOffKeySSN(LEFT,RIGHT));		
												 

Layout_Join_DOB_SSN :=RECORD
Layout_Concat_DOB;
END;

Layout_Join_DOB_SSN tr_join_SSN_AND_DOBS(ds_Rollup_AdditionalCasesAliasDOB L, ds_Rollup_AdditionalCasesSSN R) := TRANSFORM
//SELF.ECL_CADE_ID := IF((STRING) L.ECL_CADE_ID <>'',L.ECL_CADE_ID,11);//R.ECL_CADE_ID_SSN);
//SELF.ECL_CADE_ID := L.ECL_CADE_ID + R.ECL_CADE_ID_SSN
//SELF.ECL_CADE_ID := IF((STRING) L.ECL_CADE_ID = '',R.ECL_CADE_ID_SSN,L.ECL_CADE_ID);
SELF.ECL_CADE_ID := IF(L.ECL_CADE_ID >0,L.ECL_CADE_ID,R.ECL_CADE_ID_SSN);
SELF.OFFENDER_KEY := IF(L.OFFENDER_KEY <>'',L.OFFENDER_KEY,R.OFFENDER_KEY_SSN);
SELF.CM_CASE_NUM := IF(L.CM_CASE_NUM <>'',L.CM_CASE_NUM,R.CM_CASE_NUM_SSN);	
SELF.OLD_RECORD_SUPPLIER_CD_C	:= IF(L.OLD_RECORD_SUPPLIER_CD_C <>'',L.OLD_RECORD_SUPPLIER_CD_C,R.OLD_RECORD_SUPPLIER_CD_C_SSN);	
SELF.RECORD_SUPPLIER_CD_C	:=	IF(L.RECORD_SUPPLIER_CD_C <>'',L.RECORD_SUPPLIER_CD_C,R.RECORD_SUPPLIER_CD_C_SSN);																													 
SELF.CASE_DESCRIPTION := TRIM(IF(L.CASE_DESCRIPTION <> '','Additional Dobs: ' + TRIM(L.CASE_DESCRIPTION) + '; ','')) 
                           + TRIM(IF(R.CASE_DESCRIPTION_SSN <> '','Additional SSN: ' + TRIM(R.CASE_DESCRIPTION_SSN),''));
END;


ds_Join_Cases_SSN_AND_DOBS := JOIN(ds_Rollup_AdditionalCasesAliasDOB,ds_Rollup_AdditionalCasesSSN,
																			 LEFT.ecl_cade_id=RIGHT.ecl_cade_id_ssn,
																				tr_join_SSN_AND_DOBS(LEFT,RIGHT),FULL OUTER
																				 );			
																 
Layout_additional_cases_Offender_key := Layout_additional_cases_cp;

Layout_additional_cases_Offender_key   tr_OffenderAdditionalCases(ds_Join_Cases_SSN_AND_DOBS L) := TRANSFORM
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.OFFENDER_KEY := L.OFFENDER_KEY;
SELF.ADCA_ID := '';   
SELF.CASE_ID := L.CM_CASE_NUM;
SELF.CASE_DESCRIPTION := L.CASE_DESCRIPTION;
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

		
ds_AddtionalCases := PROJECT(ds_Join_Cases_SSN_AND_DOBS,tr_OffenderAdditionalCases(LEFT));

export MapOffenderToAdditionalCases := SORT(ds_AddtionalCases,ecl_cade_id);

