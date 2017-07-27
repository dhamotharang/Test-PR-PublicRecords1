import Bankrupt,lib_keylib,lib_fileservices;

Main_dis := UtilFile.File_Util_in;

//Main_dis := distribute(Main_file,hash(court_code));

main_rec :=  record
 Main_dis.address_state;
 Max_date_filed := MAX(group,Main_dis.record_date);
 Min_date_filed := MIN(group,Main_dis.record_date);
 total := count(group);
end;

main_stats := table(Main_dis,main_rec,Main_dis.address_state,few);


main_perc_rec := record
 string2 Util_State := '';
  string8 Mmax_record_date := '';
 string8 Mmin_record_date := '';
 string10 Mtotal := '';
end;

main_perc_rec MainGetPerc(Main_stats L) := TRANSFORM
 self.Util_State := L.address_state;
 self.Mmax_record_date := L.Max_date_filed;
 self.Mmin_record_date := L.Min_date_filed;
 self.Mtotal := (string10)L.total;
end;

main_perc_rec_proj := project(main_stats(trim(address_state,left,right) <> ''),MainGetPerc(LEFT));

main_stats_sort := sort(main_perc_rec_proj,Util_State);

output(main_stats_sort(trim(Mmax_record_date,left,right) not in ['Ver','00000000'] and trim(Mmin_record_date,left,right) not in ['Ver','00000000']));