


//export File_LN_Cross_Extract_Driver := DATASET('~thor_data400::in::ln_to_cp::sourcelkp_flba.csv',Layout_LN_Cross_Extract_Driver ,CSV);


a := DATASET('~thor_data400::in::ln_to_cp::sourcelkp_tarun_0ct1_2010',Layout_LN_Cross_Extract_Driver ,CSV);


export File_LN_Cross_Extract_Driver := a(old_record_supplier_cd = 'FLBA');


// OHAL
// FLBA
// WICR
// IAOC
// MOCR
// FLPB