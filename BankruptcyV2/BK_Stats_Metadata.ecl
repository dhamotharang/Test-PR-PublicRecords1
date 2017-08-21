import Bankrupt,lib_keylib,lib_fileservices,ut;



stats_function(dataset(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp) Main_dis) := function

main_rec :=  record
 Main_dis.court_code;
 Main_dis.court_name;
 Max_date_filed := MAX(group,Main_dis.date_filed);
 Min_date_filed := MIN(group,Main_dis.date_filed);
 total := count(group);
end;

main_stats := table(Main_dis,main_rec,Main_dis.court_code,Main_dis.court_name,few);


main_perc_rec := record
 string5 Mcourt_code := '';
 string Mcourt_name := '';
 string8 Mmax_date_filed := '';
 string8 Mmin_date_filed := '';
 string10 Mtotal := '';
  string2 crlf := '\r\n';
end;

main_perc_rec MainGetPerc(Main_stats L) := TRANSFORM
 self.Mcourt_code := L.court_code;
 self.Mcourt_name := L.court_name;
 self.Mmax_date_filed := L.Max_date_filed;
 self.Mmin_date_filed := L.Min_date_filed;
 self.Mtotal := (string10)L.total;
end;

main_perc_rec_proj := project(main_stats,MainGetPerc(LEFT));

return main_perc_rec_proj;

end;

first_max_ds := Bankruptcyv2.file_bankruptcy_main_v3((date_filed <> '' or date_filed <> '00000000'));
second_max_ds := Bankruptcyv2.file_bankruptcy_main_v3((date_filed <> '' or date_filed <> '00000000') and process_date < Max(Bankruptcyv2.file_bankruptcy_main_v3,Bankruptcyv2.file_bankruptcy_main_v3.process_date));


first_ds := stats_function(first_max_ds);
second_ds := stats_function(second_max_ds);


typeof(first_ds) join_rec(first_ds l,second_ds r) := transform
	self := l;
end;

join_out := join(first_ds,second_ds,
				left.Mcourt_code = right.Mcourt_code, /*and
				left.Mmin_date_filed = right.Mmin_date_filed,*/
				join_rec(left,right),
				left only
				)(trim(Mcourt_code) <> '');

myset := set(join_out,Mcourt_code);


join_out1 := join(first_ds,second_ds,
				left.Mcourt_code = right.Mcourt_code and
				left.Mmin_date_filed = right.Mmin_date_filed,
				join_rec(left,right),
				left only
				)(trim(Mcourt_code) <> '' and Mcourt_code not in myset);
				
export BK_Stats_Metadata := if ((count(join_out) > 0 or count(join_out1) > 0 ),
												sequential(output(choosen(join_out,300),named('New_Court_Codes')),
															output(choosen(join_out1,300),named('Min_Filing_Date_Changed')),
														fileservices.sendemail('vniemela@seisint.com,avenkatachalam@seisint.com,DCADataInsightTeam@Choicepoint.com',
																		'New/Updated BK Court Codes ' + ut.GetDate,
																		'New/Updated BK Court Codes:  http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit + '\r\n')
																	),
														output('No New BK Codes'));
										


