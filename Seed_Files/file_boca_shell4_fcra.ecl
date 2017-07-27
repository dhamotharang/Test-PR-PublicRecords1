IMPORT ut, Seed_Files;

filename := '~thor_data400::base::testseed_boca_shell4_fcra';
export file_boca_shell4_fcra := dataset(filename, Seed_Files.layout_boca_shell4, csv(maxlength(65536),heading(1)), OPT);