IMPORT Data_Services,Seed_Files;

EXPORT File_identityreport := DATASET (Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_identityreport', Seed_Files.layout_identityreport.rec_in, 
                                CSV (heading(1), separator(','), QUOTE('"'), MAXLENGTH (40000)));