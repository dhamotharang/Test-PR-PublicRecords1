import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP, zz_bbraaten2;
eyeball := 20;

	a:= ut.GetDate;
	
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);
	
b1:=b +'_1'; 
// b1:='20180429_1'; 
	
	a1:= a +'_1';

 output(a1);
 output(b1);

// basefilename := ut.foreign_prod + 'scoringqa::out::nonfcra::bocashell_41_historydate_999999_prod_20180302_1';            //change tracking to cert_tracking     
// testfilename := ut.foreign_prod + 'scoringqa::out::nonfcra::bocashell_41_historydate_999999_prod_20180306_1';             //change fcra to nonfcra


basefilename := '~scoringqa::out::nonfcra::bocashell_50_historydate_999999_cert_'+b1;           //NonFCRA     
testfilename := '~scoringqa::out::nonFcra::bocashell_50_historydate_999999_cert_'+a1;  



Layout3 := Scoring_Project_Macros.Global_Output_Layouts.BocaShell_Global_Layout; //layout new file

// zz_bbraaten2.Boca_41_Non_Cert_lay_new

 

ds_baseline := dataset(basefilename, Layout3, thor);
ds_new := dataset(testfilename, Layout3 , thor);

	
		clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');		
	

	
	
	// output(choosen(ds_baseline, 5));
	// output(choosen(ds_new, 5));
	
// clean_ds_baseline_full := project(clean_ds_baseline, transform(layout3,self := left, self := []));
// clean_ds_new_full := project(clean_ds_new,  transform(layout3, self := left, self := []));





ashirey.flatten(clean_ds_baseline,clean_ds_1_flat);
ashirey.flatten(clean_ds_new,clean_ds_2_flat);

// ashirey.flatten(clean_ds_baseline_full2,clean_ds_1_flat2);
// ashirey.flatten(clean_ds_new_full2,clean_ds_2_flat2);


output(choosen(clean_ds_1_flat,5));
output(choosen(clean_ds_2_flat,5));



// j1 := join(clean_ds_baseline, clean_ds_new,  left.AccountNumber = right.AccountNumber
					// AND LEFT.fd_scores.fraudpoint_v3 < right.fd_scores.fraudpoint_v3,
	
				// transform({dataset(Layout3) res}, self.res := left + right));
		// OUTPUT(CHOOSEN(j1, 10), named('fd_scores__fraudpoint_v3'));
		// OUTPUT(count(j1), named('fd_scores__fraudpoint_v3_count'));
		
		
j1 := join(clean_ds_baseline, clean_ds_new,  left.AccountNumber = right.AccountNumber
					AND LEFT.fd_scores.fraudpoint_v3 < right.fd_scores.fraudpoint_v3, 
	
				transform(layout3, self := left ));
		OUTPUT(CHOOSEN(j1, 10), named('fd_scores__fraudpoint_v3'));
		OUTPUT(count(j1), named('fd_scores__fraudpoint_v3_count'));
		
		
		j2 := join(clean_ds_baseline, clean_ds_new,  left.AccountNumber = right.AccountNumber
					AND LEFT.fd_scores.fraudpoint_v3 < right.fd_scores.fraudpoint_v3, 
	
				transform(layout3, self := right ));
		OUTPUT(CHOOSEN(j2, 10), named('fd_scores__fraudpoint_v3second'));
		OUTPUT(count(j2), named('fd_scores__fraudpoint_v3_countsecond'));
		
ds1 := j1;
ds2 := j2;
ashirey.flatten(ds1,clean_ds_1_flat2);
ashirey.flatten(ds2,clean_ds_2_flat2);

		Scoring_Project_PIP.COMPARE_DSETS_MACRO(clean_ds_1_flat2, clean_ds_2_flat2, ['AccountNumber'], 0.01);

// j2 := join(clean_ds_baseline_full2, clean_ds_new_full2,  left.AccountNumber = right.AccountNumber
					// AND LEFT.other_address_info.addrs_last90 > RIGHT.other_address_info.addrs_last90,
	
				// transform({dataset(Layout3) res}, self.res := left + right));
		// OUTPUT(CHOOSEN(j2, 10), named('other_address_info_addrs_last90_second_41'));
		// OUTPUT(count(j2), named('other_address_info_addrs_last90_count_second_41'));		
		
// j3 := join(j1, j2,  left.res[1].AccountNumber = right.res[3].AccountNumber
					// AND LEFT.res[1].did = right.res[3].did,
				// transform({dataset(Layout3) res}, self.res := left.res + right.res));
		
		// OUTPUT(CHOOSEN(j3, 10), named('five_not_eql_four'));
		// OUTPUT(count(j3), named('five_not_eql_four_count'));


// Scoring_Project_PIP.COMPARE_DSETS_MACRO(clean_ds_1_flat, clean_ds_2_flat, ['AccountNumber'], 0.01);
// Scoring_Project_PIP.CROSSTAB_MACRO(clean_ds_1_flat, clean_ds_2_flat, ['AccountNumber'], 'IID__nap_type');

		
