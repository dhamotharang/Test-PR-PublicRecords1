import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, easi, std;


export FP5812_1_0(
	grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam,
	integer num_reasons,
	boolean OFAC
	) := FUNCTION


	// prepare bs/easi
	layout_bseasi := record 
		Risk_Indicators.Layout_Boca_Shell bs;
		Easi.layout_census ea;
	end;

	layout_bseasi join2recs(clam le, easi.Key_Easi_Census rt) :=transform
		self.bs	 := le;
		self.ea  := rt;
		self     := [];
	end; 

	results := join(clam, easi.Key_Easi_Census,
				keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
				join2recs(left,right),
				left outer);


	Layout_ModelOut doModel(results le) := TRANSFORM
		geo_blk 												 :=  le.bs.shell_input.geo_blk;
		st															 :=  le.bs.shell_input.st;
		county													 :=  le.bs.shell_input.county;
		out_addr_status                  :=  le.bs.address_validation.error_codes;
		in_dob                           :=  le.bs.shell_input.dob;
		nas_summary                      :=  le.bs.iid.nas_summary;
		nap_summary                      :=  le.bs.iid.nap_summary;
		rc_hriskphoneflag                :=  le.bs.iid.hriskphoneflag;
		rc_hphonetypeflag                :=  le.bs.iid.hphonetypeflag;
		rc_phonevalflag                  :=  le.bs.iid.phonevalflag;
		rc_hphonevalflag                 :=  le.bs.iid.hphonevalflag;
		rc_phonezipflag                  :=  le.bs.iid.phonezipflag;
		rc_hriskaddrflag                 :=  (INTEGER)le.bs.iid.hriskaddrflag;
		rc_decsflag                      :=  le.bs.ssn_verification.validation.deceased;
		rc_ssndobflag                    :=  (INTEGER)le.bs.iid.socsdobflag;
		rc_ssnvalflag                    :=  le.bs.iid.socsvalflag;
		rc_pwssnvalflag                  :=  le.bs.iid.pwsocsvalflag;
		rc_ssnhighissue                  :=  le.bs.iid.soclhighissue;
		rc_addrvalflag                   :=  le.bs.iid.addrvalflag;
		rc_dwelltype                     :=  trim(le.bs.address_validation.dwelling_type);
		rc_bansflag                      :=  le.bs.iid.bansflag;
		rc_sources                       :=  le.bs.iid.sources;
		rc_phoneaddr_addrcount           :=  le.bs.iid.phoneaddr_addrcount;
		rc_addrcommflag                  :=  le.bs.iid.addrcommflag;
		rc_hrisksic                      :=  (INTEGER)le.bs.iid.hrisksic;
		rc_hrisksicphone                 :=  le.bs.iid.hrisksicphone;
		rc_cityzipflag                   :=  le.bs.iid.cityzipflag;
		rc_lnamessnmatch2                :=  le.bs.iid.lastssnmatch2;
		rc_fnamessnmatch                 :=  le.bs.iid.firstssnmatch;
		combo_dobscore                   :=  le.bs.iid.combo_dobscore;
		combo_dobcount                   :=  le.bs.iid.combo_dobcount;
		rc_watchlist_flag                :=  le.bs.iid.watchlistHit;
		fname_sources                    :=  StringLib.StringToUppercase(trim(le.bs.Source_Verification.firstnamesources));
		lname_sources                    :=  StringLib.StringToUppercase(trim(le.bs.Source_Verification.lastnamesources));
		addr_sources                     :=  StringLib.StringToUppercase(trim(le.bs.Source_Verification.addrsources));
		ssnlength                        :=  le.bs.input_validation.ssn_length;
		dobpop                           :=  (INTEGER)le.bs.input_validation.dateofbirth;
		add1_isbestmatch                 :=  le.bs.address_verification.input_address_information.isbestmatch;
		add1_lres                        :=  le.bs.lres;
		add1_applicant_owned             :=  le.bs.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              :=  le.bs.address_verification.input_address_information.occupant_owned;
		add1_family_owned                :=  le.bs.address_verification.input_address_information.family_owned;
		dist_a1toa2                      :=  le.bs.address_verification.distance_in_2_h1;
		dist_a1toa3                      :=  le.bs.address_verification.distance_in_2_h2;
		add2_isbestmatch                 :=  le.bs.address_verification.address_history_1.isbestmatch;
		add2_lres                        :=  le.bs.lres2;
		add2_applicant_owned             :=  le.bs.address_verification.address_history_1.applicant_owned;
		add2_family_owned                :=  le.bs.address_verification.address_history_1.family_owned;
		nameperssn_count                 :=  le.bs.SSN_Verification.NamePerSSN_count;
		adlperssn_count                  :=  le.bs.SSN_Verification.adlPerSSN_count;
		addrs_per_ssn                    :=  le.bs.velocity_counters.addrs_per_ssn;
		adls_per_addr                    :=  le.bs.velocity_counters.adls_per_addr;
		ssns_per_addr                    :=  le.bs.velocity_counters.ssns_per_addr;
		phones_per_addr                  :=  le.bs.velocity_counters.phones_per_addr;
		ssns_per_adl_c6                  :=  le.bs.velocity_counters.ssns_per_adl_created_6months;
		addrs_per_adl_c6                 :=  le.bs.velocity_counters.addrs_per_adl_created_6months;
		phones_per_adl_c6                :=  le.bs.velocity_counters.phones_per_adl_created_6months;
		ssns_per_addr_c6                 :=  le.bs.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6               :=  le.bs.velocity_counters.phones_per_addr_created_6months;
		bankrupt                         :=  le.bs.bjl.bankrupt;
		liens_recent_unreleased_count    :=  le.bs.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   :=  le.bs.bjl.liens_historical_unreleased_count;
		liens_recent_released_count      :=  le.bs.bjl.liens_recent_released_count;
		liens_historical_released_count  :=  le.bs.bjl.liens_historical_released_count;
		
		// Even though this is not an FCRA model we are using felony  (BUG 31550)
		criminal_count                   :=  le.bs.bjl.felony_count;
		rel_criminal_count               :=  Min(le.bs.relatives.relative_felony_count, 1);
		rel_prop_owned_count             :=  le.bs.relatives.owned.relatives_property_count;
		rel_prop_owned_purchase_total    :=  le.bs.relatives.owned.relatives_property_owned_purchase_total;
		rel_prop_sold_purchase_total     :=  le.bs.relatives.sold.relatives_property_owned_purchase_total;
		rel_within25miles_count          :=  le.bs.relatives.relative_within25miles_count;
		rel_within100miles_count         :=  le.bs.relatives.relative_within100miles_count;
		rel_withinother_count            :=  le.bs.relatives.relative_withinOther_count;
		rel_homeunder150_count           :=  le.bs.relatives.relative_homeUnder150_count;
		rel_educationunder12_count       :=  le.bs.relatives.relative_educationUnder12_count;
		rel_ageunder30_count             :=  le.bs.relatives.relative_ageUnder30_count;
		rel_ageunder60_count             :=  le.bs.relatives.relative_ageUnder60_count;
		ams_college_code                 :=  le.bs.student.college_code;
		addr_stability                   :=  le.bs.mobility_indicator;
		archive_date                     :=  le.bs.historydate;
		error_codes                      :=  le.bs.address_validation.error_codes;
		ipaddrpop                        :=  le.bs.shell_input.ip_address <> '';

		cenmatch                         := (integer)(trim(le.ea.geolink) = (trim(le.bs.shell_input.st) + trim(le.bs.shell_input.county) + trim(le.bs.shell_input.geo_blk)));
		// cenmatch                         := (integer)(trim(le.ea.geolink) + (trim(le.bs.shell_input.st) + trim(le.bs.shell_input.county) + trim(le.bs.shell_input.geo_blk)));
		
		// Changed from converting to (REAL) as we need to check for blank values as well from these fields.
		c_fammar_p                       := le.ea.fammar_p;       //(REAL)le.ea.fammar_p;       
		c_young                          := le.ea.young;          //(REAL)le.ea.young;          
		c_bigapt_p                       := le.ea.bigapt_p;       //(REAL)le.ea.bigapt_p;       
		c_hval_400k_p                    := le.ea.hval_400k_p;    //(REAL)le.ea.hval_400k_p;    
		c_low_hval                       := le.ea.low_hval;       //(REAL)le.ea.low_hval;       
		c_inc_15K_p                      := le.ea.in15K_p;        //(REAL)le.ea.in15K_p;        
		c_cartheft                       := le.ea.cartheft;       //(REAL)le.ea.cartheft;       
		c_easiqlife                      := le.ea.easiqlife;      //(REAL)le.ea.easiqlife;      
		c_construction                   := le.ea.construction;   //(REAL)le.ea.construction;   
		c_rental                         := le.ea.rental;         //(REAL)le.ea.rental;         
		c_born_usa                       := le.ea.born_usa;       //(REAL)le.ea.born_usa;       
		c_old_homes                      := le.ea.old_homes;      //(REAL)le.ea.old_homes;      
		c_new_homes                      := le.ea.new_homes;      //(REAL)le.ea.new_homes;      
		//                                                               
		
		telcordia_type                   := le.bs.phone_verification.telcordia_type;     //330
		
		// Additional Fields from the modeling shell
    rc_fnamecount                    :=  le.bs.iid.firstcount;       // Number of Non-Phone Sources Confirming First Name
    rc_ssncount                      :=  le.bs.iid.socscount;        // Number of Non-Phone Sources Confirming SSN
    rc_phonephonecount               :=  le.bs.iid.phonephonecount;  // Number of Phone Sources Confirming Phone (Phone Search)
    rc_phoneaddr_lnamecount          :=  le.bs.iid.phoneaddr_lastcount; //le.bs.iid.phonelastcount;   // Number of Phone Sources Confirming Last Name (Address Search)
    combo_addrscore                  :=  le.bs.iid.combo_addrscore;  // Address Name Match Score (255 = Could not calculate)
    combo_fnamecount                 :=  le.bs.iid.combo_firstcount; // Number of Sources Confirming First Name
    combo_ssncount                   :=  le.bs.iid.combo_ssncount;   // Number of Sources Confirming SSN
    EQ_count                         :=  le.bs.Source_Verification.eq_count;  // Number of EQ Source Records
    ssn_sources                      :=  le.bs.source_verification.socssources;  // Header Sources Confirming SSN
    hphnpop                          :=  (INTEGER)le.bs.input_validation.homephone;  // Home Phone # Populated Indicator
    ssns_per_adl                     :=  le.bs.velocity_counters.ssns_per_adl;   // Current # of Unique SSN's Found with ADL
    addrs_per_adl                    :=  le.bs.velocity_counters.addrs_per_adl;  // Current # of Unique Addresses Found with ADL
    phones_per_adl                   :=  le.bs.velocity_counters.phones_per_adl; // Current # of Unique Phones Found with ADL

		
		
		/********************************************************************************/
		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		/********************************************************************************/

		
		
		
		sysyear := if( archive_date=999999, (integer)((STRING)Std.Date.Today())[1..4], archive_date/100 );
		phone_zip_mismatch := (integer)((INTEGER)rc_phonezipflag=1);
		disconnected := (integer)((INTEGER)rc_hriskphoneflag=5);
		deceased := (integer)(rc_decsflag);
		
		dob_yr := if((INTEGER)in_dob=0, -1, (INTEGER)in_dob[1..4]);	
		
		cell_mobile_pager := (INTEGER)((INTEGER)rc_hriskphoneflag in [1,2,3] );

		pnotpot := 1-(INTEGER)(rc_hphonetypeflag in ['0','Z']);
		phninval := (INTEGER)((INTEGER)rc_phonevalflag=0);


		phninval2           := (INTEGER)((INTEGER)rc_hphonevalflag=0);
		busphone_flag       := (INTEGER)((INTEGER)rc_hphonevalflag=1);
		hr_phone_flag       := (INTEGER)((INTEGER)rc_hphonevalflag=3);
		non_land_phone_flag := (INTEGER)((INTEGER)rc_hphonevalflag=4);

		ssnprior_pi := (INTEGER)((INTEGER)rc_ssndobflag=1);
		ssninval_pw := (INTEGER)((INTEGER)rc_pwssnvalflag in [1,2,3]);
		addinval    := (INTEGER)(rc_addrvalflag='N');
		aptflag     := (INTEGER)(rc_dwelltype='A');
		bkflag      := (INTEGER)((INTEGER)rc_bansflag in [1,2]);
		hirisk_commercial_flag := (INTEGER)((INTEGER)rc_addrcommflag in [1,2]);
		city_zip_mismatch := (INTEGER)((INTEGER)rc_cityzipflag=1);


		/* Verification                  */

		source_FR_tot := contains_i(rc_sources,'FR,');
		source_L2_tot := contains_i(rc_sources,'L2,');
		source_LI_tot := contains_i(rc_sources,'LI,');

		source_DA_fst := contains_i(fname_sources,'DA,');
		source_FR_fst := contains_i(fname_sources,'FR,');
		source_P_fst  := contains_i(fname_sources,'P ,');

		source_BA_lst := contains_i(lname_sources,'BA,');
		source_DA_lst := contains_i(lname_sources,'DA,');
		source_FR_lst := contains_i(lname_sources,'FR,');
		source_P_lst  := contains_i(lname_sources,'P ,');

		source_AM_add := contains_i(addr_sources ,'AM,');
		source_AR_add := contains_i(addr_sources ,'AR,');
		source_BA_add := contains_i(addr_sources ,'BA,');
		source_D_add  := contains_i(addr_sources ,'D ,');
		source_EB_add := contains_i(addr_sources ,'EB,');
		source_EM_add := contains_i(addr_sources ,'EM,');
		source_VO_add := contains_i(addr_sources, 'VO,'); // voter is seperate from EM now on new records
		source_EM_VO_add := if(source_EM_add=1 or source_VO_add=1, 1, 0);	// check for either em or vo
		source_FR_add := contains_i(addr_sources ,'FR,');
		source_P_add  := contains_i(addr_sources ,'P ,');
		source_PL_add := contains_i(addr_sources ,'PL,');
		source_TU_add := contains_i(addr_sources ,'TU,');
		source_V_add  := contains_i(addr_sources ,'V ,');
		source_W_add  := contains_i(addr_sources ,'W ,');
		source_WP_add := contains_i(addr_sources ,'WP,');


		num_pos_sources_NOEQ_add :=
			source_AM_add
			+ source_AR_add
			+ source_BA_add
			+ source_D_add 
			+ source_EB_add
			+ source_EM_VO_add
			+ source_P_add 
			+ source_PL_add
			+ source_TU_add
			+ source_V_add 
			+ source_W_add 
			+ source_WP_add
		;


		source_DA_flag := (integer)(source_DA_fst=1 and source_DA_lst=1);
		source_FR_flag := (source_FR_tot = 1);
		source_L2_flag := (source_L2_tot = 1);
		source_LI_flag := (source_LI_tot = 1);

		source_P_Flag := map(
			source_P_fst=1 and source_P_lst=1 and source_P_add=1 => 1,
			source_P_fst=1 and source_P_lst=1                    => -1,
			0
		);

		source_lien_flag := (integer)source_L2_flag + (integer)source_LI_flag;


		/* Nap Summary */
		contrary_phone := (INTEGER)(nap_summary=1);

		verfst_p := (INTEGER)(nap_summary in [2,3,4,8,9,10,12]);
		verlst_p := (INTEGER)(nap_summary in [2,5,7,8,9,11,12]);
		veradd_p := (INTEGER)(nap_summary in [3,5,6,8,10,11,12]);
		verphn_p := (INTEGER)(nap_summary in [4,6,7,9,10,11,12]);
                  
		best_match_level := map(
			(INTEGER)add1_isbestmatch=1 => 2,
			(INTEGER)add2_isbestmatch=1 => 0,
			1
		);

		ver_phone_tree := map(
			contrary_phone=1                                        => -1,
			verphn_p=1 and veradd_p=1 and verlst_p=1 and verfst_p=1 =>  4,
			verphn_p=1 and veradd_p=1 and verlst_p=1                =>  3,
			verphn_p=1 and                verlst_p=1 and verfst_p=1 =>  3,
			verphn_p=1 and                verlst_p=1                =>  2,
			               veradd_p=1 and verlst_p=1                =>  1,
			0
		);

		combo_dobcount_c := min( combo_dobcount, 3 );


		rc_lnamessnmatch2_c := (integer)rc_lnamessnmatch2;
		rc_fnamessnmatch_c  := (integer)rc_fnamessnmatch;
		combo_dobscore_c := (integer)(combo_dobscore=100);


		num_pos_sources_NOEQ_add_c := min( num_pos_sources_NOEQ_add, 2 );

		ver_phone_tree_m := map( 
			ver_phone_tree = -1 => 0.1430793157,
			ver_phone_tree = 0 => 0.0965580262,
			ver_phone_tree = 1 => 0.0832570906,
			ver_phone_tree = 2 => 0.0441717791,
			ver_phone_tree = 3 => 0.0322705563,
			ver_phone_tree = 4 => 0.0287731213,
			-9999
		);


		rc_lnamessnmatch2_c_m := if( rc_lnamessnmatch2_c=0, 0.0670427425, 0.047043714 );
		rc_fnamessnmatch_c_m  := if( rc_fnamessnmatch_c=0,  0.0684438802, 0.0461804887 );


		best_match_level_m := map( 
			best_match_level = 0 => 0.1305721306,
			best_match_level = 1 => 0.090647482,
			best_match_level = 2 => 0.03354579,
			-9999
		);


		combo_dob_flag := map( 
			combo_dobscore_c = 0 and combo_dobcount_c  = 0 => 0,
			combo_dobscore_c = 0 => 1,
			combo_dobscore_c = 1 and combo_dobcount_c <= 1 => 2,
			combo_dobscore_c = 1 and combo_dobcount_c <= 2 => 3,
			combo_dobscore_c = 1 => 4,
			-9999
		);

		vflag := map( 
			num_pos_sources_NOEQ_add_c = 2 and source_P_flag = 1 => 4,
			num_pos_sources_NOEQ_add_c = 2 => 3,
			num_pos_sources_NOEQ_add_c = 1 and source_P_flag = 1 => 3,
			num_pos_sources_NOEQ_add_c = 1 => 2,
			num_pos_sources_NOEQ_add_c = 0 and source_P_flag = -1 => 0,
			num_pos_sources_NOEQ_add_c = 0 => 1,
			-9999
		);


		combo_dob_flag_m := map( 
			combo_dob_flag = 0 => 0.1253342246,
			combo_dob_flag = 1 => 0.0705882353,
			combo_dob_flag = 2 => 0.0536858974,
			combo_dob_flag = 3 => 0.0423194303,
			combo_dob_flag = 4 => 0.0397022333,
			-9999
		);

		vflag_m := map( 
			vflag = 0 => 0.1185770751,
			vflag = 1 => 0.0747782003,
			vflag = 2 => 0.0476190476,
			vflag = 3 => 0.0333628907,
			vflag = 4 => 0.0269027042,
			-9999
		);

		nas_ver := (integer)(nas_summary >= 10);

		ver_pl_p := map( 
			best_match_level = 2 and nas_ver=1 and verphn_p=1 and verlst_p=1 => 2,
			best_match_level = 2 and nas_ver=1 and verphn_p=1 => 1,
			verphn_p=1 and verlst_p=1 => 1,
		   0
		);
		
		ver_mod_best2 := -2.748940675
		   + rc_fnamessnmatch_c_m  * 13.910793055
		   + combo_dob_flag_m  * 10.184313015
		   + nas_ver  * -1.435012608
		   + ver_pl_p  * -0.411016589
		;
		
		ver_mod_notbest2 := -3.478058771
			+ ver_phone_tree_m  * 16.757335633
			+ rc_lnamessnmatch2_c_m  * -22.8650506
			+ combo_dob_flag_m  * 11.363475337
			+ vflag_m  * 12.741625525
			+ nas_ver  * -0.615939096
			+ rc_phoneaddr_addrcount  * 0.5389731378
		;
		ver_mod2 := if(add1_isbestmatch, ver_Mod_best2, ver_mod_notbest2 );
		ver_mod3 := (exp(ver_mod2 )) / (1+exp(ver_mod2 ));


		/* FP                            */
		cellphone := (integer)( cell_mobile_pager=1 or non_land_phone_flag=1 );
	

		pnotpot2 := map( 
			pnotpot = 1 and cellphone = 0 => 2,
			pnotpot = 1 or  cellphone = 1 => 1,
			0
		);

		phninval_flag := (integer)(phninval=1 or phninval2=1);

		
		phnprob_tree := map( 
			pnotpot2=2 or phone_zip_mismatch=1 or hr_phone_flag=1 or phninval_flag=1 => 4,
			pnotpot = 1     => 3,
			disconnected=1  => 2,
			busphone_flag=1 => 1,
		   0
		);


/* Address */
		ec1 := trim(error_codes)[1];
		ec3 := trim(error_codes)[3];
		ec4 := trim(error_codes)[4];
		
		addr_changed := (INTEGER)(ec1='S' AND ec3 != '0');
		unit_changed := (INTEGER)(ec1='S' AND ec4 != '0');

		casserror3 := map(
			trim(error_codes)='E412' => 1,
			ec1 = 'E' => 4,
			ec1 = 'S' and addr_changed=1 and unit_changed=1  => 3,
			ec1 = 'S' and (unit_changed=1 or addr_changed=1) => 2,
			0
		);

		addprob_tree := map(
			aptflag=1 or city_zip_mismatch=1 or hirisk_commercial_flag=1 => 3,
			addinval=1 or casserror3>=3 => 2,
			casserror3 >= 1 => 1,
			0
		);


		/* SSN */
		ssnprob := (integer)(deceased=1 or ssnprior_pi=1 or ssninval_pw=1);

		phnprob_tree_m := map( 
			phnprob_tree = 0 => 0.0407985028,
			phnprob_tree = 1 => 0.0573170732,
			phnprob_tree = 2 => 0.0868131868,
			phnprob_tree = 3 => 0.1066359801,
			phnprob_tree = 4 => 0.1684311838,
			-9999
		);

		aptflag_m := map( 
			aptflag = 0 => 0.045842459,
			aptflag = 1 => 0.1045490822,
			-9999
		);

		addinval_m := map( 
			addinval = 0 => 0.0524318966,
			addinval = 1 => 0.0741869919,
			-9999
		);

		casserror3_m := map( 
			casserror3 = 0 => 0.0457557437,
			casserror3 = 1 => 0.0558375635,
			casserror3 = 2 => 0.0682358535,
			casserror3 = 3 => 0.0869565217,
			casserror3 = 4 => 0.0982142857,
			-9999
		);

		addprob_tree_m := map( 
			addprob_tree = 0 => 0.0385510856,
			addprob_tree = 1 => 0.0577606635,
			addprob_tree = 2 => 0.0693069307,
			addprob_tree = 3 => 0.108478803,
			-9999
		);




		/* Velocity                      */

		ssns_per_adl_c6_c   := min( ssns_per_adl_c6  , 2 );
		addrs_per_adl_c6_c  := min( addrs_per_adl_c6 , 2 );
		phones_per_adl_c6_c := min( phones_per_adl_c6, 2 );

		velo_adl_c6 := map( 
			phones_per_adl_c6_c  = 2 or  ssns_per_adl_c6_c   = 2 => 3,
			phones_per_adl_c6_c <= 0 and addrs_per_adl_c6_c <= 1 => 0,
			phones_per_adl_c6_c <= 0                             => 1,
			phones_per_adl_c6_c <= 1 and ssns_per_adl_c6_c <= 0  => 1,
			phones_per_adl_c6_c <= 1                             => 2,
			2
		);

		addrs_per_ssn_c := 1-((integer)(addrs_per_ssn in [2,3]));

		nameperssn_count_c := min( nameperssn_count, 1 );

		adlperssn_count_c := map( 
			adlperssn_count = 1 => 0,
			adlperssn_count = 2 => 1,
			adlperssn_count = 3 => 2,
			//adlperssn_count_c => 3
			3
		);

		velo_ssn := map( 
			adlperssn_count_c = 3 => 4,
			nameperssn_count_c >= 1 => 3,
			nameperssn_count_c = 0 and addrs_per_ssn_c = 0 => 0,
			sum( nameperssn_count_c, addrs_per_ssn_c ) = 1 => 1,
			sum( nameperssn_count_c, addrs_per_ssn_c ) = 2 => 2,
			sum( nameperssn_count_c, addrs_per_ssn_c ) = 3 => 3,
			3
		);

		adls_per_addr_c := map( 
			adls_per_addr in [2,3,4,5]    => 0,
			adls_per_addr in [6,7]        => 1,
			adls_per_addr in [8,9,10 ]    => 2,
			adls_per_addr in [1,11,12,13] => 3,
			adls_per_addr >= 14 and adls_per_addr <= 21 => 4,
			5
		);

		ssns_per_addr_c := map( 
			ssns_per_addr in [2,3,4]     => 0,
			ssns_per_addr in [5,6,7]     => 1,
			ssns_per_addr in [8,9,10,11] => 2,
			ssns_per_addr = 1            => 3,
			ssns_per_addr >= 12 and ssns_per_addr <= 22 => 3,
			4
		);

		phones_per_addr_c := map( 
			phones_per_addr = 1 => 0,
			phones_per_addr in [0,2] => 1,
			phones_per_addr = 3 => 2,
			3
		);

		velo_addr := map( 
			ssns_per_addr_c <= 0 => 0,
			ssns_per_addr_c <= 1 and adls_per_addr_c <= 1 => 1,
			ssns_per_addr_c <= 2 => 2,
			ssns_per_addr_c <= 3 and adls_per_addr_c <= 0 => 2,
			ssns_per_addr_c <= 3 and adls_per_addr_c <= 3 => 3,
			ssns_per_addr_c <= 3 => 4,
			ssns_per_addr_c <= 4 and adls_per_addr_c <= 3 => 3,
			ssns_per_addr_c <= 4 and adls_per_addr_c <= 4 => 4,
			ssns_per_addr_c <= 4 and adls_per_addr_c <= 5 => 5,
			5
		);


		velo_addr2 := map( 
			phones_per_addr_c <= 0 and velo_addr <= 0 => 0,
			phones_per_addr_c <= 0 and velo_addr <= 1 => 1,
			phones_per_addr_c <= 0 and velo_addr <= 2 => 2,
			phones_per_addr_c <= 0 and velo_addr <= 3 => 5,
			phones_per_addr_c <= 0 and velo_addr <= 4 => 7,
			phones_per_addr_c <= 0 => 8,

			phones_per_addr_c <= 1 and velo_addr <= 0 => 1,
			phones_per_addr_c <= 1 and velo_addr <= 1 => 3,
			phones_per_addr_c <= 1 and velo_addr <= 2 => 4,
			phones_per_addr_c <= 1 and velo_addr <= 3 => 6,
			phones_per_addr_c <= 1 => 9,

			phones_per_addr_c <= 2 and velo_addr <= 3 => 8,
			phones_per_addr_c <= 2 and velo_addr <= 4 => 9,
			phones_per_addr_c <= 2 => 10,

			phones_per_addr_c <= 3 and velo_addr <= 1 => 8,
			phones_per_addr_c <= 3 and velo_addr <= 4 => 9,
			phones_per_addr_c <= 3 => 10,
			10
		);

		ssns_per_addr_c6_c   := min( ssns_per_addr_c6, 4 );
		phones_per_addr_c6_c := min( phones_per_addr_c6, 3 );

		velo_addr_c6 := map( 
			phones_per_addr_c6_c <= 0 and ssns_per_addr_c6_c <= 0 => 0,
			phones_per_addr_c6_c <= 0 and ssns_per_addr_c6_c <= 1 => 1,
			phones_per_addr_c6_c <= 0 and ssns_per_addr_c6_c <= 2 => 2,
			phones_per_addr_c6_c <= 0 and ssns_per_addr_c6_c <= 3 => 4,
			phones_per_addr_c6_c <= 0 => 6,

			phones_per_addr_c6_c <= 1 and ssns_per_addr_c6_c <= 0 => 1,
			phones_per_addr_c6_c <= 1 and ssns_per_addr_c6_c <= 3 => 4,
			phones_per_addr_c6_c <= 1 => 6,

			phones_per_addr_c6_c <= 2 and ssns_per_addr_c6_c <= 0 => 3,
			phones_per_addr_c6_c <= 2 and ssns_per_addr_c6_c <= 2 => 4,
			phones_per_addr_c6_c <= 2 => 6,

			phones_per_addr_c6_c <= 3 and ssns_per_addr_c6_c <= 2 => 5,
			phones_per_addr_c6_c <= 3 => 6,
			6
		);


		/* Property                      */

		dist_a1a2_flag := map( 
			dist_a1toa2 = 0 => 0,
			dist_a1toa2 >= 20 => 2,
			1
		);

		dist_a1a3_flag := map( 
			dist_a1toa3 = 0 => 0,
			dist_a1toa3 >= 20 => 2,
			1
		);

		dist_flag := map( 
			dist_a1a2_flag = 0 => 0,
			dist_a1a3_flag = 0 => 1,
			dist_a1a3_flag = 1 => 2,
			dist_a1a2_flag = 1 => 3,
			4
		);


		add1_lres_flag := map( 
			add1_lres = 0 => 0,
			add1_lres <= 4 => 1,
			2
		);

		add2_lres_flag := map( 
			add2_lres = 0 => 0,
			add2_lres <= 5 => 1,
			2
		);

		lres_flag := map( 
			add1_lres_flag = 2 and add2_lres_flag = 2 => 3,
			add1_lres_flag = 2 => 2,
			add1_lres_flag = 0 and add2_lres_flag <= 1 => 0,
			1
		);

		addr_stability2 := map( 
			(integer)addr_stability <= 0 => 0,
			(integer)addr_stability <= 1 => 1,
			(integer)addr_stability <= 3 => 2,
			(integer)addr_stability <= 4 => 3,
			(integer)addr_stability <= 5 => 4,
			5
		);

		add1_ownership_flag := map( 
			add1_applicant_owned and add1_family_owned => 4,
			add1_applicant_owned                       => 3,
									 add1_family_owned => 2,
			add1_occupant_owned => 1,
			0
		);


		add2_ownership_flag := map( 
			add2_applicant_owned => 2,
			add2_family_owned    => 1,
			0
		);

		dist_flag_m := map( 
			dist_flag = 0 => 0.0439172135,
			dist_flag = 1 => 0.0477508651,
			dist_flag = 2 => 0.051291698,
			dist_flag = 3 => 0.0563420159,
			dist_flag = 4 => 0.0647645499,
			-9999
		);

		lres_flag_m := map( 
			lres_flag = 0 => 0.1858000706,
			lres_flag = 1 => 0.0700152207,
			lres_flag = 2 => 0.0436820797,
			lres_flag = 3 => 0.0366303789,
			-9999
		);

		add1_ownership_flag_m := map( 
			add1_ownership_flag = 0 => 0.0904248408,
			add1_ownership_flag = 1 => 0.0713506437,
			add1_ownership_flag = 2 => 0.0390738061,
			add1_ownership_flag = 3 => 0.03855307,
			add1_ownership_flag = 4 => 0.0270467076,
			-9999
		);

		add2_ownership_flag_m := map( 
			add2_ownership_flag = 0 => 0.0484675695,
			add2_ownership_flag = 1 => 0.0561555076,
			add2_ownership_flag = 2 => 0.0723828514,
			-9999
		);

		addr_stability2_m := map( 
			addr_stability2 = 0 => 0.108559499,
			addr_stability2 = 1 => 0.0779804388,
			addr_stability2 = 2 => 0.056542811,
			addr_stability2 = 3 => 0.049677664,
			addr_stability2 = 4 => 0.047422365,
			addr_stability2 = 5 => 0.0380656755,
			-9999
		);

		prop_mod_a := -6.417021023
			+ dist_flag_m  * 25.3869821
			+ lres_flag_m  * 9.0350963562
			+ add1_ownership_flag_m  * 8.4757127566
			+ add2_ownership_flag_m  * 16.763011653
			+ addr_stability2_m  * 3.8242668478
			+ source_P_flag  * -0.269968978
		;

		prop_mod := (exp(prop_mod_a)) / (1+exp(prop_mod_a));


		/* Derog                         */
		lien_rec_unrel_flag := (integer)(liens_recent_unreleased_count>0);
		lien_hist_unrel_flag := (integer)(liens_historical_unreleased_ct>0);
		lien_rec_rel_flag := (integer)(liens_recent_released_count>0);
		lien_hist_rel_flag := (integer)(liens_historical_released_count>0);

		lien_level := map(
			lien_rec_unrel_flag=1 or source_lien_flag=2 => 2,
			source_lien_flag+lien_hist_unrel_flag+lien_rec_rel_flag+lien_hist_rel_flag > 0 => 1,
			0
		);

		criminal_flag := (integer)(criminal_count>0);
		crim_drug_flag := (integer)(criminal_flag=1 or source_DA_flag=1);

		bankrupt_flag := max( bkflag, bankrupt, source_BA_lst );


		derog_level2 := map( 
			lien_level=2 or crim_drug_flag=1 or source_FR_flag => 2,
			lien_level=1 or bankrupt_flag=1 => 1,
			0
		);

		derog_level2_m := map( 
			derog_level2 = 0 => 0.0517161822,
			derog_level2 = 1 => 0.0649681529,
			derog_level2 = 2 => 0.0963855422,
			-9999
		);

		fp_mod3_a := -5.286940933
			+ phnprob_tree_m  * 11.642233722
			+ addprob_tree_m  * 12.388971237
			+ casserror3_m  * 5.516033048
			+ ssnprob  * 1.6198863542
			+ derog_level2_m  * 12.986136904
		;
		fp_mod3 := (exp(fp_mod3_a)) / (1+exp(fp_mod3_a));


		/* Age                           */
		dob_age := if(dob_yr=-1, 0, sysyear - dob_yr);
		dob_age_code3 := map( 
			dob_age <= 20 => 0,
			dob_age <= 27 => 1,
			dob_age <= 47 => 2,
			dob_age <= 60 => 3,
			dob_age <= 69 => 4,
			dob_age <= 83 => 5,
			6
		);

		dob_age_code3_m := map( 
			dob_age_code3 = 0 => 0.0738688827,
			dob_age_code3 = 1 => 0.0492365223,
			dob_age_code3 = 2 => 0.0430723727,
			dob_age_code3 = 3 => 0.049876109,
			dob_age_code3 = 4 => 0.0595642614,
			dob_age_code3 = 5 => 0.0868036777,
			dob_age_code3 = 6 => 0.1700404858,
			-9999
		);



		/* Relatives                     */
		rel_prop_owned_risk := map( 
			rel_prop_owned_count = 1 => 0,
			rel_prop_owned_count in [2,3,4,5] => 1,
			2
		);

		rel_prop_owned_p_amt_risk := map( 
			rel_prop_owned_purchase_total = 0 => 1,
			rel_prop_owned_purchase_total <= 30000 => 2,
			rel_prop_owned_purchase_total <= 40000 => 1,
			0
		);


		rel_prop_sold_p_amt_risk := map( 
			rel_prop_sold_purchase_total = 0 => 0,
			rel_prop_sold_purchase_total <= 50000 => 1,
			0
		);


		rel_within25miles_risk := map( 
			rel_within25miles_count = 3 => 0,
			rel_within25miles_count in [1,2,4] => 1,
			rel_within25miles_count in [5,6,7] => 2,
			rel_within25miles_count = 0 => 4,
			3
		);

		rel_within100miles_risk := map( 
			rel_within100miles_count in [1,2] => 0,
			1
		);

		rel_withinother_risk := min ( rel_withinother_count, 5 );


		rel_homeunder150_risk := map( 
			rel_homeunder150_count = 3 => 0,
			rel_homeunder150_count = 2 => 1,
			rel_homeunder150_count <= 6 => 2,
			3
		);


		rel_educationunder12_risk := map( 
			rel_educationunder12_count = 0 => 0,
			rel_educationunder12_count = 1 => 1,
		   2
		);

		rel_ageunder30_risk := map( 
			rel_ageunder30_count = 0 => 0,
			rel_ageunder30_count <= 4 => 1,
			2
		);


		rel_ageunder60_risk := map( 
			rel_ageunder60_count = 1 => 0,
		   1
		);



		rel_mod_a := -4.431264259
			+ rel_criminal_count  * 0.518044903
			+ rel_prop_owned_risk  * 0.1397163608
			+ rel_prop_owned_p_amt_risk  * 0.1546865155
			+ rel_prop_sold_p_amt_risk  * 0.4719136257
			+ rel_within25miles_risk  * 0.2403386075
			+ rel_within100miles_risk  * 0.1582733197
			+ rel_withinother_risk  * 0.082105894
			+ rel_homeunder150_risk  * 0.1230061547
			+ rel_educationunder12_risk  * 0.2462402658
			+ rel_ageunder30_risk  * 0.1870088651
			+ rel_ageunder60_risk  * 0.3286735365
		;
		rel_mod := (exp(rel_mod_a)) / (1+exp(rel_mod_a));

		ams_4year := (integer)(ams_college_code[1] = '4');


		/* Census */

		c_young_x         := (integer)(cenmatch=1 and (REAL)c_young        >= 42  );
		c_cartheft_x      := (integer)(cenmatch=1 and (REAL)c_cartheft     >= 146 );
		c_construction_x  := (integer)(cenmatch=1 and (REAL)c_construction <= 0   );
		c_rental_x        := (integer)(cenmatch=1 and (REAL)c_rental       >= 186 );
		c_new_homes_x     := (integer)(cenmatch=1 and (REAL)c_new_homes    <= 93  );


	  // Check to see if any values used in calculation are empty.
		run_calc := Map(length(trim(c_fammar_p)) = 0 => 0,
										length(trim(c_bigapt_p)) = 0 => 0,
										length(trim(c_hval_400k_p)) = 0 => 0,
										length(trim(c_low_hval)) = 0 => 0,
										length(trim(c_inc_15K_p)) = 0 => 0,
										length(trim(c_easiqlife)) = 0 => 0,
										length(trim(c_born_usa)) = 0 => 0,
										length(trim(c_old_homes)) = 0 => 0,
										length(trim(c_young)) = 0 => 0,
										length(trim(c_cartheft)) = 0 => 0,
										length(trim(c_construction)) = 0 => 0,
										length(trim(c_rental)) = 0 => 0,
										length(trim(c_new_homes)) = 0 => 0,
										1);

		cenmod2_a :=
			-2.204934938
			+ (REAL)c_fammar_p  * -0.012948072
			+ (REAL)c_bigapt_p  * 0.0048627991
			+ (REAL)c_hval_400k_p  * 0.0068055095
			+ (REAL)c_low_hval  * 0.0052586168
			+ (REAL)c_inc_15K_p  * 0.0140868107
			+ (REAL)c_easiqlife  * 0.0024348604
			+ (REAL)c_born_usa  * -0.003358364
			+ (REAL)c_old_homes  * -0.003596838
			+ (REAL)c_young_x  * 0.2898477368
			+ (REAL)c_cartheft_x  * 0.4112065379
			+ (REAL)c_construction_x  * 0.235961274
			+ (REAL)c_rental_x  * 0.1675063027
			+ (REAL)c_new_homes_x  * 0.1247791255
		;
     
		 cenmod2 := if( cenmatch=1 and run_calc=1, (exp(cenmod2_a)) / (1+exp(cenmod2_a)), 0.0796178);
				
				
 
		/* FP3710 Model */
		base  := 701;
		odds  := 1 / 201;
		point := -50;



		 fd_mod13b_t := -3.914470584
			+ rel_mod  * 5.6938954562
			+ prop_mod  * 3.5029999684
			+ dob_age_code3_m  * 17.561090948
			+ ver_mod3  * 4.591155478
			+ ams_4year  * -0.869704159
			+ fp_mod3  * 4.6162392889
			+ cenmod2  * 7.3291175074
			+ velo_ssn  * 0.1331470325
			+ velo_addr2  * 0.0414953039
			+ velo_adl_c6  * 0.1550482151
			+ velo_addr_c6  * 0.0791216624
			+ addinval_m  * -42.8591799
			+ aptflag_m  * -8.480579594
			+ best_match_level_m  * 3.9120832423
			+ ver_phone_tree_m  * 4.6226146469
			+ combo_dob_flag_m  * 3.1934970541
		 ;
		 
		 fd_mod13b_a := fd_mod13b_t -2.662320034;		 
		 
		 fd_mod13b_b := (exp(fd_mod13b_a)) / (1+exp(fd_mod13b_a));
		 phat := fd_mod13b_b;
		 fd_mod13b := (integer)(point*(log(phat/(1-phat)) - log(odds))/log(2) + base);
		 
// ********************************************************************************************************
/* Insert Code to Handle Missing Phone, SSN and DOB                  10-01-08 PK */


     fd_mod13c := fd_mod13b;

     source_AM_ssn := contains_i(ssn_sources ,'AM,');
     source_AR_ssn := contains_i(ssn_sources ,'AR,');
     source_BA_ssn := contains_i(ssn_sources ,'BA,');
     source_D_ssn  := contains_i(ssn_sources ,'D ,');
     source_EB_ssn := contains_i(ssn_sources ,'EB,');
     source_EM_ssn := contains_i(ssn_sources ,'EM,');
	 source_VO_ssn := contains_i(ssn_sources ,'VO,');
	 source_EM_VO_ssn := if(source_EM_ssn=1 or source_VO_ssn=1, 1, 0);
     source_P_ssn  := contains_i(ssn_sources ,'P ,');
     source_PL_ssn := contains_i(ssn_sources ,'PL,');
     source_TU_ssn := contains_i(ssn_sources ,'TU,');
     source_V_ssn  := contains_i(ssn_sources ,'V ,');
     source_W_ssn  := contains_i(ssn_sources ,'W ,');
     source_WP_ssn := contains_i(ssn_sources ,'WP,');
                              
		                 
     num_pos_sources_NOEQ_ssn := sum(
                              source_AM_ssn ,
                              source_AR_ssn ,
                              source_BA_ssn ,
                              source_D_ssn  ,
                              source_EB_ssn ,
                              source_EM_VO_ssn ,
                              source_P_ssn  ,
                              source_PL_ssn ,
                              source_TU_ssn ,
                              source_V_ssn  ,
                              source_W_ssn  ,
                              source_WP_ssn
                            );


     num_pos_sources_NOEQ_ssn_c := min ( num_pos_sources_NOEQ_ssn , 1 );

     num_pos_sources_NOEQ_ssn_c_m := if(num_pos_sources_NOEQ_ssn_c = 0, 0.1022262608, 0.0492867332);

     ssns_per_adl_c := if(ssns_per_adl = 1, 0, 1);

     addrs_per_adl_c := Map(addrs_per_adl = 7 => 0,
														(( addrs_per_adl >= 3 ) and ( addrs_per_adl <= 20 )) => 1,
														addrs_per_adl = 2 => 2,
														3);

     phones_per_adl_c := Map(phones_per_adl = 1 => 0,
														 phones_per_adl = 0 => 1,
														 2);


     velo_adl := Map(ssns_per_adl_c <= 0  and addrs_per_adl_c <= 0  and phones_per_adl_c <= 0  => 0,
										 ssns_per_adl_c <= 0  and addrs_per_adl_c <= 0  and phones_per_adl_c <= 1  => 1,
										 ssns_per_adl_c <= 0  and addrs_per_adl_c <= 1  and phones_per_adl_c <= 1  => 1,
										 ssns_per_adl_c <= 0  and addrs_per_adl_c <= 2  and phones_per_adl_c <= 1  => 2,
										 ssns_per_adl_c <= 0  and addrs_per_adl_c <= 3  and phones_per_adl_c <= 0  => 2,
										 ssns_per_adl_c <= 0  and addrs_per_adl_c <= 1  and phones_per_adl_c <= 2  => 3,
										 ssns_per_adl_c <= 0  and addrs_per_adl_c <= 3  and phones_per_adl_c <= 2  => 4,
										 ssns_per_adl_c <= 1  and addrs_per_adl_c <= 0  and phones_per_adl_c <= 1  => 2,
										 ssns_per_adl_c <= 1  and addrs_per_adl_c <= 1  and phones_per_adl_c <= 0  => 2,
										 ssns_per_adl_c <= 1  and addrs_per_adl_c <= 0  and phones_per_adl_c <= 2  => 3,
										 ssns_per_adl_c <= 1  and addrs_per_adl_c <= 1  and phones_per_adl_c <= 1  => 3,
										 4);



     city_zip_mismatch_m := if(city_zip_mismatch = 0, 0.0524951824, 0.1888111888);

     hirisk_commercial_flag_m := if(hirisk_commercial_flag = 0, 0.0526736898, 0.1102040816);


     addprob_mod_tmp := -4.30549571
                  + city_zip_mismatch_m  * 4.8402114832
                  + casserror3_m  * 6.119055673
                  + addprob_tree_m  * 14.455156819 ;
		 
     addprob_mod := (exp(addprob_mod_tmp )) / (1+exp(addprob_mod_tmp ));

     addprob_mod2_tmp := -4.994542159
                  + city_zip_mismatch_m  * 9.6138923018
                  + hirisk_commercial_flag_m  * 12.730319108
                  + casserror3_m  * 16.93160518 ;
		 
     addprob_mod2 := (exp(addprob_mod2_tmp )) / (1+exp(addprob_mod2_tmp ));



     rc_fnamecount_c := min( rc_fnamecount, 3 );

     rc_fnamecount_c_m := Map(rc_fnamecount_c = 0 => 0.2291666667,
														  rc_fnamecount_c = 1 => 0.0986145069,
														  rc_fnamecount_c = 2 => 0.0619195046,
														  rc_fnamecount_c = 3 =>0.0483529265,
															-9999);


     combo_ssncount_c := min ( combo_ssncount   , 2 );

     combo_ssncount_c_m := Map(combo_ssncount_c = 0 => 0.2328244275,
															 combo_ssncount_c = 1 => 0.0814006367,
															 combo_ssncount_c = 2 => 0.0492080634,
															 -9999);


     combo_addrscore_flag := if(combo_addrscore = 100, 1, 0);
     
     combo_addrscore_flag_m := if(combo_addrscore_flag = 0, 0.1462184874, 0.042983936);

     rc_ssncount_c := min ( rc_ssncount  , 3 );

     rc_ssncount_c_m := Map(rc_ssncount_c = 0 => 0.2328244275,
														rc_ssncount_c = 1 => 0.0814006367,
														rc_ssncount_c = 2 => 0.0471645143,
														rc_ssncount_c = 3 => 0.0560237203,
														-9999);


     source_EQ_fst := contains_i(fname_sources ,'EQ,');
     source_EQ_lst := contains_i(lname_sources ,'EQ,');
     source_EQ_add := contains_i(addr_sources ,'EQ,');
     source_EQ_ssn := contains_i(ssn_sources ,'EQ,');
 

     num_pos_sources_add := sum(
                              source_AM_add ,
                              source_AR_add ,
                              source_BA_add ,
                              source_D_add  ,
                              source_EB_add ,
                              source_EM_VO_add ,
                              source_EQ_add ,
                              source_P_add  ,
                              source_PL_add ,
                              source_TU_add ,
                              source_V_add  ,
                              source_W_add  ,
                              source_WP_add
                            );

     num_pos_sources_add_c := min ( num_pos_sources_add, 3 );


     source_EQ_flag := map(source_EQ_fst = 1 and source_EQ_lst = 1 and source_EQ_add = 1 and source_EQ_ssn = 1 => 1,
													 source_EQ_fst = 1 and source_EQ_lst = 1 and source_EQ_ssn = 1 => -1,
													 0);


     vaddflag := Map(num_pos_sources_add_c >= 3 and source_EQ_flag >= 1 => 4,
										 num_pos_sources_add_c >= 2 and  source_EQ_flag >= 1 => 3,
										 num_pos_sources_add_c >= 1 and  source_EQ_flag >= 1 => 2,
										 num_pos_sources_add_c >= 2                          => 2,
										 num_pos_sources_add_c >= 1                          => 1,
										 0);

     vaddflag_m := Map(vaddflag = 0 => 0.1878021569,
											 vaddflag = 1 => 0.0772913817,
											 vaddflag = 2 => 0.0535898317,
											 vaddflag = 3 => 0.0331095688,
											 vaddflag = 4 => 0.026844071,
											 -9999);


     EQ_count_c := Map(EQ_count <= 0 => 0,
											 EQ_count <= 1 => 1,
											 EQ_count <= 2 => 2,
											 EQ_count <= 6 => 3,
											 EQ_count <= 8 => 4,
											 5);

     EQ_count_c_m := Map(EQ_count_c = 0 => 0.0681362725,
												 EQ_count_c = 1 => 0.0629213483,
												 EQ_count_c = 2 => 0.0597014925,
												 EQ_count_c = 3 => 0.0540998898,
												 EQ_count_c = 4 => 0.0507115136,
												 EQ_count_c = 5 => 0.0458922096,
												 -9999);



     combo_fnamecount_c  := min ( combo_fnamecount , 4 );

     combo_fnamecount_c_m := Map(combo_fnamecount_c = 0 => 0.2647058824,
																 combo_fnamecount_c = 1 => 0.1029572837,
																 combo_fnamecount_c = 2 => 0.0741974561,
																 combo_fnamecount_c = 3 => 0.0604832658,
																 combo_fnamecount_c = 4 => 0.0438973827,
																 -9999);


     ssnprob_nodob := if(deceased = 1 or ssninval_pw = 1, 1, 0);       /* Added 6-16 PK */
 
     ver_mod_best_nodob := -2.817321692                                      /* Added 6-11 PK */
                       + rc_fnamessnmatch_c_m  * 14.458214449
                       + num_pos_sources_NOEQ_ssn_c_m  * 10.74621313
                       + nas_ver  * -1.384909133
                       + ver_pl_p  * -0.424054628 ;
											 
     ver_mod_nodob_a := (exp( ver_mod_best_nodob )) / (1+exp( ver_mod_best_nodob ));


     ver_mod_notbest_nodob := -2.810354097                                 /* Added 6-11 PK */
                       + ver_phone_tree_m  * 17.130353728
                       + rc_lnamessnmatch2_c_m  * -20.64699447
                       + vflag_m  * 11.875682126
                       + nas_ver  * -0.737431011
                       + rc_phoneaddr_addrcount  * 0.5485123481 ;
											 
     ver_mod_nodob_b := (exp( ver_mod_notbest_nodob )) / (1+exp( ver_mod_notbest_nodob ));
		 
		 ver_mod_nodob := if(add1_isbestmatch, ver_mod_nodob_a, ver_mod_nodob_b);
		 
		 
		 
     fp_mod_nodob_tmp := -5.303359747                                    /* NoDob FP Mod Added 6-16 PK */
                  + phnprob_tree_m  * 11.794036178
                  + addprob_tree_m  * 12.425884432
                  + casserror3_m  * 5.696204236
                  + ssnprob_nodob  * 2.3734076637
                  + derog_level2_m  * 12.881184075 ;
									
     fp_mod_nodob := (exp(fp_mod_nodob_tmp )) / (1+exp(fp_mod_nodob_tmp ));


     fd_mod13c_NoDob_tmp := -2.88997184
                  + rel_mod  * 5.38990313
                  + prop_mod  * 3.3185918565
                  + ver_mod_nodob  * 4.9613068619
                  + ams_4year  * -0.955767008
                  + fp_mod_nodob  * 5.3472319067
                  + cenmod2  * 7.512663796
                  + velo_adl  * 0.1115868161
                  + velo_ssn  * 0.1229260866
                  + velo_addr2  * 0.0373797368
                  + velo_addr_c6  * 0.0912110407
                  + addinval_m  * -42.92472364
                  + aptflag_m  * -8.018854371
                  + best_match_level_m  * 3.6842211858
                  + ver_phone_tree_m  * 3.1457282663

          -2.662320034                  /* Weighting Adjustment        8-22-2008 PK */
     ;
     phat2 := (exp( fd_mod13c_NoDob_tmp )) / (1+exp( fd_mod13c_NoDob_tmp ));
     fd_mod13c_NoDob := (INTEGER)(point*(log(phat2/(1-phat2)) - log(odds))/log(2) + base);



/* Added Code to Handle Missing Phone And/Or SSN                    8-22-2008  PK  */

     /* NoPhn Specific Code */

        ver_phone_nophn_tree := Map(veradd_p = 1 and verlst_p = 1 and verfst_p = 1 => 3,
																		veradd_p = 1 and verlst_p = 1                  => 2,
																		veradd_p = 1                                   => 1,
																		0);

        ver_phone_nophn_tree_m := Map(ver_phone_nophn_tree = 0 => 0.0799772756,
																			ver_phone_nophn_tree = 1 => 0.0736842105,
																			ver_phone_nophn_tree = 2 => 0.0457697642,
																			ver_phone_nophn_tree = 3 => 0.0350677704,
																			-9999);


        fp_mod_nophn_tmp := -4.36620104
                     + addprob_mod  * 14.087731403
                     + ssnprob  * 1.7646756233
                     + derog_level2_m  * 12.462135456 ;
										 
        fp_mod_nophn := (exp(fp_mod_nophn_tmp )) / (1+exp(fp_mod_nophn_tmp ));


        fd_mod13b_nophn_tmp := -3.272175166
                     + rel_mod  * 6.4468814916
                     + prop_mod  * 3.0245521128
                     + dob_age_code3_m  * 16.270260998
                     + ver_mod3  * 5.420172046
                     + ams_4year  * -0.780643876
                     + cenmod2  * 7.8869112809
                     + velo_ssn  * 0.1420720258
                     + velo_addr2  * 0.0497830487
                     + velo_addr_c6  * 0.0968564996
                     + addinval_m  * -47.37285036
                     + aptflag_m  * -7.828005034
                     + best_match_level_m  * 3.3855341774
                     + ver_phone_nophn_tree  * -0.068017881
                     + fp_mod_nophn  * 4.2745119871

          -2.662320034                  /* Weighting Adjustment        8-22-2008 PK */
        ;
				
        phat3 := (exp(fd_mod13b_nophn_tmp )) / (1+exp(fd_mod13b_nophn_tmp ));
        fd_mod13b_nophn := (INTEGER)(point*(log(phat3/(1-phat3)) - log(odds))/log(2) + base);



     /* NoPhn-NoDOB Specific Code                          9-18 PK */

        ver_mod_best_nophn_nodob := -5.450978595
                          + source_lien_flag  * 0.497058458
                          + rc_fnamecount_c_m  * 9.6625931128
                          + combo_ssncount_c_m  * 10.982575246
                          + rc_fnamessnmatch_c_m  * 15.172238179
                          + combo_addrscore_flag_m  * 4.8794081841
                          + rc_phoneaddr_lnamecount  * -0.244366466 ;
													
        ver_mod3_nophn_nodob_a := (exp(ver_mod_best_nophn_nodob )) / (1+exp(ver_mod_best_nophn_nodob ));

        ver_mod_notbest_nophn_nodob := -2.133995178
                          + rc_ssncount_c_m  * 5.4611001641
                          + rc_fnamessnmatch_c_m  * -13.64586626
                          + vflag_m  * 11.13474313
                          + nas_ver  * -0.640957086
                          + rc_phoneaddr_lnamecount  * -0.823717162
                          + rc_phoneaddr_addrcount  * 0.7930225277 ;
													
        ver_mod3_nophn_nodob_b := (exp(ver_mod_notbest_nophn_nodob )) / (1+exp(ver_mod_notbest_nophn_nodob ));

				ver_mod3_nophn_nodob := if(add1_isbestmatch, ver_mod3_nophn_nodob_a, ver_mod3_nophn_nodob_b);
				

        fp_mod_nophn_nodob_tmp := -4.363028812
                     + addprob_mod  * 14.179441454
                     + ssnprob_nodob  * 2.2731785863
                     + derog_level2_m  * 12.320909962;
										 
        fp_mod_nophn_nodob := (exp(fp_mod_nophn_nodob_tmp )) / (1+exp(fp_mod_nophn_nodob_tmp ));


        fd_mod13b_nophn_nodob_tmp := -3.308262932
                     + rel_mod  * 6.0971089165
                     + prop_mod  * 3.5202674502
                     + ams_4year  * -0.883067771
                     + cenmod2  * 7.8556060401
                     + velo_adl  * 0.0996849163
                     + velo_ssn  * 0.104700376
                     + velo_addr2  * 0.035057128
                     + velo_addr_c6  * 0.0818020021
                     + addprob_mod2  * 5.0643570725
                     + addinval_m  * -40.47716557
                     + ssnprob_nodob  * 2.1376503499
                     + best_match_level_m  * 4.3734094729
                     + ver_mod3_nophn_nodob  * 5.512545749

          -2.662320034                  /* Weighting Adjustment        8-22-2008 PK */
        ;
        phat4 := (exp(fd_mod13b_nophn_nodob_tmp )) / (1+exp(fd_mod13b_nophn_nodob_tmp ));
        fd_mod13b_nophn_nodob := (INTEGER)(point*(log(phat4/(1-phat4)) - log(odds))/log(2) + base);



   /* NoSSN Specific Code */

     combo_dob_flag_nossn_a := Map(combo_dobscore_c = 0 and  combo_dobcount_c   = 0 => 0,
																		combo_dobscore_c = 0 and  combo_dobcount_c   = 1 => 1,
																		combo_dobscore_c = 0                             => 2,
																		combo_dobscore_c = 1 and  combo_dobcount_c  <= 1 => 2,
																		combo_dobscore_c = 1                             => 3,
																		-9999);

     ver_phone_tree_nossn_a := Map(verphn_p = 1 and verlst_p = 1 and verfst_p = 1 => 3,
																		verphn_p = 1 and verlst_p = 1                  => 2,
																		verphn_p = 1                                   => 1,
																		0);

     source_P_flag_nossn_a := Map(source_P_add = 1 and source_P_lst = 1 and source_P_fst = 1 => 2,
																	   source_P_lst = 1 and source_P_fst = 1 => 1,
																	   0);

     num_pos_sources_NOEQ_add_c_nossn_a := 1 * num_pos_sources_NOEQ_add_c;

     source_EQ_flag_nossn_a := Map(source_EQ_add = 1 and source_EQ_lst = 1 and source_EQ_fst = 1 => 2,
																		  source_EQ_lst = 1 and source_EQ_fst = 1 => 1,
                                      0);

     num_pos_sources_add_c_nossn_a := 1 * num_pos_sources_add_c;


     combo_dob_flag_nossn_b := Map(combo_dobscore_c = 0 and  combo_dobcount_c   = 0 => 10,
																		combo_dobscore_c = 0                             => 11,
																		combo_dobscore_c = 1 and  combo_dobcount_c  <= 2 => 12,
																		combo_dobscore_c = 1                             => 13,
																		-9999);

     ver_phone_tree_nossn_b := Map(verphn_p = 1 and verlst_p = 1 and verfst_p = 1    => 13,
																		verphn_p = 1 and ( verlst_p = 1 or verfst_p = 1 ) => 12,
																		verphn_p = 1                                      => 10,
																		contrary_phone = 1                                => 10,
																		11);

     source_P_flag_nossn_b := Map(source_P_add = 1 and source_P_lst = 1 and source_P_fst = 1 => 12,
																	 source_P_lst = 1 and source_P_fst = 1 => 10,
																	 11);

     num_pos_sources_NOEQ_add_c_nossn_b := 1 * num_pos_sources_NOEQ_add_c + 10;

     source_EQ_flag_nossn_b := Map(source_EQ_add = 1 and source_EQ_lst = 1 and source_EQ_fst = 1 => 12,
																		source_EQ_lst = 1 and source_EQ_fst = 1 => 11,
																		10);

     num_pos_sources_add_c_nossn_b := 1 * num_pos_sources_add_c + 10;



		 combo_dob_flag_nossn := if(add1_isbestmatch, combo_dob_flag_nossn_a, combo_dob_flag_nossn_b);
		 ver_phone_tree_nossn := if(add1_isbestmatch, ver_phone_tree_nossn_a, ver_phone_tree_nossn_b);
		 source_P_flag_nossn :=  if(add1_isbestmatch, source_P_flag_nossn_a, source_P_flag_nossn_b);
		 num_pos_sources_NOEQ_add_c_nossn := if(add1_isbestmatch, num_pos_sources_NOEQ_add_c_nossn_a, num_pos_sources_NOEQ_add_c_nossn_b);
		 source_EQ_flag_nossn := if(add1_isbestmatch, source_EQ_flag_nossn_a, source_EQ_flag_nossn_b);
		 num_pos_sources_add_c_nossn := if(add1_isbestmatch, num_pos_sources_add_c_nossn_a, num_pos_sources_add_c_nossn_b);



     combo_dob_flag_nossn_m := Map(combo_dob_flag_nossn =  0 => 0.0805084746,
																	 combo_dob_flag_nossn =  1 => 0.0369068541,
																	 combo_dob_flag_nossn =  2 => 0.0338927815,
																	 combo_dob_flag_nossn =  3 => 0.0253761039,
																	 combo_dob_flag_nossn = 10 => 0.2436295836,
																	 combo_dob_flag_nossn = 11 => 0.1944922547,
																	 combo_dob_flag_nossn = 12 => 0.1021377672,
																	 combo_dob_flag_nossn = 13 => 0.0899365367,
																	 -9999);


     ver_phone_tree_nossn_m := Map(ver_phone_tree_nossn =  0 => 0.0543197103,
																	 ver_phone_tree_nossn =  1 => 0.0449189985,
																	 ver_phone_tree_nossn =  2 => 0.0251498288,
																	 ver_phone_tree_nossn =  3 => 0.0219029932,
																	 ver_phone_tree_nossn = 10 => 0.2503586801,
																	 ver_phone_tree_nossn = 11 => 0.1695733834,
																	 ver_phone_tree_nossn = 12 => 0.0930232558,
																	 ver_phone_tree_nossn = 13 => 0.0565938405,
																	 -9999);


     source_P_flag_nossn_m := Map(source_P_flag_nossn =  0 => 0.041014611,
																  source_P_flag_nossn =  1 => 0.0322862129,
																  source_P_flag_nossn =  2 => 0.0261767531,
																  source_P_flag_nossn = 10 => 0.1736600306,
																  source_P_flag_nossn = 11 => 0.1341214839,
																  source_P_flag_nossn = 12 => 0.0556607346,
																	-9999);


     num_pos_src_NOEQ_add_c_nossn_m := Map(num_pos_sources_NOEQ_add_c_nossn =  0 => 0.0428911835,
																					 num_pos_sources_NOEQ_add_c_nossn =  1 => 0.0298863095,
																					 num_pos_sources_NOEQ_add_c_nossn =  2 => 0.0255477057,
																					 num_pos_sources_NOEQ_add_c_nossn = 10 => 0.1676179033,
																					 num_pos_sources_NOEQ_add_c_nossn = 11 => 0.071372549,
																					 num_pos_sources_NOEQ_add_c_nossn = 12 => 0.0461346633,
																					 -9999);


     source_EQ_flag_nossn_m := Map(source_EQ_flag_nossn =  0 => 0.0507075472,
																	 source_EQ_flag_nossn =  1 => 0.0351579884,
																	 source_EQ_flag_nossn =  2 => 0.0314310466,
																	 source_EQ_flag_nossn = 10 => 0.2216582064,
																	 source_EQ_flag_nossn = 11 => 0.1693817878,
																	 source_EQ_flag_nossn = 12 => 0.0791459599,
																	 -9999);


     num_pos_sources_add_c_nossn_m := Map(num_pos_sources_add_c_nossn =  0 => 0.0772833724,
																					num_pos_sources_add_c_nossn =  1 => 0.0410322167,
																					num_pos_sources_add_c_nossn =  2 => 0.0287022235,
																					num_pos_sources_add_c_nossn =  3 => 0.0256621278,
																					num_pos_sources_add_c_nossn = 10 => 0.195631752,
																					num_pos_sources_add_c_nossn = 11 => 0.1126760563,
																					num_pos_sources_add_c_nossn = 12 => 0.0651844366,
																					num_pos_sources_add_c_nossn = 13 => 0.0362318841,
																					-9999);



     ver_mod_best_nossn := -5.352053576
                     + source_lien_flag  * 0.5252931547
                     + vaddflag_m  * 5.7948027076
                     + combo_dob_flag_nossn_m  * 18.645561837
                     + ver_phone_tree_nossn_m  * 25.616202257 ;
										 
     ver_mod_nossn_a := (exp(ver_mod_best_nossn )) / (1+exp(ver_mod_best_nossn ));


     ver_mod_notbest_nossn := -5.560172854
                       + (INTEGER)source_L2_flag  * 0.6511762238
                       + rc_phonephonecount  * -0.269927864
                       + rc_phoneaddr_addrcount  * 0.3468944101
                       + combo_dob_flag_nossn_m  * 5.8473472756
                       + ver_phone_tree_nossn_m  * 7.4613823404
                       + source_P_flag_nossn_m  * 6.5066930387
                       + num_pos_sources_add_c_nossn_m  * 5.9817391002 ;
											 
     ver_mod_nossn_b := (exp(ver_mod_notbest_nossn )) / (1+exp(ver_mod_notbest_nossn ));


		 ver_mod_nossn := if(add1_isbestmatch, ver_mod_nossn_a, ver_mod_nossn_b); 
		 
		 

     fd_mod13b_nossn_tmp := -4.584758517
                  + rel_mod  * 6.2893752453
                  + prop_mod  * 3.8288237831
                  + dob_age_code3_m  * 17.527390517
                  + ams_4year  * -0.913447425
                  + fp_mod3  * 5.3160945922
                  + cenmod2  * 7.0895197859
                  + velo_addr2  * 0.0439067827
                  + velo_addr_c6  * 0.0922650096
                  + addinval_m  * -40.92873555
                  + aptflag_m  * -9.784347353
                  + best_match_level_m  * 4.0372767974
                  + ver_phone_tree_m  * 5.8544591816
                  + combo_dob_flag_m  * 4.4790525705
                  + add2_ownership_flag_m  * 11.354988741
                  + ver_mod_nossn  * 3.7332821025

          -2.662320034                  /* Weighting Adjustment        8-22-2008 PK */

     ;
		 
     phat5 := (exp(fd_mod13b_nossn_tmp )) / (1+exp(fd_mod13b_nossn_tmp ));
     fd_mod13b_nossn := (INTEGER)(point*(log(phat5/(1-phat5)) - log(odds))/log(2) + base);


   /* NoSSN-NoDOB Specific Code                               9-18-2008 PK */

     ver_mod_best_nossn_nodob := -6.56208862
                     + source_lien_flag  * 0.5846462245
                     + rc_fnamecount_c_m  * 11.874072025
                     + eq_count_c_m  * 22.044148939
                     + vaddflag_m  * 5.5583891637
                     + ver_phone_tree_nossn_m  * 27.040022136 ;
										 
     ver_mod_nossn_nodob_a := (exp(ver_mod_best_nossn_nodob )) / (1+exp(ver_mod_best_nossn_nodob ));



     ver_mod_notbest_nossn_nodob := -4.843506848
                       + (INTEGER)source_L2_flag  * 0.5813919714
                       + rc_phonephonecount  * -0.277589734
                       + rc_phoneaddr_addrcount  * 0.3659000276
                       + ver_phone_tree_nossn_m  * 7.6679777737
                       + source_p_flag_nossn_m  * 4.9722461216
                       + num_pos_sources_add_c_nossn_m  * 7.8726210193 ;
											 
     ver_mod_nossn_nodob_b := (exp(ver_mod_notbest_nossn_nodob )) / (1+exp(ver_mod_notbest_nossn_nodob ));

		 ver_mod_nossn_nodob := if(add1_isbestmatch, ver_mod_nossn_nodob_a, ver_mod_nossn_nodob_b); 
		 

     fp_mod_nossn_nodob_tmp := -4.978128798
                  + phnprob_tree_m  * 11.565293683
                  + addprob_mod  * 11.715693326
                  + derog_level2_m  * 13.783518279  ;
									
     fp_mod_nossn_nodob := (exp(fp_mod_nossn_nodob_tmp )) / (1+exp(fp_mod_nossn_nodob_tmp ));


     fd_mod13b_nossn_nodob_tmp := -3.697873922
                  + rel_mod  * 6.136747898
                  + prop_mod  * 3.8853803622
                  + ams_4year  * -0.988323911
                  + cenmod2  * 7.4183177966
                  + velo_adl  * 0.1137899569
                  + velo_addr2  * 0.039860833
                  + velo_addr_c6  * 0.0956690109
                  + addinval_m  * -37.5452857
                  + aptflag_m  * -6.926214983
                  + best_match_level_m  * 3.5140564502
                  + ver_phone_tree_m  * 5.1492785428
                  + add2_ownership_flag_m  * 9.7047406983
                  + ver_mod_nossn_nodob  * 4.0922851143
                  + fp_mod_nossn_nodob  * 4.2672689933

          -2.662320034                  /* Weighting Adjustment        8-22-2008 PK */

     ;
     phat6 := (exp(fd_mod13b_nossn_nodob_tmp )) / (1+exp(fd_mod13b_nossn_nodob_tmp ));
     fd_mod13b_nossn_nodob := (INTEGER)(point*(log(phat6/(1-phat6)) - log(odds))/log(2) + base);



   /* NoPhnSSN Specific Code */

     combo_dob_flag_nophnssn_a := Map(combo_dobscore_c = 0 and  combo_dobcount_c = 0 => 0,
																				 combo_dobscore_c = 0 and  combo_dobcount_c   = 1 => 1,
																				 combo_dobscore_c = 0                             => 2,
																				 combo_dobscore_c = 1 and  combo_dobcount_c  <= 1 => 2,
																				 combo_dobscore_c = 1                             => 3,
																				 -9999);

     source_P_flag_nophnssn_a := Map(source_P_add = 1 and source_P_lst = 1 and source_P_fst = 1 => 2,
																				source_P_lst = 1 and source_P_fst = 1 => 1,
																				0);

     num_pos_src_NOEQ_add_c_nophnssn_a := 1 * num_pos_sources_NOEQ_add_c;

     source_EQ_flag_nophnssn_a := Map(source_EQ_add = 1 and source_EQ_lst = 1 and source_EQ_fst = 1 => 2,
																			 source_EQ_lst = 1 and source_EQ_fst = 1 => 1,
																			 0);

     num_pos_src_add_c_nophnssn_a := 1 * num_pos_sources_add_c;


     combo_dob_flag_nophnssn_b := Map(combo_dobscore_c = 0 and  combo_dobcount_c   = 0 => 10,
																				 combo_dobscore_c = 0                             => 11,
																				 combo_dobscore_c = 1 and  combo_dobcount_c  <= 2 => 12,
																				 combo_dobscore_c = 1                             => 13,
																				 -9999);

     source_P_flag_nophnssn_b := Map(source_P_add = 1 and source_P_lst = 1 and source_P_fst = 1 => 12,
																				source_P_lst = 1 and source_P_fst = 1 => 10,
																				11);

     num_pos_src_NOEQ_add_c_nophnssn_b := 1 * num_pos_sources_NOEQ_add_c + 10;

     source_EQ_flag_nophnssn_b := Map(source_EQ_add = 1 and source_EQ_lst = 1 and source_EQ_fst = 1 => 12,
																				 source_EQ_lst = 1 and source_EQ_fst = 1 => 11,
																				 10);

     num_pos_src_add_c_nophnssn_b := 1 * num_pos_sources_add_c + 10;

		 
		 combo_dob_flag_nophnssn := if(add1_isbestmatch, combo_dob_flag_nophnssn_a, combo_dob_flag_nophnssn_b);
		 source_P_flag_nophnssn := if(add1_isbestmatch, source_P_flag_nophnssn_a, source_P_flag_nophnssn_b);
		 source_EQ_flag_nophnssn := if(add1_isbestmatch, source_EQ_flag_nophnssn_a, source_EQ_flag_nophnssn_b);
		 num_pos_src_NOEQ_add_c_nophnssn := if(add1_isbestmatch, num_pos_src_NOEQ_add_c_nophnssn_a, num_pos_src_NOEQ_add_c_nophnssn_b);
		 num_pos_src_add_c_nophnssn := if(add1_isbestmatch, num_pos_src_add_c_nophnssn_a, num_pos_src_add_c_nophnssn_b);
		 
		 
     combo_dob_flag_nophnssn_m := Map(combo_dob_flag_nophnssn =  0 => 0.0829655781,
																		  combo_dob_flag_nophnssn =  1 => 0.0370588235, 
																		  combo_dob_flag_nophnssn =  2 => 0.0339285714,
																		  combo_dob_flag_nophnssn =  3 => 0.0253063214,
																		  combo_dob_flag_nophnssn = 10 => 0.2444168734,
																		  combo_dob_flag_nophnssn = 11 => 0.1936316695,
																		  combo_dob_flag_nophnssn = 12 => 0.1017282011,
																		  combo_dob_flag_nophnssn = 13 => 0.0895630191,
																			-9999);


     source_p_flag_nophnssn_m := Map(source_p_flag_nophnssn =  0 => 0.0413430959,
																		 source_p_flag_nophnssn =  1 => 0.0320167044,
																		 source_p_flag_nophnssn =  2 => 0.0259665042,
																		 source_p_flag_nophnssn = 10 => 0.1726772616,
																		 source_p_flag_nophnssn = 11 => 0.1342770475,
																		 source_p_flag_nophnssn = 12 => 0.0549034457,
																		 -9999);


     n_pos_src_noeq_add_c_nophnssn_m := Map(num_pos_src_noeq_add_c_nophnssn =  0 => 0.043516561,
																					 num_pos_src_noeq_add_c_nophnssn =  1 => 0.0296630442,
																					 num_pos_src_noeq_add_c_nophnssn =  2 => 0.0252070837,
																					 num_pos_src_noeq_add_c_nophnssn = 10 => 0.1669648181,
																					 num_pos_src_noeq_add_c_nophnssn = 11 => 0.0710639969,
																					 num_pos_src_noeq_add_c_nophnssn = 12 => 0.0455396132,
																					 -9999);


     source_eq_flag_nophnssn_m := Map(source_eq_flag_nophnssn =  0 => 0.0501835985,
																		  source_eq_flag_nophnssn =  1 => 0.0356030263,
																		  source_eq_flag_nophnssn =  2 => 0.0314167321,
																		  source_eq_flag_nophnssn = 10 => 0.2194719472,
																		  source_eq_flag_nophnssn = 11 => 0.1687746216,
																		  source_eq_flag_nophnssn = 12 => 0.0786516854,
																			-9999);


     num_pos_src_add_c_nophnssn_m := Map(num_pos_src_add_c_nophnssn =  0 => 0.0790697674,
																				 num_pos_src_add_c_nophnssn =  1 => 0.0415596919,
																				 num_pos_src_add_c_nophnssn =  2 => 0.0284549887,
																				 num_pos_src_add_c_nophnssn =  3 => 0.0253145596,
																				 num_pos_src_add_c_nophnssn = 10 => 0.1944830783,
																				 num_pos_src_add_c_nophnssn = 11 => 0.1122608968,
																				 num_pos_src_add_c_nophnssn = 12 => 0.0647773279,
																				 num_pos_src_add_c_nophnssn = 13 => 0.0355329949,
																				 -9999);


     ver_mod_best_nophnssn := -4.783913239
                     + source_lien_flag  * 0.5691776724
                     + combo_addrscore_flag_m  * 5.7313205674
                     + vaddflag_m  * 5.7439981434
                     + combo_dob_flag_nophnssn_m  * 19.900695396 ;
										 
     ver_mod_nophnssn_a := (exp(ver_mod_best_nophnssn )) / (1+exp(ver_mod_best_nophnssn ));

     ver_mod_notbest_nophnssn := -4.093440283
                       + (INTEGER)source_L2_flag  * 0.6022824496
                       + vflag_m  * 9.2906545221
                       + rc_phoneaddr_lnamecount  * -0.380791011
                       + combo_dob_flag_nophnssn_m  * 6.589031013
                       + num_pos_src_add_c_nophnssn_m  * 4.5285254189 ;
											 
     ver_mod_nophnssn_b := (exp(ver_mod_notbest_nophnssn )) / (1+exp(ver_mod_notbest_nophnssn ));

		 ver_mod_nophnssn := if(add1_isbestmatch, ver_mod_nophnssn_a, ver_mod_nophnssn_b);
		 
		 

     fd_mod13b_NoPhnSSN_tmp := -3.01706852
                  + rel_mod  * 6.883229321
                  + prop_mod  * 3.7861659367
                  + dob_age_code3_m  * 16.186071473
                  + ams_4year  * -0.781575319
                  + cenmod2  * 8.0438167255
                  + velo_addr2  * 0.0544388803
                  + velo_addr_c6  * 0.1036443193
                  + addprob_mod  * 6.8111015388
                  + addinval_m  * -57.78671264
                  + aptflag_m  * -12.80923181
                  + best_match_level_m  * 3.4816749614
                  + add2_ownership_flag_m  * 8.7744310398
                  + ver_mod_nophnssn  * 5.9947816673

          -2.662320034                  /* Weighting Adjustment        8-22-2008 PK */

     ;
     phat7 := (exp(fd_mod13b_NoPhnSSN_tmp )) / (1+exp(fd_mod13b_NoPhnSSN_tmp ));
     fd_mod13b_NoPhnSSN := (INTEGER)(point*(log(phat7/(1-phat7)) - log(odds))/log(2) + base);



   /* NoPhnSSN_NoDob Specific Code */

      ver_mod_best_nophnssn_nodob := -5.822216599
                       + source_lien_flag  * 0.625757842
                       + rc_fnamecount_c_m  * 13.64019179
                       + EQ_count_c_m  * 22.320922072
                       + combo_addrscore_flag_m  * 4.582257735
                       + rc_phoneaddr_lnamecount  * -0.276090351
                       + num_pos_src_add_c_nophnssn_m  * 11.920944631 ;
											 
      ver_mod3_nophnssn_nodob_a := (exp(ver_mod_best_nophnssn_nodob )) / (1+exp(ver_mod_best_nophnssn_nodob ));


      ver_mod_notbest_nophnssn_nodob := -3.547126855
                       + (INTEGER)source_L2_flag  * 0.6174960372
                       + combo_fnamecount_c_m  * 3.9235977944
                       + vflag_m  * 8.7631404284
                       + rc_phoneaddr_lnamecount  * -0.334088102
                       + num_pos_src_add_c_nophnssn_m  * 5.4597220786 ;
											 
     ver_mod3_nophnssn_nodob_b := (exp(ver_mod_notbest_nophnssn_nodob )) / (1+exp(ver_mod_notbest_nophnssn_nodob ));

		 ver_mod3_nophnssn_nodob := if(add1_isbestmatch, ver_mod3_nophnssn_nodob_a, ver_mod3_nophnssn_nodob_b);



     fp_mod_nophnssn_nodob_tmp := -4.480101051
                  + addprob_mod  * 14.200619431
                  + derog_level2_m  * 14.628264547 ;
									
     fp_mod_nophnssn_nodob := (exp(fp_mod_nophnssn_nodob_tmp )) / (1+exp(fp_mod_nophnssn_nodob_tmp ));


     fd_mod13b_NoPhnSSN_NoDob_tmp := -2.854544073
                  + rel_mod  * 6.6784204409
                  + prop_mod  * 3.9385861345
                  + ams_4year  * -0.872708453
                  + cenmod2  * 8.1473437546
                  + velo_adl  * 0.0946586561
                  + velo_addr2  * 0.0465563844
                  + velo_addr_c6  * 0.1078864813
                  + addprob_mod2  * 4.5975314905
                  + addinval_m  * -52.30455067
                  + aptflag_m  * -5.221716363
                  + best_match_level_m  * 4.4093018342
                  + add2_ownership_flag_m  * 9.0397688776
                  + ver_mod3_nophnssn_nodob  * 5.1861507581

          -2.662320034                  /* Weighting Adjustment        8-22-2008 PK */

     ;
     phat8 := (exp(fd_mod13b_NoPhnSSN_NoDob_tmp )) / (1+exp(fd_mod13b_NoPhnSSN_NoDob_tmp ));
     fd_mod13b_NoPhnSSN_NoDob := (INTEGER)(point*(log(phat8/(1-phat8)) - log(odds))/log(2) + base);


     ssnpop := ((integer)ssnlength>0);

     fdef710_a := Map(hphnpop = 0 and (integer)ssnpop = 0 => fd_mod13b_NoPhnSSN,
											 hphnpop = 0                => fd_mod13b_NoPhn,
											 (integer)ssnpop = 0 								=> fd_mod13b_NoSSN,
											 fd_mod13c);

     fdef710_b := Map(hphnpop = 0 and (integer)ssnpop = 0 => fd_mod13b_NoPhnSSN_NoDob,
												hphnpop = 0                	=> fd_mod13b_NoPhn_NoDob,
												(integer)ssnpop = 0 									=> fd_mod13b_NoSSN_NoDob,
												fd_mod13c_NoDob);

		 fdef710 := if(dobpop = 1, fdef710_a, fdef710_b);


/*   FP3710_a := fd_mod13b;                 out on 10-01-2008  PK   */
     FP3710_a := fdef710;            /*      Added 10-01-2008  PK   */

/* End of Code to Handle Missing Phone And/Or SSN and/or DOB     10-01-2008  PK  */
 
// ********************************************************************************************************		 

		/* Overrides */
		usps_deliverable := (integer)(rc_addrvalflag='V');
		
		ssnhighissue_yr := if((INTEGER)rc_ssnhighissue=0, -1, (INTEGER)rc_ssnhighissue[1..4]);
		dob_mismatch := map(
			ssnhighissue_yr = -1 or dob_yr = -1 => 0,
			dob_yr > ssnhighissue_yr and dobpop=1 => dob_yr - ssnhighissue_yr,
			0
		);

		verssn_s := (integer)(nas_summary in [4,6,7,9,10,11,12]);
		hr_phone := (integer)((integer)rc_hriskphoneflag=6);
		phn_corrections := (integer)((integer)rc_hrisksicphone=2225);
		not_deliverable := (integer)(usps_deliverable=0);
		add1_hr_address := (integer)(rc_hriskaddrflag=4);
		corrections := (integer)(rc_hrisksic=2225);
		ssn_valid := (integer)((INTEGER)rc_ssnvalflag in [0,3] or ((integer)rc_ssnvalflag=2 and (integer)ssnlength=4) );
		watchlist_hit := (integer)(rc_watchlist_flag);
		dob_mismatch_flag := (integer)(dob_mismatch > 0);


		cap_ssnver2              := if( nas_ver=0, 765, 999999 );
		cap_ssnver3              := if ( verssn_s = 0, 680, 999999 );
		cap_disc                 := if ( verphn_p = 0 and disconnected = 1, 680, 999999 );
		cap_pnotpot              := if ( verphn_p = 0 and pnotpot      = 1, 765, 999999 );
		cap_phninval             := if ( verphn_p = 0 and (phninval = 1 or phninval2 = 1), 680, 999999 );
		cap_hr_phn               := if ( hr_phone = 1  or hr_phone_flag = 1 or phn_corrections = 1, 680, 999999 );
		cap_busphone             := if ( verphn_p = 0 and busphone_flag = 1, 765, 999999 );
		cap_pzipmis1             := if ( verphn_p = 0 and phone_zip_mismatch = 1, 680, 999999 );
		cap_pzipmis2             := if ( verphn_p = 1 and phone_zip_mismatch = 1, 765, 999999 );
		cap_notdeliverable       := if ( not_deliverable = 1, 765, 999999 );
		cap_city_zip_mismatch    := if ( city_zip_mismatch = 1, 765, 999999 );
		cap_hr_addr              := if ( add1_hr_address = 1 or hirisk_commercial_flag = 1, 765, 999999 );
		cap_corrections          := if ( corrections = 1, 680, 999999 );
		cap_ssnprob              := if ( ssnpop  and (deceased = 1 or ssn_valid = 0 or ssninval_pw = 1 or ssnprior_pi = 1), 610, 999999 );
		cap_velo_ssns_per_adl_c6 := if ( ssns_per_adl_c6 >= 2, 765, 999999 );
		cap_velo_adls_per_addr   := if ( aptflag = 0 and adls_per_addr >= 25, 765, 999999 );
		cap_adlperssn            := if ( adlperssn_count >= 6, 680, 999999 );
		cap_watchlist            := if ( watchlist_hit = 1, 765, 999999 );
		cap_dobmismatch          := if ( dob_mismatch_flag = 1, 610, 999999 );

		
		fp3710_b := fp3710_a;


		FP3710_c := min( FP3710_b,
			cap_ssnver2,
			cap_ssnver3,
			cap_disc,
			cap_pnotpot,
			cap_phninval,
			cap_hr_phn,
			cap_busphone,
			cap_pzipmis1,
			cap_pzipmis2,
			cap_notdeliverable,
			cap_city_zip_mismatch,
			cap_hr_addr,
			cap_corrections,
			cap_ssnprob,
			cap_velo_ssns_per_adl_c6,
			cap_velo_adls_per_addr,
			cap_adlperssn,
			cap_watchlist,
			cap_dobmismatch
		);

		FP3710 := map(
			FP3710_c < 300 => 300,
			FP3710_c > 999 => 999,
			FP3710_c
		);
		
		

/***********************************************************************************************/
/* Tweak to fit  ex95 with override  conditions   - Dan Hamre                                             */
/***********************************************************************************************/

     phone_zip_mismatch_n := if( (integer)rc_phonezipflag = 1, 1, 0);

     disconnected_n := if( (integer)rc_hriskphoneflag = 5, 1, 0);

     hr_phone_n := if( (integer)rc_hriskphoneflag = 6, 1, 0);

     ssninval := if( ssn_valid = 0, 1, 0);
		 
     high_issue_date := if( (integer)rc_ssnhighissue = 0, 0, (integer)rc_ssnhighissue);

     high_issue_dateyr := (integer)(high_issue_date/10000);

     ssnage := sysyear - high_issue_dateyr;

     ssnprior_fa := if(ssnage <= 16, 1, 0);

     pnotpots := if(length(trim(telcordia_type)) > 0 and (integer)telcordia_type in [0, 50, 51, 52, 54], 0, 1);

     hr_address := if((integer)rc_hriskaddrflag = 4, 1, 0);

		 hr_address_n := 1 * hr_address;

     ssndead := deceased;

     standardization_error := if((integer)usps_deliverable = 0 and (integer)add1_isbestmatch = 0, 1, 0);


     fp3710_mod_prod := Map(fp3710 <= 418 => 10,
													  fp3710 <= 448 => 20,
													  fp3710 <= 638 => 30,
													  fp3710 <= 665 => 40,
													  fp3710 <= 717 => 50,
													  fp3710 >  717 => 60,
														-9999);


     fpcount := sum( hr_phone_n, phone_zip_mismatch_n, disconnected_n, standardization_error,
                     ssninval, ssndead, ssnprior_fa, hr_address_n, bankrupt );

     phn_not_ver := if( nap_summary in [0, 1], 1, 0);

     fp3710_mod_proda_tmp := if( nas_summary = 1, min(45,  fp3710_mod_prod + 5), fp3710_mod_prod);
		 
		 
		 fp3710_mod_proda := Map(fp3710_mod_proda_tmp >= 40 and (integer)phn_not_ver=1 and fpcount > 0 and (integer)pnotpots=1 => 32,
														 fp3710_mod_proda_tmp >= 40 and (integer)phn_not_ver=1 and fpcount > 0 and (integer)phone_zip_mismatch_n=1 => 31,
														 fp3710_mod_proda_tmp >= 40 and (integer)phn_not_ver=1 and fpcount > 0 and nas_summary = 1 => 31,
														 fp3710_mod_proda_tmp);


		 fp5812_1_0  := fp3710_mod_proda;

     self.seq   := le.bs.seq;
     self.score := (string)fp5812_1_0;
		

 SELF := [];


	end;

	out := project(results, doModel(LEFT));
	
	Risk_Indicators.Layout_Output into_layout_output(clam le) := TRANSFORM
		self.seq := le.seq;
		self.socllowissue := (string)le.SSN_Verification.Validation.low_issue_date;
		self.soclhighissue := (string)le.SSN_Verification.Validation.high_issue_date;
		self.socsverlevel := le.iid.NAS_summary;
		self.nxx_type := le.phone_verification.telcordia_type;
		self := le.iid;
		self := le.shell_input;
		self := le;
	END;
	iid := project(clam, into_layout_output(left));


	Layout_ModelOut addReasons(Layout_ModelOut le, iid ri) := TRANSFORM
		ritmp := RiskWise.fdReasonCodes(ri, num_reasons, OFAC);
		
		// If no reason codes are triggered and the score being returned is less than 800, return RC 34 - Per Bug 92594.
		reasons := Models.Common.checkFraudPointRC34((UNSIGNED)le.score, ritmp, num_reasons);
		
		self.ri := reasons;
		self := le;
	END;
	final := join(out, iid, left.seq=right.seq, addReasons(left, right));
	
		
	return final;

END;