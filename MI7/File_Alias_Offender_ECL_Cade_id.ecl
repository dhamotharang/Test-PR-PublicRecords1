


import crim_common;
import crim_cp_ln;
import hygenics_eval;


ds_AliasOffender := File_AOC_Offenders_CodeV3(pty_typ='2');

Layout_Offender_ECL_Cade_id := RECORD
//STRING10 ecl_cade_id;
INTEGER ecl_cade_id;
hygenics_eval.Layout_Common_Crim_Offender;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
//string330 Sex_descr;
//string330 Vendor_descr;
Layout_LN_Cross_Extract_Driver.court_id;
Crim_Common.Layout_Moxie_Court_Offenses.court_cd;
Crim_Common.Layout_Moxie_Court_Offenses.court_desc;	
string330 Sex_descr;
end;


Layout_Offender_ECL_Cade_id   tr_Add_ECL_CadeID_To_Alias(ds_AliasOffender L, File_Primary_Offender_ECL_Cade_id R) := TRANSFORM
SELF.ECL_CADE_ID := R.ECL_CADE_ID;
SELF := L;
//SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD;
//SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD;
//SELF.Sex_descr := R.Sex_descr;
//SELF.Vendor_descr := R.Vendor_descr;
END;

distribute_alias :=  DISTRIBUTE(ds_AliasOffender,HASH32(offender_key));

ds_Alias_Offender_ECL_Cade_id := //*JOIN(ds_AliasOffender,File_Primary_Offender_ECL_Cade_id,*//
                                    JOIN(distribute_alias,Distribute_File_Primary_Offender_ECL_Cade_id,
																			LEFT.offender_key=RIGHT.offender_key,
																			//* tr_Add_ECL_CadeID_To_Alias(LEFT,RIGHT)); *//
                                        tr_Add_ECL_CadeID_To_Alias(LEFT,RIGHT),LOCAL);

sort_Alias_Offender_ECL_Cade_id := SORT(ds_Alias_Offender_ECL_Cade_id,ECL_CADE_ID);

export File_Alias_Offender_ECL_Cade_id := sort_Alias_Offender_ECL_Cade_id;

