/*2012-06-18T15:31:21Z (Todd Leonard)

*/
// on unix use iconv -f utf-16le -t utf-8 IntlIID_Test_Seeds.txt > IntlIID_Test_Seeds_utf8.txt to convert from utf-16le to utf-8

export file_IntlIID := dataset('~thor_data400::base::testseed_intliid', seed_files.Layout_IntlIID, csv(separator('\t'),heading(1), quote('\"'), maxlength(10000), unicode));