



import crim_common;
import crim_cp_ln;

//ds_Court_Offenses := File_Court_Offenses(off_delete_flag <> 'Y');



//distribute_offense :=  DISTRIBUTE(ds_Court_Offenses,HASH32(offender_key));

//////////////////////////////////////////////////////////////////////////////

//Dedup added																				
sort_crim_offenses_doc := sort(distribute(File_Crim_Offenses,HASH32(offender_key)),       	
    	offender_key,
     	vendor,
    	source_file,
    	offense_key,
     	off_date,
     	arr_date,
    	case_num,
     	num_of_counts,
    	off_code,
    	chg,
     	chg_typ_flg,
    	off_desc_1,
    	off_desc_2,
     	add_off_cd,
    	add_off_desc,
     	off_typ,
     	off_lev,
     	arr_disp_date,
     	arr_disp_cd,
    	arr_disp_desc_1,
    	arr_disp_desc_2,
    	arr_disp_desc_3,
     	court_cd,
    	court_desc,
    	ct_dist,
     	ct_fnl_plea_cd,
    	ct_fnl_plea,
     	ct_off_code,
    	ct_chg,
     	ct_chg_typ_flg,
    	ct_off_desc_1,
    	ct_off_desc_2,
     	ct_addl_desc_cd,
     	ct_off_lev,
     	ct_disp_dt,
     	ct_disp_cd,
    	ct_disp_desc_1,
    	ct_disp_desc_2,
     	cty_conv_cd,
    	cty_conv,
     	adj_wthd,
     	stc_dt,
     	stc_cd,
     	stc_comp,
    	stc_desc_1,
    	stc_desc_2,
    	stc_desc_3,
    	stc_desc_4,
    	stc_lgth,
    	stc_lgth_desc,
     	inc_adm_dt,
    	min_term,
    	min_term_desc,
    	max_term,
    	max_term_desc,
			process_date,local);		

dedup_crim_offenses_doc := DEDUP(sort_crim_offenses_doc, RECORD, EXCEPT Process_date, KEEP 1,RIGHT,LOCAL);


//////////////////////////////////////////////////////////////////////////////

Crim_Offenses_ct_id_driver := JOIN(dedup_crim_offenses_doc,Table(File_LN_Cross_Extract_Driver,{source_file,court_id,ln_cross_extract_flag}),
                                          LEFT.Source_file = RIGHT.Source_file and RIGHT.ln_cross_extract_flag = 'Y',lookup);


//distribute_offense :=  DISTRIBUTE(ds_Court_Offenses_ct_id_driver,HASH32(offender_key));

distribute_offense :=  DISTRIBUTE(Crim_Offenses_ct_id_driver,HASH32(offender_key));

Layout_Crim_Offenses_ECL_Cade_id := RECORD
INTEGER ecl_cade_id;
//Crim_Common.Layout_Moxie_Court_Offenses;
Crim_Common.Layout_In_DOC_Offenses.previous;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.dl_num;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.dl_state;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.case_number;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.case_type;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
string20 court_ID;
end;

Layout_Crim_Offenses_ECL_Cade_id   tr_Add_ECL_CadeID_To_Crim_Offenses
                                             (distribute_offense L, Distribute_File_Primary_Offender_ECL_Cade_id R) := TRANSFORM
SELF.ECL_CADE_ID := R.ECL_CADE_ID;
SELF := L;
SELF.DL_NUM := R.DL_NUM;
SELF.Dl_STATE := R.Dl_STATE;
SELF.CASE_NUMBER := R.CASE_NUMBER; 
SELF.CASE_TYPE := R.CASE_TYPE; 
SELF.OLD_RECORD_SUPPLIER_CD_C := R.OLD_RECORD_SUPPLIER_CD_C;
SELF.RECORD_SUPPLIER_CD_C := R.RECORD_SUPPLIER_CD_C;
END;

ds_Crim_Offenses_ECL_Cade_id := //*JOIN(ds_Court_Offenses,File_Primary_Offender_ECL_Cade_id, *//
                                     JOIN(distribute_offense,Distribute_File_Primary_Offender_ECL_Cade_id,
																			    LEFT.offender_key=RIGHT.offender_key
																		//	and LEFT.Process_date = RIGHT.Process_date -- commented for hygenics testing, uncomment later..tp
																		,
																			 //*tr_Add_ECL_CadeID_To_Court_Offenses(LEFT,RIGHT)); *//
																			  tr_Add_ECL_CadeID_To_Crim_Offenses(LEFT,RIGHT),LOCAL);
																				
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*       
Layout_AOC_ct_off_lev_desc := RECORD
Layout_Court_Offenses_ECL_Cade_id;
string330 ct_off_lev_desc;
end;		
			 
Layout_AOC_ct_off_lev_desc  tr_get_ct_off_lev_desc(ds_Court_Offenses_ECL_Cade_id L, File_CodesV3_Court_Offenses R) := TRANSFORM
SELF := L;
SELF.ct_off_lev_desc := R.long_desc;
END;

File_AOC_offenses_CodeV3_ct_off_lev := JOIN(ds_Court_Offenses_ECL_Cade_id,File_CodesV3_Court_Offenses,
                                              LEFT.court_off_lev = RIGHT.code 
																					      and LEFT.vendor = RIGHT.field_name2
																					       and RIGHT.field_name = 'COURT_OFF_LEV',tr_get_ct_off_lev_desc(LEFT,RIGHT),LEFT OUTER,lookup);		

Layout_AOC_ar_off_lev_desc := RECORD
Layout_AOC_ct_off_lev_desc;
string330 arr_off_lev_desc;
end;	
																								 

Layout_AOC_ar_off_lev_desc  tr_get_ar_off_lev_desc(File_AOC_offenses_CodeV3_ct_off_lev L, File_CodesV3_Court_Offenses R) := TRANSFORM
SELF := L;
SELF.arr_off_lev_desc := R.long_desc;
END;
																					
File_AOC_offenses_CodeV3_ct_arr_off_lev := JOIN(File_AOC_offenses_CodeV3_ct_off_lev,File_CodesV3_Court_Offenses,
                                                 LEFT.arr_off_lev = RIGHT.code 
																						       and LEFT.vendor = RIGHT.field_name2
																						        and RIGHT.field_name = 'ARR_OFF_LEV',tr_get_ar_off_lev_desc(LEFT,RIGHT),LEFT OUTER, lookup);
																										
Layout_AOC_pr_off_lev_desc := RECORD
Layout_AOC_ar_off_lev_desc;
string330 pr_off_lev_desc;
end;																									 

Layout_AOC_pr_off_lev_desc  tr_get_pr_off_lev_desc(File_AOC_offenses_CodeV3_ct_arr_off_lev L, File_CodesV3_Court_Offenses R) := TRANSFORM
SELF := L;
SELF.pr_off_lev_desc := R.long_desc;
END;																				
																						
File_AOC_offenses_CodeV3_ct_arr_pros_off_lev := JOIN(File_AOC_offenses_CodeV3_ct_arr_off_lev,File_CodesV3_Court_Offenses,
                                                      LEFT.pros_off_lev = RIGHT.code 
																						           and LEFT.vendor = RIGHT.field_name2
																						            and RIGHT.field_name = 'PROS_OFF_LEV',tr_get_pr_off_lev_desc(LEFT,RIGHT),LEFT OUTER, lookup);

*/																												
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////																				
																			    
     
//sort_Court_Offenses_ECL_Cade_id := SORT(ds_Court_Offenses_ECL_Cade_id,ECL_CADE_ID);

sort_Crim_Offenses_ECL_Cade_id := SORT(ds_Crim_Offenses_ECL_Cade_id,ECL_CADE_ID);


Layout_Crim_Offenses_ECL_CadeCharge_id := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
//Crim_Common.Layout_Moxie_Court_Offenses;
Crim_Common.Layout_In_DOC_Offenses.previous;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.dl_num;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.dl_state;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.case_number;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.CASE_TYPE; 
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
string20 court_ID;
// string330 ct_off_lev_desc;
// string330 arr_off_lev_desc;
// string330 pr_off_lev_desc;
end;


Layout_Crim_Offenses_ECL_CadeCharge_id  tr_Add_ECL_SentID_To_Crim_Offenses
                                           (sort_Crim_Offenses_ECL_Cade_id L,INTEGER C) := TRANSFORM
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.ECL_CHARGE_ID := C;
SELF := L;
END;		

ds_Crim_Offenses_ECL_CadeCharge_id := PROJECT(sort_Crim_Offenses_ECL_Cade_id,tr_Add_ECL_SentID_To_Crim_Offenses(LEFT,COUNTER));

sort_Crim_Offenses_ECL_CadeCharge_id := SORT(ds_Crim_Offenses_ECL_CadeCharge_id,ECL_CADE_ID);

export File_Crim_Offenses_ECL_Cade_id := sort_Crim_Offenses_ECL_CadeCharge_id;

