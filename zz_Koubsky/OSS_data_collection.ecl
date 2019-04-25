// EXPORT OSS_data_collection := 'todo';

IMPORT zz_Koubsky, ashirey, RiskProcessing;

filetag1 := '702_233';
date1 := '20140903';
filetag2 := 'OSS_234';
date2 := '20140903';
record_count := 1000;

eyeball := 25;
zz_Koubsky.OSS_FCRA_Function(record_count, '702', filetag1);
// zz_Koubsky.OSS_FCRA_Function(record_count, 'OSS', filetag2);

// c := zz_Koubsky.OSS_compare_query(filetag1, date1, filetag2, date2);

