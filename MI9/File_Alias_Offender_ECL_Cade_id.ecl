

import crim_cp_ln;
import hygenics_soff;

ds_AliasOffender := File_soff_Offenders(name_type = '2');

dist_AliasOffender :=  DISTRIBUTE(ds_AliasOffender,HASH32(Seisint_Primary_Key));  

Layout_Offender_ECL_Cade_id := RECORD
INTEGER ecl_cade_id;
hygenics_soff.Layout_Out_Main_cross;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
Layout_LN_Cross_Extract_Driver.court_id;
end;

Layout_Offender_ECL_Cade_id   tr_Add_ECL_CadeID_To_Alias(dist_AliasOffender L, Distribute_File_Primary_Offender_ECL_Cade_id R) := TRANSFORM
SELF.ECL_CADE_ID := R.ECL_CADE_ID;
SELF := L;
SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD;
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD;
END;

ds_Alias_Offender_ECL_Cade_id :=  JOIN(dist_AliasOffender,Distribute_File_Primary_Offender_ECL_Cade_id,
																		              	      LEFT.Seisint_Primary_Key=RIGHT.Seisint_Primary_Key,
																	                          tr_Add_ECL_CadeID_To_Alias(LEFT,RIGHT),LOCAL);

sort_Alias_Offender_ECL_Cade_id := SORT(ds_Alias_Offender_ECL_Cade_id,ECL_CADE_ID);

export File_Alias_Offender_ECL_Cade_id := sort_Alias_Offender_ECL_Cade_id
                                                                   : persist ('~thor_data400::persist::out::crim::cross_soff::File_Alias_Offender_ECL_Cade_id');   

