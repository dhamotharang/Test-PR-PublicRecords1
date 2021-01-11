EXPORT Phone_Shell_Cert_Tracking_Report := function

//**************************************************************************
//*  WARNING!!!!  THIS WORKUNIT MUST RUN ON AN HTHOR OR IT WILL FAIL!!!!!  *
//**************************************************************************************

import scoring_project_pip, std, ashirey, Phone_Shell, Risk_Indicators, zz_bkarnatz;


//Options to change
thresh := 0.5;
eyeball := 10;
model :='COLLECTIONSCORE_V3'; //'PHONESCORE_V2';//	
today := (String8)std.date.today();
// today := '20190812';

b:= (string8)std.date.adjustdate((integer)today, 0, 0, -1);


a1:= today +'_1';
b1:= b +'_1';


//reading in dataset
input_layout := Record
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus - Raw_Input - Clean_Input - Clam Phone_Shell;
	Risk_Indicators.Layout_Boca_Shell - LnJ_datasets - ConsumerStatements - bk_chapters Boca_Shell;
END;

ds_base := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ b1, input_layout, thor);
ds_test := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ a1, input_layout, thor);

// output(ds_base, named('ds_base'));


//slimming down dataset and creating hashtag
slim_rec := RECORD
  string50 acctno;
  string10 gathered_phone;
  integer phone_score;
  string200 source_list;
END;

slim_rec Num_trans(input_layout le) := TRANSFORM
	self.acctno := le.phone_shell.input_echo.acctno;
	self.gathered_phone := le.phone_shell.gathered_phone;
	self.phone_score := (integer)le.phone_shell.phone_model_score;
	self.source_list := le.phone_shell.sources.source_list;
	self := [];
END;

ds_trans_base := project(ds_base, num_trans(left));
ds_trans_test := project(ds_test, num_trans(left));

// output(ds_trans_base, named('ds_trans_base'));

mod_lay := record
	string hashtag;
	slim_rec;
end;

ds_mod_base := project(ds_trans_base, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));
ds_mod_test := project(ds_trans_test, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));

// output(ds_mod_base, named('ds_mod_base'));


//getting a count of the number of test cases in the sample
ds_mod_base_dedup := dedup(ds_mod_base, acctno);
ds_mod_test_dedup := dedup(ds_mod_test, acctno);

// output(count(ds_mod_base_dedup), named('ds_mod_base_dedup_count')); 
// output(count(ds_mod_test_dedup), named('ds_mod_test_dedup_count')); 

Matched_test_case_base := join(ds_mod_base_dedup, ds_mod_test_dedup, left.acctno = right.acctno, transform(mod_lay, Self := left));    //# of test cases with responses both days
Matched_test_case_test := join(ds_mod_base_dedup, ds_mod_test_dedup, left.acctno = right.acctno, transform(mod_lay, Self := right));   //# of test cases with responses both days

// output(count(Matched_test_case_base), named('Matched_test_case_base_count')); 
// output(count(Matched_test_case_test), named('Matched_test_case_test_count')); 


/////////*New Layout for dataset field compare */
NewLay := Record
	string hashtag;	
	input_layout - Boca_Shell;     //Removing Bocashell attributes as we only want to compare PhoneShell fields
End;

NewLay New_transPSbase(ds_base le) := TRANSFORM
	self.hashtag := trim(le.phone_shell.Input_Echo.acctno, left, right) + trim(le.Phone_Shell.Gathered_Phone, left, right);	
	self := le;
END;

NewLay New_transPStest(ds_test le) := TRANSFORM
	self.hashtag := trim(le.phone_shell.input_echo.acctno, left, right) + trim(le.Phone_Shell.Gathered_Phone, left, right);	
	self := le;
END;

ds_trans_PS_Result_base := project(ds_base, New_transPSbase(left));
ds_trans_PS_Result_test := project(ds_test, New_transPStest(left));

// output(choosen(ds_trans_PS_Result,5), named('ds_trans_PS_Result'));

ashirey.flatten(ds_trans_PS_Result_base, flatten_base_PhoneShell);
ashirey.flatten(ds_trans_PS_Result_test, flatten_test_PhoneShell);

// output(choosen(flatten_PhoneShell,5), named('flatten_PhoneShell'));

cert_ds_out := Scoring_Project_PIP.Compare_dsets_macro_email(flatten_base_PhoneShell, flatten_test_PhoneShell, ['hashtag'], thresh);

OUTPUT (cert_ds_out, , '~ScoringQA::out::PhoneShellv1Diffs_' + a1 + 'vs' + b1 + '_Cert', thor, overwrite);








//NEW DIFF REPORT CALCULATIONS

Master := dataset('~scoringqa::out::DDT_CERT_NonFCRA_Master_' + today, zz_bkarnatz.PhoneShell.DDT_Master_NonFCRA_Layout.DDT_Master_Layout, thor);

// output(master, named('master'));

sortedMaster := sort(Master, -(integer)date);

// output(sortedMaster, named('sortedMaster'));

NewMasterlay:= record
	String ImportantKeysUpdated;
	integer matchnum;
	boolean DiffReportExists;
	zz_bkarnatz.PhoneShell.DDT_Master_NonFCRA_Layout.DDT_Master_Layout;
End;

NewMasterlay PreMatchtrans(sortedMaster le) := Transform
	self.ImportantKeysUpdated :=  If(le.BusinessHeaderKeys_Version = '' and le.GongKeys_Version = '' and le.InquirytableKeys_Version = '' and le.InquiryTableUpdateKeys_Version = '' and le.PersonHeaderKeys_Version = '' and le.PhoneFeedbackKeys_Version = '' and le.PhonesPlusV2Keys_Version = '' and le.QuickHeaderKeys_Version = '' and le.RelativeV3Keys_Version = '' and le.TelcordiaTdsKeys_Version = '' and le.TelcordiaTpmKeys_Version = '' and ((string8)std.date.adjustdate((integer)le.date, 0, 0, 1))[7..8] <> '01', 'No Pertinent Updates',
																if(le.BusinessHeaderKeys_Version <> '', 'BusinessHeaderKeys, ', '') + 
																if(le.GongKeys_Version <> '', 'GongKeys, ', '') + 
																if(le.InquirytableKeys_Version <> '', 'InquirytableKeys, ', '') + 
																if(le.InquiryTableUpdateKeys_Version <> '', 'InquiryTableUpdateKeys, ', '') + 
																if(le.PersonHeaderKeys_Version <> '', 'PersonHeaderKeys, ', '') + 
																if(le.PhoneFeedbackKeys_Version <> '', 'PhoneFeedbackKeys, ', '') + 																
																if(le.PhonesPlusV2Keys_Version <> '', 'PhonesPlusV2Keys, ', '') + 
																if(le.QuickHeaderKeys_Version <> '', 'QuickHeaderKeys, ', '') +
																if(le.RelativeV3Keys_Version <> '', 'RelativeV3Keys, ', '') +
																if(le.TelcordiaTdsKeys_Version <> '', 'TelcordiaTdsKeys, ', '') +
																if(le.TelcordiaTpmKeys_Version <> '', 'TelcordiaTpmKeys, ', '') +
																if(((string8)std.date.adjustdate((integer)le.date, 0, 0, 1))[7..8] = '01', 'Monthly_Rollover, ', ''));
																
														// if(le.PhonemartKeys_Version <> '', 'PhonemartKeys, ', '') + 										
	
	self.DiffReportExists := If((le.date = (string8)std.date.adjustdate((integer)today, 0, 0, -1)), true, STD.File.FileExists('~scoringqa::out::phoneshellv1diffs_' + (string8)std.date.adjustdate((integer)le.date, 0, 0, 1) + '_1vs' + le.date + '_1_cert'));
	self := le;
	self := [];
End;

PreMatchMaster := project(sortedMaster, PreMatchtrans(left));
// output(PreMatchMaster, Named('PreMatchMaster'));

NewMasterlay Matchtrans(PreMatchMaster le, integer c) := Transform
	self.MatchNum := if(PreMatchMaster[1].ImportantKeysUpdated = le.ImportantKeysUpdated, c, 99999);											
	self := le;
End;

MatchMaster := project(PreMatchMaster, Matchtrans(left, counter));
// output(MatchMaster, Named('MatchMaster'));

MatchOnlyMaster := MatchMaster(MatchNum <> 99999 and DiffReportExists = true);
// output(MatchOnlyMaster, Named('MatchOnlyMaster'));

String KeysChecked := 'BusinessHeaderKeys, GongKeys, InquirytableKeys, InquiryTableUpdateKeys, PersonHeaderKeys, PhoneFeedbackKeys, PhonesPlusV2Keys, QuickHeaderKeys, RelativeV3Keys, TelcordiaTdsKeys, TelcordiaTpmKeys';
String KeysUpdated := MatchOnlyMaster[1].ImportantKeysUpdated;
// KeysUpdated := output(MatchOnlyMaster[1].ImportantKeysUpdated, named('KeysUpdated'));


//The ddt report reports the keys that were updated yesterday, so that date will match the prev date and should be compared with the next day for the diff report.
PrevDay := MatchOnlyMaster[1].date + '_1';
CurrDay := (string8)std.date.adjustdate((integer)PrevDay[..8], 0, 0, 1) + '_1';

matchday1Prev:= MatchOnlyMaster[2].date + '_1';
matchday1 := (string8)std.date.adjustdate((integer)matchday1Prev[..8], 0, 0, 1) + '_1';

matchday2Prev := MatchOnlyMaster[3].date + '_1';
matchday2 := (string8)std.date.adjustdate((integer)matchday2Prev[..8], 0, 0, 1) + '_1';

matchday3Prev:= MatchOnlyMaster[4].date + '_1';
matchday3 := (string8)std.date.adjustdate((integer)matchday3Prev[..8], 0, 0, 1) + '_1';

matchday4Prev := MatchOnlyMaster[5].date + '_1';
matchday4 := (string8)std.date.adjustdate((integer)matchday4Prev[..8], 0, 0, 1) + '_1';

String ComparedDays := map(
														count(MatchOnlyMaster) >= 5 => matchday1[..8] + ', ' + matchday2[..8] + ', '  + matchday3[..8] + ', '  + matchday4[..8],
														count(MatchOnlyMaster) = 4 => matchday1[..8] + ', ' + matchday2[..8] + ', '  + matchday3[..8],
														count(MatchOnlyMaster) = 3 => matchday1[..8] + ', ' + matchday2[..8],
														count(MatchOnlyMaster) = 2 => matchday1[..8], 'No Matching Days');

// Output(ComparedDays, Named('ComparedDays'));


// output(CurrDay, Named('CurrDay'));
// output(PrevDay, Named('PrevDay'));
// output(matchday1, Named('matchday1'));
// output(matchday1Prev, Named('matchday1Prev'));
// output(matchday2, Named('matchday2'));
// output(matchday2Prev, Named('matchday2Prev'));
// output(matchday3, Named('matchday3'));
// output(matchday3Prev, Named('matchday3Prev'));
// output(matchday4, Named('matchday4'));
// output(matchday4Prev, Named('matchday4Prev'));

RepLay := RECORD
  string field;
  integer8 total_cnt;
  integer8 diff_cnt;
  decimal10_2 diff_pct;
  integer8 up_cnt;
  decimal10_2 up_pct;
  integer8 down_cnt;
  decimal10_2 down_pct;
 END;


Prev4Diff := '~ScoringQA::out::PhoneShellv1Diffs_' + matchday4 + 'vs' + matchday4Prev + '_Cert';
Prev3Diff := '~ScoringQA::out::PhoneShellv1Diffs_' + matchday3 + 'vs' + matchday3Prev + '_Cert';
Prev2Diff := '~ScoringQA::out::PhoneShellv1Diffs_' + matchday2 + 'vs' + matchday2Prev + '_Cert';
Prev1Diff := '~ScoringQA::out::PhoneShellv1Diffs_' + matchday1 + 'vs' + matchday1Prev + '_Cert';
Currdiff := cert_ds_out;


ds_Prev4diff := dataset(Prev4Diff, RepLay, Thor);
ds_Prev3diff := dataset(Prev3Diff, RepLay, Thor);
ds_Prev2diff := dataset(Prev2Diff, RepLay, Thor);
ds_Prev1diff := dataset(Prev1Diff, RepLay, Thor);
ds_CurrDiff := cert_ds_out; 

// output(ds_CurrDiff, Named('ds_CurrDiff'));
// output(ds_Prev1diff, Named('ds_Prev1diff'));
// output(ds_Prev2diff, Named('ds_Prev2diff'));
// output(ds_Prev3diff, Named('ds_Prev3diff'));
// output(ds_Prev4diff, Named('ds_Prev4diff'));



//adding previous diff and 2nd previous Diff Together.
ds_SumPrev1_2 := join(ds_Prev1diff, ds_Prev2diff, left.field = right.field,
			  TRANSFORM(RepLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.diff_pct := LEFT.diff_pct + Right.diff_pct;
					SELF.up_pct := LEFT.up_pct + Right.up_pct;
					SELF.down_pct := LEFT.down_pct + Right.down_pct;
					Self := [];
					), Full Outer);
//adding 3rd previous Diff and 4th Previous Diff together
ds_SumPrev3_4 := join(ds_Prev3diff, ds_Prev4diff, left.field = right.field,
			  TRANSFORM(RepLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.diff_pct := LEFT.diff_pct + Right.diff_pct;
					SELF.up_pct := LEFT.up_pct + Right.up_pct;
					SELF.down_pct := LEFT.down_pct + Right.down_pct;
					Self := [];
					), Full Outer);

//adding summed 1&2 diff with 3rd previous diff together
ds_SumPrev1_2_3 := join(ds_SumPrev1_2, ds_Prev3diff, left.field = right.field,
			  TRANSFORM(RepLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.diff_pct := LEFT.diff_pct + Right.diff_pct;
					SELF.up_pct := LEFT.up_pct + Right.up_pct;
					SELF.down_pct := LEFT.down_pct + Right.down_pct;
					Self := [];
					), Full Outer);


//adding summed 1&2 diffs with summed 3&4 diffs together
ds_SumPrev1_2_3_4 := join(ds_SumPrev1_2, ds_SumPrev3_4, left.field = right.field,
			  TRANSFORM(RepLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.diff_pct := LEFT.diff_pct + Right.diff_pct;
					SELF.up_pct := LEFT.up_pct + Right.up_pct;
					SELF.down_pct := LEFT.down_pct + Right.down_pct;
					Self := [];
					), Full Outer);


// output(ds_SumPrev1_2, Named('ds_SumPrev1_2'));
// output(ds_SumPrev3_4, Named('ds_SumPrev3_4'));
// output(ds_SumPrev, Named('ds_SumPrev'));

DiffLay := RECORD
  string field;
  decimal10_2 Current_diff;
  decimal10_2 Expected_diff;
  decimal10_2 Surprise_change;
  // decimal10_2 Surprise_pct;
  // decimal10_2 Current_up;
  // decimal10_2 Expected_up;
  decimal10_2 Surprise_up;
  // decimal10_2 Current_Down;
  // decimal10_2 Expected_Down;
  decimal10_2 Surprise_Down;
 END;



DiffinDiff_avg1 := join(ds_CurrDiff, ds_Prev1diff, left.field = right.field,
			  TRANSFORM(DiffLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.Current_diff := LEFT.diff_pct;
					SELF.Expected_diff := right.diff_pct;
					SELF.Surprise_change := LEFT.diff_pct - (RIGHT.diff_pct);
					// SELF.Surprise_pct := ((LEFT.diff_pct - RIGHT.diff_pct)/Right.diff_pct)*100;  //not a good field.  need to do something about the magnitude of change vs size of bins.
					// SELF.Current_up := left.up_pct;
					// SELF.Expected_up := right.up_pct;
					SELF.Surprise_Up := left.up_pct - (right.up_pct);
					// SELF.Current_Down := left.down_pct;
					// SELF.Expected_Down := right.down_pct;
					SELF.Surprise_Down := left.down_pct - (right.down_pct);
					Self := [];
					), Full Outer);


DiffinDiff_avg2 := join(ds_CurrDiff, ds_SumPrev1_2, left.field = right.field,
			  TRANSFORM(DiffLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.Current_diff := LEFT.diff_pct;
					SELF.Expected_diff := right.diff_pct/2;
					SELF.Surprise_change := LEFT.diff_pct - (RIGHT.diff_pct/2);
					// SELF.Surprise_pct := ((LEFT.diff_pct - RIGHT.diff_pct)/Right.diff_pct)*100;  //not a good field.  need to do something about the magnitude of change vs size of bins.
					// SELF.Current_up := left.up_pct;
					// SELF.Expected_up := right.up_pct/2;
					SELF.Surprise_Up := left.up_pct - (right.up_pct/2);
					// SELF.Current_Down := left.down_pct;
					// SELF.Expected_Down := right.down_pct/2;
					SELF.Surprise_Down := left.down_pct - (right.down_pct/2);
					Self := [];
					), Full Outer);


DiffinDiff_avg3 := join(ds_CurrDiff, ds_SumPrev1_2_3, left.field = right.field,
			  TRANSFORM(DiffLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.Current_diff := LEFT.diff_pct;
					SELF.Expected_diff := right.diff_pct/3;
					SELF.Surprise_change := LEFT.diff_pct - (RIGHT.diff_pct/3);
					// SELF.Surprise_pct := ((LEFT.diff_pct - RIGHT.diff_pct)/Right.diff_pct)*100;  //not a good field.  need to do something about the magnitude of change vs size of bins.
					// SELF.Current_up := left.up_pct;
					// SELF.Expected_up := right.up_pct/3;
					SELF.Surprise_Up := left.up_pct - (right.up_pct/3);
					// SELF.Current_Down := left.down_pct;
					// SELF.Expected_Down := right.down_pct/3;
					SELF.Surprise_Down := left.down_pct - (right.down_pct/3);
					Self := [];
					), Full Outer);

DiffinDiff_avg4 := join(ds_CurrDiff, ds_SumPrev1_2_3_4, left.field = right.field,
			  TRANSFORM(DiffLay,
					SELF.Field := if(LEFT.field <> '', left.field, right.field);
					SELF.Current_diff := LEFT.diff_pct;
					SELF.Expected_diff := right.diff_pct/4;
					SELF.Surprise_change := LEFT.diff_pct - (RIGHT.diff_pct/4);
					// SELF.Surprise_pct := ((LEFT.diff_pct - RIGHT.diff_pct)/Right.diff_pct)*100;  //not a good field.  need to do something about the magnitude of change vs size of bins.
					// SELF.Current_up := left.up_pct;
					// SELF.Expected_up := right.up_pct/4;
					SELF.Surprise_Up := left.up_pct - (right.up_pct/4);
					// SELF.Current_Down := left.down_pct;
					// SELF.Expected_Down := right.down_pct/4;
					SELF.Surprise_Down := left.down_pct - (right.down_pct/4);
					Self := [];
					), Full Outer);



DiffinDiff_avg := map(
											count(MatchOnlyMaster) >= 5 => DiffinDiff_avg4,
											count(MatchOnlyMaster) = 4 => DiffinDiff_avg3,
											count(MatchOnlyMaster) = 3 => DiffinDiff_avg2,
											count(MatchOnlyMaster) = 2 => DiffinDiff_avg1);


sorted_DiffinDiff_avg := Sort(DiffinDiff_avg, -Abs(Surprise_change));

DiffinDiff_Report := sorted_DiffinDiff_avg;
// DiffinDiff_Report := output(sorted_DiffinDiff_avg, named('Report'));


//END DIFF REPORT CALCULATIONS










cert_ds_out_filter := cert_ds_out(field not in ['phone_shell__input_echo__in_processing_date']);

//calculating dropped and added sources
j_dropped := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, left only);								
j_new := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, right only);	
							
dropped := count(j_dropped);	
new := count(j_new);	

dropped_sources := table(j_dropped, {source_list, _count := count(group)}, source_list);
new_sources := table(j_new, {source_list, _count := count(group)}, source_list);

// output(dropped_sources, named('dropped_sources'));
// output(new_sources, named('new_sources'));



nonfcra_ds_curr := ds_mod_test;
nonfcra_ds_prev := ds_mod_base;

cleaned_nonfcra_curr_date := a1;
cleaned_nonfcra_prev_date := b1;

	nonfcra_join1 := JOIN(nonfcra_ds_curr, nonfcra_ds_prev,  LEFT.hashtag=RIGHT.hashtag, transform(left));
	nonfcra_clean_file := nonfcra_join1(hashtag <> '');


//designing emailed report
	MyRec := RECORD
		INTEGER order;
		STRING line;
	END;
max_diff := (STRING)cert_ds_out_filter[1].diff_pct	 + '%';
max_unexpected_diff := (STRING)DiffinDiff_Report[1].Surprise_change	 + '%';
		
		
		
	ds_no_diff := DATASET([{2, 'No differences exceeding the ' + thresh + '% threshold'}], MyRec);
	ds_no_diff_DiffReport := DATASET([{2, 'No differences'}], MyRec);
	ds_no_key_matches := DATASET([{2, 'No previous days matching current key changes'}], MyRec);
	
	STRING filler := '        ';

	cert_realtime := IF(COUNT(cert_ds_out_filter) > 0,
																		PROJECT(cert_ds_out_filter, TRANSFORM(MyRec, SELF.order := 2;
																		SELF.line := (TRIM(LEFT.Field[14..]) + filler)[1..75] + (LEFT.diff_cnt	 + filler)[1..10] + (LEFT.diff_pct	 + '%'+filler)[1..10]+ (left.up_cnt + filler)[1..10]    + (left.up_pct + '%'+filler)[1..10] + (left.down_cnt + filler)[1..10]    + (left.down_pct + '%')[1..10]     )),
																		ds_no_diff);

																		
	line_heading := ('Phone_Shell__ Field (Threshold: ' + thresh + '%)' + filler)[1..75] + ('Diff Cnt' + filler)[1..10] + ('Diff Pct' + filler)[1..10]+ ('Up Cnt' + filler)[1..10]+ ('Up Pct' + filler)[1..10]+('Down Cnt' + filler)[1..10] + ('Down Pct' + filler)[1..10];


//NEW DIFF Report
	cert_Diff := if(count(MatchOnlyMaster) > 1, 
									IF(COUNT(DiffinDiff_Report) > 0,
											PROJECT(DiffinDiff_Report, TRANSFORM(MyRec, SELF.order := 2;
											SELF.line := (TRIM(LEFT.Field[14..]) + filler)[1..78] + (left.Surprise_change + filler)[1..15]    + (LEFT.Current_Diff	 + filler)[1..15] + (LEFT.Expected_diff	 + filler)[1..15]+ (left.Surprise_up +filler)[1..15] + (left.Surprise_down + filler)[1..15])),
											ds_no_diff_DiffReport),
									ds_no_key_matches);

																		
	Diff_line_heading := ('Phone_Shell__ Field' + filler)[1..75] + ('Surprise Diff' + filler)[1..15]+ ('Current Diff' + filler)[1..15] + ('Expected Diff' + filler)[1..15]+ ('Surprise Up' + filler)[1..15]+('Surprise Down' + filler)[1..15];

//New Diff Report


filler2 := '                    ';
	ds_no_diff2 := DATASET([{2, 'No dropped sources '}], MyRec);
	ds_no_diff3 := DATASET([{2, 'No added sources '}], MyRec);
	
	cert_realtime_dropped := IF(COUNT(dropped_sources) > 0,
																		PROJECT(dropped_sources, TRANSFORM(MyRec, SELF.order := 2;
																		SELF.line := (TRIM(LEFT.source_list	) + filler2)[1..35] + (LEFT._count + filler2)[1..10] )),
																		ds_no_diff2);

																		
	line_heading_sources := ('source list' + filler2 + filler2)[1..35] + ('Count' + filler2)[1..10] ;

	cert_realtime_new := IF(COUNT(new_sources) > 0,
																		PROJECT(new_sources, TRANSFORM(MyRec, SELF.order := 2;
																		SELF.line := (TRIM(LEFT.source_list	) + filler2)[1..35] + (LEFT._count + filler2)[1..10] )),
																		ds_no_diff3);
	
	
	main_head := DATASET([{1,   'Phone Shell' + '\n'
												+ '*** This report is produced by Scoring QA ***' + '\n\n'
												}], MyRec); 		
			
real dp_pct := round((dropped/COUNT(nonfcra_clean_file))*100,2)		;		
				
	head_cert_realtime_dropped := DATASET([{1,    
													'Environment:  CERT - NONFCRA'	+ '\n'
												+ 'Archive date:  999999' + '\n'
												+ 'Previous run date:  ' + cleaned_nonfcra_prev_date + '\n'
												+ 'Current run date:  ' + cleaned_nonfcra_curr_date + '\n' 
												+ 'Previous phone count:  ' + COUNT(nonfcra_ds_prev) + '\n'
												+ 'Current phone count:  ' + COUNT(nonfcra_ds_curr) + '\n'
												+ 'Matched phone records:  ' + COUNT(nonfcra_clean_file) + '\n'
												+ 'Matched test case count:  ' + COUNT(Matched_test_case_base) + '\n'    //# of matched test cases with responses both days												
												+ '\n' 
												+ '\n' 
												+ 'Phones Dropped: 	' + dropped + '\n'  
												+ 'Percent Dropped: 	' + dp_pct + '\n'  
												+ '\n'
												+ line_heading_sources + '\n'
												+ '----------------------------------------'
												}], MyRec); 

real new_pct := round((new/COUNT(nonfcra_clean_file))*100,2);

	head_cert_realtime_new := DATASET([{1,    
												'Phones Gained: 	' + new + '\n'  
												+'Percent Gained: 	' + new_pct + '\n'  
												+ '\n'
												+ line_heading_sources + '\n'
												+ '----------------------------------------'
												}], MyRec); 			


Prev_Avg := (decimal5_2)ave(ds_mod_base, Phone_score);
Curr_Avg := (decimal5_2)ave(ds_mod_test, Phone_score);
Diff_Avg := (decimal5_2)(Curr_Avg - Prev_Avg);
DiffPct_Avg := (Curr_Avg - Prev_Avg)/Prev_Avg*100;
line_heading_avg := ('Field' + filler)[1..42] + ('Previous Avg' + filler)[1..15] + ('Current Avg' + filler)[1..15]+ ('Diff Avg' + filler)[1..14] + 'Diff Pct';

j_base_matched := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, Transform(mod_lay, Self := left));								
j_test_matched := join(ds_mod_base, ds_mod_test, left.hashtag = right.hashtag, transform(mod_lay, Self := right));	
Prev_Avg_matched := (decimal5_2)ave(j_base_matched, Phone_score);
Curr_Avg_matched := (decimal5_2)ave(j_test_matched, Phone_score);
Diff_Avg_matched := (decimal5_2)(Curr_Avg_matched - Prev_Avg_matched);
DiffPct_Avg_matched := (Diff_Avg_matched)/Prev_Avg_matched*100;

TopOneScore_matched_base := dedup(sort(j_base_matched, acctno, -phone_score), acctno);
TopOneScore_matched_test := dedup(sort(j_test_matched, acctno, -phone_score), acctno);

Prev_Avg_matched_TopOne := (decimal5_2)ave(TopOneScore_matched_base, Phone_score);
Curr_Avg_matched_TopOne := (decimal5_2)ave(TopOneScore_matched_test, Phone_score);
Diff_Avg_matched_TopOne := (decimal5_2)(Curr_Avg_matched_TopOne - Prev_Avg_matched_TopOne);
DiffPct_Avg_matched_TopOne := (Diff_Avg_matched_TopOne)/Prev_Avg_matched_TopOne*100;

// output(count(TopOneScore_matched_base));
// output(TopOneScore_matched_base);
// output(count(TopOneScore_matched_test));
// output(TopOneScore_matched_test);

	head_cert_realtime_avg := DATASET([{1,    
												line_heading_avg + '\n'
												+ '----------------------------------------------------------------------------------------------' + '\n'
												+('Phone_model_score(unmatched)' + filler)[1..45] + ((string)Round(Prev_Avg, 2) + filler)[1..14] + ((string)Round(Curr_Avg, 2) + filler)[1..14]+ ((string)Round(Diff_Avg, 2) + filler)[1..14]+ (string)Round(DiffPct_Avg,1) + '\n'
												+('Phone_model_score(matched)' + filler)[1..45] + ((string)Round(Prev_Avg_matched, 2) + filler)[1..14] + ((string)Round(Curr_Avg_matched, 2) + filler)[1..14]+ ((string)Round(Diff_Avg_matched, 2) + filler)[1..14]+ (string)Round(DiffPct_Avg_matched,1) + '\n'
												+('Phone_model_score(matched, top 1 score)' + filler)[1..45] + ((string)Round(Prev_Avg_matched_TopOne, 2) + filler)[1..14] + ((string)Round(Curr_Avg_matched_TopOne, 2) + filler)[1..14]+ ((string)Round(Diff_Avg_matched_TopOne, 2) + filler)[1..14]+ (string)Round(DiffPct_Avg_matched_TopOne,1)
												}], MyRec);
	
	head_cert_realtime := DATASET([{1,    												
												line_heading + '\n'
												+ '-------------------------------------------------------------------------------------------------------------------------------------'
												}], MyRec); 

//Diff Report
	head_cert_Diff := DATASET([{1,    												
												'Keys Actually Updated: 	' + KeysUpdated + '\n'  
												+'Previous Days Averaged: ' + ComparedDays + '\n' 												
												+ 'Keys Checked For:   ' + KeysChecked[1..90] + '\n'
												+ '                    ' + KeysChecked[90..] + '\n'
 												+ '\n'												
												+ Diff_line_heading + '\n'
												+ '----------------------------------------------------------------------------------------------------------------------------------------------------'
												}], MyRec); 

//Diff Report


												
	spacer := DATASET([{3,    
													'\n' 
												+ '\n' 
												+ '\n' 
												}], MyRec);
	
	spacer2 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 3; SELF := LEFT));
	spacer4 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 5; SELF := LEFT));
	spacer6 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 7; SELF := LEFT));
	spacer8 := PROJECT(spacer, TRANSFORM(MyRec, SELF.order := 9; SELF := LEFT));

	output_cert_realtime_dropped := PROJECT(SORT(head_cert_realtime_dropped + cert_realtime_dropped, order), TRANSFORM(MyRec, SELF.order := 2; SELF := LEFT));
	output_cert_realtime_new := PROJECT(SORT(head_cert_realtime_new + cert_realtime_new, order), TRANSFORM(MyRec, SELF.order := 4; SELF := LEFT));
	output_cert_realtime_avg := PROJECT(SORT(head_cert_realtime_avg, order), TRANSFORM(MyRec, SELF.order := 6; SELF := LEFT));
	output_cert_realtime := PROJECT(SORT(head_cert_realtime + cert_realtime, order), TRANSFORM(MyRec, SELF.order := 8; SELF := LEFT));
	output_cert_Diff := PROJECT(SORT(head_cert_Diff + cert_Diff, order), TRANSFORM(MyRec, SELF.order := 10; SELF := LEFT));

	output_append := main_head + output_cert_realtime_dropped +spacer2+output_cert_realtime_new+spacer4+output_cert_realtime_avg+spacer6+output_cert_realtime + spacer8 + output_cert_Diff;
	output_full := SORT(output_append, order);

	MyRec Xform(myrec L,myrec R) := TRANSFORM
			SELF.line := TRIM(L.line, LEFT) + '\n' + TRIM(R.line, LEFT); 
			self := l;
	END;

	XtabOut := ITERATE(output_full, Xform(LEFT, RIGHT));

// final := FileServices.SendEmail('Benjamin.Karnatz@lexisnexisrisk.com', 'PhoneShell Cert Tracking Report: MaxDiff ' + max_diff + ' Max Unexpected Diff ' + max_unexpected_diff, XtabOut[COUNT(XtabOut)].line);
final := FileServices.SendEmail('Benjamin.Karnatz@lexisnexisrisk.com;Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com;Blake.Huebner@lexisnexisrisk.com;Barbara.Gress@lexisnexisrisk.com;Brent.Sorenson@lexisnexisrisk.com;jim.corbin@lexisnexisrisk.com; Sheryl.Ramos@lexisnexisrisk.com;Daniel.Harkins@lexisnexisrisk.com; Noah.Lahr@lexisnexisrisk.com;Karen.Acuna@lexisnexisrisk.com;Lucky.Mores@lexisnexisrisk.com', 'PhoneShell Cert Tracking Report: MaxDiff ' + max_diff + ' Max Unexpected Diff ' + max_unexpected_diff, XtabOut[COUNT(XtabOut)].line);

return final;

END;

