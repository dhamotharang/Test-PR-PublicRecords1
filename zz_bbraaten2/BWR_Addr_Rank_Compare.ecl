// EXPORT BWR_Addr_Rank_Compare := 'todo';

layout := RECORD
  string3 score;
  string12 hhid;
  qstring10 acctno;
  string12 did;
  qstring9 ssn;
  qstring8 dob;
  qstring10 phoneno;
  qstring5 title;
  qstring20 name_first;
  qstring20 name_middle;
  qstring20 name_last;
  qstring5 name_suffix;
  qstring10 prim_range;
  qstring2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  qstring2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring2 st;
  qstring5 z5;
  qstring4 zip4;
  string10 best_phone;
  string9 best_ssn;
  string9 max_ssn;
  string5 best_title;
  string20 best_fname;
  string20 best_mname;
  string20 best_lname;
  string5 best_name_suffix;
  string120 best_addr1;
  string30 best_city;
  string2 best_state;
  string5 best_zip;
  string4 best_zip4;
  string6 best_addr_date;
  string8 best_dob;
  string8 best_dod;
  string3 verify_best_phone;
  string3 verify_best_ssn;
  string3 verify_best_address;
  string3 verify_best_name;
  string3 verify_best_dob;
  string3 score_any_ssn;
  string3 score_any_addr;
  string3 any_addr_date;
  string3 score_any_dob;
  string3 score_any_phn;
  string3 score_any_fzzy;
  string5 known;
  string5 name_match;
  string10 number_with_same_name;
  string6 first_seen;
  string5 relative_count;
  string errorcode;
 END;

lay_new := RECORD
	string headerdate;
  string3 score;
  string12 hhid;
  qstring10 acctno;
  string12 did;
  qstring9 ssn;
  qstring8 dob;
  qstring10 phoneno;
  qstring5 title;
  qstring20 name_first;
  qstring20 name_middle;
  qstring20 name_last;
  qstring5 name_suffix;
  qstring10 prim_range;
  qstring2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  qstring2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 p_city_name;
  qstring2 st;
  qstring5 z5;
  qstring4 zip4;
  string10 best_phone;
  string9 best_ssn;
  string9 max_ssn;
  string5 best_title;
  string20 best_fname;
  string20 best_mname;
  string20 best_lname;
  string5 best_name_suffix;
  string120 best_addr1;
  string30 best_city;
  string2 best_state;
  string5 best_zip;
  string4 best_zip4;
  string6 best_addr_date;
  string8 best_dob;
  string8 best_dod;
  string3 verify_best_phone;
  string3 verify_best_ssn;
  string3 verify_best_address;
  string3 verify_best_name;
  string3 verify_best_dob;
  string3 score_any_ssn;
  string3 score_any_addr;
  string3 any_addr_date;
  string3 score_any_dob;
  string3 score_any_phn;
  string3 score_any_fzzy;
  string5 known;
  string5 name_match;
  string10 number_with_same_name;
  string6 first_seen;
  string5 relative_count;
  string errorcode;
 END;
 
 // lay_new trans(readin_old le) := transform
 
 // self := left;
 // end;
 
 
 
 
// filetag_temp := '20170613_1';
// filetag2 := '20170504_1';
// readin_new := dataset('~scoringqa::header_'+ build_v+'_didville_best_addr_'+ filetag_temp, layout, thor);
// p_file_name := dataset('~scoringqa::header_'+ '20170321'+'_didville_best_addr_'+ filetag2, layout, thor);

// output(choosen(readin_new, 25), named('new_ds'));

// filenames_details :=  nothor(STD.File.LogicalFileList('scoringqa::header_*_didville_best_addr_*_1'));
// filelist := sort(filenames_details, -modified);
// output(filelist, named('filelist'));

// p_file_name := filelist[2].name;
// output(p_file_name, named('p_file_name'));

// prev_date := p_file_name[length(p_file_name)-9.. length(p_file_name)-2];
// output(prev_date, named('prev_date'));

// prev_hdr_date := p_file_name[length(p_file_name)-37.. length(p_file_name)-30];
// output(prev_hdr_date, named('prev_hdr_date'));

prev_hdr_date := '20170223';
prev_date := '20170502';

build_v := '20170321';
filetag_temp := '20170504';

// prev_hdr_date := '20170321';
// prev_date := '20170504';

// build_v := '20170321';
// filetag_temp := '20170504';

// prev_hdr_date := '20170321';
// prev_date := '20170504';

build__3 := '20170430b';
filetag_temp_3 := '20170620';



readin_old := dataset('~scoringqa::header_'+prev_hdr_date+'_didville_best_addr_'+prev_date+'_1', layout, thor);
clean_ds_first := project(readin_old, transform(lay_new ,self.headerdate := prev_hdr_date; self := left; SELF := [] ));


ds_1 := sort(clean_ds_first, acctno);
// output(choosen(ds_1, 200), named('ds_1'));

readin_new := dataset('~scoringqa::header_'+build_v+'_didville_best_addr_'+filetag_temp+'_1', layout, thor);
clean_ds_second := project(readin_new, transform(lay_new ,self.headerdate := build_v; self := left; SELF := [] ));

ds_2 := sort(clean_ds_second, acctno);
// output(choosen(ds_2, 200), named('ds_2'));

readin_new_recent := dataset('~scoringqa::header_'+build__3+'_didville_best_addr_'+filetag_temp_3+'_1', layout, thor);
clean_ds_third := project(readin_new_recent, transform(lay_new ,self.headerdate := build__3; self := left; SELF := [] ));

ds_3 := sort(clean_ds_third, acctno);
// output(choosen(ds_3, 200), named('ds_3'));

pt_one := join(ds_1, ds_2, left.acctno = right.acctno
								and left.errorcode = '' and right.errorcode = '', 
								transform({dataset(lay_new) res}, self.res := left + right));

// output(choosen(flipflop_pt_one, 200), named('flipflop_pt_one'));

join_count := Join(pt_one, ds_3, left.res[1].acctno = right.acctno
								 and right.errorcode = '' ,
								transform({dataset(lay_new) res}, self.res := left.res + right));


output(choosen(join_count, 200), named('join_count'));
output(count(join_count), named('join_count_count'));


flipflop_pt_one := join(ds_1, ds_2, left.acctno = right.acctno
								and left.errorcode = '' and right.errorcode = '' 
								and left.best_addr1 <> right.best_addr1,
								transform({dataset(lay_new) res}, self.res := left + right));

// output(choosen(flipflop_pt_one, 200), named('flipflop_pt_one'));

flipflop := Join(flipflop_pt_one, ds_3, left.res[1].acctno = right.acctno
								 and right.errorcode = '' 
								 and left.res[1].best_addr1 = right.best_addr1,
								transform({dataset(lay_new) res}, self.res := left.res + right));


output(choosen(flipflop, 200), named('lipflop'));
output(count(flipflop), named('flipflop_count'));



freq_move_pt_one := join(ds_1, ds_2, left.acctno = right.acctno
								and left.errorcode = '' and right.errorcode = '' 
								and left.best_addr1 <> right.best_addr1,
								transform({dataset(lay_new) res}, self.res := left + right));

// output(choosen(freq_move_pt_one, 200), named('freq_move_pt_one'));

freq_move := Join(freq_move_pt_one, ds_2, left.res[1].acctno = right.acctno
								 and right.errorcode = '' 
								 and left.res[1].best_addr1 <> right.best_addr1
								 and left.res[2].best_addr1 <> right.best_addr1,
								transform({dataset(lay_new) res}, self.res := left.res + right));

output(choosen(freq_move, 200), named('freq_move'));
output(count(freq_move), named('freq_move_count'));



ds_results := zz_bbraaten2.Compare_dsets_macro_email(ds_1, ds_2, ['acctno'], 0);
ds_results2 := zz_bbraaten2.Compare_dsets_macro_email(ds_2, ds_3, ['acctno'], 0);

// output(ds_results, named('ds_results'));
// count(ds_results);

// output(ds_results2, named('ds_results2'));
// count(ds_results2);

layout_results := record
string field;
integer Compare_count;
integer Different_Count;
decimal Different_Percent;
integer Up_Count;
decimal Up_Percent;
integer Down_Count;
decimal Down_Percent;
string Date1_ran;
string Prev_header;
string Date2_ran;
string Curr_header;
end;

layout_results trans(ds_results le) := transform
self.field := le.field ;
self.Compare_count := le.total_cnt ;
self.Different_Count := le.Diff_cnt ;
self.Different_Percent := le.Diff_pct ;
self.Up_Count := le.Up_cnt ;
self.Up_Percent := le.Up_pct ;
self.Down_Count := le.Down_cnt ;
self.Down_Percent := le.Down_pct ;
self.Date1_ran := prev_date ;
self.Prev_header := prev_hdr_date ;
self.Date2_ran := filetag_temp ;
self.Curr_header := build_v ;
end;


ds_full := project(ds_results, trans(left));
output(choosen(ds_full, 25), named('ds_full'));

ds_full2 := project(ds_results2, trans(left));
output(choosen(ds_full2, 25), named('ds_full_two'));
//compares old

// ttlcount1 := 	join(ds_1, ds_2, left.acctno = right.acctno
ttlcount1 := join(ds_2, ds_3, left.acctno = right.acctno
							and left.errorcode = '' and right.errorcode = '',
											transform({dataset(lay_new) res}, self.res := left + right));
											
totalcount1 := Count(ttlcount1);
output(totalcount1, named('totalcount1'));

	// Lost := join(ds_1, ds_2, left.acctno = right.acctno
	Lost := join(ds_2, ds_3, left.acctno = right.acctno
						and left.errorcode = '' and right.errorcode = '' 
					AND left.best_addr1	 <> '' and right.best_addr1 = ''	 ,
				transform({dataset(lay_new) res}, self.res := left + right));
				
output(choosen(Lost, 25), named('Lost_address'));
output(count(Lost), named('Lost_address_count'));

	// Gained := join(ds_1, ds_2, left.acctno = right.acctno
	Gained := join(ds_2, ds_3, left.acctno = right.acctno
											and left.errorcode = '' and right.errorcode = '' 
					AND left.best_addr1	 = '' and right.best_addr1 <> ''	 ,
				transform({dataset(lay_new) res}, self.res := left + right));
				
output(choosen(Gained, 25), named('Gained_address'));
output(count(Gained), named('Gained_address_count'));

	// Moved := join(ds_1, ds_2, left.acctno = right.acctno
	Moved := join(ds_2, ds_3, left.acctno = right.acctno
							and left.errorcode = '' and right.errorcode = '' 
					AND left.best_addr1	 <> '' and right.best_addr1 <> ''	 
					and left.best_addr1 <> right.best_addr1,
				transform({dataset(lay_new) res}, self.res := left + right));
				
output(choosen(Moved, 25), named('Moved_address'));
output(count(Moved), named('Moved_address_count'));


// best_addr_date_decrease := join(ds_1, ds_2, left.acctno = right.acctno
best_addr_date_decrease := join(ds_2, ds_3, left.acctno = right.acctno
						and left.errorcode = '' and right.errorcode = '' 
					AND left.best_addr_date	 >  right.best_addr_date ,
				transform({dataset(lay_new) res}, self.res := left + right));
				
output(choosen(best_addr_date_decrease, 25), named('best_addr_date_decrease'));
output(count(best_addr_date_decrease), named('best_addr_date_decrease_count'));

// best_addr_date_increase := join(ds_1, ds_2, left.acctno = right.acctno
best_addr_date_increase := join(ds_2, ds_3, left.acctno = right.acctno
						and left.errorcode = '' and right.errorcode = '' 
					AND left.best_addr_date	 <  right.best_addr_date ,
				transform({dataset(lay_new) res}, self.res := left + right));
				
output(choosen(best_addr_date_increase, 25), named('best_addr_date_increase'));
output(count(best_addr_date_increase), named('best_addr_date_increase_count'));

// best_addr_date_no := join(ds_1, ds_2, left.acctno = right.acctno
best_addr_date_no := join(ds_2, ds_3, left.acctno = right.acctno
						and left.errorcode = '' and right.errorcode = '' 
					AND left.best_addr_date	 =  right.best_addr_date ,
				transform({dataset(lay_new) res}, self.res := left + right));
				
output(choosen(best_addr_date_no, 25), named('best_addr_date_no_increase'));
output(count(best_addr_date_no), named('best_addr_date_no_count'));





pct_flipflop := (count(flipflop)/count(join_count))*100;
output(pct_flipflop, named('pct_flipflop'));

pct_freq_move := (count(freq_move)/count(join_count))*100;
output(pct_freq_move, named('pct_freq_move'));



// Lost_pct := (count(Lost)/totalcount1)*100;
// output(Lost_pct, named('Lost_pct'));

// Gained_pct := (count(Gained)/totalcount1)*100;
// output(Gained_pct, named('Gained_pct'));

// Moved_pct := (count(Moved)/totalcount1)*100;
// output(Moved_pct, named('Moved_pct'));




output_layout := record
string Versions;
integer Compare_Count;
integer Dropped_Address_Count;
real4 Dropped_Address_PCT;
integer Gained_Address_Count;
real4 Gained_Address_PCT;
integer Moved_Address_Count;
real4 Moved_Address_PCT;
integer DateLastSeen_Increase_Count;
real4 DateLastSeen_Increases_PCT;
integer DateLastSeen_Decrease_Count;
real4 DateLastSeen_Decrease_PCT;
integer DateLastSeen_No_Change_Count;
real4 DateLastSeen_No_Change_PCT;
end;

output_layout trans_out(ut.ds_oneRecord le) := Transform
// self.Versions := prev_hdr_date + ' ' + 'VS' + ' ' + build_v;
self.Versions := build_v + ' ' + 'VS' + ' ' + build__3;
self.Compare_Count := totalcount1 ;
self.Dropped_Address_Count := count(Lost);
self.Gained_Address_Count := count(gained);
self.Moved_Address_Count := count(moved);
self.Dropped_Address_PCT := (count(Lost)/totalcount1)*100;
self.Gained_Address_PCT := (count(gained)/totalcount1)*100;
self.Moved_Address_PCT := (count(moved)/totalcount1)*100;
self.DateLastSeen_Increase_Count := count(best_addr_date_increase);
self.DateLastSeen_Decrease_Count := count(best_addr_date_decrease);
self.DateLastSeen_No_Change_Count := count(best_addr_date_no);
self.DateLastSeen_Increases_PCT := (count(best_addr_date_increase)/totalcount1)*100;
self.DateLastSeen_Decrease_PCT := (count(best_addr_date_decrease)/totalcount1)*100;
self.DateLastSeen_No_Change_PCT := (count(best_addr_date_no)/totalcount1)*100;
end;

ds_out := project(ut.ds_oneRecord, trans_out(left));
output(ds_out);

output_layout_two := record
string Versions;
integer Compare_Count;
integer Flip_Flipped_Address_Count;
real4 Flip_Flipped_Address_PCT;
integer Frequent_Movers_Count;
real4 Frequent_Movers_PCT;
end;


output_layout_two trans_out2(ut.ds_oneRecord le) := Transform
self.Versions := prev_hdr_date + ' ' + 'VS' + ' ' + build_v +  ' ' + 'VS' + ' ' + build__3;;
self.Compare_Count := count(join_count);
self.Flip_Flipped_Address_Count := count(flipflop);
self.Frequent_Movers_Count := count(freq_move);
self.Flip_Flipped_Address_PCT :=(count(flipflop)/count(join_count))*100;
self.Frequent_Movers_PCT := (count(freq_move)/count(join_count))*100;
end;

ds_out2 := project(ut.ds_oneRecord, trans_out2(left));
output(ds_out2);

/*

count_ := Count(summaryxml);
output(count_);
//Code to generate the email with failure case attachment
Workut := STD.System.Job.WUID();
file_name := Workut + '___bbraaten::small_business_analytics_sbfe_edit';
main_head	:= if(count_ =0, 'No Values Outside Range', 'Please find the attached excel sheet for errors in file: bbraaten::small_business_analytics' + '\n For the detailed error report, go to: http://10.241.12.207:8010/WsWorkunits/WUResult?Wuid=' + (string)Workut +'&Sequence=4');

Layout_Text := RECORD
string text;
END;									

Layout_Text ConvertToText(summaryxml L) := Transform
 self.text := L.rulename + ',' + L.ruletype + ',' + L.rulemeaning + ',' + L.lowerlimit +','+ L.upperlimit + ',' + L.matchpercent + ',' + L.finalconclusion;
END;

HeaderText := 'RuleName,RuleType,RuleMeaning,LowerLimit,UpperLimit,MatchPercent,FinalConclusion';
SCOUT_Email := PROJECT(summaryxml,ConvertToText(LEFT));


Layout_Text ConvertOutput(Layout_Text L, Layout_Text R) := Transform
 self.text := L.text + '\n' + R.text;
END;

SCOUT_Output := ITERATE(SCOUT_Email,ConvertOutput(LEFT,RIGHT));

//Update the email id here with the distribution list
FileServices.SendEmailAttachText('Bridgett.Braaten@lexisnexisrisk.com', file_name + ' Report',main_head, HeaderText + SCOUT_Output[count(Scout_Output)].text,
      																				 'text/plain; charset=ISO-8859-3', 
      																				 file_name + '.csv',
      																				 ,
      																				 ,
      																				 'Bridgett.Braaten@lexisnexis.com');

*/