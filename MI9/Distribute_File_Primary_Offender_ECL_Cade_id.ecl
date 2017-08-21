

import crim_cp_ln;
import hygenics_soff;

// need to add dist for local sort

ds_PrimaryOffendner := SORT(File_soff_Offenders(name_type = '0'),source_file,seisint_primary_key);  

Layout_Offender_ECL_Cade_id := RECORD
INTEGER ecl_cade_id;
hygenics_soff.Layout_Out_Main_cross;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
Layout_LN_Cross_Extract_Driver.court_id;
end;

Layout_Offender_ECL_Cade_id   tr_Add_ECL_CadeID_To_PrimOffender(ds_PrimaryOffendner L, INTEGER C ) := TRANSFORM
//SELF.ECL_CADE_ID := (STRING) C;
SELF.ECL_CADE_ID := C;
SELF := L;
SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD;
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD;
END;

ds_Primary_Offender_ECL_Cade_id := PROJECT(ds_PrimaryOffendner,tr_Add_ECL_CadeID_To_PrimOffender(LEFT,COUNTER));

export  Distribute_File_Primary_Offender_ECL_Cade_id := 
                 DISTRIBUTE(ds_Primary_Offender_ECL_Cade_id,HASH32(Seisint_Primary_Key))
								         : persist ('~thor_data400::persist::out::crim::cross_soff::Distribute_File_Primary_Offender_ECL_Cade_id');




