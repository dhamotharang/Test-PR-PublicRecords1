


import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking,ut,sghatti,Gateway, Scoring_Project_ISS,Phone_Shell,Risk_Indicators,Business_Risk_BIP,Models;
thresh := 0;
eyeball := 10;
input_layout := Record
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus - Raw_Input - Clean_Input - Clam Phone_Shell;
	Risk_Indicators.Layout_Boca_Shell - LnJ_datasets - ConsumerStatements - bk_chapters Boca_Shell;
END;

slim_rec := RECORD
  string50 acctno;
  string10 gathered_phone;
  integer phone_score;
  string200 source_list;
	STRING200 Source_Owner_DID;
	STRING200 Source_Owner_Name_Prefix;
	STRING200 Source_Owner_Name_First;
	STRING200 Source_Owner_Name_Middle;
	STRING200 Source_Owner_Name_Last;
	STRING200 Source_Owner_Name_Suffix;
	STRING200 Source_List_Last_Seen;
	STRING200 Source_List_First_Seen	;
	integer count_list	;
END;

slim_rec Num_trans(input_layout le) := TRANSFORM
	self.acctno := le.phone_shell.input_echo.acctno;
	self.gathered_phone := le.phone_shell.gathered_phone;
	self.phone_score := (integer)le.phone_shell.phone_model_score;
	self.source_list := le.phone_shell.sources.source_list;
	self.Source_Owner_DID := le.phone_shell.sources.Source_Owner_DID;
	self.Source_Owner_Name_Prefix := le.phone_shell.sources.Source_Owner_Name_Prefix;
	self.Source_Owner_Name_First := le.phone_shell.sources.Source_Owner_Name_First;
	self.Source_Owner_Name_Middle := le.phone_shell.sources.Source_Owner_Name_Middle;
	self.Source_Owner_Name_Last := le.phone_shell.sources.Source_Owner_Name_Last;
	self.Source_Owner_Name_Suffix := le.phone_shell.sources.Source_Owner_Name_Suffix;
	self.Source_List_Last_Seen := le.phone_shell.sources.Source_List_Last_Seen;
	self.Source_List_First_Seen := le.phone_shell.sources.Source_List_First_Seen;
	self.count_list := STD.Str.CountWords(le.phone_shell.sources.source_list, ','),
	self := [];
END; 


   	a:= ut.GetDate;
	
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);

	a1:= a +'_1';
	b1:= b +'_1';
	// b1:= '20180817'+'_1';

model := 'COLLECTIONSCORE_V3';
model2 := 'PHONESCORE_V2';
ds_base := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ b1, input_layout, thor);
ds_test := dataset('~ScoringQA::out::phone_shell_'+model+'_Cert_'+ a1, input_layout, thor);



ds_trans_base := project(ds_base, num_trans(left));
ds_trans_test := project(ds_test, num_trans(left));

mod_lay := record
	string hashtag;
	slim_rec;
end;

ds_mod_base := project(ds_trans_base, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));
ds_mod_test := project(ds_trans_test, transform(mod_lay, self.hashtag := trim(left.acctno, left, right) + trim(left.gathered_phone, left, right); self := left));


output(choosen(ds_mod_base, 10), named('ds_mod_base'));
count(ds_mod_base);				

output(choosen(ds_mod_test, 10), named('ds_mod_test'));
count(ds_mod_test);				


mod_lay trans2(recordof(ds_mod_base) le, integer c) := TRANSFORM
	self.hashtag := le.hashtag;
	self.acctno := le.acctno;
	self.gathered_phone := le.gathered_phone;
	self.phone_score := (integer)le.phone_score;
SL := STD.Str.SplitWords(le.source_list, ',');
SD := STD.Str.SplitWords(le.Source_Owner_DID, ',');
SNP := STD.Str.SplitWords(le.Source_Owner_Name_Prefix, ',');
SNF := STD.Str.SplitWords(le.Source_Owner_Name_First, ',');
SNM := STD.Str.SplitWords(le.Source_Owner_Name_Middle, ',');
SNL := STD.Str.SplitWords(le.Source_Owner_Name_Last, ',');
SNS := STD.Str.SplitWords(le.Source_Owner_Name_Suffix, ',');
SLSD := STD.Str.SplitWords(le.Source_List_Last_Seen, ',');
SFSD := STD.Str.SplitWords(le.Source_List_First_Seen, ',');

	self.source_list := CHOOSE((integer)c, SL[c]);
	self.Source_Owner_DID := CHOOSE((integer)c, SD[c]);
	self.Source_Owner_Name_Prefix := CHOOSE((integer)c, SNP[c]);
	self.Source_Owner_Name_First := CHOOSE((integer)c, SNF[c]);
	self.Source_Owner_Name_Middle := CHOOSE((integer)c, SNM[c]);
	self.Source_Owner_Name_Last := CHOOSE((integer)c, SNL[c]);
	self.Source_Owner_Name_Suffix := CHOOSE((integer)c, SNS[c]);
	self.Source_List_Last_Seen := CHOOSE((integer)c, SLSD[c]);
	self.Source_List_First_Seen := CHOOSE((integer)c, SFSD[c]);

	self := le;
	self := [];
END; 

dset_slim1 := NORMALIZE(ds_mod_base,  left.count_list,trans2(LEFT,COUNTER));
dset_slim2 := NORMALIZE(ds_mod_test,  left.count_list,trans2(LEFT,COUNTER));

output(choosen(dset_slim1, 10), named('dset_slim1'));
count(dset_slim1);				

output(choosen(dset_slim2, 10), named('dset_slim2'));
count(dset_slim2);	

new_j_lay:= record
string uniqueid;
mod_lay - count_list;
end;

base := project(dset_slim1, transform(new_j_lay, self.uniqueid := trim(left.hashtag, left, right) + trim(left.source_list, left, right); self := left));
second := project(dset_slim2, transform(new_j_lay, self.uniqueid := trim(left.hashtag, left, right) + trim(left.source_list, left, right); self := left));

Scoring_Project_PIP.Compare_dsets_macro_email(base, second, ['uniqueid'], thresh);

output(choosen(base, 10), named('base'));
count(base);				

output(choosen(second, 10), named('second'));
count(second);	

base_tbl_src := table(base,{source_list,	Total := count(group)	},source_list);
output(base_tbl_src, named('base_tbl_src'));

second_tbl_src := table(second,{source_list,	Total := count(group)	},source_list);
output(second_tbl_src, named('second_tbl_src'));

cmpr := record
	recordof(base_tbl_src) base;
	recordof(second_tbl_src) test;
	integer Diff;
end;

datetime_join := join(base_tbl_src, second_tbl_src, left.source_list=right.source_list,
	transform(cmpr, self.base := left, self.test := right, self.Diff := right.total - left.total),
	full outer);
output(datetime_join, all,  named('full_source'));

j1 := join(base, second, left.uniqueid = right.uniqueid, 
									transform({dataset(new_j_lay) res}, self.res := left));
	output(choosen(j1, 10), named('left_ds_output_match'));
	c1 := count(j1);
	output(c1, named('left_ds_output_Match_count'));

j2 := join(base, second, left.uniqueid = right.uniqueid, 
									transform({dataset(new_j_lay) res}, self.res := right));
	output(choosen(j2, 10), named('right_ds_output_Match'));
	c2 := count(j2);
	output(c2, named('right_ds_output_Match_count'));

//dropped
j3 := join(base, second, left.uniqueid = right.uniqueid, left only);
	output(choosen(j3, 10), named('left_ds_output_ONLY'));
	c3 := count(j3);
	output(c3, named('left_ds_output_ONLY_count'));

cmpr2 := record
	recordof(base_tbl_src) dropped;
	recordof(second_tbl_src) added;
	integer Diff;
end;

//added
j4 := join(base, second, left.uniqueid = right.uniqueid, right only);
	output(choosen(j4, 10), named('right_ds_output_ONLY'));
	c4 := count(j4);
	output(c4, named('right_ds_output_ONLY_count'));
	
dropped_tbl_src := table(j3,{source_list,	Total := count(group)	},source_list);
output(dropped_tbl_src, named('dropped_tbl_src'));

added_tbl_src := table(j4,{source_list,	Total := count(group)	},source_list);
output(added_tbl_src, named('added_tbl_src'));

datetime_join_se := join(dropped_tbl_src, added_tbl_src, left.source_list=right.source_list,
	transform(cmpr2, self.dropped := left, self.added := right, self.Diff := right.total - left.total),
	full outer);
output(datetime_join_se, all,  named('diff_source'));


j_dates := join(base, second, left.uniqueid = right.uniqueid
												and left.source_list_last_seen <> right.source_list_last_seen,
									transform({dataset(new_j_lay) res}, self.res := left + right));
	output(choosen(j_dates, 10), named('J_dates'));
	c_dates := count(j_dates);
	output(c_dates, named('J_dates_counts'));

EXPORT PhoneShell_Parse_Sources := 'todo';