



import crim_common;
import crim_cp_ln;
import hygenics_eval;

ds_Court_Offenses := File_Court_Offenses(off_delete_flag <> 'Y');


//distribute_offense :=  DISTRIBUTE(ds_Court_Offenses,HASH32(offender_key));

Court_Offenses_ct_id_driver := JOIN(ds_Court_Offenses,Table(File_LN_Cross_Extract_Driver,{source_file,court_id,ln_cross_extract_flag}),
                                          LEFT.Source_file = RIGHT.Source_file and RIGHT.ln_cross_extract_flag = 'Y',lookup);


//distribute_offense :=  DISTRIBUTE(ds_Court_Offenses_ct_id_driver,HASH32(offender_key));

distribute_offense :=  DISTRIBUTE(Court_Offenses_ct_id_driver,HASH32(offender_key));

Layout_Court_Offenses_ECL_Cade_id := RECORD
INTEGER ecl_cade_id;
hygenics_eval.Layout_Common_Court_Offenses;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.dl_num;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.dl_state;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.case_number;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.case_type_desc;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
string20 court_ID;
end;

Layout_Court_Offenses_ECL_Cade_id   tr_Add_ECL_CadeID_To_Court_Offenses
                                             (distribute_offense L, Distribute_File_Primary_Offender_ECL_Cade_id R) := TRANSFORM
SELF.ECL_CADE_ID := R.ECL_CADE_ID;
SELF := L;
SELF.DL_NUM := R.DL_NUM;
SELF.Dl_STATE := R.Dl_STATE;
SELF.CASE_NUMBER := R.CASE_NUMBER; 
SELF.CASE_TYPE_DESC := R.CASE_TYPE_DESC; 
SELF.OLD_RECORD_SUPPLIER_CD_C := R.OLD_RECORD_SUPPLIER_CD_C;
SELF.RECORD_SUPPLIER_CD_C := R.RECORD_SUPPLIER_CD_C;
END;

ds_Court_Offenses_ECL_Cade_id := //*JOIN(ds_Court_Offenses,File_Primary_Offender_ECL_Cade_id, *//
                                     JOIN(distribute_offense,Distribute_File_Primary_Offender_ECL_Cade_id,
																			    LEFT.offender_key=RIGHT.offender_key
																		//	and LEFT.Process_date = RIGHT.Process_date  -- commented for hygenics testing, uncomment later..tp
																		,
																			 //*tr_Add_ECL_CadeID_To_Court_Offenses(LEFT,RIGHT)); *//
																			  tr_Add_ECL_CadeID_To_Court_Offenses(LEFT,RIGHT),LOCAL);
																				
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
       
Layout_AOC_ct_off_lev_desc := RECORD
Layout_Court_Offenses_ECL_Cade_id;
string330 ct_off_lev_desc;
end;		
			 
Layout_AOC_ct_off_lev_desc  tr_get_ct_off_lev_desc(ds_Court_Offenses_ECL_Cade_id L, File_CodesV3_Court_Offenses R) := TRANSFORM
SELF := L;
//SELF.ct_off_lev_desc := R.long_desc;
SELF.ct_off_lev_desc := L.court_off_lev;
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
//SELF.arr_off_lev_desc := R.long_desc;
SELF.arr_off_lev_desc := L.arr_off_lev;
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
//SELF.pr_off_lev_desc := R.long_desc;
SELF.pr_off_lev_desc := L.pros_off_lev;
END;																				
																						
File_AOC_offenses_CodeV3_ct_arr_pros_off_lev := JOIN(File_AOC_offenses_CodeV3_ct_arr_off_lev,File_CodesV3_Court_Offenses,
                                                      LEFT.pros_off_lev = RIGHT.code 
																						           and LEFT.vendor = RIGHT.field_name2
																						            and RIGHT.field_name = 'PROS_OFF_LEV',tr_get_pr_off_lev_desc(LEFT,RIGHT),LEFT OUTER, lookup);
																												
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////																				
																			    
     
//sort_Court_Offenses_ECL_Cade_id := SORT(ds_Court_Offenses_ECL_Cade_id,ECL_CADE_ID);

sort_Court_Offenses_ECL_Cade_id := SORT(File_AOC_offenses_CodeV3_ct_arr_pros_off_lev,ECL_CADE_ID);


Layout_Court_Offenses_ECL_CadeCharge_id := RECORD
INTEGER ecl_cade_id;
INTEGER ecl_charge_id;
hygenics_eval.Layout_Common_Court_Offenses;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.dl_num;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.dl_state;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.case_number;
Crim_Common.Layout_Moxie_Crim_Offender2.previous.CASE_TYPE_DESC; 
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
string20 court_ID;
string330 ct_off_lev_desc;
string330 arr_off_lev_desc;
string330 pr_off_lev_desc;
end;


Layout_Court_Offenses_ECL_CadeCharge_id  tr_Add_ECL_SentID_To_Court_Offenses
                                           (sort_Court_Offenses_ECL_Cade_id L,INTEGER C) := TRANSFORM
SELF.ECL_CADE_ID := L.ECL_CADE_ID;
SELF.ECL_CHARGE_ID := C;
SELF := L;
END;		

ds_Court_Offenses_ECL_CadeCharge_id := PROJECT(sort_Court_Offenses_ECL_Cade_id,tr_Add_ECL_SentID_To_Court_Offenses(LEFT,COUNTER));

sort_Court_Offenses_ECL_CadeCharge_id := SORT(ds_Court_Offenses_ECL_CadeCharge_id,ECL_CADE_ID);

export File_Court_Offenses_ECL_Cade_id := sort_Court_Offenses_ECL_CadeCharge_id
                                                    : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::File_Court_Offenses_ECL_Cade_id');





