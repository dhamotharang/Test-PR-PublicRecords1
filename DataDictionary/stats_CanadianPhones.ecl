import CanadianPhones;
canPhones := CanadianPhones.file_CanadianWhitePagesBase;

export stats_CanadianPhones := 
// Canadian Phones	Total records	
output(count(canPhones),named('CanadianPhonesTotalRecords'));