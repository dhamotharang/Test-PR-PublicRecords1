import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, easi, std;

export FD3606_0_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, dataset(easi.layout_census) easi_census, 
			  boolean OFAC=true, boolean isFCRA=false, boolean inCalif=false, boolean fdReasonsWith38=false, boolean nugen=false) := FUNCTION

	// prepare bs/easi
		layout_bseasi := record 
			Risk_Indicators.Layout_Boca_Shell  bs;
			Easi.layout_census  ea;
		end;

		layout_bseasi join2recs(clam le, easi_census rt) :=transform
			self.bs	 := le;
			self.ea  := rt;
			self     := [];
		end; 
								 
								 
		results :=join(clam, easi_census,
					right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk,
					join2recs(left,right),
					left outer, lookup);
	//
	
	Layout_ModelOut doModel(results le) := TRANSFORM
		// input data
			in_dob                    := le.bs.shell_input.dob;

			nas_summary               := le.bs.iid.nas_summary;
			nap_summary               := le.bs.iid.nap_summary;
			nap_status                := le.bs.iid.nap_status;

			usps_deliverable          := le.bs.Address_Validation.usps_deliverable;

			age                       := le.bs.Name_Verification.age;

			add1_isbestmatch          := le.bs.address_verification.input_address_information.isbestmatch;
			add1_naprop               := le.bs.address_verification.input_address_information.naprop;
			add1_date_first_seen      := le.bs.address_verification.input_address_information.date_first_seen;
			hr_address                := le.bs.Address_Validation.HR_Address;

			add2_isbestmatch          := le.bs.address_verification.address_history_1.isbestmatch;

			telcordia_type            := le.bs.phone_verification.telcordia_type;
			phone_zip_mismatch        := le.bs.phone_verification.phone_zip_mismatch;
			disconnected              := le.bs.phone_verification.disconnected;
			hr_phone                  := le.bs.phone_verification.HR_Phone;

			adlperssn_count           := le.bs.SSN_Verification.adlPerSSN_count;
			header_first_seen         := le.bs.SSN_Verification.header_first_seen;
			header_last_seen          := le.bs.SSN_Verification.header_last_seen;
			deceased                  := le.bs.ssn_verification.validation.deceased;
			ssn_valid                 := le.bs.SSN_Verification.validation.valid;
			high_issue_date           := le.bs.ssn_verification.validation.high_issue_date;

			rel_count                 := le.bs.relatives.relative_count;
			rel_bankrupt_count        := le.bs.relatives.relative_bankrupt_count;
			rel_criminal_count        := le.bs.relatives.relative_criminal_count;
			rel_within25miles_count   := le.bs.relatives.relative_within25miles_count;
			rel_within100miles_count  := le.bs.relatives.relative_within100miles_count;
			rel_within500miles_count  := le.bs.relatives.relative_within500miles_count;
			rel_withinother_count     := le.bs.relatives.relative_withinOther_count;
		// end input data

		// census data
			geolink := le.ea.GEOLINK;
			cenmatch                  := trim(geolink) = (trim(le.bs.shell_input.st) + trim(le.bs.shell_input.county) + trim(le.bs.shell_input.geo_blk));
			c_hhsize                  := (REAL)le.ea.hhsize;
			c_fammar_p                := (REAL)le.ea.fammar_p;
			c_young                   := (REAL)le.ea.young;
			c_bigapt_p                := (REAL)le.ea.bigapt_p;
			c_hval_400k_p             := (REAL)le.ea.hval_400k_p;
			c_low_hval                := (REAL)le.ea.low_hval;
			c_inc_15K_p               := (REAL)le.ea.in15K_p;
			c_white_col               := (REAL)le.ea.white_col;
			c_cartheft                := (REAL)le.ea.cartheft;
			c_easiqlife               := (REAL)le.ea.easiqlife;
			c_construction            := (REAL)le.ea.construction;
			c_food                    := (REAL)le.ea.food;
			c_rental                  := (REAL)le.ea.rental;
			c_born_usa                := (REAL)le.ea.born_usa;
			c_old_homes               := (REAL)le.ea.old_homes;
			c_new_homes               := (REAL)le.ea.new_homes;



		// end census data


		/* Verification */

			best_match_level := map(
				add1_isbestmatch	=> 2,
				add2_isbestmatch	=> 0,
				1
			);


		/* NAP and NAS */

			verlst_p := nap_summary in [2,5,7,8,9,11,12];
			verphn_p := nap_summary in [4,6,7,9,10,11,12];
			verssn_s := nas_summary in [4,6,7,9,10,11,12];

			nas_ver := nas_summary >= 10;


			ver_pl_p := map(
				best_match_level = 2 and nas_ver and verphn_p and verlst_p	=> 2,
				best_match_level = 2 and nas_ver and verphn_p			=> 1,
				verphn_p and verlst_p						=> 1,
				0
			);

			ver_tree := map(
				best_match_level = 0 and ~nas_ver and ver_pl_p = 0   => 0,
				best_match_level = 0 and  nas_ver and ver_pl_p = 1   => 5,
				best_match_level = 0 and (nas_ver or  ver_pl_p = 1)  => 2,
				best_match_level = 1 and ~nas_ver and ver_pl_p = 0   => 1,
				best_match_level = 1 and  nas_ver and ver_pl_p = 1   => 6,
				best_match_level = 1 and (nas_ver or  ver_pl_p = 1)  => 3,
				best_match_level = 2 and ~nas_ver and ver_pl_p = 0   => 1,
				best_match_level = 2 and ~nas_ver and ver_pl_p = 1   => 3,
				best_match_level = 2 and  nas_ver and ver_pl_p = 0   => 4,
				best_match_level = 2 and  nas_ver and ver_pl_p = 1   => 6,
				//best_match_level = 2 and  nas_ver and ver_pl_p = 2   => 7,
				7
			);


			ver_tree_adj_m := case( ver_tree,
				0 => 0.2580256,
				1 => 0.1998092,
				2 => 0.1441303,
				3 => 0.0824258,
				4 => 0.0508425,
				5 => 0.0491798,
				6 => 0.033238531,
				//7 => 0.0172097
				0.0172097
			);




		/* Property */
			naprop_ver := case( add1_naprop,
				4	=> 2,
				3	=> 1,
				0	// values of 0, 1, and 2
			);

			add1_year_first_seen := (INTEGER)((STRING)add1_date_first_seen)[1..4];

			sysyear := if(le.bs.historydate <> 999999, (integer)(((string)le.bs.historydate)[1..4]), (integer)(((STRING)Std.Date.Today())[1..4]));

			lres_years_a := ( sysyear - add1_year_first_seen );
			lres_years := if( lres_years_a > 100, 0, lres_years_a );

			recent_mover := (INTEGER)(lres_years <= 1);



		/* FP */

			ssninval := ~ssn_valid;
			ssndead := deceased;


			high_issue_dateyr := (INTEGER)(((STRING)high_issue_date)[1..4]);

			ssnage := sysyear - high_issue_dateyr;

			hr_address_n := (INTEGER)hr_address;

			pnotpots := not telcordia_type in ['00','50','51','52','54'];


			phone_zip_mismatch_n  := (INTEGER)phone_zip_mismatch;
			disconnected_n        := (INTEGER)disconnected;
			hr_phone_n            := (INTEGER)hr_phone;

			not_connected := not(trim(nap_status) = 'C' and disconnected_n = 0);

			mult_adl_count := map(
				adlperssn_count <= 1	=> 0,
				adlperssn_count <= 2	=> 1,
				2
			);

			not_deliverable := not usps_deliverable;

			phnprob_fa := map(
				pnotpots or phone_zip_mismatch_n = 1	=> 2,
				not_connected				=> 1,
				0
			);

			ssnprior_fa := ssnage <= 16;

			ssnprob_fa := map(
				ssninval or ssndead	=> 2,
				ssnprior_fa		=> 1,
				0
			);

			phnprob_fa_m := case( phnprob_fa,
				0	=> 0.0296986461,
				1	=> 0.0572437078,
				0.1305099395
			);



		/* Bureau / Time on Bureau */

			time_on_header_years    := sysyear - (INTEGER)(((STRING)header_first_seen)[1..4]);
			time_since_header_years := sysyear - (INTEGER)(((STRING)header_last_seen)[1..4]);

			time_since_header_code := map(
				time_since_header_years >= 14	=> 3,
				time_since_header_years >= 8	=> 2,
				time_since_header_years >= 2	=> 1,
				0
			);
				
			time_on_header_large := if( time_on_header_years <= 5 or time_on_header_years = sysyear, 0, 1 );

			Header_Combo_a := 1 + time_since_header_code - time_on_header_large;
			Header_Combo   := if( 3 < Header_Combo_a, 3, Header_Combo_a );



			header_combo_m := case( header_combo,
				0 => 0.0483458234,
				1 => 0.0526112186,
				2 => 0.0667040359,
				0.1126158232
			);


		/* Relatives */

			rel_dist := map(
				rel_count = 0	=> 0,
				rel_within25miles_count  > 0	=> 25,
				rel_within100miles_count > 0	=> 100,
				rel_within500miles_count > 0	=> 500,
				// rel_withinother_count > 0	=> 501
				501
			);

			rel_dist_code := case( rel_dist,
				0	=> 2,
				25	=> 0,
				100	=> 1,
				500	=> 3,
				4
			);

			rel_criminal_flag := rel_criminal_count > 0;
			rel_bk_flag       := rel_bankrupt_count > 0;

			rel_crimbk := map(
				rel_criminal_flag and rel_bk_flag	=> 2,
				rel_criminal_flag or  rel_bk_flag	=> 1,
				0
			);



		/* Age */

			dob_y   := in_dob[1..4];
			dob_m   := in_dob[5..6];
			dob_d   := in_dob[7..8];
			
			today := if( le.bs.historydate != 999999, ((string)le.bs.historydate)[1..6] + '01', (STRING8)Std.Date.Today() );
			today1900 := ut.DaysSince1900( today[1..4], today[5..6], today[7..8] );
			
			bd1900 := if( (INTEGER)dob_m > 0 and (INTEGER)dob_d > 0,
					ut.DaysSince1900( dob_y, dob_m, dob_d ),
					-1
			);

			age_years_a := if( bd1900 = -1, -1, round( (today1900 - bd1900)/365.25 ) );
			age_years   := if( age_years_a <= 0, -1, age_years_a );
			
			age_combo := if( age_years = -1, age, age_years );

			xx_age_combo := age_combo * age_combo;


			c_hhsize_x       := (INTEGER)(cenmatch and c_hhsize <= 2);
			c_young_x        := (INTEGER)(cenmatch and c_young >= 42);
			c_white_col_x    := (INTEGER)(cenmatch and c_white_col <= 19);
			c_cartheft_x     := (INTEGER)(cenmatch and c_cartheft >= 146);
			c_construction_x := (INTEGER)(cenmatch and c_construction <= 0);
			c_rental_x       := (INTEGER)(cenmatch and c_rental >= 186);
			c_new_homes_x    := (INTEGER)(cenmatch and c_new_homes <= 93);



		/* Census Models */

			CenMod4_a := -2.434175512
				+ c_fammar_p  * -0.011493149
				+ c_bigapt_p  * 0.0060132245
				+ c_hval_400k_p  * 0.006634643
				+ c_low_hval  * 0.0046363839
				+ c_inc_15K_p  * 0.0117017158
				+ c_easiqlife  * 0.0038452753
				+ c_food  * -0.003314186
				+ c_born_usa  * -0.003503216
				+ c_old_homes  * -0.003201655
				+ c_hhsize_x  * -0.397890044
				+ c_young_x  * 0.5606032355
				+ c_white_col_x  * 0.3328855206
				+ c_cartheft_x  * 0.3847385446
				+ c_construction_x  * 0.3196207637
				+ c_rental_x  * 0.3219857045
				+ c_new_homes_x  * 0.1687260639
			;
			CenMod4_b := (exp(CenMod4_a)) / (1+exp(CenMod4_a));
			CenMod4_c := round(1000 * CenMod4_b)/10.0;

			CenMod4 := if( ~cenmatch, 7.5, CenMod4_c );


			mod3 := -5.867363657
				+ ver_tree_adj_m  * 8.9504147198
				+ naprop_ver  * -0.083433582
				+ recent_mover  * 0.1755982284
				+ mult_adl_count  * 0.12460101
				+ ssnprob_fa  * 0.4470404535
				+ phnprob_fa_m  * 8.1201717603
				+ header_combo_m  * 4.1954175836
				+ rel_crimbk  * 0.2008317116
				+ rel_dist_code  * 0.062361402
				+ xx_age_combo  * 0.0003008191
				+ CenMod4  * 0.0921261458
			;
			phat := (exp(mod3 )) / (1+exp(mod3 ));

			base  := 660;
			odds  := 0.0531 / 0.9469;
			point := -20;

			Fraud_Score_606_a := (INTEGER)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);



		/* Overrides */

			Fraud_Score_606_b := map(
				(ssninval or ssndead) and Fraud_Score_606_a > 624	=> 624,
				~verssn_s             and Fraud_Score_606_a > 641	=> 641,
				nas_summary <= 9      and Fraud_Score_606_a > 679	=> 679,
				Fraud_Score_606_a
			);

			Fraud_Score_606_c := if( not_deliverable                        and Fraud_Score_606_b > 679, 679, Fraud_Score_606_b );
			Fraud_Score_606_d := if( ~verphn_p and disconnected_n = 1       and Fraud_Score_606_c > 641, 641, Fraud_Score_606_c );
			Fraud_Score_606_e := if( ~verphn_p and pnotpots                 and Fraud_Score_606_d > 679, 679, Fraud_Score_606_d );
			Fraud_Score_606_f := if( ~verphn_p and phone_zip_mismatch_n = 1 and Fraud_Score_606_e > 641, 641, Fraud_Score_606_e );

			Fraud_Score_606_g := if( adlperssn_count >= 10                  and Fraud_Score_606_f > 641, 641, Fraud_Score_606_f );

			Fraud_Score_606_h := if( hr_address_n = 1                       and Fraud_Score_606_g > 679, 679, Fraud_Score_606_g );
			Fraud_Score_606_i := if( hr_phone_n = 1                         and Fraud_Score_606_h > 679, 679, Fraud_Score_606_h );

			
			Fraud_Score_606 := map(Fraud_Score_606_i > 999 => 999,
														 Fraud_Score_606_i < 300 => 300,
														 Fraud_Score_606_i);


		self.ri := RiskWiseFCRA.corrReasonCodes(le.bs.consumerflags, 4);
		self.score := if(isFCRA and self.ri[1].hri in ['91','92','93','94','95'], (string)((integer)self.ri[1].hri + 10), (string)Fraud_Score_606);
		self.seq := le.bs.seq;
		
	END;

	out := PROJECT(results, doModel(LEFT));


	Risk_Indicators.Layout_Output into_layout_output(clam le) := transform
		self.seq := le.seq;
		self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
		self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
		self.socsverlevel := le.iid.NAS_summary;
		self.nxx_type := le.phone_verification.telcordia_type;
		self := le.iid;
		self := le.shell_input;
		// self := [];
		self := le;
	end;
	iid := project(clam, into_layout_output(left));

	Layout_ModelOut addReasons(Layout_ModelOut le, iid ri) := TRANSFORM
		self.ri := if(isFCRA and (le.ri[1].hri <> '00'),le.ri,RiskWise.bdReasonCodesConsumer( ri, 4, OFAC ));
		self := le;
	END;
	final := join(out, iid, left.seq=right.seq, addReasons(left, right));

	return final;
END;