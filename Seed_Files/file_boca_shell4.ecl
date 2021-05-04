IMPORT Data_Services,Seed_Files;

filename := Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_boca_shell4';
EXPORT file_boca_shell4 := DATASET(filename, Seed_Files.layout_boca_shell4, CSV(MAXLENGTH(65536),HEADING(1)), OPT);