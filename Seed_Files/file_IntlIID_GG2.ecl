IMPORT Data_Services,Seed_Files;

EXPORT file_IntlIID_GG2 := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_intliid_gg2',
	Seed_Files.Layout_IntlIID_GG2,CSV(SEPARATOR('\t'),HEADING(1), QUOTE('\"'), MAXLENGTH(10000), UNICODE));