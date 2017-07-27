// MANN BRACKEN
import ut, risk_indicators, address;

export RSN508_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

Layout_RecoverScore doModel(clam le, recoverscore_batchin rt) := TRANSFORM 

// mappings from batchinput to named variables
	dcd_match_code_1 := if(rt.deceased='1' or le.ssn_verification.validation.deceased, '1', '0');
	addr_type_a := rt.address_type;
	addr_confidence_a := rt.address_confidence;
	chargeoffAmount := rt.debt_amount;
	chargeoffDate := rt.charge_off_date;
	opendate := rt.open_date;
	verphone := rt.custom_input_1;
	veremploy := rt.custom_input_2;
	veraddr := rt.custom_input_3;
	empFlag := rt.custom_input_4;
	propFlag := rt.custom_input_5;
	equifaxsc := rt.custom_input_6;
	
	//  Sure contact fields 
 
     deceased_sc := IF(dcd_match_code_1 = '1', true, false);

	// address_ver_sc

     address_confirmed := if(trim(StringLib.StringToUpperCase(addr_type_a)) = 'C', true, false);
	address_updated := if(trim(StringLib.StringToUpperCase(addr_type_a)) = 'U', true, false);
	address_verified := if(trim(StringLib.StringToUpperCase(addr_confidence_a)) = 'A', true, false);


     address_ver_sc := MAP(address_confirmed and address_verified => 0.1791045,
					  address_updated and address_verified => 0.1415797,
					  address_confirmed => 0.1399002,
					  0.1148148);

	
	// Boca fields

	// verxb 

	sourcecnt := IF(le.name_verification.source_count <= 3, 0, 1);


	add_cnta := MAP(le.address_verification.input_address_information.source_count = 4 => 1,
				 le.address_verification.input_address_information.source_count >= 5 => 2,
				 0);


	count_as := MAP(add_cnta = 0 => 0,
				 sourcecnt = 0 => 1,
				 sourcecnt = 1 and add_cnta = 1 => 2,
				 3);
	
	verxb := MAP(le.iid.nap_summary = 12 and count_as >= 2 => 0.1855459,
			   le.iid.nap_summary = 11 and count_as = 3 => 0.1723329,
			   le.iid.nap_summary = 12 => 0.1600975,
			   le.iid.nap_summary = 11 => 0.1495726,
			   le.iid.nap_summary <= 1 and count_as = 0 and le.iid.nap_type = 'P' => 0.1013878,
			   le.iid.nap_summary <= 1 and count_as = 0 => 0.1212871,
			   le.iid.nap_summary <= 10 and count_as = 3 => 0.1221282,
			   le.iid.nap_summary <= 10 and le.iid.nap_type = 'P' => 0.10138780,
			   0.1212871);


	// agex 

     agex := MAP(le.name_verification.age <= 39 => 0.1482007,
			  le.name_verification.age <= 59 => 0.1438849,
			  le.name_verification.age <= 69 => 0.1184593,
			  0.0872845);

	
	// apt 

     apt := IF(trim(StringLib.StringToUpperCase(le.address_validation.dwelling_type)) = 'A', 1, 0);

	// criminal

     criminal := IF(le.bjl.criminal_count > 0, 1,0);


	// Prop_applicant_owner 

     Prop_Applicant_Owner := IF(le.address_verification.input_address_information.applicant_owned or le.address_verification.address_history_1.applicant_owned or 
						  le.address_verification.address_history_2.applicant_owned, 1, 0);


	// lres 

     sysyear := (integer)(ut.GetDate[1..4]);

     add1_year_first_seen1 := le.address_verification.input_address_information.date_first_seen;
	add1_year_first_seen := (integer)(add1_year_first_seen1[1..4]);

     lres := IF((sysyear - add1_year_first_seen) >= 6, 1, 0);


	// DLX

	dlx := IF(le.available_sources.dl and ~le.address_verification.input_address_information.dl_sourced, 1, 0);


	// add1_cen_inc

	add1_cen_inc := MAP(le.address_verification.input_address_information.census_income = '' => 50000,
					(integer)le.address_verification.input_address_information.census_income < 30000 => 30000,
					(integer)le.address_verification.input_address_information.census_income > 70000 => 70000,
					(integer)le.address_verification.input_address_information.census_income);


	// Customer Supplied fields  

	// co_amt_l 

     co_amt_l := IF((integer)chargeoffAmount <= 2000, 1, 0);


	// co_mths_var

	today := ut.GetDate;
	today1900 := ut.DaysSince1900(today[1..4], today[5..6], today[7..8]);
	
	co_dt := ut.DaysSince1900(chargeoffDate[1..4], chargeoffDate[5..6], chargeoffDate[7..8]);

	op_dt := ut.DaysSince1900(opendate[1..4], opendate[5..6], opendate[7..8]);

	
	msod := if((integer)(opendate[1..4]) = 0 , -1, ut.DaysSince1900(opendate[1..4], opendate[5..6], opendate[7..8]));
	mco_op := if((integer)(opendate[1..4]) = 0 or (integer)(chargeoffDate[1..4]) = 0 or (integer)((co_dt - op_dt)/30.25) < 0, -1, (integer)((co_dt - op_dt)/30.25));

	mco_open := IF(mco_op <= 24, 0, 1);

	mths_open := IF(msod <= 36, 0, 1);


	co_mths_var := MAP(mco_open = 0 and mths_open = 0 => 0.2320410,
				    mco_open = 1 and mths_open = 0 => 0.2162162,
				    mco_open = 0 and mths_open = 1 => 0.1697497,
				    0.1012478);


	// vermann_propm 

	vermann := IF(((integer)verphone = 1) or ((integer)veremploy = 1) or ((integer)veraddr = 1), 1, 0);

	propemp := IF(trim(StringLib.StringToUpperCase(empFlag)) = 'Y' or ((integer)propFlag = 1), 1, 0);

	vermann_prop := MAP(vermann = 0 and propemp = 0 => 0,
					vermann = 0 and propemp = 1 => 1,
					vermann = 1 => 2,
					0);


	vermann_propm := MAP(vermann_prop = 0 => 0.1360926,
					 vermann_prop = 1 => 0.2391304,
					 0.3000000);

	// eqscr

	eqscr := IF(equifaxsc = '', 89, (integer)equifaxsc);

	// model 

     MB_bocacombined21 := -7.931457864
					   + verxb  * 4.0669662979
					   + address_ver_sc  * 4.3540795001
					   + agex  * 7.5485800725
					   + apt  * -0.278782712
					   + criminal  * -0.388524494
					   + Prop_Applicant_Owner  * 0.2264883619
					   + lres  * 0.1738214441
					   + add1_cen_inc  * 9.3226759E-6
					   + co_amt_l  * 0.4559896476
					   + co_mths_var  * 5.9971505174
					   + dlx  * -0.550443752
					   + vermann_propm  * 10.746576543
					   + eqscr  * 0.0087177795;
     MB_bocacombined2 := (exp(MB_bocacombined21)) / (1+exp(MB_bocacombined21));
     phat := mb_bocacombined2;

	base  := 700;
	odds  := .1405/.8595;
	point :=  50;

     MB_collection_scr1 := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);

	MB_collection_scr2 := MAP(MB_collection_scr1 < 250 => 250,
						MB_collection_scr1 > 999 => 999,
						MB_collection_scr1);


	// score overide 

     MB_collection_scr := IF(deceased_sc, 200, MB_collection_scr2);

	SELF.address_index := intformat(MB_collection_scr,3,1);
	SELF.seq := (string)le.seq;
	SELF := [];
END;
scores := join(clam, recoverscore_batchin, left.seq=right.seq, doModel(LEFT, right));

RETURN (scores);

END;