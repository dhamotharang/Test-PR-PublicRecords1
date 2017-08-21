
import crim_common,crim_cp_ln,hygenics_soff;

ds_soff_Offenses := File_IN_SOFF_Offenses;

//distribute_offense :=  DISTRIBUTE(ds_Court_Offenses,HASH32(offender_key));
Court_Offenses_ct_id_driver := JOIN(ds_soff_Offenses,Table(File_LN_Cross_Extract_Driver,{source_file,court_id,ln_cross_extract_flag}),
                                          LEFT.Source_file = RIGHT.Source_file and RIGHT.ln_cross_extract_flag = 'Y',lookup);

distribute_offense :=  DISTRIBUTE(Court_Offenses_ct_id_driver,HASH32(Seisint_Primary_Key));

Layout_Court_Offenses_ECL_Cade_id := RECORD
INTEGER ecl_cade_id;
hygenics_soff.Layout_common_Offense;
hygenics_soff.Layout_out_main_cross.registration_type;
hygenics_soff.Layout_out_main_cross.registration_county;
hygenics_soff.Layout_out_main_cross.orig_dl_number;
hygenics_soff.Layout_out_main_cross.orig_dl_state;
hygenics_soff.Layout_out_main_cross.offender_status;
hygenics_soff.Layout_out_main_cross.offender_category;
hygenics_soff.Layout_out_main_cross.risk_level_code  ;
hygenics_soff.Layout_out_main_cross.risk_description ;
hygenics_soff.Layout_out_main_cross.reg_date_1       ;
hygenics_soff.Layout_out_main_cross.reg_date_1_type  ;
hygenics_soff.Layout_out_main_cross.reg_date_2       ;
hygenics_soff.Layout_out_main_cross.reg_date_2_type  ;
hygenics_soff.Layout_out_main_cross.reg_date_3       ;
hygenics_soff.Layout_out_main_cross.reg_date_3_type  ;
//hygenics_soff.Layout_out_main_cross.police_agency  ;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
string20 court_ID;
end;

Layout_Court_Offenses_ECL_Cade_id   tr_Add_ECL_CadeID_To_Court_Offenses
                                             (distribute_offense L, Distribute_File_Primary_Offender_ECL_Cade_id R) := TRANSFORM
SELF.ECL_CADE_ID := R.ECL_CADE_ID;
SELF.orig_dl_number    := R.orig_dl_number;
SELF.orig_dl_state     := R.orig_dl_state;
//SELF.court_case_number := L.court_case_number; 
SELF.registration_type := R.registration_type;
SELF.offender_status   := R.offender_status;
SELF.offender_category := R.offender_category;
SELF.risk_level_code   := R.risk_level_code;
SELF.risk_description  := R.risk_description;
SELF.reg_date_1        := R.reg_date_1;
SELF.reg_date_1_type   := R.reg_date_1_type;
SELF.reg_date_2        := R.reg_date_2;
SELF.reg_date_2_type   := R.reg_date_2_type;
SELF.reg_date_3        := R.reg_date_3;
SELF.reg_date_3_type   := R.reg_date_3_type;
SELF.registration_county := R.registration_county;
//SELF.police_agency     := R.police_agency; 
SELF.OLD_RECORD_SUPPLIER_CD_C := R.OLD_RECORD_SUPPLIER_CD_C;
SELF.RECORD_SUPPLIER_CD_C := R.RECORD_SUPPLIER_CD_C;
SELF := L;
END;

ds_Court_Offenses_ECL_Cade_id :=  JOIN(distribute_offense,Distribute_File_Primary_Offender_ECL_Cade_id,
																			    LEFT.seisint_primary_key=RIGHT.seisint_primary_key
																		//	and LEFT.Process_date = RIGHT.Process_date  -- commented for hygenics testing, uncomment later..tp
																		,
																			 //*tr_Add_ECL_CadeID_To_Court_Offenses(LEFT,RIGHT)); *//
																			  tr_Add_ECL_CadeID_To_Court_Offenses(LEFT,RIGHT),LOCAL);

sort_Court_Offenses_ECL_Cade_id := SORT(ds_Court_Offenses_ECL_Cade_id,ECL_CADE_ID);

Layout_Court_Offenses_ECL_CadeCharge_id := RECORD
INTEGER ecl_charge_id;
Layout_Court_Offenses_ECL_Cade_id;
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
                                                    : persist ('~thor_data400::persist::out::crim::cross_SOFF::File_Court_Offenses_ECL_Cade_id');





