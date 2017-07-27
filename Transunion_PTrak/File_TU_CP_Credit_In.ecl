Layout_TU_CP_Credit2_In := RECORD
 Transunion_Ptrak.Layout_TU_CP_Credit_In;
 string1 extra_eol;
END;


exp_cp_cred_file1:= DATASET('~thor_data400::in::tu::cp::credit01', Layout_TU_CP_Credit2_In, THOR);
exp_cp_cred_file2:= DATASET('~thor_data400::in::tu::cp::credit02', Transunion_Ptrak.Layout_TU_CP_Credit_In, THOR);
exp_cp_cred_file3:= DATASET('~thor_data400::in::tu::cp::credit_update', Layout_TU_CP_Credit2_In, THOR);

exp_cp_cred_file1_reformatted := PROJECT(exp_cp_cred_file1 + exp_cp_cred_file3, TRANSFORM(Transunion_Ptrak.Layout_TU_CP_Credit_In, SELF := LEFT));
export File_TU_CP_Credit_In := exp_cp_cred_file2 + exp_cp_cred_file1_reformatted;