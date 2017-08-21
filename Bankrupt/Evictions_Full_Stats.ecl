import Bankrupt,lib_keylib,lib_fileservices,_control;

Evictions_stat_dis := Bankrupt.File_Evictions_Daily(filing_date <> '' or filing_date <> '00000000');

//Evictions_stat_dis := distribute(Evictions_file,hash(courtid));

filename := fileservices.getsuperfilesubname('~thor_data400::base::eviction',1);

filedate := filename[length(filename)-7..length(filename)];

Evictions_stat_rec :=  record
 string2 court_st := Evictions_stat_dis.courtid[1..2];
 total := count(group);
 Max_filing_date := MAX(group,Evictions_stat_dis.filing_date);
 Min_filing_date := MIN(group,Evictions_stat_dis.filing_date);
end;

Evictions_stats := table(Evictions_stat_dis(regexfind('[A-Z]',courtid)),Evictions_stat_rec,Evictions_stat_dis.courtid[1..2],few);

Evictions_perc_rec := record
 string2 stat_court_st := '';
 string8 stat_Max_Filing_Date := '';
 string8 stat_Min_Filing_Date := '';
 string10 stat_total := '';
 string2 crlf := '\r\n';
end;

Evictions_perc_rec GetPerc(Evictions_stats L) := TRANSFORM
 self.stat_court_st := L.court_st;
 self.stat_total := (string10)L.total;
 self.stat_Max_Filing_Date := L.Max_filing_date;
 self.stat_Min_Filing_Date := L.Min_filing_date;
end;

Evictions_perc_rec_proj := project(Evictions_stats,GetPerc(LEFT));

Evictions_stats_sort := sort(Evictions_perc_rec_proj(trim(stat_court_st,left,right) <> ''),stat_court_st);

Evictions_stat_out := output(Evictions_stats_sort(trim(stat_Max_Filing_Date,left,right) <> '' or trim(stat_Min_Filing_Date,left,right) <> ''),,'~thor_data400::out::Evictions_full_stats',overwrite);

Evictions_file_despray := lib_fileservices.fileservices.Despray('~thor_data400::out::Evictions_full_stats',_control.IPAddress.edata12,
 									'/thor_back5/liens/eviction/stats/Evictions_stats.d00',,,,TRUE);

export Evictions_Full_Stats := sequential(Evictions_stat_out,Evictions_file_despray);