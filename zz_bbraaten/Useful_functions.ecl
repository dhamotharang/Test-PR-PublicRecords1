#workunit('name', 'phonescore_analysis');
//************************************************************************************************************;		
dataset_you_are_using(	StringLib.StringFind(attribute, 'what_you_are_trying_to_find', 1) > 0);  //No idea what the 1 does, if you leave it alone it will output the max number of lines allowed by your ecl setttings.;
//************************************************************************************************************;		
OUTPUT(bus_shell_stats,, '~bbraaten::out::businessshell_21_Sprint6_SBFEInternalObservationPerfMonth_stats_' + thorlib.wuid(), THOR, expire(30));

//************************************************************************************************************;		

Distribution(Dataset_using, Attribute, NAMED('Stats'));

Post-processing the result with PARSE:
x := DATASET(ROW(TRANSFORM({STRING line},
       SELF.line := WORKUNIT('Stats', STRING))));
res := RECORD
  STRING Fieldname := XMLTEXT('@name');
  STRING Cnt := XMLTEXT('@distinct');
END;

out := PARSE(x, line, res, XML('XML/Field'));
out;
//************************************************************************************************************;		
import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP, scoring_qa;
//************************************************************************************************************;		
scoring_qa.COMPARE_DSETS_MACRO(clean_ds_1_flat, clean_ds_2_flat, ['hashtag'], 0);
Scoring_QA.CROSSTAB_MACRO(clean_ds_1_flat, clean_ds_2_flat, ['hashtag'], 'phone_model_score');

//************************************************************************************************************;		
ashirey.flatten(ds_mod_base,clean_ds_1_flat);
ashirey.flatten(ds_mod_test,clean_ds_2_flat);

//************************************************************************************************************;		

inputFile := '~lweiner::tmp::business_shell_results_sbfe_sprint5W20150921-133659_Default_HistPast.csv';
layout := zz_bbraaten.Bus_shell_21_Sprint6_layout;


ds_input := DATASET(inputFile, layout, CSV(HEADING(1), QUOTE('"')));

Slim_Lay := RECORD
	layout - inquiry2 - input_echo - clean_input - input - verification - business_activity - business_characteristics - firmographic - organizational_structure - sos - bankruptcy - lien_and_judgment - asset_information - public_record - tradeline - business_to_executive_link - business_to_person_link - input_characteristics - associates - data_build_dates - file_ind;
	string30 acctno;
END;

Slim_Lay Lay_trans(layout le) := TRANSFORM
	self.acctno := le.input_echo.acctno;
	self.sbfe := le.sbfe;
	self.errorcode := le.errorcode;
END;

//************************************************************************************************************;				
trans_lay2 := record
  string30 acctno;
	string3 l_score;
  string3 r_score;
  integer3 score_diff;
end;

trans_lay2 j_trans2(clean_ds_1_flat le, clean_ds_2_flat ri) := transform
	self.acctno  := le.acctno;
	self.r_score  := ri.tciaddr;
	self.l_score := le.tciaddr;
	self.score_diff  := (integer)le.tciaddr - (integer)ri.tciaddr;
end;		
		
		ds_join5 := join(clean_ds_1_flat, clean_ds_2_flat, 
			left.acctno = right.acctno 
			and left.tciaddr <> right.tciaddr AND RIGHT.ERRORCODE = '' AND LEFT.ERRORCODE = '', 
			j_trans2(left, right));		

//************************************************************************************************************;				
L1 := 300;
U1 := 649;
L2 := 650;
U2 := 680;
L3 := 681;
U3 := 729;
L4 := 730;
U4 := 764;
L5 := 765;

Baseline1 := count(clean_ds_1_flat((Integer)cmpyaddrscore <= U1 and (Integer)cmpyaddrscore >= L1));
Proposed1 := count(clean_ds_2_flat( (Integer)cmpyaddrscore <= U1 and (Integer)cmpyaddrscore >= L1));

Baseline2 := count(clean_ds_1_flat( (Integer)cmpyaddrscore <= U2 and (Integer)cmpyaddrscore >= L2));
Proposed2 := count(clean_ds_2_flat( (Integer)cmpyaddrscore <= U2 and (Integer)cmpyaddrscore >= L2));

Baseline3 := count(clean_ds_1_flat( (Integer)cmpyaddrscore <= U3 and (Integer)cmpyaddrscore >= L3));
Proposed3 := count(clean_ds_2_flat( (Integer)cmpyaddrscore <= U3 and (Integer)cmpyaddrscore >= L3));

Baseline4 := count(clean_ds_1_flat( (Integer)cmpyaddrscore <= U4 and (Integer)cmpyaddrscore >= L4));
Proposed4 := count(clean_ds_2_flat( (Integer)cmpyaddrscore <= U4 and (Integer)cmpyaddrscore >= L4));

Baseline5 := count(clean_ds_1_flat( (Integer) cmpyaddrscore >= L5));
Proposed5 := count(clean_ds_2_flat(  (Integer)cmpyaddrscore >= L5));


Total_Baseline := sum(Baseline1, Baseline2, Baseline3, Baseline4, Baseline5);
Total_Proposed := sum(Proposed1, Proposed2, Proposed3, Proposed4, Proposed5);

FreqDiff1 := (Proposed1 - Baseline1);
FreqDiff2 := (Proposed2 - Baseline2);
FreqDiff3 := (Proposed3 - Baseline3);
FreqDiff4 := (Proposed4 - Baseline4);
FreqDiff5 := (Proposed5 - Baseline5);

Percent_FreqDiff1 := (FreqDiff1/Baseline1)*100;
Percent_FreqDiff2 := (FreqDiff2/Baseline2)*100;
Percent_FreqDiff3 := (FreqDiff3/Baseline3)*100;
Percent_FreqDiff4 := (FreqDiff4/Baseline4)*100;
Percent_FreqDiff5 := (FreqDiff5/Baseline5)*100;

Baseline_Proportion1 := (Baseline1/Total_Baseline);
Baseline_Proportion2 := (Baseline2/Total_Baseline);
Baseline_Proportion3 := (Baseline3/Total_Baseline);
Baseline_Proportion4 := (Baseline4/Total_Baseline);
Baseline_Proportion5 := (Baseline5/Total_Baseline);

Proposed_Proportion1 := (Proposed1/Total_Proposed);
Proposed_Proportion2 := (Proposed2/Total_Proposed);
Proposed_Proportion3 := (Proposed3/Total_Proposed);
Proposed_Proportion4 := (Proposed4/Total_Proposed);
Proposed_Proportion5 := (Proposed5/Total_Proposed);

Proportion_Diff1 := (Proposed_Proportion1 - Baseline_Proportion1);
Proportion_Diff2 := (Proposed_Proportion2 - Baseline_Proportion2);
Proportion_Diff3 := (Proposed_Proportion3 - Baseline_Proportion3);
Proportion_Diff4 := (Proposed_Proportion4 - Baseline_Proportion4);
Proportion_Diff5 := (Proposed_Proportion5 - Baseline_Proportion5);

Baseline_mean := ave(clean_ds_1_flat, (integer)cmpyaddrscore);
Proposed_mean := ave(clean_ds_2_flat, (integer)cmpyaddrscore);

Mean_diff := (Proposed_mean - Baseline_mean);
Percent_mean_diff := (Mean_diff/Baseline_mean)*100;

MyRec := RECORD
	string10 Lower_Bound;
	string10 Upper_Bound;
	string10 Baseline_Freq;
	String10 Proposed_Freq;
	string10 Freq_diff;
	string10 Percent_Freq_diff;
	string10 Baseline_Prop;
	string10 Proposed_Prop;
	string10 Prop_diff;
END;


table1 := DATASET([{L1,U1,Baseline1,Proposed1,FreqDiff1,Percent_FreqDiff1,Baseline_Proportion1,Proposed_Proportion1,Proportion_Diff1},
									 {L2,U2,Baseline2,Proposed2,FreqDiff2,Percent_FreqDiff2,Baseline_Proportion2,Proposed_Proportion2,Proportion_Diff2},
									 {L3,U3,Baseline3,Proposed3,FreqDiff3,Percent_FreqDiff3,Baseline_Proportion3,Proposed_Proportion3,Proportion_Diff3},
									 {L4,U4,Baseline4,Proposed4,FreqDiff4,Percent_FreqDiff4,Baseline_Proportion4,Proposed_Proportion4,Proportion_Diff4},
									 {L5,'',Baseline5,Proposed5,FreqDiff5,Percent_FreqDiff5,Baseline_Proportion5,Proposed_Proportion5,Proportion_Diff5},
					         {'','AVE',Baseline_mean,Proposed_mean,Mean_diff,Percent_mean_diff,'','',''},
					         {'','Total',Total_Baseline,Total_Proposed,'','','','',''}],MyRec);
									 
output(table1);

//************************************************************************************************************;		
layout_2 := record
	layout;
	integer new_source_count;
	boolean same_count;
end;

ds_new := project(clean_ds_1, transform(layout_2,
								temp_count := if(left.verification.addrverificationsourcelist = '', 0 , LENGTH(Stringlib.StringFilter (left.verification.addrverificationsourcelist, ','))+ 1);
								self.new_source_count := temp_count;
								self.same_count := if((integer)left.verification.AddrVerificationSourceCount = -1, True, temp_count = (integer)left.verification.AddrVerificationSourceCount);
								self := left;
								));
								
output(count(ds_new(same_count = false)), named('bad_count'));
output(choosen(ds_new(same_count = false), 25), named('examples'));

//******************************************************************************************************************;
basefilename :=  '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20160113_1';          
testfilename := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20160114_1';  



Layout1 := zz_bbraaten2.Boca_41_Non_Cert_lay_old;  //old layout
Layout2 := zz_bbraaten2.Boca_41_Non_Cert_lay_new;	//new layout has 1 additional field


ds_baseline := dataset(basefilename, Layout1 , thor);
ds_new := dataset(testfilename, Layout2 , thor);

ds_baseline2 := project(ds_baseline, transform(Layout2, self.header_summary.lnames_on_file := ''; self := left));  //transforms and adds the missing field and gives a value of blank

output(choosen(ds_baseline2,5));
// Bocashell layout changes


	
clean_ds_new := project(clean_ds_new, transform(zz_bbraaten2.Boca_41_FCRA_Cert_lay_new, self := left));
clean_ds_baseline_full := project(clean_ds_baseline, transform(zz_bbraaten2.Boca_41_Non_Cert_lay_new - LnJ_datasets ,self := left, self := []));
clean_ds_baseline_full := project(clean_ds_baseline, transform(Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout,self := left, self := []));
clean_ds_new_full := project(clean_ds_new,  transform(Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout, self := left));
//******************************************************************************************************************;
//FCRA collections in cert 232 only;
fcra_roxieIP := 'http://10.173.232.' + (STRING)(thorlib.node() % 20 + 1) + ':9876';

//nonFCRA collections in cert 128/130 only;
fcra_roxieIP := 'http://10.173.128.' + (STRING)(thorlib.node() % 20 + 1) + ':9876';
fcra_roxieIP := 'http://10.173.130.' + (STRING)(thorlib.node() % 20 + 1) + ':9876';


Hit alpharetta DR 134
roxieIP_cert := 'http://10.192.134.' + (STRING)(thorlib.node() % 20 + 1) + ':9876';

//******************************************************************************************************************;

yesterday := ut.date_math(ut.getdate, -1);

//******************************************************************************************************************;

a2 := j5((integer)res[1].results.accountnumber = 22430);
// when joining left + right

//******************************************************************************************************************;
j5 := join(ds_join_baseline5, ds_join_second5, left.results.acctno = right.results.acctno
							AND (integer)LEFT.results.fp_score < (integer)RIGHT.results.fp_score,
							TRANSFORM(join_lay, SELF := LEFT ));

OUTPUT(count(j5), NAMED('fp_score5'));
OUTPUT(CHOOSEN(j5, 25), named('fp_score_count5'));

// s5:= set(j5, (integer)PII.SSN);

joins := (j1+j2+j3+j4+j5);
//******************************************************************************************************************;



RiskView3Table := table(joins,
	{
		pii.ssn,
		Total := count(group)
	},
	pii.ssn
);
output(RiskView3Table, named('joins'));

//******************************************************************************************************************;

out_lay := record
		string bef_val;
		string aft_val;
		integer diff;
end;

j1 := join(clean_ds_baseline, clean_ds_new, left.accountnumber = right.accountnumber,	transform(out_lay,
																																									self.bef_val := left.liencount;
																																									self.aft_val := right.liencount;
																																									self.diff := (integer)right.liencount - (integer)left.liencount;
																																									));
output(j1);

tbl := table(j1, {j1.diff, _count := count(group)}, diff);

output(tbl);
//******************************************************************************************************************;

// find string in 

ds_isn := full_lv2(Models.Common.Contains(party.orig_name, 'ISD'));
ds_school := full_lv2(Models.Common.Contains(party.orig_name, 'SCHOOL DIST'));
ds_indep := full_lv2(Models.Common.Contains(party.orig_name, 'INDEPENDENT SCHOOL'));

a4_PlaintiffList := ds_isn+ds_school+ds_indep;

// a4 := project(full_lv2(main.filing_jurisdiction = 'TX' and party.orig_name in a4_PlaintiffList and party.name_type = 'C'), append_filt(left, 'a4'));
a4 := project(a4_PlaintiffList(main.filing_jurisdiction = 'TX' and party.name_type = 'C'), append_filt(left, 'a4'));
output(choosen(a4, eyeball), named('a4'));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

j2 := join(slim_base, slim_newe, left.accountnumber = right.accountnumber
					AND LEFT.nonderogcount03	> RIGHT.nonderogcount03,

				transform({dataset(slim) res}, self.res := left + right));
					
OUTPUT(count(j2), NAMED('sourcenonderogcount03month_count'));
 OUTPUT(CHOOSEN(j2, 25), named('sourcenonderogcount03month'));

//v3 
j3 := join(slim_base_v3, slim_newe_v3, left.accountnumber = right.accountnumber
					AND LEFT.nonderogcount03	> RIGHT.nonderogcount03,

				transform({dataset(slim) res}, self.res := left + right));
					
OUTPUT(count(j3), NAMED('nonderogcount03_count_v3'));
 OUTPUT(CHOOSEN(j3, 25), named('nonderogcount03month_v3'));



j_full := join(j3, j2 , left.res[1].accountnumber = right.res[1].accountnumber
				and left.res[1].nonderogcount03 <> right.res[1].nonderogcount03,
					transform({dataset(slim) res}, self.res := left.res + right.res)); 					// transform({dataset(j3) res}, self.res := left + right));
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

'~foreign::' + _control.IPAddress.prod_thor_dali + '::'+