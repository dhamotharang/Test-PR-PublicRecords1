import easi, ut, address, riskwise, risk_indicators;

CDN_DEBUG := false;

export CDN712_0_0(
	grouped dataset(Risk_Indicators.Layout_BocaShell_BtSt_Out) clam,
	boolean IBICID,
	boolean WantstoSeeBillToShipToDifferenceFlag
) := FUNCTION

//saving time by using the address input rather than re-clean address
	layout_cd2iPlus := RECORD
		RiskWise.Layout_CD2I;
		string3 county := '';
		string7 geo_blk := '';
		string3 county2 := '';
		string7 geo_blk2 := '';
	END;

	layout_ineasi := record
		layout_cd2iPlus cd2i;
		recordof(EASI.Key_Easi_Census) easi;
		recordof(EASI.Key_Easi_Census) easi2;
	END;
	layout_model_in := RECORD
		Risk_Indicators.Layout_BocaShell_BtSt_Out bs;
		layout_ineasi; //census
	END;
	layout_model_in join2recs(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
		SELF.bs := le;
		SELF.easi := ri;	
		self.cd2i.county := le.bill_to_out.shell_input.county;
		self.cd2i.state := le.bill_to_out.shell_input.st;
		self.cd2i.geo_blk := le.bill_to_out.shell_input.geo_blk;
		self.cd2i.seq := le.bill_to_out.shell_input.seq;
		self.cd2i := le;		
		self	:= [];
	END;	

	clam_with_bt_easi := join(clam, Easi.Key_Easi_Census,
				 keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 join2recs(left,right),
				 left outer,
				 ATMOST(keyed(right.geolink=left.bill_to_out.shell_input.st+
								left.bill_to_out.shell_input.county+left.bill_to_out.shell_input.geo_blk),
				 RiskWise.max_atmost),keep(1));		

	layout_model_in joinEm(clam_with_bt_easi le, Easi.Key_Easi_Census ri) := TRANSFORM
		self.easi2 := ri;
		self.cd2i.county2 := le.bs.ship_to_out.shell_input.county;
		self.cd2i.state := le.bs.ship_to_out.shell_input.st;
		self.cd2i.geo_blk2 := le.bs.ship_to_out.shell_input.geo_blk;
		self.cd2i := le;
		self := le;
	END;

	clam_with_easi := join(clam_with_bt_easi, Easi.Key_Easi_Census,
				keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				joinEm(left,right),
				left outer,
				ATMOST(keyed(right.geolink=left.bs.ship_to_out.shell_input.st+
						left.bs.ship_to_out.shell_input.county+left.bs.ship_to_out.shell_input.geo_blk),
				RiskWise.max_atmost),keep(1));

	ineasi := project(clam_with_easi, transform(layout_ineasi,
			self := left, self := []));

#if(CDN_DEBUG)
	layout_debug := record
		Risk_Indicators.Layout_BocaShell_BtSt_Out clam;
		String in_state;
		String in_email_address;
		Boolean ipaddrpop;
		Boolean emailpop;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String rc_dwelltype;
		Integer rc_ziptypeflag;
		String rc_addrvalflag;
		Integer rc_hriskaddrflag;
		Integer rc_hriskphoneflag;
		Integer rc_phonezipflag;
		Integer rc_hrisksic;
		String rc_sources;
		String lname_sources;
		String addr_sources;
		Boolean lname_credit_sourced;
		Boolean lname_tu_sourced;
		Boolean lname_eda_sourced;
		Boolean lname_voter_sourced;
		Integer add1_lres;
		Integer add1_naprop;
		Boolean add1_family_owned;
		Real add1_census_income;
		String add1_census_education;
		Integer property_owned_total;
		Integer property_sold_total;
		Integer property_ambig_total;
		Integer add2_naprop;
		Integer add3_naprop;
		Integer ssns_per_addr_c6;
		String telcordia_type;
		Integer rel_count;
		Integer rel_within25miles_count;
		Integer rel_within100miles_count;
		Integer rel_within500miles_count;
		Integer criminal_count;
		String in_state_s;
		Integer nas_summary_s;
		Integer nap_summary_s;
		String rc_dwelltype_s;
		Integer rc_ziptypeflag_s;
		String rc_addrvalflag_s;
		Integer rc_hriskaddrflag_s;
		Integer rc_phonezipflag_s;
		Integer rc_hrisksic_s;
		String rc_sources_s;
		String lname_sources_s;
		String addr_sources_s;
		Boolean voter_avail_s;
		Boolean lname_credit_sourced_s;
		Boolean lname_tu_sourced_s;
		Boolean fname_voter_sourced_s;
		Boolean lname_voter_sourced_s;
		Integer add1_lres_s;
		Integer add1_naprop_s;
		Boolean add1_voter_sourced_s;
		Boolean add1_family_owned_s;
		Integer add1_assessed_amount_s;
		Integer property_owned_total_s;
		Integer property_sold_total_s;
		Integer property_ambig_total_s;
		Integer add2_naprop_s;
		Integer add3_naprop_s;
		Integer ssns_per_addr_c6_s;
		String telcordia_type_s;
		Integer liens_hist_unrel_ct_s;
		Integer criminal_count_s;
		String C_MED_INC;
		String C_LOW_ED;
		String C_FAMMAR_P;
		String C_ROBBERY;
		String C_SPAN_LANG;
		String C_LOW_ED_s;
		String C_FAMMAR_P_s;
		String C_ROBBERY_s;
		String C_SPAN_LANG_s;
		String C_INCOLLEGE_s;
		String IP_topleveldomain;
		String IP_routingmethod;
		String IP_continent;
		String IP_countrycode;
		String IP_state;
		String IP_region;
		Integer IST_lastscore;
		Integer IST_addrscore;
		Integer IST_efirstscore;
		Integer IST_elastscore;
		Integer dist_addraddr2;
		Integer vs_nas;
		Integer vs_nap;
		Integer vs_verx;
		Integer vss_nas;
		Integer vss_nap;
		Integer vss_verx1;
		Boolean vss_credit_sourced;
		Integer vss_verx;
		Integer vs_verx_combo;
		Integer vss_ver_voter_sourced;
		Integer vsb_lres;
		Integer vss_lres;
		Integer vs_lres;
		Integer vss_ssns_per_addr_c6_att;
		Boolean vsb_addr_apt;
		Boolean vsb_addr_mil;
		Boolean vsb_addr_deliverable;
		Boolean vsb_addr_hr;
		Integer vsb_addr_risk;
		Boolean vss_addr_apt;
		Boolean vss_addr_mil;
		Boolean vss_addr_deliverable;
		Boolean vss_addr_hr;
		Integer vss_addr_risk;
		Integer vs_addr_risk;
		Integer vsb_phn_notpots;
		Integer vsb_phn_fp2;
		Integer vss_phn_notpots;
		Integer vss_phn_fp2;
		Integer vs_phn_fp;
		Integer vsb_naprop;
		Boolean vsb_anyprop;
		Integer vsb_property_tree;
		Integer vss_naprop;
		Boolean vss_anyprop;
		Integer vss_property_tree;
		Integer vs_property_tree;
		Integer vss_add1_assessed_amount_att;
		Integer vss_liens_unrel_flag;
		Integer vsb_C_MED_INCatt;
		Integer vsb_c_low_ed;
		Integer vss_c_low_ed;
		Integer vs_c_low_ed;
		Integer vsb_c_fammar_p;
		Integer vss_c_fammar_p;
		Integer vs_c_fammar_p;
		Integer vsb_c_robbery;
		Integer vss_c_robbery;
		Integer vss_C_ROBBERY_att;
		Integer vsb_c_span_lang;
		Integer vss_c_span_lang;
		Integer vs_c_span_lang;
		Integer vss_C_INCOLLEGE_att;
		Integer vs_ist_lastScore100;
		Integer vs_Dist_addraddr2;
		Integer vs_ip_nonUS;
		Integer vs_ip_domainRisk;
		Integer vs_ip_routingRisk;
		Integer vs_ip_regionDetectRisk;
		String _ip_state;
		String _in_state;
		String _in_state_s;
		Integer vs_IP_stateMatchRisk;
		Integer vs_ip_risk1;
		Integer vs_ip_risk2;
		Integer vs_ip_risk;
		Integer vs_enamematch;
		Integer atpos;
		Integer lenEmail;
		String vs_email_domain;
		Integer vs_email_domain_risk;
		Integer vs_email_risk;
		Integer vb_nas;
		Integer vb_nap;
		Integer vb_verx1;
		Integer vb_verx2;
		Real vb_verx3;
		Real vb_verx;
		Integer vb_lres;
		Integer vb_ssns_per_addr_c6;
		Boolean vb_phn_notpots;
		Boolean vb_phn_disconnected;
		Integer vb_phn_fp;
		Integer vb_prop_Tree1;
		Integer vb_prop_tree;
		Integer vb_rel_dist;
		Real vb_census_income;
		Integer vb_census_education;
		Integer vb_C_FAMMAR_P;
		Integer vb_C_ROBBERY;
		Integer vb_IP_stateMatchRisk;
		Integer vb_ip_risk1;
		Integer vb_ip_risk2;
		Real vb_ip_risk;
		Integer vb_enamematch;
		Integer vb_email_domain_risk;
		Integer vb_email_risk;
		Real vs_verx_combo_l;
		Real vss_ver_voter_sourced_l;
		Real vs_lres_l;
		Real vss_ssns_per_addr_c6_att_l;
		Real vs_addr_risk_l;
		Real vs_phn_fp_l;
		Real vs_property_tree_l;
		Real vss_add1_assessed_amount_att_l;
		Real vsb_C_MED_INCatt_l;
		Real vss_c_low_ed_l;
		Real vs_c_low_ed_l;
		Real vss_c_fammar_p_l;
		Real vs_c_fammar_p_l;
		Real vsb_c_robbery_l;
		Real vss_c_robbery_l;
		Real vs_c_span_lang_l;
		Real vss_C_INCOLLEGE_att_l;
		Real vss_C_ROBBERY_att_l;
		Real vs_Dist_addraddr2_l;
		Real vs_ip_risk_l;
		Real vs_email_risk_l;
		Real vb_verx_l;
		Real vb_lres_l;
		Real vb_ssns_per_addr_c6_l;
		Real vb_phn_fp_l;
		Real vb_prop_tree_l;
		Real vb_rel_dist_l;
		Real vb_C_FAMMAR_P_l;
		Real vb_C_ROBBERY_l;
		Real vb_ip_risk_l;
		Real vb_email_risk_l;
		Boolean addrpop_s;
		Boolean uv_shipto;
		Real logit;
		Real phat;
		Real toRound;
		Integer CBD712;
		Boolean correction;
		Boolean source_tot_DS;
		Boolean source_lname_DS;
		Boolean source_addr_DS;
		Boolean source_tot_DS_s;
		Boolean source_lname_DS_s;
		Boolean source_addr_DS_s;
		Boolean decease;
		Boolean criminal;
		Boolean IP_flag;
		Integer cbd712_cap;
		String cbd712_out;
		models.Layout_ModelOut;
	end;
	Layout_debug doModel( clam le, ineasi ri ) := TRANSFORM
#else
	models.Layout_ModelOut doModel( clam le, ineasi ri ) := TRANSFORM
#end

		// Bt/St
		in_state                 := le.Bill_to_Out.shell_input.in_state;
		in_email_address         := StringLib.StringToUppercase(trim(le.Bill_to_Out.shell_input.email_address));
		ipaddrpop                := le.Bill_to_Out.shell_input.ip_address <> '';
		emailpop                 := le.Bill_to_Out.shell_input.email_address <> '';
		nas_summary              := le.Bill_to_Out.iid.nas_summary;
		nap_summary              := le.Bill_to_Out.iid.nap_summary;
		rc_dwelltype             := trim(le.Bill_to_Out.address_validation.dwelling_type);
		rc_ziptypeflag           := (INTEGER)le.Bill_to_Out.address_validation.zip_type;
		rc_addrvalflag           := le.Bill_to_Out.iid.addrvalflag;
		rc_hriskaddrflag         := (INTEGER)le.Bill_to_Out.iid.hriskaddrflag;
		rc_hriskphoneflag        := (INTEGER)le.Bill_to_Out.iid.hriskphoneflag;
		rc_phonezipflag          := (INTEGER)le.Bill_to_Out.iid.phonezipflag;
		rc_hrisksic              := (INTEGER)le.Bill_to_Out.iid.hrisksic;
		rc_sources               := StringLib.StringToUppercase(trim(le.Bill_to_Out.iid.sources));

		lname_sources            := StringLib.StringToUppercase(trim(le.Bill_to_Out.Source_Verification.lastnamesources));
		addr_sources             := StringLib.StringToUppercase(trim(le.Bill_to_Out.Source_Verification.addrsources));
		lname_credit_sourced     := le.Bill_to_Out.name_verification.lname_credit_sourced;
		lname_tu_sourced         := le.Bill_to_Out.name_verification.lname_tu_sourced;
		lname_eda_sourced        := le.Bill_to_Out.name_verification.lname_eda_sourced;
		lname_voter_sourced      := le.Bill_to_Out.name_verification.lname_voter_sourced;
		add1_lres                := le.Bill_to_Out.lres;
		add1_naprop              := le.Bill_to_Out.address_verification.input_address_information.naprop;
		add1_family_owned        := le.Bill_to_Out.address_verification.input_address_information.family_owned;
		add1_census_income       := (REAL)le.Bill_to_Out.address_verification.input_address_information.census_income;
		add1_census_education    := le.Bill_to_Out.address_verification.input_address_information.census_education;
		property_owned_total     := le.Bill_to_Out.address_verification.owned.property_total;
		property_sold_total      := le.Bill_to_Out.address_verification.sold.property_total;
		property_ambig_total     := le.Bill_to_Out.address_verification.ambiguous.property_total;
		add2_naprop              := le.Bill_to_Out.address_verification.address_history_1.naprop;
		add3_naprop              := le.Bill_to_Out.address_verification.address_history_2.naprop;
		ssns_per_addr_c6         := le.Bill_to_Out.velocity_counters.ssns_per_addr_created_6months;
		telcordia_type           := le.Bill_to_Out.phone_verification.telcordia_type;
		rel_count                := le.Bill_To_Out.relatives.relative_count;
		rel_within25miles_count  := le.Bill_To_Out.relatives.relative_within25miles_count;
		rel_within100miles_count := le.Bill_To_Out.relatives.relative_within100miles_count;
		rel_within500miles_count := le.Bill_To_Out.relatives.relative_within500miles_count;
		criminal_count           := le.Bill_To_Out.bjl.criminal_count;


		in_state_s               := le.Ship_to_Out.shell_input.in_state;
		nas_summary_s            := le.Ship_to_Out.iid.nas_summary;
		nap_summary_s            := le.Ship_to_Out.iid.nap_summary;
		rc_dwelltype_s           := trim(le.Ship_to_Out.address_validation.dwelling_type);
		rc_ziptypeflag_s         := (INTEGER)le.Ship_to_Out.address_validation.zip_type;
		rc_addrvalflag_s         := le.Ship_to_Out.iid.addrvalflag;
		rc_hriskaddrflag_s       := (INTEGER)le.Ship_to_Out.iid.hriskaddrflag;
		rc_phonezipflag_s        := (INTEGER)le.Ship_to_Out.iid.phonezipflag;
		rc_hrisksic_s            := (INTEGER)le.Ship_to_Out.iid.hrisksic;
		rc_sources_s             := StringLib.StringToUppercase(trim(le.Ship_to_Out.iid.sources));
		lname_sources_s          := StringLib.StringToUppercase(trim(le.Ship_to_Out.Source_Verification.lastnamesources));
		addr_sources_s           := StringLib.StringToUppercase(trim(le.Ship_to_Out.Source_Verification.addrsources));
		voter_avail_s            := le.Ship_to_Out.Available_Sources.voter;
		lname_credit_sourced_s   := le.Ship_to_Out.name_verification.lname_credit_sourced;
		lname_tu_sourced_s       := le.Ship_to_Out.name_verification.lname_tu_sourced;
		fname_voter_sourced_s    := le.Ship_to_Out.name_verification.fname_voter_sourced;
		lname_voter_sourced_s    := le.Ship_to_Out.name_verification.lname_voter_sourced;
		add1_lres_s              := le.Ship_to_Out.lres;
		add1_naprop_s            := le.Ship_to_Out.address_verification.input_address_information.naprop;
		add1_voter_sourced_s     := le.Ship_to_Out.address_verification.input_address_information.voter_sourced; //?
		add1_family_owned_s      := le.Ship_to_Out.address_verification.input_address_information.family_owned;
		add1_assessed_amount_s   := le.Ship_to_Out.address_verification.input_address_information.assessed_amount;
		property_owned_total_s   := le.Ship_to_Out.address_verification.owned.property_total;
		property_sold_total_s    := le.Ship_to_Out.address_verification.sold.property_total;
		property_ambig_total_s   := le.Ship_to_Out.address_verification.ambiguous.property_total;
		add2_naprop_s            := le.Ship_to_Out.address_verification.address_history_1.naprop;
		add3_naprop_s            := le.Ship_to_Out.address_verification.address_history_2.naprop;
		ssns_per_addr_c6_s       := le.Ship_to_Out.velocity_counters.ssns_per_addr_created_6months;
		telcordia_type_s         := le.Ship_to_Out.phone_verification.telcordia_type;
		liens_hist_unrel_ct_s    := le.Ship_to_Out.bjl.liens_historical_unreleased_count;
		criminal_count_s         := le.Ship_To_Out.bjl.criminal_count;

		// census data		
		C_MED_INC              := trim(ri.easi.MED_INC);
		C_LOW_ED               := trim(ri.easi.LOW_ED);
		C_FAMMAR_P             := trim(ri.easi.FAMMAR_P);
		C_ROBBERY              := trim(ri.easi.ROBBERY);
		C_SPAN_LANG            := trim(ri.easi.SPAN_LANG);

		C_LOW_ED_s             := trim(ri.easi2.LOW_ED);
		C_FAMMAR_P_s           := trim(ri.easi2.FAMMAR_P);
		C_ROBBERY_s            := trim(ri.easi2.ROBBERY);
		C_SPAN_LANG_s          := trim(ri.easi2.SPAN_LANG);
		C_INCOLLEGE_s          := trim(ri.easi2.INCOLLEGE);

		// ip data
		IP_topleveldomain      := le.ip2o.topleveldomain;
		IP_routingmethod       := le.ip2o.iproutingmethod;
		IP_continent           := le.ip2o.continent;
		IP_countrycode         := le.ip2o.countrycode;
		IP_state               := le.ip2o.state;
		IP_region              := le.ip2o.ipregion;
	
		// comparison score
		IST_lastscore          := (INTEGER)le.eddo.lastscore;
		IST_addrscore          := (INTEGER)le.eddo.addrscore;
		IST_efirstscore        := (INTEGER)le.eddo.efirstscore;
		IST_elastscore         := (INTEGER)le.eddo.elastscore;
		dist_addraddr2         := (INTEGER)le.eddo.distaddraddr2;
		//


		// helpers
		mymax(a,b) := MACRO if( a > b, a, b ) ENDMACRO;
		mymin(a,b) := MACRO if( a < b, a, b ) ENDMACRO;
		integer ceil(real val)  := if((integer)val = val, (integer)val, (integer)(val + 1));
		integer floor(real val) := (integer)val;
		boolean contains( string needle, string haystack ) := StringLib.StringFind(haystack, needle, 1) > 0;
 

		// *************** verification - nap,nas,header sources, rc counts, distance **********************; 
		vs_nas := map(
			nas_summary = 0 => 3,
			nas_summary<= 5 => 2,
			1
		);
		
		vs_nap := map(
			nap_summary <= 3 => 3,
			nap_summary <=10 => 2,
			1
		);

		vs_verx := map(
			vs_nap=1 => 1,
			vs_nap=2 and  lname_credit_sourced => 2,
			vs_nap=2 and ~lname_credit_sourced => 3,
			vs_nap+vs_nas-1
		);
		 
		vss_nas := map(
			nas_summary_s  = 0 => 3,
			nas_summary_s <= 5 => 2,
			1
		);
		
		vss_nap := map(
			nap_summary_s <= 3 => 3,
			nap_summary_s <=10 => 2,
			1
		);
		
		vss_verx1 := map(
			vss_nap = 1 => vss_nap*10,
			vss_nap = 2 => vss_nap*10 + vss_nas,
			vss_nap*10 + vss_nas // ?? this is the same as the above line
		);
			
		vss_credit_sourced := mymax(lname_credit_sourced_s, lname_tu_sourced_s);

		vss_verx := map(
			vss_verx1 = 32 and ~vss_credit_sourced   => 33,
			vss_verx1 = 10 and lname_voter_sourced_s => 5,

			vss_verx1
		);

		vs_verx_combo := map(
			vss_verx = 5 and vs_verx<=1 => 1,
			vss_verx = 5 and vs_verx<=4 => 2,
			vss_verx = 5                => 4,
			vss_verx<=21 and vs_verx<=1 => 2,
			vss_verx<=21 and vs_verx<=3 => 4,
			vss_verx<=21                => 5,
			vss_verx =22 and vs_verx<=1 => 3,
			vss_verx =22 and vs_verx<=3 => 4,
			vss_verx =22                => 5,
			vss_verx =23 and vs_verx<=1 => 3,
			vss_verx =23 and vs_verx<=3 => 4,
			vss_verx =23                => 6,
			vss_verx =31 and vs_verx<=3 => 4,
			vss_verx =31 and vs_verx<=4 => 6,
			vss_verx =31                => 7,
			vss_verx =32 and vs_verx<=2 => 4,
			vss_verx =32 and vs_verx<=3 => 5,
			vss_verx =32 and vs_verx<=4 => 6,
			vss_verx =32                => 7,
			vss_verx =33 and vs_verx<=3 => 6,
			7
		);

		vss_ver_voter_sourced := map(
			voter_avail_s and fname_voter_sourced_s and lname_voter_sourced_s and add1_voter_sourced_s => 1,
			voter_avail_s and (fname_voter_sourced_s or lname_voter_sourced_s or add1_voter_sourced_s) => 2,
			voter_avail_s                                                                              => 3,
			2
		);

		// *************** Verification - addres, add1 isbestmatch, house number match, lres, credit/other sourced, distance a1/a2/a3 ****;

		vsb_lres := map(
			add1_lres <= 0 =>  0,
			add1_lres <= 2 =>  2,
			add1_lres <=10 => 10,
			11
		);

		vss_lres := map(
			add1_lres_s <=  0 =>  0,
			add1_lres_s <=  3 =>  2,
			add1_lres_s <= 10 => 10,
			11
		);
			
		vs_lres := map(
			vss_lres =  0 and vsb_lres <= 0 => 4,
			vss_lres =  0 and vsb_lres <= 2 => 3,
			vss_lres =  0                   => 3,
			vss_lres =  2 and vsb_lres <= 0 => 3,
			vss_lres =  2                   => 2,
			vss_lres = 10                   => 2,
			vss_lres = 11 and vsb_lres <= 2 => 2,
			1
		);


		// *************** Verification - velocity ****************************;   
		vss_ssns_per_addr_c6_att := map(
			ssns_per_addr_c6_s = 0 => 1,
			ssns_per_addr_c6_s = 1 => 2,
			ssns_per_addr_c6_s = 2 => 3,
			4
		);

		 
		 // *************** FP - address: addr type,apartment, high risk, zip type, areacode split, miskey***************;     

		vsb_addr_apt := StringLib.StringToUppercase(rc_dwelltype)='A';
		vsb_addr_mil := (rc_ziptypeflag=3);
		vsb_addr_deliverable := StringLib.StringToUppercase(rc_addrvalflag)='V';
		vsb_addr_hr := (rc_hriskaddrflag=4);

		vsb_addr_risk := map(
			vsb_addr_mil                                                  => 1,
			vsb_addr_deliverable and not vsb_addr_apt and not vsb_addr_hr => 2,
			vsb_addr_deliverable                                          => 3,
			4
		);


		vss_addr_apt := StringLib.StringToUppercase(rc_dwelltype_s)='A';
		vss_addr_mil := (rc_ziptypeflag_s=3);
		vss_addr_deliverable := StringLib.StringToUppercase(rc_addrvalflag_s)='V';
		vss_addr_hr := (rc_hriskaddrflag_s=4);
		
		vss_addr_risk := map(
			vss_addr_mil                                                  => 1,
			vss_addr_deliverable and not vss_addr_apt and not vss_addr_hr => 2,
			vss_addr_deliverable                                          => 3,
			3
		);

		vs_addr_risk := map(
			vss_addr_risk=1                     => 1,
			vsb_addr_risk=1                     => 2,
			vss_addr_risk=2 and vsb_addr_risk=2 => 2,
			vss_addr_risk=2 and vsb_addr_risk=3 => 3,
			vss_addr_risk=2 and vsb_addr_risk=4 => 4,
			vss_addr_risk=3 and vsb_addr_risk=2 => 3,
			vss_addr_risk=3 and vsb_addr_risk=3 => 4,
			5
		);


		// *************** FP - phone: type,pots, zip mismatch, disconnect, high risk, miskey *****************;     

		vsb_phn_notpots := (INTEGER)(telcordia_type not in ['00','50','51','52','54'] );

		vsb_phn_fp2 := map(
			vsb_phn_notpots = 0 and rc_phonezipflag != 1 => 1,
			vsb_phn_notpots = 0 and rc_phonezipflag  = 1 => 3,
			vsb_phn_notpots = 1 and rc_phonezipflag != 1 => 2,
			4
		);

		vss_phn_notpots := (INTEGER)(telcordia_type_s not in ['00','50','51','52','54'] );

		vss_phn_fp2 := map(
			vss_phn_notpots = 0 and rc_phonezipflag_s != 1 => 1,
			vss_phn_notpots = 0 and rc_phonezipflag_s  = 1 => 3,
			vss_phn_notpots = 1 and rc_phonezipflag_s != 1 => 2,
			4
		);

		vs_phn_fp := map(
			vss_phn_fp2 = 1 and vsb_phn_fp2 <= 1 => 1,
			vss_phn_fp2 = 1 and vsb_phn_fp2 <= 3 => 2,
			vss_phn_fp2 = 1                      => 4,
			vss_phn_fp2 = 2 and vsb_phn_fp2 <= 2 => 3,
			vss_phn_fp2 = 2 and vsb_phn_fp2 <= 3 => 4,
			vss_phn_fp2 = 2                      => 5,     
			vss_phn_fp2 = 3 and vsb_phn_fp2 <= 1 => 3,
			vss_phn_fp2 = 3 and vsb_phn_fp2 <= 3 => 4,
			vss_phn_fp2 = 3                      => 5,     
			vss_phn_fp2 = 4 and vsb_phn_fp2 <= 2 => 4,
			5                                   
		);     

		// *************** property ownership ******************;
		vsb_naprop := map(
			4 in [add1_naprop,add2_naprop,add3_naprop] => 2,
			3 in [add1_naprop,add2_naprop,add3_naprop] => 1,
			0
		);

		vsb_anyprop := (property_owned_total>0  or  property_sold_total >0  or  property_ambig_total>0);

		vsb_property_tree := map(
			add1_naprop = 4 or add1_family_owned => 1,
			add1_naprop in [2,3]                 => 3,
			vsb_naprop = 2                       => 2,
			vsb_naprop = 1 or vsb_anyprop        => 3,
			4
		);

		vss_naprop := map(
			4 in [add1_naprop_s,add2_naprop_s,add3_naprop_s] => 2,
			3 in [add1_naprop_s,add2_naprop_s,add3_naprop_s] => 1,
			0
		);
		
		vss_anyprop := (property_owned_total_s>0  or  property_sold_total_s >0  or  property_ambig_total_s>0);

		vss_property_tree := map(
			add1_naprop_s = 4 or add1_family_owned_s => 1,
			add1_naprop_s in [2,3]                   => 3,
			vss_naprop = 2                           => 2,
			vss_naprop = 1 or vss_anyprop            => 3,
			4
		);

	 
	 
		vs_property_tree := map(
			vss_property_tree=1 and vsb_property_tree=1 => 1,
			vss_property_tree=1                         => 2,
			vss_property_tree=2 and vsb_property_tree=1 => 3,
			vss_property_tree=2                         => 4,
			vss_property_tree=3 and vsb_property_tree=1 => 4,
			vss_property_tree=3                         => 5,
			vss_property_tree=4 and vsb_property_tree=1 => 6,
			7
		);




		vss_add1_assessed_amount_att := map(
			add1_assessed_amount_s = 0 => 2,
			add1_assessed_amount_s <= 100000 => 3,
			1
		);


		// *************** Derog - BK, Liens, Crime, Forclosure *************;
		vss_liens_unrel_flag := (INTEGER)(liens_hist_unrel_ct_s>0);


		// *************** census/easi census: age,income,home value, education,marriage,crime,profession ***************;


		vsb_C_MED_INCatt := map(
			(REAL)C_MED_INC < 100 => 3, // this should also cover missing values
			(REAL)C_MED_INC < 161 => 2,
			1
		);

		vsb_c_low_ed := map(
			(REAL)C_low_ed  = -1 => 60,
			(REAL)C_low_ed <= 59 => 59, // this should also cover missing values
			60
		);

		vss_c_low_ed := map(
			(REAL)C_low_ed_s  = -1 => 53,
			(REAL)C_low_ed_s <= 23 => 23, // this should also cover missing values
			(REAL)C_low_ed_s <= 41 => 41,
			(REAL)C_low_ed_s <= 53 => 53,
			(REAL)C_low_ed_s <= 62 => 62,
			63
		);

		vs_c_low_ed := map(
			vss_c_low_ed<62 and vsb_c_low_ed=59 => vss_c_low_ed,
			vss_c_low_ed<62                     => 62,
			vss_c_low_ed
		);


		vsb_c_fammar_p := map(
			(REAL)C_fammar_p<=49 => 49,
			(REAL)C_fammar_p<=60 => 60,
			(REAL)C_fammar_p<=79 => 79,
			80  
		);


		vss_c_fammar_p := map(
			c_fammar_p_s ='' => 83, // missing value
			(REAL)C_fammar_p_s<  0 => 83,
			(REAL)C_fammar_p_s<=49 => 49,
			(REAL)C_fammar_p_s<=59 => 59,
			(REAL)C_fammar_p_s<=64 => 64,
			(REAL)C_fammar_p_s<=71 => 71,
			(REAL)C_fammar_p_s<=83 => 83,
			(REAL)C_fammar_p_s<=88 => 88,
			89  
		);

		vs_c_fammar_p := map(
			vss_c_fammar_p=49                        => 7,
			vss_c_fammar_p=59                        => 6,
			vss_c_fammar_p=64 and vsb_c_fammar_p<=49 => 6,
			vss_c_fammar_p=64                        => 6,
			vss_c_fammar_p=71 and vsb_c_fammar_p<=49 => 6,
			vss_c_fammar_p=71 and vsb_c_fammar_p<=60 => 6,
			vss_c_fammar_p=71                        => 4,
			vss_c_fammar_p=83 and vsb_c_fammar_p<=49 => 6,
			vss_c_fammar_p=83 and vsb_c_fammar_p<=79 => 4,
			vss_c_fammar_p=83                        => 3,
			vss_c_fammar_p=88 and vsb_c_fammar_p<=79 => 3,
			vss_c_fammar_p=88                        => 2,
			vss_c_fammar_p=89 and vsb_c_fammar_p<=60 => 3,
			vss_c_fammar_p=89 and vsb_c_fammar_p<=79 => 2,
			1
		);


		vsb_c_robbery := map(
			C_ROBBERY =''  => 173,
			(REAL)C_robbery<=124 => 124,
			(REAL)C_robbery<=173 => 173,
			174
		);

		vss_c_robbery := map(
			c_robbery_s =''  => 129,
			(REAL)C_robbery_s<= 15 =>  15,
			(REAL)C_robbery_s<=129 => 129,
			(REAL)C_robbery_s<=146 => 146,
			(REAL)C_robbery_s<=166 => 166,
			167 
		);

		vss_C_ROBBERY_att := map(
			c_ROBBERY_s       = ''  => 3,
			(REAL)C_ROBBERY_s < 21  => 1,
			(REAL)C_ROBBERY_s < 41  => 2,
			(REAL)C_ROBBERY_s < 141 => 3,
			(REAL)C_ROBBERY_s < 161 => 4,
			(REAL)C_ROBBERY_s < 181 => 5,
			6
		);


		vsb_c_span_lang := map(
			c_span_lang       = '' => 186, // missing value
			(REAL)c_span_lang<   0 => 186,
			(REAL)C_span_lang<=157 => 157,
			(REAL)C_span_lang<=185 => 185,
			186 
		);

		vss_c_span_lang := map(
			c_span_lang_s       =''  => 151,
			(REAL)C_span_lang_s<=129 => 129,
			(REAL)C_span_lang_s<=151 => 151,
			(REAL)C_span_lang_s<=167 => 167,
			(REAL)C_span_lang_s<=187 => 187,
			188 
		);

		vs_c_span_lang := map(
			vss_c_span_lang=129 and vsb_c_span_lang=186 => 167,
			vss_c_span_lang=151 and vsb_c_span_lang=186 => 167,
			vss_c_span_lang
		);


		vss_C_INCOLLEGE_att := map(
			(REAL)C_INCOLLEGE_S > 40 => 1,
			(REAL)C_INCOLLEGE_S > 20 => 2,
			3
		);

		vs_ist_lastScore100 := (INTEGER)(IST_lastscore=100);

		vs_Dist_addraddr2 := map(
			Dist_addraddr2 =  0 => 2,
			Dist_addraddr2<= 10 => 1,
			Dist_addraddr2<= 50 => 2,
			Dist_addraddr2<=171 => 3,
			Dist_addraddr2<=344 => 4,
			Dist_addraddr2<=642 => 5,
			Dist_addraddr2<=991 => 6,
			7
		);

		// ************** IP ***********************************;

		vs_ip_nonUS := map(
			~ipaddrpop => -1,
			StringLib.StringToUpperCase(IP_Countrycode) != 'US' => 1,
			0
		);

		vs_ip_domainRisk := map(
			~ipaddrpop => -1, 
			StringLib.StringToUppercase(IP_topleveldomain) in ['GOV','MIL'] => 1,
			StringLib.StringToUppercase(IP_topleveldomain) in ['NET','COM','EDU','ORG','US'] => 2,
			3
		);

		vs_ip_routingRisk := map(
			~ipaddrpop => -1,
			IP_routingMethod = '06' => 2,
			1
		);

		vs_ip_regionDetectRisk := map(
			~ipaddrpop => -1,
			StringLib.StringToUppercase(IP_region)='NO REGION' => 2,
			1
		);


		_ip_state   := StringLib.StringToUppercase(ip_state);
		_in_state   := StringLib.StringToUppercase(in_state);
		_in_state_s := StringLib.StringToUppercase(in_state_s);

		vs_IP_stateMatchRisk := map(
			~ipaddrpop                                           => -1,
			vs_ip_nonUS=1                                        =>  6,
			_ip_state='AOL'                                      => -2,
			_in_state  = _in_state_s and _in_state   = _ip_state =>  1,
			_in_state  = _in_state_s and _in_state  != _ip_state =>  3,
			_in_state != _in_state_s and _in_state   = _ip_state =>  2,
			_in_state != _in_state_s and _in_state_s = _ip_state =>  4,
			5
		);

		vs_ip_risk1 := map(
			vs_IP_stateMatchRisk=-1 => -1,
			vs_IP_stateMatchRisk=-2 =>  5,
			vs_ip_domainRisk=1      =>  1,
			vs_IP_stateMatchRisk=1  =>  2,
			vs_IP_stateMatchRisk=2  =>  2,
			vs_IP_stateMatchRisk=3  =>  3,
			vs_IP_stateMatchRisk=4  =>  4,
			vs_IP_stateMatchRisk=5 and vs_ip_domainRisk=2 => 5,
			vs_IP_stateMatchRisk=5 and vs_ip_domainRisk=3 => 6,
			vs_IP_stateMatchRisk=6 and vs_ip_domainRisk=2 => 7,
			8
		);

		vs_ip_risk2 := if( vs_ip_risk1 >= 6 and vs_ip_routingRisk = 2, 9, vs_ip_risk1 );
		vs_ip_risk  := if( vs_ip_risk2  = 9 and vs_ip_regionDetectRisk = 2, 10, vs_ip_risk2 );

		// ************** Email - domain,compare to name score ********************************;
		vs_enamematch := map(
			IST_elastscore = -1 => -1,
			IST_elastscore != 0 or IST_efirstscore != 0 => 1,
			0
		);

		atPos := StringLib.StringFind(in_email_address, '@', 1);
		lenEmail := length(in_email_address);

		vs_email_domain := if(contains('@',in_email_address),
			StringLib.StringToUpperCase(in_email_address[atPos+1..lenEmail]),
			''
		);
		
		vs_email_domain_risk := map(
			vs_email_domain = '' => -1,
			vs_email_domain in ['COMCAST.NET',
								'EARTHLINK.NET',
								'SBCGLOBAL.NET',
								'COX.NET',
								'BELLSOUTH.NET',
								'VERIZON.NET',
								'CHARTER.NET',
								'ADELPHIA.NET',
								'OPTONLINE.NET',
								'JUNO.COM',
								'MINDSPRING.COM',
								'ATT.NET',
								'PRODIGY.NET',
								'WORLDNET.ATT.NET',
								'ALLTEL.NET',
								'AMERITECH.NET',
								'CABLEONE.NET',
								'SWBELL.NET',
								'PACBELL.NET'] => 1,
			contains( '.MIL', vs_email_domain ) => 1,
			contains( '.GOV', vs_email_domain ) => 1,
			contains( '.EDU', vs_email_domain ) => 1,
			vs_email_domain in ['YAHOO.COM','HOTMAIL.COM','AOL.COM','MSN.COM','GMAIL.COM'] => 3,
			2
		);



		vs_email_risk := map(
			vs_enamematch=-1                            => -1,
			vs_enamematch= 1 and vs_email_domain_risk=1 =>  1,
			vs_enamematch= 1 and vs_email_domain_risk=2 =>  2,
			vs_enamematch= 1 and vs_email_domain_risk=3 =>  3,
			vs_enamematch= 0 and vs_email_domain_risk=1 =>  3,
			vs_enamematch= 0 and vs_email_domain_risk=2 =>  4,
			5
		);


		// *************************************************************;
		// *                            billto                         *;     
		// *************************************************************;
		 
		// *************** verification - nap,nas,header sources, rc counts, distance **********************;
		vb_nas := map(
			nas_summary = 0 => 3,
			nas_summary <=5 => 2,
			1
		);
		
		vb_nap := map(
			nap_summary <=3  => 3,
			nap_summary <=10 => 2,
			1
		);

		vb_verx1 := map(
			vb_nap=1 and vb_nas = 1 => 1,
			vb_nap + vb_nas     = 5 => 3,
			vb_nap + vb_nas     = 6 => 4,
			2
		);

		vb_verx2 := map(
			vb_verx1=1 and lname_tu_sourced => 0,
			vb_verx1=2 and lname_tu_sourced => 1,
			vb_verx1
		);

		vb_verx3 := map(
			vb_verx2=1 and lname_eda_sourced => 0.5,
			vb_verx2=2 and lname_eda_sourced => 1,
			vb_verx2
		);

		vb_verx := map(
			vb_verx3=0   and lname_voter_sourced => -1,
			vb_verx3=0.5 and lname_voter_sourced => 0.25,
			vb_verx3=1   and lname_voter_sourced => 0.75,
			vb_verx3
		);


		// *************** Verification - addres, add1 isbestmatch, house number match, lres, credit/other sourced, distance a1/a2/a3 ****;
		vb_lres := map(
			add1_lres<=0 => 7,
			add1_lres<=1 => 6,
			add1_lres<=2 => 5,
			add1_lres<=4 => 4,
			add1_lres<=9 => 3,
			add1_lres<=30 => 2,
			add1_lres<=50 => 1,
			0
		);

		// *************** Verification - velocity ****************************;   

		vb_ssns_per_addr_c6 := if( ssns_per_addr_c6 between 0 and 4, ssns_per_addr_c6, 5 );



		// *************** FP - phone: type,pots, zip mismatch, disconnect, high risk, miskey *****************;     
		vb_phn_notpots := trim(telcordia_type) not in ['00','50','51','52','54'];
		vb_phn_disconnected := (rc_hriskphoneflag = 5);

		vb_phn_fp := map(
			~vb_phn_notpots and rc_phonezipflag != 1 and ~vb_phn_disconnected => 1,
			~vb_phn_notpots and rc_phonezipflag != 1 => 2,
			~vb_phn_notpots and rc_phonezipflag  = 1 => 3,
			 vb_phn_notpots and rc_phonezipflag != 1 => 2,
			4     
		);


		// *************** property ownership ******************;
		vb_prop_Tree1 := map(
			4 in [add1_naprop,add2_naprop,add3_naprop] => 1,
			3 in [add1_naprop,add2_naprop,add3_naprop] => 2,
			3
		);

		vb_prop_tree := map(
			vb_prop_tree1 = 1 and add1_family_owned => 0,
			vb_prop_tree1 = 2 and add1_family_owned => 1,
			vb_prop_tree1
		);


		// *************** Relative - count,property ownership,distance,derog,age,income,home value,education,vechicle   *************;     

		vb_rel_dist := map(
			rel_count = 0                => 9999,
			rel_within25miles_count  > 0 =>   25,
			rel_within100miles_count > 0 =>  100,
			rel_within500miles_count > 0 =>  500,
			501
		);


		// *************** census/easi census: age,income,home value, education,marriage,crime,profession ***************;


		vb_census_income := mymax(1,mymin(100000,add1_census_income));

		vb_census_education := map(
			add1_census_education = '' => 12,
			mymax(11,mymin(14,(integer)add1_census_education))
		);

		vb_C_FAMMAR_P := map(
			(REAL)C_FAMMAR_P <  0  or C_FAMMAR_P        = '' => 80,
			(REAL)C_FAMMAR_P > 35 and (REAL)C_FAMMAR_P <= 50 => 45,
			(REAL)C_FAMMAR_P > 50 and (REAL)C_FAMMAR_P <= 60 => 60,
			mymin(85, mymax(35,ceil(((REAL)C_FAMMAR_P)/5)*5))
		);

	 
	 
		vb_C_ROBBERY := MAP(
			(REAL)C_ROBBERY <    0 => 145,
			C_ROBBERY = ''         => 145, // missing value is a very large negative number
			(REAL)C_ROBBERY <=  25 => 25,
			(REAL)C_ROBBERY <= 145 => 145,
			(REAL)C_ROBBERY <= 180 => 180,
			181
		);

		// ************** IP ***********************************;

		vb_IP_stateMatchRisk := map(
			~ipaddrpop            => -1,
			vs_ip_nonUS = 1       =>  3,
			_ip_state='AOL'       => -2,
			_in_state = _ip_state =>  1,
			2
		);

		vb_ip_risk1 := map(
			vb_IP_stateMatchRisk=-1 => -1,
			vb_IP_stateMatchRisk=-2 => -2,
			vs_ip_domainRisk=1      =>  1,
			vb_IP_stateMatchRisk=1  =>  2,
			vb_IP_stateMatchRisk=2 and vs_ip_domainRisk=2 => 3,
			vb_IP_stateMatchRisk=2 and vs_ip_domainRisk=3 => 4,
			vb_IP_stateMatchRisk=3 and vs_ip_domainRisk=2 => 5,
			6
		);

		vb_ip_risk2 := if(vb_ip_risk1 >= 4 and vs_ip_routingRisk=2, 7, vb_ip_risk1 );
		vb_ip_risk := map(
			vb_ip_risk2 in [5,6] and vs_ip_RegionDetectRisk=2 => 6.5,
			vb_ip_risk2  =    7  and vs_ip_RegionDetectRisk=2 => 8,
			vb_ip_risk2
		);

		// ************** Email - domain,compare to name score ********************************;     

		vb_enamematch := map(
			~emailpop         => -1,
			IST_elastscore>0  =>  1,
			IST_efirstscore>0 =>  2,
			3
		);
		
		vb_email_domain_risk := map(
			~emailpop => -1,
			vs_email_domain in ['COMCAST.NET',
								'EARTHLINK.NET',
								'SBCGLOBAL.NET',
								'COX.NET',
								'BELLSOUTH.NET',
								'VERIZON.NET',
								'CHARTER.NET',
								'ADELPHIA.NET',
								'OPTONLINE.NET',
								'JUNO.COM',
								'MINDSPRING.COM',
								'ATT.NET',
								'PRODIGY.NET',
								'WORLDNET.ATT.NET',
								'ALLTEL.NET',
								'AMERITECH.NET',
								'CABLEONE.NET',
								'SWBELL.NET',
								'PACBELL.NET'] => 1,
			contains( '.MIL', vs_email_domain ) => 1,
			contains( '.GOV', vs_email_domain ) => 1,
			contains( '.EDU', vs_email_domain ) => 1,
			vs_email_domain in ['YAHOO.COM','HOTMAIL.COM','AOL.COM','MSN.COM','GMAIL.COM'] => 3,
			2
		);

		vb_email_risk := map(
			vb_email_domain_risk=-1                     => -1,
			vb_email_domain_risk=1 and vb_enamematch<=2 =>  1,
			vb_email_domain_risk=1                      =>  2,
			vb_email_domain_risk=2 and vb_enamematch<=2 =>  2,
			vb_email_domain_risk=2                      =>  4,
			vb_email_domain_risk=3 and vb_enamematch<=2 =>  3,
			4
		);



		/*** create means ****/

		vs_verx_combo_l := case( vs_verx_combo,
			1 => -3.768922118,
			2 => -2.991556882,
			3 => -2.868529998,
			4 => -2.369862197,
			5 => -1.868073142,
			6 => -1.420558951,
			7 => -0.591437968,
			-1.974219601
		);

		

		vss_ver_voter_sourced_l := case( vss_ver_voter_sourced,
			1 => -3.165150402,
			2 => -2.162767378,
			3 => -1.695460094,
			-1.974219601 
		);

		vs_lres_l := case( vs_lres,
			1 => -3.049273019,
			2 => -2.126188796,
			3 => -1.978767731,
			4 => -1.15914737,
			-1.974219601 
		);


		vss_ssns_per_addr_c6_att_l := case( vss_ssns_per_addr_c6_att,
			1 => -2.232722985,
			2 => -1.71151903,
			3 => -1.554189433,
			4 => -1.03001397,
			-1.974219601 
		);

		vs_addr_risk_l := case( vs_addr_risk,
			1 => -4.127134323,
			2 => -2.14649188,
			3 => -1.924873342,
			4 => -1.647784112,
			5 => -1.042653632,
			-1.974219601 
		);


		vs_phn_fp_l := case( vs_phn_fp,
			1 => -2.760917486,
			2 => -2.124056326,
			3 => -1.724689464,
			4 => -1.227025199,
			5 => -0.456017386,
			-1.974219601 
		);


		vs_property_tree_l := case( vs_property_tree,
			1 => -3.090150768,
			2 => -2.739405288,
			3 => -2.638036386,
			4 => -2.231357574,
			5 => -1.910818822,
			6 => -1.743053188,
			7 => -1.527208225,
			-1.974219601 
		);


		vss_add1_assessed_amount_att_l := case( vss_add1_assessed_amount_att,
			1 => -2.181179794,
			2 => -1.930917358,
			3 => -1.54323133,
			-1.974219601 
		);



		vsb_C_MED_INCatt_l := case( vsb_C_MED_INCatt,
			1 => -2.149075225,
			2 => -2.013393579,
			3 => -1.755130123,
			-1.974219601 
		);


		vss_c_low_ed_l := case( vss_c_low_ed,
			23 => -2.324563989,
			41 => -2.17587805,
			53 => -1.872584133,
			62 => -1.695010008,
			63 => -1.315582977,
			-1.974219601 
		);


		vs_c_low_ed_l := case( vs_c_low_ed,
			23 => -2.364376513,
			41 => -2.219270569,
			53 => -1.961974744,
			62 => -1.646795844,
			63 => -1.315582977,
			-1.974219601 
		);


		vss_c_fammar_p_l := case( vss_c_fammar_p,
			49 => -0.80608759,
			59 => -1.398036175,
			64 => -1.571781188,
			71 => -1.838279479,
			83 => -2.098657749,
			88 => -2.299639573,
			89 => -2.484532876,
			-1.974219601 
		);


		vs_c_fammar_p_l := case( vs_c_fammar_p,
			1 => -2.649986386,
			2 => -2.360390867,
			3 => -2.179781187,
			4 => -1.984258036,
			6 => -1.44566663,
			7 => -0.80608759,
			-1.974219601 
		);


		vsb_c_robbery_l := case( vsb_c_robbery,
			124 => -2.206746063,
			173 => -1.796931252,
			174 => -1.552158201,
			-1.974219601 
		);


		vss_c_robbery_l := case( vss_c_robbery,
			15 => -2.526291853,
			129 => -2.285841922,
			146 => -1.781105609,
			166 => -1.687734444,
			167 => -1.488373633,
			-1.974219601 
		);



		vs_c_span_lang_l := case( vs_c_span_lang,
			129 => -2.311168827,
			151 => -1.956199622,
			167 => -1.645836339,
			187 => -1.511392714,
			188 => -1.164024551,
			-1.974219601 
		);


		vss_C_INCOLLEGE_att_l := case( vss_C_INCOLLEGE_att,
			1 => -2.777043057,
			2 => -2.156273965,
			3 => -1.942597288,
			-1.974219601 
		);


		vss_C_ROBBERY_att_l := case( vss_C_ROBBERY_att,
			1 => -2.525728632,
			2 => -2.273597546,
			3 => -2.205161118,
			4 => -1.845826684,
			5 => -1.564476611,
			6 => -1.345365702,
			-1.974219601 
		);


		vs_Dist_addraddr2_l := case( vs_Dist_addraddr2,
			1 => -2.480636169,
			2 => -2.246396484,
			3 => -2.077877812,
			4 => -1.615419979,
			5 => -1.466999975,
			6 => -1.368559902,
			7 => -1.088642113,
			-1.974219601 
		);


		vs_ip_risk_l := case( vs_ip_risk,
			-1 => -2.01212137,
			1 => -3.008154773,
			2 => -2.721742032,
			3 => -2.123062156,
			4 => -1.508511989,
			5 => -1.40129123,
			6 => -0.908037588,
			7 => -0.632111288,
			8 => 0.2899522217,
			9 => 2.2686835414,
			10 => 3.135494216,
			-1.974219601 
		);

		vs_email_risk_l := case( vs_email_risk,
			-1 => -2.01212137,
			1 => -3.326964296,
			2 => -2.77306936,
			3 => -2.030631011,
			4 => -1.557290764,
			5 => -1.205520276,
			-1.974219601 
		);



		vb_verx_l := case( vb_verx,
			-1  => -4.766438216,
			0   => -4.229101986,
			0.25 => -3.63211838,
			0.5  => -3.398024279,
			0.75 => -3.015595397,
			1   => -2.864026014,
			2   => -2.187126473,
			3   => -1.412040538,
			4   => -0.234268872,
			-2.556421924 
		);


		vb_lres_l := case( vb_lres,
			0 => -4.107316558,
			1 => -3.768128782,
			2 => -3.578820382,
			3 => -3.173355286,
			4 => -2.89620266,
			5 => -2.126559456,
			6 => -1.555464844,
			7 => -1.183344421,
			-2.556421924 
		);

		vb_ssns_per_addr_c6_l := case( vb_ssns_per_addr_c6,
			0 => -2.798432712,
			1 => -2.472386457,
			2 => -2.032500881,
			3 => -1.644829032,
			4 => -1.446112852,
			5 => -0.860201263,
			-2.556421924 
		);

		vb_phn_fp_l := case( vb_phn_fp,
			1 => -3.217153888,
			2 => -2.049300842,
			3 => -1.808431307,
			4 => -1.73460105,
			-2.556421924 
		);
		
		vb_prop_tree_l := case( vb_prop_tree,
			0 => -4.105099467,
			1 => -3.180738372,
			2 => -2.24491503,
			3 => -1.719188771,
			-2.556421924 
		);

		vb_rel_dist_l := case( vb_rel_dist,
			  25 => -3.210331366,
			 100 => -2.447905682,
			 500 => -2.011913474,
			 501 => -1.98551928,
			9999 => -0.893980663,
			-2.556421924 
		);

		vb_C_FAMMAR_P_l := case( vb_C_FAMMAR_P,
			35 => -0.92969739,
			45 => -1.506634284,
			60 => -1.749199849,
			65 => -2.046319209,
			70 => -2.228603207,
			75 => -2.432145184,
			80 => -2.562937455,
			85 => -2.992466056,
			-2.556421924 
		);

		vb_C_ROBBERY_l := case( vb_C_ROBBERY,
			 25 => -3.137290552,
			145 => -2.749143799,
			180 => -2.134831455,
			181 => -1.774725466,
			-2.556421924 
		);

		vb_ip_risk_l := case(vb_ip_risk,
			-2  => -3.112914506,
			-1  => -2.389444702,
			 1  => -3.427514659,
			 2  => -3.229198472,
			 3  => -2.70181316,
			 4  => -2.173196502,
			 5  => -1.437192003,
			 6  => -0.135876058,
			6.5 => 0.5479651713,
			 7  => 2.4350742761,
			 8  => 2.5123056241,
			-2.556421924 
		);

		vb_email_risk_l := case( vb_email_risk,
			-1 => -2.389444702,
			 1  => -3.668596357,
			 2  => -2.984273042,
			 3  => -2.615138105,
			 4  => -2.070384615,
			-2.556421924 
		);


	/////////////

		// uv_shipto := (IST_addrscore != 100);
		addrpop_s := le.ship_to_out.addrpop;
		uv_shipto := (addrpop_s and IST_addrscore !=100);


		logit := map(
			uv_shipto and ipaddrpop and emailpop =>
				12.154101875
				+ vs_verx_combo_l  * 0.5934477687
				+ vss_ver_voter_sourced_l  * 0.3062394116
				+ vs_lres_l  * 0.637498321
				+ vss_ssns_per_addr_c6_att_l  * 0.7429795364
				+ vs_addr_risk_l  * 0.4354325472
				+ vs_phn_fp_l  * 0.4709153668
				+ vss_add1_assessed_amount_att_l  * 0.512802987
				+ vss_c_low_ed_l  * 0.2113735512
				+ vss_c_fammar_p_l  * 0.474676909
				+ vss_c_robbery_l  * 0.4436123115
				+ vss_C_INCOLLEGE_att_l  * 1.2782215397
				+ vs_ist_lastScore100  * -0.67000386
				+ vs_Dist_addraddr2_l  * 0.5876906461
				+ vs_ip_risk_l  * 0.8407781063
				+ vs_email_risk_l  * 0.8491484323,
		 
			uv_shipto and ipaddrpop =>
				11.557837043
				+ vs_verx_combo_l  * 0.5109928018
				+ vss_ver_voter_sourced_l  * 0.3114634263
				+ vs_lres_l  * 0.591661217
				+ vss_ssns_per_addr_c6_att_l  * 0.7111611737
				+ vs_addr_risk_l  * 0.3877380895
				+ vs_phn_fp_l  * 0.475923422
				+ vs_property_tree_l  * 0.1675485019
				+ vss_add1_assessed_amount_att_l  * 0.5480914908
				+ vss_liens_unrel_flag  * 0.2735607595
				+ vsb_C_MED_INCatt_l  * 0.3926624196
				+ vss_c_fammar_p_l  * 0.5405697853
				+ vss_c_robbery_l  * 0.3777405268
				+ vs_c_span_lang_l  * 0.1754373302
				+ vss_C_INCOLLEGE_att_l  * 1.4148467368
				+ vs_ist_lastScore100  * -0.746167738
				+ vs_Dist_addraddr2_l  * 0.6024052674
				+ vs_ip_risk_l  * 0.8568318854,
			
			uv_shipto and emailpop =>
				12.466680481
				+ vs_verx_combo_l  * 0.6534316552
				+ vss_ver_voter_sourced_l  * 0.4854916962
				+ vs_lres_l  * 0.5430421305
				+ vss_ssns_per_addr_c6_att_l  * 0.7878604272
				+ vs_phn_fp_l  * 0.5632409372
				+ vs_property_tree_l  * 0.1673913924
				+ vss_add1_assessed_amount_att_l  * 0.5947545567
				+ vss_liens_unrel_flag  * 0.2888163775
				+ vs_c_low_ed_l  * 0.2174752011
				+ vs_c_fammar_p_l  * 0.5512357051
				+ vs_c_span_lang_l  * 0.2277402194
				+ vss_C_INCOLLEGE_att_l  * 1.5575665846
				+ vss_C_ROBBERY_att_l  * 0.3460640881
				+ vs_ist_lastScore100  * -0.68372916
				+ vs_Dist_addraddr2_l  * 0.9767622524
				+ vs_email_risk_l  * 0.886598884,

			uv_shipto =>
				12.895248518
				+ vs_verx_combo_l  * 0.5579480505
				+ vss_ver_voter_sourced_l  * 0.5798154893
				+ vs_lres_l  * 0.4622118483
				+ vss_ssns_per_addr_c6_att_l  * 0.857560186
				+ vs_phn_fp_l  * 0.7543575124
				+ vs_property_tree_l  * 0.2718561282
				+ vss_add1_assessed_amount_att_l  * 0.7392444822
				+ vss_liens_unrel_flag  * 0.2876247335
				+ vs_c_low_ed_l  * 0.3612414124
				+ vs_c_fammar_p_l  * 0.6482879829
				+ vsb_c_robbery_l  * 0.2183708544
				+ vs_c_span_lang_l  * 0.2885434787
				+ vss_C_INCOLLEGE_att_l  * 1.6937583867
				+ vss_C_ROBBERY_att_l  * 0.4440235636
				+ vs_ist_lastScore100  * -0.464111252
				+ vs_Dist_addraddr2_l  * 0.9899417381,

			~uv_shipto and ipaddrpop and emailpop =>
				5.1268911022
				+ vb_verx_l  * 0.2644692984
				+ vb_lres_l  * 0.5921428
				+ vb_ssns_per_addr_c6_l  * 0.5691578443
				+ vb_phn_fp_l  * 0.4918836268
				+ vb_rel_dist_l  * 0.1609804272
				+ vb_census_income  * -0.000013502
				+ vb_C_ROBBERY_l  * 0.3390766037
				+ vb_ip_risk_l  * 0.7797772799
				+ vb_email_risk_l  * 0.6320518665,

			~uv_shipto and ipaddrpop =>
				3.7331122889
				+ vb_verx_l  * 0.2613312734
				+ vb_lres_l  * 0.5991246789
				+ vb_ssns_per_addr_c6_l  * 0.5849843244
				+ vb_phn_fp_l  * 0.4858581284
				+ vb_rel_dist_l  * 0.1546061484
				+ vb_census_income  * -0.000014247
				+ vb_C_ROBBERY_l  * 0.3834444841
				+ vb_ip_risk_l  * 0.8108731645,

			~uv_shipto and emailpop =>
				6.000861608
				+ vb_verx_l  * 0.3026926316
				+ vb_lres_l  * 0.5881357
				+ vb_ssns_per_addr_c6_l  * 0.5642250571
				+ vb_phn_fp_l  * 0.6901423012
				+ vb_prop_tree_l  * 0.1490879969
				+ vb_rel_dist_l  * 0.2508785454
				+ vb_census_income  * -4.880458E-6
				+ vb_census_education  * -0.105984654
				+ vb_C_FAMMAR_P_l  * 0.2504633278
				+ vb_C_ROBBERY_l  * 0.2109299328
				+ vb_email_risk_l  * 0.8308996585,
			// else
			5.2795544851
			+ vb_verx_l  * 0.3392388372
			+ vb_lres_l  * 0.5480511434
			+ vb_ssns_per_addr_c6_l  * 0.562779097
			+ vb_phn_fp_l  * 0.8311430782
			+ vb_prop_tree_l  * 0.1955468658
			+ vb_rel_dist_l  * 0.2112471603
			+ vb_census_income  * -5.294214E-6
			+ vb_census_education  * -0.159443994
			+ vb_C_FAMMAR_P_l  * 0.2661914229
			+ vb_C_ROBBERY_l  * 0.3355546791
		);
				   
		phat := (exp(logit )) / (1+exp(logit ));
		toRound := -30*(log(phat/(1-phat)) - log(.0476))/log(2) + 660;
		CBD712  := if( toRound-floor(toRound) >= 0.5, ceil(toRound), floor(toRound) );

		/********* overwrites ***********/

		correction := (rc_hrisksic=2225 or rc_hrisksic_s=2225);

		source_tot_DS     := contains( 'DS', rc_sources );
		source_lname_DS   := contains( 'DS', lname_sources);
		source_addr_DS    := contains( 'DS', addr_sources);

		source_tot_DS_s   := contains( 'DS', rc_sources_s );
		source_lname_DS_s := contains( 'DS', lname_sources_s);
		source_addr_DS_s  := contains( 'DS', addr_sources_s);

		decease := source_tot_DS
				or source_lname_DS
				or source_addr_DS
				or source_tot_DS_s
				or source_lname_DS_s
				or source_addr_DS_s;

		criminal := (criminal_count>0 or criminal_count_s>0);

		IP_flag := (INTEGER)IP_continent in [1,2,3,4,7];
			/* 1 Africa        */
			/* 2 Asia          */
			/* 3 Australian    */
			/* 4 Europe        */
			/* 7 South America */
			/* 5 north america */

		cbd712_cap := map(
			CBD712 > 999 => 999,
			CBD712 < 300 => 300,
			CBD712
		);

		cbd712_out := map(
			CBD712_cap > 850 and (correction or decease or criminal or IP_flag ) => '850',
			intformat(CBD712_cap,3,1)
		);

		#if(CDN_DEBUG)
			self.clam := le;
			self.in_state := in_state;
			self.in_email_address := in_email_address;
			self.ipaddrpop := ipaddrpop;
			self.emailpop := emailpop;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_ziptypeflag := rc_ziptypeflag;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_hriskaddrflag := rc_hriskaddrflag;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_phonezipflag := rc_phonezipflag;
			self.rc_hrisksic := rc_hrisksic;
			self.rc_sources := rc_sources;
			self.lname_sources := lname_sources;
			self.addr_sources := addr_sources;
			self.lname_credit_sourced := lname_credit_sourced;
			self.lname_tu_sourced := lname_tu_sourced;
			self.lname_eda_sourced := lname_eda_sourced;
			self.lname_voter_sourced := lname_voter_sourced;
			self.add1_lres := add1_lres;
			self.add1_naprop := add1_naprop;
			self.add1_family_owned := add1_family_owned;
			self.add1_census_income := add1_census_income;
			self.add1_census_education := add1_census_education;
			self.property_owned_total := property_owned_total;
			self.property_sold_total := property_sold_total;
			self.property_ambig_total := property_ambig_total;
			self.add2_naprop := add2_naprop;
			self.add3_naprop := add3_naprop;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.telcordia_type := telcordia_type;
			self.rel_count := rel_count;
			self.rel_within25miles_count := rel_within25miles_count;
			self.rel_within100miles_count := rel_within100miles_count;
			self.rel_within500miles_count := rel_within500miles_count;
			self.criminal_count := criminal_count;
			self.in_state_s := in_state_s;
			self.nas_summary_s := nas_summary_s;
			self.nap_summary_s := nap_summary_s;
			self.rc_dwelltype_s := rc_dwelltype_s;
			self.rc_ziptypeflag_s := rc_ziptypeflag_s;
			self.rc_addrvalflag_s := rc_addrvalflag_s;
			self.rc_hriskaddrflag_s := rc_hriskaddrflag_s;
			self.rc_phonezipflag_s := rc_phonezipflag_s;
			self.rc_hrisksic_s := rc_hrisksic_s;
			self.rc_sources_s := rc_sources_s;
			self.lname_sources_s := lname_sources_s;
			self.addr_sources_s := addr_sources_s;
			self.voter_avail_s := voter_avail_s;
			self.lname_credit_sourced_s := lname_credit_sourced_s;
			self.lname_tu_sourced_s := lname_tu_sourced_s;
			self.fname_voter_sourced_s := fname_voter_sourced_s;
			self.lname_voter_sourced_s := lname_voter_sourced_s;
			self.add1_lres_s := add1_lres_s;
			self.add1_naprop_s := add1_naprop_s;
			self.add1_voter_sourced_s := add1_voter_sourced_s;
			self.add1_family_owned_s := add1_family_owned_s;
			self.add1_assessed_amount_s := add1_assessed_amount_s;
			self.property_owned_total_s := property_owned_total_s;
			self.property_sold_total_s := property_sold_total_s;
			self.property_ambig_total_s := property_ambig_total_s;
			self.add2_naprop_s := add2_naprop_s;
			self.add3_naprop_s := add3_naprop_s;
			self.ssns_per_addr_c6_s := ssns_per_addr_c6_s;
			self.telcordia_type_s := telcordia_type_s;
			self.liens_hist_unrel_ct_s := liens_hist_unrel_ct_s;
			self.criminal_count_s := criminal_count_s;
			self.C_MED_INC := C_MED_INC;
			self.C_LOW_ED := C_LOW_ED;
			self.C_FAMMAR_P := C_FAMMAR_P;
			self.C_ROBBERY := C_ROBBERY;
			self.C_SPAN_LANG := C_SPAN_LANG;
			self.C_LOW_ED_s := C_LOW_ED_s;
			self.C_FAMMAR_P_s := C_FAMMAR_P_s;
			self.C_ROBBERY_s := C_ROBBERY_s;
			self.C_SPAN_LANG_s := C_SPAN_LANG_s;
			self.C_INCOLLEGE_s := C_INCOLLEGE_s;
			self.IP_topleveldomain := IP_topleveldomain;
			self.IP_routingmethod := IP_routingmethod;
			self.IP_continent := IP_continent;
			self.IP_countrycode := IP_countrycode;
			self.IP_state := IP_state;
			self.IP_region := IP_region;
			self.IST_lastscore := IST_lastscore;
			self.IST_addrscore := IST_addrscore;
			self.IST_efirstscore := IST_efirstscore;
			self.IST_elastscore := IST_elastscore;
			self.dist_addraddr2 := dist_addraddr2;
			self.vs_nas := vs_nas;
			self.vs_nap := vs_nap;
			self.vs_verx := vs_verx;
			self.vss_nas := vss_nas;
			self.vss_nap := vss_nap;
			self.vss_verx1 := vss_verx1;
			self.vss_credit_sourced := vss_credit_sourced;
			self.vss_verx := vss_verx;
			self.vs_verx_combo := vs_verx_combo;
			self.vss_ver_voter_sourced := vss_ver_voter_sourced;
			self.vsb_lres := vsb_lres;
			self.vss_lres := vss_lres;
			self.vs_lres := vs_lres;
			self.vss_ssns_per_addr_c6_att := vss_ssns_per_addr_c6_att;
			self.vsb_addr_apt := vsb_addr_apt;
			self.vsb_addr_mil := vsb_addr_mil;
			self.vsb_addr_deliverable := vsb_addr_deliverable;
			self.vsb_addr_hr := vsb_addr_hr;
			self.vsb_addr_risk := vsb_addr_risk;
			self.vss_addr_apt := vss_addr_apt;
			self.vss_addr_mil := vss_addr_mil;
			self.vss_addr_deliverable := vss_addr_deliverable;
			self.vss_addr_hr := vss_addr_hr;
			self.vss_addr_risk := vss_addr_risk;
			self.vs_addr_risk := vs_addr_risk;
			self.vsb_phn_notpots := vsb_phn_notpots;
			self.vsb_phn_fp2 := vsb_phn_fp2;
			self.vss_phn_notpots := vss_phn_notpots;
			self.vss_phn_fp2 := vss_phn_fp2;
			self.vs_phn_fp := vs_phn_fp;
			self.vsb_naprop := vsb_naprop;
			self.vsb_anyprop := vsb_anyprop;
			self.vsb_property_tree := vsb_property_tree;
			self.vss_naprop := vss_naprop;
			self.vss_anyprop := vss_anyprop;
			self.vss_property_tree := vss_property_tree;
			self.vs_property_tree := vs_property_tree;
			self.vss_add1_assessed_amount_att := vss_add1_assessed_amount_att;
			self.vss_liens_unrel_flag := vss_liens_unrel_flag;
			self.vsb_C_MED_INCatt := vsb_C_MED_INCatt;
			self.vsb_c_low_ed := vsb_c_low_ed;
			self.vss_c_low_ed := vss_c_low_ed;
			self.vs_c_low_ed := vs_c_low_ed;
			self.vsb_c_fammar_p := vsb_c_fammar_p;
			self.vss_c_fammar_p := vss_c_fammar_p;
			self.vs_c_fammar_p := vs_c_fammar_p;
			self.vsb_c_robbery := vsb_c_robbery;
			self.vss_c_robbery := vss_c_robbery;
			self.vss_C_ROBBERY_att := vss_C_ROBBERY_att;
			self.vsb_c_span_lang := vsb_c_span_lang;
			self.vss_c_span_lang := vss_c_span_lang;
			self.vs_c_span_lang := vs_c_span_lang;
			self.vss_C_INCOLLEGE_att := vss_C_INCOLLEGE_att;
			self.vs_ist_lastScore100 := vs_ist_lastScore100;
			self.vs_Dist_addraddr2 := vs_Dist_addraddr2;
			self.vs_ip_nonUS := vs_ip_nonUS;
			self.vs_ip_domainRisk := vs_ip_domainRisk;
			self.vs_ip_routingRisk := vs_ip_routingRisk;
			self.vs_ip_regionDetectRisk := vs_ip_regionDetectRisk;
			self._ip_state := _ip_state;
			self._in_state := _in_state;
			self._in_state_s := _in_state_s;
			self.vs_IP_stateMatchRisk := vs_IP_stateMatchRisk;
			self.vs_ip_risk1 := vs_ip_risk1;
			self.vs_ip_risk2 := vs_ip_risk2;
			self.vs_ip_risk := vs_ip_risk;
			self.vs_enamematch := vs_enamematch;
			self.atPos := atPos;
			self.lenEmail := lenEmail;
			self.vs_email_domain := vs_email_domain;
			self.vs_email_domain_risk := vs_email_domain_risk;
			self.vs_email_risk := vs_email_risk;
			self.vb_nas := vb_nas;
			self.vb_nap := vb_nap;
			self.vb_verx1 := vb_verx1;
			self.vb_verx2 := vb_verx2;
			self.vb_verx3 := vb_verx3;
			self.vb_verx := vb_verx;
			self.vb_lres := vb_lres;
			self.vb_ssns_per_addr_c6 := vb_ssns_per_addr_c6;
			self.vb_phn_notpots := vb_phn_notpots;
			self.vb_phn_disconnected := vb_phn_disconnected;
			self.vb_phn_fp := vb_phn_fp;
			self.vb_prop_Tree1 := vb_prop_Tree1;
			self.vb_prop_tree := vb_prop_tree;
			self.vb_rel_dist := vb_rel_dist;
			self.vb_census_income := vb_census_income;
			self.vb_census_education := vb_census_education;
			self.vb_C_FAMMAR_P := vb_C_FAMMAR_P;
			self.vb_C_ROBBERY := vb_C_ROBBERY;
			self.vb_IP_stateMatchRisk := vb_IP_stateMatchRisk;
			self.vb_ip_risk1 := vb_ip_risk1;
			self.vb_ip_risk2 := vb_ip_risk2;
			self.vb_ip_risk := vb_ip_risk;
			self.vb_enamematch := vb_enamematch;
			self.vb_email_domain_risk := vb_email_domain_risk;
			self.vb_email_risk := vb_email_risk;
			self.vs_verx_combo_l := vs_verx_combo_l;
			self.vss_ver_voter_sourced_l := vss_ver_voter_sourced_l;
			self.vs_lres_l := vs_lres_l;
			self.vss_ssns_per_addr_c6_att_l := vss_ssns_per_addr_c6_att_l;
			self.vs_addr_risk_l := vs_addr_risk_l;
			self.vs_phn_fp_l := vs_phn_fp_l;
			self.vs_property_tree_l := vs_property_tree_l;
			self.vss_add1_assessed_amount_att_l := vss_add1_assessed_amount_att_l;
			self.vsb_C_MED_INCatt_l := vsb_C_MED_INCatt_l;
			self.vss_c_low_ed_l := vss_c_low_ed_l;
			self.vs_c_low_ed_l := vs_c_low_ed_l;
			self.vss_c_fammar_p_l := vss_c_fammar_p_l;
			self.vs_c_fammar_p_l := vs_c_fammar_p_l;
			self.vsb_c_robbery_l := vsb_c_robbery_l;
			self.vss_c_robbery_l := vss_c_robbery_l;
			self.vs_c_span_lang_l := vs_c_span_lang_l;
			self.vss_C_INCOLLEGE_att_l := vss_C_INCOLLEGE_att_l;
			self.vss_C_ROBBERY_att_l := vss_C_ROBBERY_att_l;
			self.vs_Dist_addraddr2_l := vs_Dist_addraddr2_l;
			self.vs_ip_risk_l := vs_ip_risk_l;
			self.vs_email_risk_l := vs_email_risk_l;
			self.vb_verx_l := vb_verx_l;
			self.vb_lres_l := vb_lres_l;
			self.vb_ssns_per_addr_c6_l := vb_ssns_per_addr_c6_l;
			self.vb_phn_fp_l := vb_phn_fp_l;
			self.vb_prop_tree_l := vb_prop_tree_l;
			self.vb_rel_dist_l := vb_rel_dist_l;
			self.vb_C_FAMMAR_P_l := vb_C_FAMMAR_P_l;
			self.vb_C_ROBBERY_l := vb_C_ROBBERY_l;
			self.vb_ip_risk_l := vb_ip_risk_l;
			self.vb_email_risk_l := vb_email_risk_l;
			self.addrpop_s := addrpop_s;
			self.uv_shipto := uv_shipto;
			self.logit := logit;
			self.phat := phat;
			self.toRound := toRound;
			self.CBD712 := CBD712;
			self.correction := correction;
			self.source_tot_DS := source_tot_DS;
			self.source_lname_DS := source_lname_DS;
			self.source_addr_DS := source_addr_DS;
			self.source_tot_DS_s := source_tot_DS_s;
			self.source_lname_DS_s := source_lname_DS_s;
			self.source_addr_DS_s := source_addr_DS_s;
			self.decease := decease;
			self.criminal := criminal;
			self.IP_flag := IP_flag;
			self.cbd712_cap := cbd712_cap;
			self.cbd712_out := cbd712_out;
		#else

		#end

		self.score := cbd712_out;
		self.seq := le.bill_to_out.seq;
		self := [];
	end;

	model := join(clam, ineasi, 
		left.bill_to_out.seq=(right.cd2i.seq), 
		doModel(left,right), left outer);


	#if(CDN_DEBUG)
		return model;
	#else
	// need to project billto boca shell results into layout.output
	Risk_Indicators.Layout_Output into_layout_output(clam le) := TRANSFORM
		self.seq := le.Bill_To_Out.seq;
		self.socllowissue := (string)le.Bill_To_Out.SSN_Verification.Validation.low_issue_date;
		self.soclhighissue := (string)le.Bill_To_Out.SSN_Verification.Validation.high_issue_date;
		self.socsverlevel := le.Bill_To_Out.iid.NAS_summary;
		self.nxx_type := le.Bill_To_Out.phone_verification.telcordia_type;
		self := le.Bill_To_Out.iid;
		self := le.Bill_To_Out.shell_input;
		self := le.bill_to_out;
	END;
	iidBT := project(clam, into_layout_output(left));

	RiskWise.Layout_IP2O fill_ip(clam le) := TRANSFORM
		self.countrycode := le.ip2o.countrycode[1..2];
		self := le.ip2o;
	END;
	ipInfo := PROJECT(clam, fill_ip(left));


	Layout_ModelOut addBTReasons(iidBT le, ipInfo rt) := TRANSFORM
		self.seq := le.seq;
		self.ri := RiskWise.cdReasonCodes(le, 6, rt, true, IBICID, WantstoSeeBillToShipToDifferenceFlag);
		self := [];
	END;
	BTReasons := join(iidBT, ipInfo, left.seq = right.seq, addBTReasons(left, right), left outer);

	Layout_ModelOut fillReasons(Layout_ModelOut le, BTreasons rt) := TRANSFORM
		self.ri := rt.ri;
		self := le;
	END;
	BTrecord := JOIN(model, BTReasons, left.seq = right.seq, fillReasons(left,right), left outer);


	// need to project the shipto boca shell results into layout.output
	Risk_Indicators.Layout_Output into_layout_output2(clam le) := TRANSFORM
		self.seq := le.Ship_To_Out.seq;
		self.socllowissue := (string)le.Ship_To_Out.SSN_Verification.Validation.low_issue_date;
		self.soclhighissue := (string)le.Ship_To_Out.SSN_Verification.Validation.high_issue_date;
		self.socsverlevel := le.Ship_To_Out.iid.NAS_summary;
		self.nxx_type := le.Ship_To_Out.phone_verification.telcordia_type;
		self := le.Ship_To_Out.iid;
		self := le.Ship_To_Out.shell_input;
		self := le.ship_to_out;
	END;
	iidST := project(clam, into_layout_output2(left));


	Layout_ModelOut addSTReasons(iidST le, ipInfo rt) := TRANSFORM
		self.seq := le.seq;
		self.ri := RiskWise.cdReasonCodes(le, 6, rt, false, IBICID, false);
		self := [];
	END;
	STReasons := join(iidST, ipInfo, left.seq=((right.seq*2)-1), addSTReasons(left, right), left outer);

	Layout_ModelOut fillReasons2(Layout_ModelOut le, STreasons rt) := TRANSFORM
		self.ri := le.ri + rt.ri;
		self := le;
	END;
	STRecord := JOIN(BTRecord, STReasons, left.seq = right.seq-1, fillReasons2(left,right), left outer);

	RETURN (STRecord);
	#end


END;