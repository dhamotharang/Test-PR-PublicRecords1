




import crim_common;
import crim_cp_ln;
import hygenics_eval;

//ds_PrimaryOffendner := SORT(File_AOC_Offenders(pty_typ='0'),source_file,offender_key);

ds_PrimaryOffendner := SORT(File_AOC_Offenders_CodeV3(pty_typ='0'),source_file,offender_key);  //check to see if local sort

Layout_Offender_ECL_Cade_id := RECORD
//STRING10 ecl_cade_id;
INTEGER ecl_cade_id;
hygenics_eval.Layout_Common_Crim_Offender;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
//Sex_descr := File_AOC_Offenders_CodeV3.Sex_descr;
//Vendor_descr := File_AOC_Offenders_CodeV3.Vendor_descr;
Layout_LN_Cross_Extract_Driver.court_id;
Crim_Common.Layout_Moxie_Court_Offenses.court_cd;
Crim_Common.Layout_Moxie_Court_Offenses.court_desc;	
string330 Sex_descr;
//string330 Vendor_descr;
end;

Layout_Offender_ECL_Cade_id   tr_Add_ECL_CadeID_To_PrimOffender(ds_PrimaryOffendner L, INTEGER C ) := TRANSFORM
//SELF.ECL_CADE_ID := (STRING) C;
SELF.ECL_CADE_ID := C;
SELF := L;
//SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD;
//SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD;
END;

ds_Primary_Offender_ECL_Cade_id := PROJECT(ds_PrimaryOffendner,tr_Add_ECL_CadeID_To_PrimOffender(LEFT,COUNTER));

//sort_Primary_Offender_ECL_Cade_id := SORT(ds_Primary_Offender_ECL_Cade_id,trim(ECL_CADE_ID));
sort_Primary_Offender_ECL_Cade_id := SORT(ds_Primary_Offender_ECL_Cade_id,ECL_CADE_ID);


//export File_Primary_Offender_ECL_Cade_id := ds_PrimaryOffendner;
export File_Primary_Offender_ECL_Cade_id := sort_Primary_Offender_ECL_Cade_id
                                                   : persist ('~thor_data400::persist::out::crim::cross_aoc_and_county::File_Primary_Offender_ECL_Cade_id');








