import Liensv2,Bankrupt,lib_keylib,lib_fileservices,_control;

Liens_stat_dis := Liensv2.file_liens_main(filing_date <> '' or filing_date <> '00000000');


string_rec := record
	string my_st := '';
	string8 my_date := '';
end;

string_rec proj_rec(Liens_stat_dis l) := transform
	self.my_st := if(l.filing_state = 'IL','IL',l.filing_jurisdiction);
	self.my_date := l.orig_filing_date;
end;

proj_out := project(liens_stat_dis,proj_rec(left));


Liens_stat_rec :=  record
 string court_st := proj_out.my_st;
 total := count(group);
 string8 Max_filing_date := MAX(group,proj_out.my_date);
 string8 Min_filing_date := MIN(group,proj_out.my_date);
end;

Liens_stats := table(proj_out(trim(my_date) <> '' and trim(my_date) <> '00000000'),Liens_stat_rec,proj_out.my_st);



Liens_perc_rec := record
 string2 stat_court_st := '';
 string8 stat_Max_Filing_Date := '';
 string8 stat_Min_Filing_Date := '';
 string10 stat_total := '';
 string2 crlf := '\r\n';
end;

Liens_perc_rec GetPerc(Liens_stats L) := TRANSFORM
 self.stat_court_st := L.court_st;
 self.stat_total := (string10)L.total;
 self.stat_Max_Filing_Date := L.Max_filing_date;
 self.stat_Min_Filing_Date := L.Min_filing_date;
end;

Liens_perc_rec_proj := project(Liens_stats,GetPerc(LEFT));

Liens_stats_sort := sort(Liens_perc_rec_proj(trim(stat_court_st,left,right) <> ''),stat_court_st);

Liens_stat_out := output(Liens_stats_sort(trim(stat_Max_Filing_Date,left,right) <> '' or trim(stat_Min_Filing_Date,left,right) <> ''),,'~thor_data400::out::Liens_full_stats',overwrite);

Liens_file_despray := lib_fileservices.fileservices.Despray('~thor_data400::out::Liens_full_stats',_control.IPAddress.edata12,
 									'/thor_back5/liens/stats/fullstats/Liens_stats.d00',,,,TRUE);

export Liens_Full_Stats := sequential(Liens_stat_out,Liens_file_despray);