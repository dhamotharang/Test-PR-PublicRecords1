import Bankrupt,lib_keylib,lib_fileservices;

Liens_stat_dis := Bankrupt.File_Liens_Daily(filing_date <> '' or filing_date <> '00000000');

//Liens_stat_dis := distribute(Liens_file,hash(courtid));

Liens_stat_rec :=  record
 Liens_stat_dis.courtid;
 total := count(group);
 Max_filing_date := MAX(group,Liens_stat_dis.filing_date);
 Min_filing_date := MIN(group,Liens_stat_dis.filing_date);
end;

Liens_stats := table(Liens_stat_dis,Liens_stat_rec,Liens_stat_dis.courtid,few);

Liens_perc_rec := record
 string2 stat_court_st := '';
 string5 stat_court_part := '';
 string8 stat_Max_Filing_Date := '';
 string8 stat_Min_Filing_Date := '';
 string10 stat_total := '';
 string2 crlf := '\r\n';
end;

Liens_perc_rec GetPerc(Liens_stats L) := TRANSFORM
 self.stat_court_st := L.courtid[1..2];
 self.stat_court_part := L.courtid[3..7];
 self.stat_total := (string10)L.total;
 self.stat_Max_Filing_Date := L.Max_filing_date;
 self.stat_Min_Filing_Date := L.Min_filing_date;
end;

Liens_perc_rec_proj := project(Liens_stats,GetPerc(LEFT));

Liens_stats_sort := sort(Liens_perc_rec_proj(trim(stat_court_st,left,right) <> ''),stat_court_st,stat_court_part);

Liens_stat_out := output(Liens_stats_sort(trim(stat_Max_Filing_Date,left,right) <> '' or trim(stat_Min_Filing_Date,left,right) <> ''),,'out::Liens_full_stats',overwrite);

Liens_file_despray := lib_fileservices.fileservices.Despray('~thor_dell400_2::out::Liens_full_stats','192.168.0.39',
 									'/thor_back5/liens/stats/fullstats/Liens_stats.d00',,,,TRUE);

export Liens_Full_Stats := sequential(Liens_stat_out,Liens_file_despray);