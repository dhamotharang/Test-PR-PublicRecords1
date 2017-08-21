IMPORT ut;
export file_boca_shell_fcra := dataset(ut.foreign_prod + 'thor_data400::base::testseed_boca_shell_fcra', Layout_Boca_Shell, csv(maxlength(65536),heading(1)));