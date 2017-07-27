import Bankrupt,lib_keylib,lib_fileservices;

Main_dis := Bankrupt.File_BK_Main(date_filed <> '' or date_filed <> '00000000');

//Main_dis := distribute(Main_file,hash(court_code));

main_rec :=  record
 Main_dis.court_code;
 Main_dis.court_location;
 Max_date_filed := MAX(group,Main_dis.date_filed);
 Min_date_filed := MIN(group,Main_dis.date_filed);
 total := count(group);
end;

main_stats := table(Main_dis,main_rec,Main_dis.court_code,Main_dis.court_location,few);


main_perc_rec := record
 string5 Mcourt_code := '';
 string10 Mcourt_location := '';
 string8 Mmax_date_filed := '';
 string8 Mmin_date_filed := '';
 string10 Mtotal := '';
 string2 crlf := '\r\n';
end;

main_perc_rec MainGetPerc(Main_stats L) := TRANSFORM
 self.Mcourt_code := L.court_code;
 self.Mcourt_location := L.court_location;
 self.Mmax_date_filed := L.Max_date_filed;
 self.Mmin_date_filed := L.Min_date_filed;
 self.Mtotal := (string10)L.total;
end;

main_perc_rec_proj := project(main_stats,MainGetPerc(LEFT));

main_stats_sort := sort(main_perc_rec_proj,Mcourt_code,Mcourt_Location);

main_stat_out := output(main_stats_sort(Mcourt_code <> '    S' and Mmax_date_filed <> '00000000' and Mmin_date_filed <> '00000000'),,'out::bk_main_full_stats',overwrite);

main_file_despray := lib_fileservices.fileservices.Despray('~thor_dell400_2::out::bk_main_full_stats','192.168.0.39',
 									'/thor_back5/bk_v8/stats/bk_main_stat.d00',,,,TRUE);

export BK_Main_Full_Stats := sequential(main_stat_out,main_file_despray);