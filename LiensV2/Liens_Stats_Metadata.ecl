import Liensv2,lib_keylib,lib_fileservices,ut;



stats_function(dataset(liensv2.Layout_liens_main_module.layout_liens_main) Main_dis) := function

st_rec := record
	string fs := '';
	string8 fdate := '';
end;

st_rec proj_st_rec(Main_dis l,unsigned1 cnt) := transform
	self.fs := if (trim(l.filing_state) <> '' and trim(l.filing_state) <> 'ILLINOIS',l.filing_state,l.filing_jurisdiction);
	self.fdate := choose(cnt,l.filing_date,l.orig_filing_date);
end;

norm_recs := normalize(Main_dis(filing_state <> '' or filing_jurisdiction <> ''),2,proj_st_rec(left,counter));

main_rec :=  record
 norm_recs.fs;
 Max_date_filed := MAX(group,norm_recs.fdate);
 Min_date_filed := MIN(group,norm_recs.fdate);
 total := count(group);
end;

main_stats := table(norm_recs(fs <> '' and fdate <> ''),main_rec,norm_recs.fs,few);

main_perc_rec := record
 string5 Mstate := '';
 string8 Mmax_date_filed := '';
 string8 Mmin_date_filed := '';
 string10 Mtotal := '';
 string2 crlf := '\r\n';
end;

main_perc_rec MainGetPerc(Main_stats L) := TRANSFORM
 self.Mstate := L.fs;
 self.Mmax_date_filed := L.Max_date_filed;
 self.Mmin_date_filed := L.Min_date_filed;
 self.Mtotal := (string10)L.total;
end;

main_perc_rec_proj := project(main_stats,MainGetPerc(LEFT));

return main_perc_rec_proj;

end;

first_max_ds := Liensv2.file_liens_main;

second_max_ds := Liensv2.file_liens_main(process_date < Max(Liensv2.file_liens_main,Liensv2.file_liens_main.process_date));


first_ds := stats_function(first_max_ds);
second_ds := stats_function(second_max_ds);

typeof(first_ds) join_rec(first_ds l,second_ds r) := transform
	self := l;
end;

join_out := join(first_ds,second_ds,
				left.Mstate = right.Mstate and
				left.Mmin_date_filed = right.Mmin_date_filed,
				join_rec(left,right),
				full only
				);

export Liens_Stats_Metadata := if (count(join_out) > 0,
														sequential(output(choosen(join_out,300),named('Liens_New_Updated_Records')),
														fileservices.sendemail('avenkatachalam@seisint.com',
																		'New/Updated Liens States ' + ut.GetDate,
																		'New/Updated Liens States:  http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n')
														),
														output('No New/Updated Liens States')
														);

