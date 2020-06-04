Import Seed_Files;

export file_FDAttributes := dataset('~thor_data400::base::testseed_fdattributes', Seed_Files.Layout_FDAttributes, csv(heading(single), maxlength(25000)) );