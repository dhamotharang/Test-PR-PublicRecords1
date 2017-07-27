import riskwise, risk_indicators, easi, ut;

export RSN607_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(Models.Layout_RecoverScore_Batch_Input) recoverscore_batchin) := function

temp := record
	Risk_Indicators.Layout_Boca_Shell;
	string1 addr_type_a;
	string1 addr_confidence_a;
	string1 ph_phone_type_a_1;
	string2 bk_disp_code_1;
	string1 dcd_match_code_1;
	string15	cus_chargeoff_amt := '';	
end;

temp add_rs(clam le, recoverscore_batchin rt) := TRANSFORM 

	self.addr_type_a := rt.address_type;
	self.addr_confidence_a := rt.address_confidence;
	self.ph_phone_type_a_1 := rt.phone_type;
	self.bk_disp_code_1 := models.getBansDispCode(le.bjl.date_last_seen, le.bjl.disposition, rt.bankruptcy);
	self.dcd_match_code_1 := if(rt.deceased='1' or le.ssn_verification.validation.deceased, '1', '0');
	self.cus_chargeoff_amt := rt.debt_amount;
	self := le;
end;

with_rs_batchin := join(clam, recoverscore_batchin, left.seq=right.seq, add_rs(left,right));


	Layout_RecoverScore doModel(with_rs_batchin le, easi.Key_Easi_Census ri) := TRANSFORM 
		addr_type_a := le.addr_type_a;
		addr_confidence_a := le.addr_confidence_a;
		cus_chargeoff_amt := le.cus_chargeoff_amt;
		ph_phone_type_a_1 := le.ph_phone_type_a_1;
		bk_disp_code_1 := le.bk_disp_code_1;
		dcd_match_code_1 := le.dcd_match_code_1;
		
		archive_date           :=  if(le.historydate = 999999, ut.GetDate, (string)le.historydate);
		in_dob                 :=  le.shell_input.dob;
		nas_summary            :=  le.iid.nas_summary;
		nap_summary            :=  le.iid.nap_summary;
		hphnpop                :=  (INTEGER)le.input_validation.homephone;
		age                    :=  (INTEGER)le.name_verification.age;
		add1_source_count      :=  le.address_verification.input_address_information.source_count;
		add1_date_first_seen   :=  le.address_verification.input_address_information.date_first_seen;
		add2_source_count      :=  le.address_verification.address_history_1.source_count;
		phone_zip_mismatch     :=  le.phone_verification.phone_zip_mismatch;         
		disposition            :=  StringLib.StringToUpperCase(le.bjl.disposition);
		rel_prop_owned_count   :=  le.relatives.owned.relatives_property_count;
		rel_homeunder50_count  :=  le.relatives.relative_homeunder50_count;
		rel_homeunder100_count :=  le.relatives.relative_homeunder100_count;
		rel_homeunder150_count :=  le.relatives.relative_homeunder150_count;
		rel_homeunder200_count :=  le.relatives.relative_homeunder200_count;
		rel_homeunder300_count :=  le.relatives.relative_homeunder300_count;
		rel_homeunder500_count :=  le.relatives.relative_homeunder500_count;
		rel_homeover500_count  :=  le.relatives.relative_homeover500_count;
		
		// ---------------------------------------------------------------------------------------------
		// Fields from Census File                             
		// ---------------------------------------------------------------------------------------------
		c_civ_emp              := ri.civ_emp;
		c_robbery              := ri.robbery;
		c_cpiall               := ri.cpiall;
		c_manufacturing        := ri.manufacturing;
		c_armforce             := ri.armforce;
                       
		// ----------------------------------------------------------------------------------------------------
		// address index variables
		// ----------------------------------------------------------------------------------------------------
		sysyear := IF(le.historydate <> 999999, (integer)((string)le.historydate[1..4]), (integer)(ut.GetDate[1..4]));

		dwelling_type         :=  trim(le.address_validation.dwelling_type);
		hr_address            := (integer)le.address_validation.hr_address;


		add1_naprop            := le.address_verification.input_address_information.naprop;
		add1_census_income     := le.address_verification.input_address_information.census_income;
		add1_census_home_value := le.address_verification.input_address_information.census_home_value;
		property_owned_total   := le.address_verification.owned.property_total;
		property_sold_total    := le.address_verification.sold.property_total;
		property_ambig_total   := le.address_verification.ambiguous.property_total;
		add2_naprop            := le.address_verification.address_history_1.naprop;
		add3_naprop            := le.address_verification.address_history_2.naprop;
		rel_criminal_count     := le.relatives.relative_criminal_count;
		current_count          := le.vehicles.current_count;


		distance := (real)le.phone_verification.distance;
		disconnected := (integer)le.phone_verification.disconnected;
		hr_phone := (integer)le.phone_verification.hr_phone;

		lname_change_date               :=  le.name_verification.lname_change_date;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bjl.criminal_count;
		rel_bankrupt_count              :=  le.relatives.relative_bankrupt_count;
		telcordia_type                  := le.phone_verification.telcordia_type;




		mymin( a, b ) := MACRO if( (a)<(b), (a), (b) ) ENDMACRO;
		mymax( a, b ) := MACRO if( (a)>(b), (a), (b) ) ENDMACRO;

		boolean contains( string needle, string haystack ) := StringLib.StringFind(haystack, needle, 1) > 0;



		/******************  this code is additional to the RSN607_0_0 variable creation code  ******************/
		cus_chargeoff_doe := if( cus_chargeoff_amt='', 1, mymax(mymin((REAL)cus_chargeoff_amt,50000), 1) );
		cus_chargeoff_doe_log := ln(cus_chargeoff_doe);

		C_MANUFACTURING_a := if( C_MANUFACTURING in ['','-1'], 3.4916304, (REAL)C_MANUFACTURING );
		/********************************************************************************************************/

		/******************  the following code until the equation code to create rsn607_1_0 is ***************** 
		 ******************  identical to the RSN607_0_0 variable creation code                 *****************/
		addr_a_level := map(
			addr_type_a = 'C' and addr_confidence_a  = 'A' => 0,
			addr_type_a = 'C'                              => 1,
			addr_type_a = 'U' and addr_confidence_a  = 'B' => 2,
			addr_type_a = 'U'                              => 3,
			addr_type_a = 'X'                              => 4,
			4 // unknown! guess 4?
		);


		/********************************************************************************************************/

		/**********************************  logic:  verification  **********************************************/
		nas_summary_doe := map(
			nas_summary >= 10 => 12,
			nas_summary >   1 =>  8,
			nas_summary >=  0 =>  0,
			nas_summary  
		);

		nap_lname_verified := (integer)(nap_summary in [5, 7, 8, 9, 11, 12]);

		nap_nas := map(
			nap_summary >= 11 and nas_summary_doe  = 12 => 1,
			nap_summary >= 11 and nas_summary_doe  < 12 => 2,
			nap_summary >=  3 and nas_summary_doe  = 12 => 3,
			nap_summary  =  0 and nas_summary_doe  = 12 => 4,
			nap_summary >=  3 and nas_summary_doe  < 12 => 5,
			nap_summary  =  1 and nas_summary_doe  = 12 => 6,
			nap_summary <=  1 and nas_summary_doe  < 12 => 7,
			6 // else value of 6 per validation discussion with NP
		);

		nap_nas2 := map(
			nap_nas  = 1 and nap_lname_verified = 1 => 1,
			nap_nas <= 3 and nap_lname_verified = 1 => 2,
			nap_nas  = 5 and nap_lname_verified = 1 => 3,
			nap_nas  = 4 and nap_lname_verified = 0 => 4,
			nap_nas  = 3 and nap_lname_verified = 0 => 5,
			nap_nas + 1
		);


		add2_source_count_doe := mymin(add2_source_count, 5);

		add1_source_count_doe := map(
			add1_source_count = 0 => 0,
			add1_source_count < 4 => 1,
			2
		);

		source_count_level := map(
			add1_source_count_doe = 0 and add2_source_count_doe >= 0 => 1,
			add1_source_count_doe = 1 and add2_source_count_doe <= 1 => 1,
			add1_source_count_doe = 2 and add2_source_count_doe  = 0 => 1,
			add1_source_count_doe = 1 and add2_source_count_doe <= 4 => 2,
			add1_source_count_doe = 2 and add2_source_count_doe <= 2 => 2,
			3
		);

		nap_nas2_source := map(
			nap_nas2 <= 2 and source_count_level  = 3 => 1,
			nap_nas2  = 1 and source_count_level  = 2 => 2,
			nap_nas2  = 1 and source_count_level  = 1 => 3,
			nap_nas2  = 2 and source_count_level  = 2 => 3,
			nap_nas2 >= 3 and source_count_level  = 3 => 4,
			nap_nas2 <= 3 and source_count_level >= 1 => 4,
			nap_nas2 <= 5 and source_count_level >= 1 => 4,
			nap_nas2 <= 7 and source_count_level >= 1 => 5,
			// nap_nas2  = 8 and source_count_level >= 1 => 6,
			6
		);
		/********************************************************************************************************/


		/******************************  logic:  phone ***************************************************/
		phnzip := (integer)phone_zip_mismatch;
		telcordia_typen := (integer)telcordia_type;


		// pnotpots := (INTEGER)(telcordia_typen not in [0,50,51,52,54]);
		pnotpots := (INTEGER)(telcordia_type not in ['00','50','51','52','54']);

		phnprob := map(
			hphnpop = 1 and pnotpots = 0 and phnzip = 0  => 1,
			hphnpop = 0                                  => 2,
			// hphnpop = 1 and (pnotpots = 1 or phnzip = 1) => 3
			3
		);


		/********************************************************************************************************/

		/******************************  logic:  ssn and age ***************************************************/
		archive_year := (INTEGER)archive_date[1..4];
		dob_year :=  (INTEGER)in_dob[1..4]; 

		age_dot := age=0;

		input_age := map(
			dob_year > 0         => mymin(mymax(archive_year - dob_year, 21), 76),
			~age_dot and age > 0 => mymin(mymax(age, 21), 76),
			35
		);

		/********************************************************************************************************/

		/******************************  logic:  crim ***************************************************/
		bk_discharged := (integer)contains('DISCHARGE',disposition);
		/********************************************************************************************************/

		/******************************  logic:  naprop ***************************************************/
		add1_year_first_seen := (integer)(add1_date_first_seen[1..4]);


		add1_dot := (integer)(add1_year_first_seen < 1900 );

		lres_years_a := (archive_year - add1_year_first_seen);
		lres_years := if( 1=add1_dot, lres_years_a, mymin(lres_years_a,20) );

		lres_code := map(
			add1_dot = 1     => 2,
			lres_years <=  3 => 0,
			lres_years <=  7 => 1,
			lres_years <= 15 => 3,
			4
		);

		/********************************************************************************************************/

		/******************************  logic:  rel  ***************************************************/
		rel_prop_owned_count1 := mymin(rel_prop_owned_count, 99);

		rel_home_val := map(
			rel_homeover500_count  > 0 => 200,
			rel_homeunder500_count > 0 => 200,
			rel_homeunder300_count > 0 => 200,
			rel_homeunder200_count > 0 => 200,
			rel_homeunder150_count > 0 => 150,
			rel_homeunder100_count > 0 => 100,
			rel_homeunder50_count  > 0 => 50,
			10
		);

		rel_home_val_c := mymin(rel_home_val, 100);
		/********************************************************************************************************/


		/******************************  logic:  means substitutions ***************************************************/
		addr_a_level_m := case( addr_a_level,
			0 => 0.279650437,
			1 => 0.233672858,
			2 => 0.1820029028,
			3 => 0.1805555556,
			// 4 => 0.0869565217
			0.0869565217
		);

		nap_nas2_source_m := case( nap_nas2_source,
			1 => 0.2975609756,
			2 => 0.2749326146,
			3 => 0.2365448505,
			4 => 0.1910195981,
			5 => 0.1299734748,
			// 6 => 0.1042944785
			0.1042944785
		);

		lres_code_m := case( lres_code,
			0 => 0.2621219395,
			1 => 0.2092320966,
			2 => 0.1961367013,
			3 => 0.1897926635,
			// 4 => 0.1758893281
			0.1758893281
		);

		rel_home_val_c_m := case( rel_home_val_c,
			10  => 0.1307420495,
			50  => 0.1448516579,
			// 100 => 0.2219097173
			0.2219097173
		);
		/********************************************************************************************************/
		  
		/******************************  logic:  missing census recodes *****************************************/
		C_CIV_EMP_a := if(C_CIV_EMP  in ['','-1'], 59.0310018,  (real)C_CIV_EMP );
		C_ROBBERY_a := if(C_ROBBERY  in ['','-1'], 115.2675054, (real)C_ROBBERY );
		C_CPIALL_a  := if(C_CPIALL   in ['','-1'], 189.9776323, (real)C_CPIALL  );
		C_ARMFORCE_a:= if(C_ARMFORCE in ['','-1'], 104.0869341, (real)C_ARMFORCE);
		/********************************************************************************************************/

		rsn607a := -6.260532873
					   + phnprob  * -0.14150431
					   + input_age  * -0.04639613
					   + bk_discharged  * 0.5298651258
					   + addr_a_level_m  * 5.287856333
					   + nap_nas2_source_m  * 3.8780270604
					   + lres_code_m  * 3.0907700485
					   + rel_prop_owned_count1  * 0.0215354992
					   + rel_home_val_c_m  * 4.0251976809
					   + C_CIV_EMP_a  * 0.0092952571
					   + C_ROBBERY_a  * -0.001040753
					   + C_CPIALL_a  * 0.0084704764
					   + C_MANUFACTURING_a  * 0.0028464412
					   + C_ARMFORCE_a  * 0.001985395
					   + cus_chargeoff_doe_log  * 0.1323015463
					 ;

		rsn607b := (exp(rsn607a)) / (1+exp(rsn607a));

		base  := 700;
		odds  := 0.17647;
		point := 40;

		rsn607_1c := mymin(mymax((integer)(point*(log(rsn607b/(1-rsn607b)) - log(odds))/log(2) + base), 250), 999);

		/******************************************************************************************************/
		/** The following code calculates the RecoverScore Indices:                                           */
		/**     Address, Contactibility, Asset, Lifestress, Liquidity, etc.                                   */
		/** These scores are identical to those calculated in the RSN509_0_0 code                             */ 
		/******************************************************************************************************/

		/* Sure Contact  */
		address_confirmed := (INTEGER)(addr_type_a = 'C');
		address_updated   := (INTEGER)(addr_type_a = 'U');
		address_verified  := (INTEGER)(addr_confidence_a = 'A');

		EDA_Match_Level := case( ph_phone_type_a_1,
			'A' => 2,
			'C' => 1,
			0
		);

		bk_level := map(
			(INTEGER)bk_disp_code_1 = 20 => 3,
			(INTEGER)bk_disp_code_1 = 2  => 2,
			(INTEGER)bk_disp_code_1 = 99 => 2,
					 bk_disp_code_1 = '' => 1,
			(INTEGER)bk_disp_code_1 = 15 => 0,
			0
		);

		deceased_sc := (integer)((INTEGER)dcd_match_code_1=1);

		address_ver_sc := map(
			1=address_confirmed and                       1=address_verified => 4,
									1=address_updated and 1=address_verified => 3,
			1=address_confirmed                                              => 2,
									1=address_updated                        => 1,
			0
		);


		/* Modeling Shell */


		/* NAP and NAS */
		verfst_p := nap_summary in [2,3,4,8,9,10,12];
		verlst_p := nap_summary in [2,5,7,8,9,11,12];
		veradd_p := nap_summary in [3,5,6,8,10,11,12];
		verphn_p := nap_summary in [4,6,7,9,10,11,12];


		aptflag := (integer)(dwelling_type='A');

		add1_source_count2 := map(
			add1_source_count <= 3 => 0,
			add1_source_count <= 4 => 1,
			add1_source_count <= 5 => 2,
			3
		);

		property_owned_total_x := (integer)(property_owned_total > 0 );
		property_sold_total_x  := (integer)(property_sold_total  > 0 );
		property_ambig_total_x := (integer)(property_ambig_total > 0 );

		Prop_Owner := map(
			4 in [add1_naprop,add2_naprop,add3_naprop] => 2,
			(property_owned_total_x+property_sold_total_x+property_ambig_total_x) > 0 => 1,
			0
		);

		NaProp4_any := (integer)( 4 in [add1_naprop,add2_naprop,add3_naprop] );
		NaProp3_any := (integer)( 3 in [add1_naprop,add2_naprop,add3_naprop] );

		NaProp_Tree := map(
			NaProp4_any = 1 => 2,
			NaProp3_any = 1 => 1,
			0
		);
		
		property_owned_total_med := map(
			property_owned_total >= 2 => 2,
			property_owned_total >= 1 => 1,
			0
		);

		Prop_Owner_med := map(
			Prop_Owner = 0 and NaProp_Tree = 0 => 0,
			Prop_Owner = 0 and NaProp_Tree > 0 => 1,
			Prop_Owner = 1                     => 2,
			// Prop_Owner = 2                     => 3
			3
		);

		prop_med := map(
			Prop_Owner_med = 0 => 0,
			Prop_Owner_med = 1 => 1,
			Prop_Owner_med = 2 and property_owned_total_med <= 1 => 2,
			Prop_Owner_med = 2 and property_owned_total_med  = 2 => 5,
			Prop_Owner_med = 3 and property_owned_total_med <= 0 => 3,
			Prop_Owner_med = 3 and property_owned_total_med <= 1 => 4,
			// Prop_Owner_med = 3 and property_owned_total_med <= 2 => 5
			5
		);


		lien_unrel_count := case( liens_historical_unreleased_ct,
			0 => 0,
			1 => 1,
			2
		);

		criminal_flag := (integer)(criminal_count > 0);
		crimlien := if(1=criminal_flag or lien_unrel_count=2, 2, lien_unrel_count);


		/* Relatives */
		rel_prop_owned_count2 := map(
			rel_prop_owned_count <= 0 => 0,
			rel_prop_owned_count <= 1 => 1,
			rel_prop_owned_count <= 2 => 2,
			3
		);

		rel_criminal_flag := (integer)(rel_criminal_count > 0);
		rel_bk_flag := (integer)(rel_bankrupt_count>0);

		rel_prop_owned_count_med_m := case( rel_prop_owned_count2,
			0 => 0.0929209103,
			1 => 0.1531404375,
			2 => 0.1656441718,
			// 3 => 0.1960569551
			0.1960569551
		);

		rel_home_val_med := map(
			rel_homeover500_count  > 0 => 501,
			rel_homeunder500_count > 0 => 500,
			rel_homeunder300_count > 0 => 300,
			rel_homeunder200_count > 0 => 200,
			rel_homeunder150_count > 0 => 200,   /* to collapse groups */
			rel_homeunder100_count > 0 => 100,
			rel_homeunder50_count  > 0 => 50,
			0
		 );


		rel_home_val_med_med_m := case( rel_home_val_med,
			0   => 0.0445945946,
			50  => 0.0956210903,
			100 => 0.1209863403,
			200 => 0.1289147851,
			300 => 0.1441578149,
			500 => 0.1549586777,
			// 501 => 0.2168674699
			0.2168674699
		);

		
		rel_criminal_flag_med_m := if( rel_criminal_flag=0, 0.1288260364, 0.0838299563 );

		/* Sources          */

		distflag := map(
			hphnpop = 1 and distance <= 1 => 0,
			hphnpop = 1                   => 1,
			2
		);

		crimlien_med_m := case( crimlien,
			0 => 0.1268323773,
			1 => 0.0975954738,
			// 2 => 0.0686359687
			0.0686359687
		);

		prop_med_med_m := case( prop_med,
			0 => 0.0732223903,
			1 => 0.1332445037,
			2 => 0.1461538462,
			3 => 0.1752688172,
			4 => 0.1910039113,
			// 5 => 0.2230215827
			0.2230215827
		);

		// ********************************;
		// * Collections Indices          *;
		// ********************************;

		lres_years1_x := ( sysyear - add1_year_first_seen );
		lres_years_x := if( lres_years1_x > 100, 0, lres_years1_x );
		
		hr_address_n := (integer)hr_address;

		/*   address confidence   */

		add_index_mod_a := -2.723092932
			+ address_ver_sc  * 0.2720249163
			+ add1_source_count2  * 0.1261334602
			+ lres_years_x  * 0.0175460381
			+ aptflag  * -0.636294027
			+ hr_address_n  * -0.779330101
		;
		add_index_mod := (exp(add_index_mod_a )) / (1+exp(add_index_mod_a ));
		phat_v := add_index_mod;


		base_v  := 55;
		odds_v  := 0.12 / 0.88;
		point_v :=  30;


		Add_Index := mymax(mymin((INTEGER)(point_v*(log(phat_v/(1-phat_v)) - log(odds_v))/log(2) + base_v),100),0);


		/*   phone confidence     */

		phnprob_x := map(
			pnotpots=1 => 3,
			hphnpop = 1 and distflag > 0 => 2,
			hphnpop = 1 and ( disconnected=1 or hr_phone=1 or phone_zip_mismatch ) => 1,
			hphnpop = 1 => 0,
			-1
		 );

		eda_ver_level := map(
			 verfst_p and  verlst_p and  veradd_p and  verphn_p => 3,
						   verlst_p and  veradd_p and  verphn_p => 2,
			~verfst_p and ~verlst_p and ~veradd_p and ~verphn_p => 0,
			~verfst_p and ~verlst_p and  veradd_p and  verphn_p => -1,
			1
		);


		if( hphnpop ) then
			phn_index_mod4a := -2.515818559
				+ EDA_Match_Level  * 0.3268017039
				+ eda_ver_level  * 0.1281022154
				+ phnprob_x  * -0.044874343
			;
			phn_index_mod4 := (exp(phn_index_mod4a )) / (1+exp(phn_index_mod4a ));
			phat_w := phn_index_mod4;

			base_w  := 60;
			odds_w  := 0.12 / 0.88;
			point_w :=  55;

			Phn_Index_x := (integer)(point_w*(log(phat_w/(1-phat_w)) - log(odds_w))/log(2) + base_w);

		else
			base_w  := 0; // suppress
			odds_w  := 0; // warning
			point_w := 0; // messages
			phat_w  := 0;
			phn_index_mod4a := 0;
			phn_index_mod4 := 0;
			
			phn_index_x := map(
				/*hphnpop = 0 and */EDA_match_Level = 0 and eda_ver_level = 0 => 7,
				/*hphnpop = 0 and */EDA_match_Level = 0 and eda_ver_level = 1 => 42,
				/*hphnpop = 0 => */ 93
			);
		end;

		Phn_Index := mymax(mymin(phn_index_x,100),0);

		/*   contactibility = Add + Phone    */

		if( hphnpop ) then
			contactibility_index_moda := -2.810862645
				+ EDA_Match_Level  * 0.2998325857
				+ eda_ver_level  * 0.0426818858
				+ phnprob_x  * -0.060120809
				+ address_ver_sc  * 0.1380910821
				+ add1_source_count2  * 0.0907197533
				+ lres_years_x  * 0.0175303489
				+ aptflag  * -0.497701656
				+ hr_address_n  * -0.637506454
			;
			contactibility_index_mod := (exp(contactibility_index_moda )) / (1+exp(contactibility_index_moda ));
			phat_x := contactibility_index_mod;

			contactibility_index_mod2a := 0.0; // suppress warning messages
			contactibility_index_mod2  := 0.0;

		else
			contactibility_index_mod2a := -2.868859016
				+ EDA_Match_Level  * 0.7960984847
				+ eda_ver_level  * 0.0925500643
				+ address_ver_sc  * 0.2295037659
				+ add1_source_count2  * 0.1840787287
				+ lres_years_x  * 0.0138710928
				+ aptflag  * -0.988828046
				+ hr_address_n  * -11.57156326
			;
			contactibility_index_mod2 := (exp(contactibility_index_mod2a )) / (1+exp(contactibility_index_mod2a ));
			phat_x := contactibility_index_mod2;

			contactibility_index_moda := 0.0; // suppress warning messages
			contactibility_index_mod  := 0.0;

		end;

		base_x  := 58;
		odds_x  := 0.12 / 0.88;
		point_x :=  28;

		Contactibility_Index := mymin(mymax((integer)(point_x*(log(phat_x/(1-phat_x)) - log(odds_x))/log(2) + base_x), 0),100);

		/*   asset              */

		car_owner := (integer)(current_count>0);
		add1_census_income2 := if(add1_census_income='', 0, (real)add1_census_income);
		add1_census_home_value2 := if(add1_census_home_value='', 0, (integer)(add1_census_Home_value));

		asset_index_mod_x := -5.990519659
			+ rel_prop_owned_count_med_m  * 3.1133624227
			+ rel_home_val_med_med_m  * 7.8544113258
			+ rel_criminal_flag_med_m  * 12.895943441
			+ add1_census_income2  * 2.5937701E-6
			+ add1_census_home_value2  * 1.7999838E-6
			+ prop_med_med_m  * 7.247877396
			+ aptflag  * -0.599609623
			+ car_owner  * -0.305779172
		;
		asset_index_mod := (exp(asset_index_mod_x )) / (1+exp(asset_index_mod_x ));
		phat_y := asset_index_mod;


		base_y  := 55;
		odds_y  := 0.12 / 0.88;
		point_y :=  28;

		Asset_Index := (integer)mymin(100,mymax(0,(point_y*(log(phat_y/(1-phat_y)) - log(odds_y))/log(2) + base_y)));


		/*   lifestress           */

		lname_change_year := (integer)lname_change_date[1..4];

		recent_name_change := (integer)(sysyear-lname_change_year < 3 );

		bk_stress_level := map(
			bk_disp_code_1 = '' => 0,
			(integer)bk_disp_code_1 = 2  => 2,
			(integer)bk_disp_code_1 = 99 => 2,
			(integer)bk_disp_code_1 = 20 => 1,
			(integer)bk_disp_code_1 = 15 => 3,
			0 // if there's a value outside '',2,99,20,15, we'll default to the same as '' -- per validation discussion with NM
		);

		recent_mover := (integer)(lres_years_x <= 1);


		LifeStress_Index := mymin( 100, 
			map(
				bk_stress_level = 1 => 11,
				bk_stress_level = 2 => 19,
				bk_stress_level = 3 => 28,
				0
			)
			+ if( criminal_flag=1, 37, 0 )
			+ map(
				lien_unrel_count >= 2 => 24,
				lien_unrel_count >= 1 => 17,
				0
			)
			+ if( deceased_sc=1, 37, 0 )
			+ if( rel_criminal_flag=1, 19, 0 )
			+ if( rel_bk_flag=1, 5, 0 )
			+ if( recent_name_change=1, 8, 0 )
			+ if( recent_mover=1, 12, 0 )
		);



		/*   liquidity  = Asset + Life Stress  */


		liquidity_index_mod1 := -7.254871747
			+ rel_prop_owned_count_med_m  * 3.0950633013
			+ rel_home_val_med_med_m  * 7.725769324
			+ rel_criminal_flag_med_m  * 11.558818552
			+ add1_census_income2  * 2.4641628E-6
			+ add1_census_home_value2  * 1.8999305E-6
			+ prop_med_med_m  * 7.1755553114
			+ aptflag  * -0.596677734
			+ car_owner  * -0.274387849
			+ crimlien_med_m  * 10.134642324
			+ bk_level  * 0.1941694112
			+ deceased_sc  * -0.421385712
			+ recent_name_change  * -0.010031783
		;
		liquidity_index_mod := (exp(liquidity_index_mod1 )) / (1+exp(liquidity_index_mod1 ));
		phat_z := liquidity_index_mod;

		base_z  := 57;
		odds_z  := 0.12 / 0.88;
		point_z :=  25;

		Liquidity_Index := (INTEGER)mymax(0,mymin(100,(point_z*(log(phat_z/(1-phat_z)) - log(odds_z))/log(2) + base_z)));
		
		self.seq := (string)le.seq;
		self.liquidity_score        := intformat(liquidity_index,3,1);
		self.lifecycle_stress_index := intformat(LifeStress_Index,3,1);
		self.Asset_Index            := intformat(Asset_Index,3,1);
		self.telephone_index        := intformat(Phn_Index,3,1);
		self.address_index          := intformat(Add_Index,3,1);
		self.contactability_score   := intformat(Contactibility_index,3,1);
		self.recover_score          := intformat(rsn607_1c,3,1);
		SELF := [];
	END;

	scores := join(with_rs_batchin, easi.key_easi_census, 
		keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
		doModel(LEFT, right),
		left outer,
		atmost(riskwise.max_atmost),
		keep(1)
	);

	return (scores);

END;