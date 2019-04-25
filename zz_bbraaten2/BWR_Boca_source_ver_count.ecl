import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP, zz_bbraaten2, Models;
eyeball := 20;



// basefilename := ut.foreign_prod + 'nmontpetit::out::bs_41_cert_tracking_full_nonfcra_151209_999999';            //change tracking to cert_tracking     
// testfilename := ut.foreign_prod + 'nmontpetit::out::bs_41_cert_tracking_full_nonfcra_151210_999999';             //change fcra to nonfcra

basefilename :=  '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20160811_1';            //change tracking to cert_tracking     
testfilename := '~scoringqa::out::nonfcra::bocashell_41_historydate_999999_cert_20160812_1';  

// ds_baseline := dataset(basefilename,Layout, csv(quote('"'), maxlength(32000), HEADING(1)));
// ds_new := dataset(testfilename,Layout, csv(quote('"'), maxlength(32000), HEADING(1)));

// Layout1 := zz_bbraaten2.Boca_41_Non_Cert_lay_old;
Layout2 := zz_bbraaten2.Boca_41_Non_Cert_lay_new;


ds_baseline := dataset(basefilename, Layout2 , thor);
ds_new := dataset(testfilename, Layout2 , thor);

// output(choosen(ds_new, 5));

// ds_baseline2 := project(ds_baseline, transform(Layout2, self.header_summary.lnames_on_file := ''; self := left));

// output(choosen(ds_baseline2,5));

// output(ds_baseline ,named('Base_input'));
// output(ds_new ,named('Prop_input'));


	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
	
	output(count(clean_ds_baseline(errorcode <> '')),named('base_errors_count'));
	output(count(clean_ds_new(errorcode <> '')),named('prop_errors_count'));
	
	
	// output(clean_ds_baseline ,named('Base_no_errors'));
	// output(clean_ds_new ,named('prop_no_errors'));

ashirey.flatten(clean_ds_baseline,clean_ds_1_flat);
ashirey.flatten(clean_ds_new,clean_ds_2_flat);
	// self.l_score  := le.header_summary__ver_fname_sources_recordcount;
	// self.r_sources  := ri.header_summary__ver_fname_sources;

trans_lay2 := record

  string30 accountnumber;
	string100 l_source;
	string100 r_source;
	integer8 l_tn_source_spot;
  integer8 r_tn_source_spot;
	qstring200 l_last_seen;
	qstring200 r_last_seen;
	string100 l_tn_date;
	string100 r_tn_date;

  integer8 score_diff;
 	unsigned6 did;
	
end;

trans_lay2 j_trans2(clean_ds_baseline le, clean_ds_new ri) := transform
	self.accountnumber  := le.accountnumber;
	self.l_source				:= le.header_summary.ver_fname_sources;
	self.r_source				:= ri.header_summary.ver_fname_sources;
	self.l_last_seen 		:= le.header_summary.ver_fname_sources_recordcount;
	self.r_last_seen 		:= ri.header_summary.ver_fname_sources_recordcount;
	self.l_tn_source_spot  := (roundup((Models.Common.findw_cpp(le.header_summary.ver_fname_sources, 'TN', ' ,'))*(1/3)));
	self.r_tn_source_spot 	:= (roundup((Models.Common.findw_cpp(ri.header_summary.ver_fname_sources, 'TN', ' ,'))*(1/3)));
	self.l_tn_date      	  := Models.Common.getw(le.header_summary.ver_fname_sources_recordcount, (roundup((Models.Common.findw_cpp(le.header_summary.ver_fname_sources, 'TN', ' ,'))*(1/3))), ', ');
	self.r_tn_date      	  := Models.Common.getw(ri.header_summary.ver_fname_sources_recordcount, (roundup((Models.Common.findw_cpp(ri.header_summary.ver_fname_sources, 'TN', ' ,'))*(1/3))), ', ');
	self.score_diff  := (integer)l_tn_date - (integer)r_tn_date;
	self.did := le.did;
	
end;		
		
	ds_join4 := join(clean_ds_baseline, clean_ds_new, 
			left.accountnumber = right.accountnumber and
			left.l_tn_date > right.r_tn_date,			
			dataset(trans_lay2)(left , right));		
						// transform({dataset(Layout2) res}, self.res := left + right));

output(ds_join4);		
count(ds_join4);		
		

		
			// output(choosen(ds_join4((integer)l_tn_date = (integer) r_tn_date ), 10), named('l_eq_r'));
// (count(ds_join4((integer)l_tn_date =(integer)r_tn_date and did <> 0)));
		
		
					// output(choosen(ds_join4((integer)l_tn_date <>  (integer) r_tn_date ), 10), named('l_deq_r'));
// (count(ds_join4((integer)l_tn_date <>(integer)r_tn_date )));

					// output(choosen(ds_join4((integer)l_tn_date <  (integer)r_tn_date ), 10), named('l_lt_r'));
// (count(ds_join4((integer)l_tn_date < (integer)r_tn_date )));

					// output(choosen(ds_join4((integer)l_tn_date >  (integer)r_tn_date ), 10), named('l_gt_r'));
// (count(ds_join4((integer)l_tn_date > (integer)r_tn_date )));
		
	
		
		
	// output(choosen(ds_join4((integer)l_tn_date = 0),10),named('left_dt_eq_zero'));
		// (count(ds_join4(((integer)l_tn_date = 0))));
				
		
		// output(choosen(ds_join4((integer)r_tn_date = 0),10),named('right_dt_eq_zero'));
		// (count(ds_join4(((integer)r_tn_date = 0))));
		
			// ds_join5 := join(clean_ds_baseline, clean_ds_new,  
			// left.accountnumber = right.accountnumber ,		
						// lay3(left, right));
			
			// ds_join6 := join(clean_ds_1_flat, clean_ds_2_flat, 
			// left.accountnumber = right.accountnumber 
			// and (integer)left.address_verification__input_address_information__assessed_value_year <> (integer)right.address_verification__input_address_information__assessed_value_year,
						// lay3(left, right));
		 

		
		// output((ds_join5));
		// output((ds_join6));		
				
		
		
		
		
		// trans_lay3 := record
	// string30 accountnumber;
	// string30 l_score;
	// string30 r_score;
	// integer8 score_diff;
 	// unsigned6 did;
		// end;
		
		
		// trans_lay3 lay3(clean_ds_1_flat le, clean_ds_2_flat ri) := transform
		// self.accountnumber  := le.accountnumber;
	// self.l_score				:= Models.Common.getw(le.header_summary.ver_sources_last_seen_date, (roundup((Models.Common.findw_cpp(le.header_summary.ver_sources, 'TN', ' ,'))*(1/3))), ', ');
	// self.r_score				:= ri.address_verification__input_address_information__assessed_value_year;
	// self.score_diff  := (integer)le.address_verification__input_address_information__assessed_value_year - (integer)ri.address_verification__input_address_information__assessed_value_year;
	// self.did := le.did;
		// end;
		
			
			// ds_join3 := join(clean_ds_1_flat, clean_ds_2_flat, 
			// left.accountnumber = right.accountnumber ,		
						// lay3(left, right));
			
			// ds_join4 := join(clean_ds_1_flat, clean_ds_2_flat, 
			// left.accountnumber = right.accountnumber 
			// and (integer)left.address_verification__input_address_information__assessed_value_year <> (integer)right.address_verification__input_address_information__assessed_value_year,
						// lay3(left, right));
		 

		
		// output((ds_join3));
		// output((ds_join4));		
		
		
		
		
		
			
		
				// output(choosen(ds_join4((integer)l_tn_date = 201512 and (integer)r_tn_date = 201512 ), 5), named('nochange'));
 // (count(ds_join4((integer)l_tn_date = 201512 and (integer)r_tn_date = 201512)));

			// output(choosen(ds_join4((integer)l_tn_date = 201510 and (integer)r_tn_date = 201512 ), 5), named('ten_to_tw'));
// (count(ds_join4((integer)l_tn_date = 201510 and (integer)r_tn_date = 201512)));
		
				// output(choosen(ds_join4((integer)l_tn_date = 201510 and (integer)r_tn_date = 0 ), 5), named('ten_to_zero'));
// (count(ds_join4((integer)l_tn_date = 201510 and (integer)r_tn_date = 0)));
		
				// output(choosen(ds_join4((integer)l_tn_date < 201510 and (integer)r_tn_date = 201512 ), 5), named('lt10_to_tw'));
// (count(ds_join4((integer)l_tn_date < 201510 and (integer)r_tn_date = 201512)));
		
						// output(choosen(ds_join4((integer)l_tn_date = 201512 and (integer)r_tn_date < 201512 ), 5), named('tw_to_lttw'));
 // (count(ds_join4((integer)l_tn_date = 201512 and (integer)r_tn_date < 201512)));	


	
				// output(choosen(ds_join4((integer)l_date = 201508 and (integer)r_tn_date = 201507 ), 5), named('b08andp_201507'));
// a2 := (count(ds_join4((integer)l_date = 201508 and (integer)r_date = 201507)));
		
				// output(choosen(ds_join4((integer)l_date = 201508 and (integer)r_date = 201508 ), 5), named('b08andp_201508'));
// b2 := (count(ds_join4((integer)l_date = 201508 and (integer)r_date = 201508)));
		
				// output(choosen(ds_join4((integer)l_date = 201508 and (integer)r_date = 201509 ), 5), named('b08andp_201509'));
// c2 := (count(ds_join4((integer)l_date = 201508 and (integer)r_date = 201509)));
		
				// output(choosen(ds_join4((integer)l_date = 201508 and (integer)r_date = 201510 ), 5), named('b08andp_201510'));
// d2 := (count(ds_join4((integer)l_date = 201508 and (integer)r_date = 201510)));
		
		
						// output(choosen(ds_join4((integer)l_date = 201509 and (integer)r_date = 201507 ), 5), named('b09andp_201507'));
// a3 := (count(ds_join4((integer)l_date = 201509 and (integer)r_date = 201507)));
		
				// output(choosen(ds_join4((integer)l_date = 201509 and (integer)r_date = 201508 ), 5), named('b09andp_201508'));
// b3 := (count(ds_join4((integer)l_date = 201509 and (integer)r_date = 201508)));
		
				// output(choosen(ds_join4((integer)l_date = 201509 and (integer)r_date = 201509 ), 5), named('b09andp_201509'));
// c3 := (count(ds_join4((integer)l_date = 201509 and (integer)r_date = 201509)));
		
				// output(choosen(ds_join4((integer)l_date = 201509 and (integer)r_date = 201510 ), 5), named('b09andp_201510'));
// d3 := (count(ds_join4((integer)l_date = 201509 and (integer)r_date = 201510)));



						// output(choosen(ds_join4((integer)l_date = 201510 and (integer)r_date = 201507 ), 5), named('b10andp_201507'));
// a4 := (count(ds_join4((integer)l_date = 201510 and (integer)r_date = 201507)));
		
				// output(choosen(ds_join4((integer)l_date = 201510 and (integer)r_date = 201508 ), 5), named('b10andp_201508'));
// b4 := (count(ds_join4((integer)l_date = 201510 and (integer)r_date = 201508)));
		
				// output(choosen(ds_join4((integer)l_date = 201510 and (integer)r_date = 201509 ), 5), named('b10andp_201509'));
// c4 := (count(ds_join4((integer)l_date = 201510 and (integer)r_date = 201509)));
		
				// output(choosen(ds_join4((integer)l_date = 201510 and (integer)r_date = 201510 ), 5), named('b10andp_201510'));
// d4 := (count(ds_join4((integer)l_date = 201510 and (integer)r_date = 201510)));



// MyRec := RECORD
	// integer8 Proposed07;
	// integer8 Proposed08;
	// integer8 Proposed09;
	// integer8 Proposed10;
	// end;


// table1 := DATASET([{a1,b1,c1,d1},
									 // {a2,b2,c2,d2},
					         // {a3,b3,c3,d3},
					         // {a4,b4,c4,d4}]);
									 
									 
// output(table1);

				// output(choosen(ds_join4((integer)l_date = 201512), 5), named('b07'));
// base1 := (count(ds_join4((integer)l_date = 201512)));
				// output(choosen(ds_join4((integer)l_date = 201510), 5), named('b08'));
// base2 := (count(ds_join4((integer)l_date = 201510)));
				// output(choosen(ds_join4((integer)l_date < 201510), 5), named('b09'));
// base3 := (count(ds_join4((integer)l_date = 201509)));
				// output(choosen(ds_join4((integer)l_date = 201510), 5), named('b10'));
// base4 := (count(ds_join4((integer)l_date = 201510)));

				// output(choosen(ds_join4((integer)r_date = 201512), 5), named('p07'));
// prop1 := (count(ds_join4((integer)r_date = 201512)));
				// output(choosen(ds_join4((integer)r_date = 201508), 5), named('p08'));
// prop2 := (count(ds_join4((integer)r_date = 201508)));
				// output(choosen(ds_join4((integer)r_date = 201509), 5), named('p09'));
// prop3 := (count(ds_join4((integer)r_date = 201509)));
				// output(choosen(ds_join4((integer)r_date = 201510), 5), named('p10'));
// prop4 := (count(ds_join4((integer)r_date = 201510)));




// MyRec2 := RECORD
	// integer8 Baseline;
	// integer8 Proposed;
// end;


// table2 := DATASET([{base1,prop1},
									 // {base2,prop2},
					         // {base3,prop3},
					         // {base4,prop4,}],MyRec2);
									 
	// output(table2);