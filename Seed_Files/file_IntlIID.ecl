/*2012-06-18T15:31:21Z (Todd Leonard)

*/
// on unix use iconv -f utf-16le -t utf-8 IntlIID_Test_Seeds.txt > IntlIID_Test_Seeds_utf8.txt to convert from utf-16le to utf-8

IMPORT Data_Services,Seed_Files;
EXPORT file_IntlIID := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_intliid', Seed_Files.Layout_IntlIID, CSV(SEPARATOR('\t'),HEADING(1), QUOTE('\"'), MAXLENGTH(10000), UNICODE));