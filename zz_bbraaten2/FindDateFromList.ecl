import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP, models.common;
eyeball := 25;
basefilename := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20161122_1';            //NonFCRA     
testfilename := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20161123_1';  
Layout2 := zz_bbraaten2.Boca_41_Non_Cert_lay_new;   //NonFCRA


ds_baseline := dataset(basefilename, Layout2 , thor);
ds_new := dataset(testfilename, Layout2 , thor);

clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	
	// output(clean_ds_baseline ,named('Base_no_errors'));
	// output(clean_ds_new ,named('prop_no_errors'));
	
ashirey.flatten(clean_ds_baseline,clean_ds_1_flat);
ashirey.flatten(clean_ds_new,clean_ds_2_flat);
// scoring_project_pip.COMPARE_DSETS_MACRO(clean_ds_1_flat, clean_ds_2_flat, ['accountnumber'], 0);

// Scoring_Project_PIP.CROSSTAB_MACRO(clean_ds_1_flat, clean_ds_2_flat, ['accountnumber'],'header_summary__ver_sources');

		// output(dataset_you_are_using(	StringLib.StringFind(header_summary__ver_sources, 'TN', 1) > 0));
		
		
// phone_pos_cr := (Models.Common.findw_cpp(left.header_summary.ver_sources, 'TN' , ',', 'E'));

// source_cr_lseen := Models.Common.getw(header_summary.ver_sources_last_seen_date, phone_pos_cr);

		
		// ds_blank_left := join(ds_scores1, ds_scores2, left.accountnumber = right.accountnumber 
					// and right.felonies = '', transform(layout_input, self := left ));
			
		// ds_blank_right := join(ds_scores1, ds_scores2, left.accountnumber = right.accountnumber 
					// and right.felonies = '', transform(layout_input, self := right ));
			
		// j_left_lay:=record
		// recordof(ds_scores1); 
		// end;
			
// j_blank := (join(ds_blank_left, ds_blank_right,  left.accountnumber = right.accountnumber ,
					// transform({dataset (j_left_lay) res}, self.res := left + right) ));			
				
// output(count(j_blank ), named('Scores_That_Are_Blank_count'));			
// output(choosen(j_blank,eyeball ), named('Scores_That_Are_Blank'));	

		// ds_changed_left := join(ds_scores1, ds_scores2, left.accountnumber = right.accountnumber 
					// and left.felonies <> right.felonies
					// and right.felonies <> '', transform(layout_input, self := left ));
			
		// ds_changed_right := join(ds_scores1, ds_scores2, left.accountnumber = right.accountnumber 
					// and left.felonies <> right.felonies
					// and right.felonies <> '', transform(layout_input, self := right ));
					
	
// j_changed := (join(ds_changed_left, ds_changed_right,  left.accountnumber = right.accountnumber ,
					// transform({dataset (j_left_lay) res}, self.res := left + right) ));			
			
// output(count(j_changed ), named('Scores_That_Changed_count'));		
// output(choosen(j_changed ,eyeball), named('Scores_That_Changed'));		
			
			
		// ds_not_changed_left := join(ds_scores1, ds_scores2, left.accountnumber = right.accountnumber 
					// and left.felonies = right.felonies
					// and (integer)right.felonies <> 0, transform(layout_input, self := left ));
																				
		// ds_not_changed_right := join(ds_scores1, ds_scores2, left.accountnumber = right.accountnumber 
					// and left.felonies = right.felonies
					// and (integer)right.felonies <> 0, transform(layout_input, self := right ));
			
// j_3 := (join(ds_not_changed_left, ds_not_changed_right,  left.accountnumber = right.accountnumber ,
					// transform({dataset (j_left_lay) res}, self.res := left + right) ));		
																								

// output(count(j_3 ), named('Scores_Not_Changed_count'));		
// output(choosen(j_3 ,eyeball),named('Scores_Not_Changed'));				
						
			
// phone_pos_cr := (Models.Common.findw_cpp(le.header_summary.ver_sources, 'TN', ',', ''));

trans_lay2 := record

  string30 accountnumber;
	string100 l_source;
	string100 r_source;
	integer8 l_source_spot;
  integer8 r_source_spot;
	qstring200 l_last_seen;
	qstring200 r_last_seen;
	string100 l_date;
	string100 r_date;
	string l_num_nonderogs180;
	string r_num_nonderogs180;
	string l_num_nonderogs;
	string r_num_nonderogs;
  // integer8 score_diff;
 	unsigned6 did;
	
end;

trans_lay2 j_trans2(in_lay le, in_lay ri) := transform
	self.accountnumber  := le.accountnumber;
	self.l_source				:= le.header_summary.ver_sources;
	self.r_source				:= ri.header_summary.ver_sources;
	self.l_last_seen 		:= le.header_summary.ver_sources_last_seen_date;
	self.r_last_seen 		:= ri.header_summary.ver_sources_last_seen_date;
	self.l_source_spot  := (roundup((Models.Common.findw_cpp(le.header_summary.ver_sources, 'FB', ' ,'))*(1/3)));
	self.r_source_spot 	:= (roundup((Models.Common.findw_cpp(ri.header_summary.ver_sources, 'FB', ' ,'))*(1/3)));
	self.l_date      	  := Models.Common.getw(le.header_summary.ver_sources_last_seen_date, (roundup((Models.Common.findw_cpp(le.header_summary.ver_sources, 'FB', ' ,'))*(1/3))), ', ');
	self.r_date      	  := Models.Common.getw(ri.header_summary.ver_sources_last_seen_date, (roundup((Models.Common.findw_cpp(ri.header_summary.ver_sources, 'FB', ' ,'))*(1/3))), ', ');
	self.l_num_nonderogs180 := le.source_verification.num_nonderogs180;
	self.r_num_nonderogs180 := ri.source_verification.num_nonderogs180;
	self.l_num_nonderogs := le.source_verification.num_nonderogs ;
	self.r_num_nonderogs  := ri.source_verification.num_nonderogs ;
	
	// self.score_diff  := (integer)le.header_summary__ver_sources - (integer)ri.header_summary__ver_sources;
	self.did := le.did;
	
end;		
		
	ds_join4 := join(clean_ds_1_flat, clean_ds_2_flat, 
			left.accountnumber = right.accountnumber
			AND left.source_verification.num_nonderogs180 < RIGHT.source_verification.num_nonderogs180
			AND left.source_verification.num_nonderogs = RIGHT.source_verification.num_nonderogs,
			// j_trans2(left, right));		
			transform({dataset(j_trans2) res}, self.res := left + right));	
		
output(choosen(ds_join4,30));		
		
// ds_join4(StringLib.StringFind(l_source, 'TN', 1) > 0);
// ds_join4(StringLib.StringFind(r_source, 'TN', 1) > 0);




// source_cr_lseen1 := Models.Common.getw(le.header_summary.ver_sources_last_seen_date, l_source);
// source_cr_lseen2 := Models.Common.getw(ri.header_summary.ver_sources_last_seen_date, r_source);


// ri.header_summary.ver_sources
	// ri.header_summary.ver_sources_last_seen_date
	
				// ds_join5 := join(clean_ds_1, clean_ds_2, 
			// left.accountnumber = right.accountnumber 
			// and left.header_summary.ver_sources_last_seen_date <> right.header_summary.ver_sources_last_seen_date, 
			// j_trans2(left, right));
		
		// output(ds_join5);
		
		// ds_join6 := join(clean_ds_1, clean_ds_2, 
			// left.accountnumber = right.accountnumber 
			// and left.source_verification.adl_en_last_seen > right.source_verification.adl_en_last_seen, 
			// j_trans2(left, right));
				
		// ds_join7 := join(clean_ds_1, clean_ds_2, 
			// left.accountnumber = right.accountnumber 
			// and left.source_verification.adl_en_last_seen < right.source_verification.adl_en_last_seen, 
			// j_trans2(left, right));
		
		// output((ds_join5((string)score_diff <> '0' and (string)r_score <> '')), named('Change_in_scores'));
		// output(count(ds_join5((string)score_diff <> '0' and (string)r_score <> '')), named('Change_in_scoresCount'));
		// output((ds_join6((string)score_diff <> '0' and (string)r_score <> '')), named('Change_in_scoresbaseNewer'));
		// output(count(ds_join6((string)score_diff <> '0' and (string)r_score <> '')), named('Change_in_scoresbaseNewerCount'));
		// output((ds_join7((string)score_diff <> '0' and (string)r_score <> '')), named('Change_in_scoresSecondNewer'));
		// output(count(ds_join7((string)score_diff <> '0' and (string)r_score <> '')), named('Change_in_scoresSecondNewerCount'));
		
		
				output(choosen(ds_join4((integer)l_date = 201507 and (integer)r_date = 201507 ), 5), named('b07andp_201507'));
a1 := (count(ds_join4((integer)l_date = 201507 and (integer)r_date = 201507)));
		
				output(choosen(ds_join4((integer)l_date = 201507 and (integer)r_date = 201508 ), 5), named('b07andp_201508'));
b1 := (count(ds_join4((integer)l_date = 201507 and (integer)r_date = 201508)));
		
				output(choosen(ds_join4((integer)l_date = 201507 and (integer)r_date = 201509 ), 5), named('b07andp_201509'));
c1 := (count(ds_join4((integer)l_date = 201507 and (integer)r_date = 201509)));
		
				output(choosen(ds_join4((integer)l_date = 201507 and (integer)r_date = 201510 ), 5), named('b07andp_201510'));
d1 := (count(ds_join4((integer)l_date = 201507 and (integer)r_date = 201510)));
		
				
				output(choosen(ds_join4((integer)l_date = 201508 and (integer)r_date = 201507 ), 5), named('b08andp_201507'));
a2 := (count(ds_join4((integer)l_date = 201508 and (integer)r_date = 201507)));
		
				output(choosen(ds_join4((integer)l_date = 201508 and (integer)r_date = 201508 ), 5), named('b08andp_201508'));
b2 := (count(ds_join4((integer)l_date = 201508 and (integer)r_date = 201508)));
		
				output(choosen(ds_join4((integer)l_date = 201508 and (integer)r_date = 201509 ), 5), named('b08andp_201509'));
c2 := (count(ds_join4((integer)l_date = 201508 and (integer)r_date = 201509)));
		
				output(choosen(ds_join4((integer)l_date = 201508 and (integer)r_date = 201510 ), 5), named('b08andp_201510'));
d2 := (count(ds_join4((integer)l_date = 201508 and (integer)r_date = 201510)));
		
		
						output(choosen(ds_join4((integer)l_date = 201509 and (integer)r_date = 201507 ), 5), named('b09andp_201507'));
a3 := (count(ds_join4((integer)l_date = 201509 and (integer)r_date = 201507)));
		
				output(choosen(ds_join4((integer)l_date = 201509 and (integer)r_date = 201508 ), 5), named('b09andp_201508'));
b3 := (count(ds_join4((integer)l_date = 201509 and (integer)r_date = 201508)));
		
				output(choosen(ds_join4((integer)l_date = 201509 and (integer)r_date = 201509 ), 5), named('b09andp_201509'));
c3 := (count(ds_join4((integer)l_date = 201509 and (integer)r_date = 201509)));
		
				output(choosen(ds_join4((integer)l_date = 201509 and (integer)r_date = 201510 ), 5), named('b09andp_201510'));
d3 := (count(ds_join4((integer)l_date = 201509 and (integer)r_date = 201510)));



						output(choosen(ds_join4((integer)l_date = 201510 and (integer)r_date = 201507 ), 5), named('b10andp_201507'));
a4 := (count(ds_join4((integer)l_date = 201510 and (integer)r_date = 201507)));
		
				output(choosen(ds_join4((integer)l_date = 201510 and (integer)r_date = 201508 ), 5), named('b10andp_201508'));
b4 := (count(ds_join4((integer)l_date = 201510 and (integer)r_date = 201508)));
		
				output(choosen(ds_join4((integer)l_date = 201510 and (integer)r_date = 201509 ), 5), named('b10andp_201509'));
c4 := (count(ds_join4((integer)l_date = 201510 and (integer)r_date = 201509)));
		
				output(choosen(ds_join4((integer)l_date = 201510 and (integer)r_date = 201510 ), 5), named('b10andp_201510'));
d4 := (count(ds_join4((integer)l_date = 201510 and (integer)r_date = 201510)));



MyRec := RECORD
	integer8 Proposed07;
	integer8 Proposed08;
	integer8 Proposed09;
	integer8 Proposed10;
	end;


table1 := DATASET([{a1,b1,c1,d1},
									 {a2,b2,c2,d2},
					         {a3,b3,c3,d3},
					         {a4,b4,c4,d4}],MyRec);
									 
									 
output(table1);

				output(choosen(ds_join4((integer)l_date = 201507), 5), named('b07'));
base1 := (count(ds_join4((integer)l_date = 201507)));
				output(choosen(ds_join4((integer)l_date = 201508), 5), named('b08'));
base2 := (count(ds_join4((integer)l_date = 201508)));
				output(choosen(ds_join4((integer)l_date = 201509), 5), named('b09'));
base3 := (count(ds_join4((integer)l_date = 201509)));
				output(choosen(ds_join4((integer)l_date = 201510), 5), named('b10'));
base4 := (count(ds_join4((integer)l_date = 201510)));

				output(choosen(ds_join4((integer)r_date = 201507), 5), named('p07'));
prop1 := (count(ds_join4((integer)r_date = 201507)));
				output(choosen(ds_join4((integer)r_date = 201508), 5), named('p08'));
prop2 := (count(ds_join4((integer)r_date = 201508)));
				output(choosen(ds_join4((integer)r_date = 201509), 5), named('p09'));
prop3 := (count(ds_join4((integer)r_date = 201509)));
				output(choosen(ds_join4((integer)r_date = 201510), 5), named('p10'));
prop4 := (count(ds_join4((integer)r_date = 201510)));




MyRec2 := RECORD
	integer8 Baseline;
	integer8 Proposed;
end;


table2 := DATASET([{base1,prop1},
									 {base2,prop2},
					         {base3,prop3},
					         {base4,prop4,}],MyRec2);
									 
	output(table2);