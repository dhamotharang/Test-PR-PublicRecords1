import ut, risk_indicators, Business_Risk, Easi, RiskWise, address, LNSmallBusiness, iesp, std;

export RVS811_0_0(
	dataset(Risk_Indicators.Layout_Boca_Shell) clam,
	dataset(business_risk.Layout_Business_Shell) bshell
	) := FUNCTION



	used_census_fields := record
		// string12 geolink;
		string3 ab_av_edu;
		string3 many_cars;
		boolean censusmatch;
		string4 fammar_p;
		string4 high_ed;
		string5 housingcpi;
		string7 med_hval;
		string4 pop_25_34_p;
		string4 pop_55_64_p;
		string3 robbery;
		string3 work_home;
	end;
		
	working_layout := RECORD
		unsigned seq;
		real     score;
		Risk_Indicators.Layout_Boca_Shell   bs;
		business_risk.Layout_Business_Shell br;
		used_census_fields                  easic; // consumer census data
		used_census_fields                  easib; // business census data
	end;
	

	clambiid := join(bshell, clam, left.biid.seq=right.seq,
		transform(working_layout,
			self.seq := left.biid.seq,
			self.bs := right,
			self.br := left,
			self := []
		),
		left outer,
		ATMOST(RiskWise.max_atmost),
		keep(1)
	);

	withCensusc := join(clambiid, Easi.Key_Easi_Census,
		keyed(right.geolink=left.bs.shell_input.st+left.bs.shell_input.county+left.bs.shell_input.geo_blk),
		transform(working_layout,
			self.easic.censusmatch := right.geolink!='',
			self.easic := right,
			self := left
		),
		left outer,
		ATMOST(keyed(right.geolink=left.bs.shell_input.st+left.bs.shell_input.county+left.bs.shell_input.geo_blk),RiskWise.max_atmost),
		keep(1)
	);
	withCensusb := join(withCensusC, Easi.Key_Easi_Census,
		keyed(right.geolink=left.br.biid.st+left.br.biid.county+left.br.biid.geo_blk),
		transform(working_layout,
			self.easib.censusmatch := right.geolink!='',
			self.easib := right,
			self := left
		),
		left outer,
		ATMOST(keyed(right.geolink=left.br.biid.st+left.br.biid.county+left.br.biid.geo_blk),RiskWise.max_atmost),
		keep(1)
	);




	LNSmallBusiness.Layouts.Model_With_Seq doModel( withCensusB le ) := TRANSFORM

		/************************************************************************************
		* Flagship RiskView Small Business Model             Developed by J Jarpe & D Yuan *
		*                                                                       12/04/2008 *
		************************************************************************************

		************************************************************************************
		*   Fields from Business Shell 1.0                                                 *
		************************************************************************************/


		score                    := le.br.biid.score;
		addr_type                := le.br.biid.addr_type;
		CNAMEMATCHFLAG           := le.br.biid.CNAMEMATCHFLAG;
		STATEMATCHFLAG           := le.br.biid.STATEMATCHFLAG;
		VERNOTRECENTFLAG         := le.br.biid.VERNOTRECENTFLAG;
		ADDRSCORE                := le.br.biid.ADDRSCORE;
		phonecmpycount           := le.br.biid.phonecmpycount;
		PHONEADDRCOUNT           := le.br.biid.PHONEADDRCOUNT;
		company_status           := le.br.biid.company_status;
		BESTPHONESCORE           := le.br.biid.BESTPHONESCORE;
		telcordiaphonetype       := le.br.biid.telcordiaphonetype;
		addrvalidflag            := le.br.biid.addrvalidflag;
		feinvalidflag            := le.br.biid.feinvalidflag;
		phonevalidflag           := le.br.biid.phonevalidflag;
		wrongphoneflag           := le.br.biid.wrongphoneflag;
		hriskphoneflag           := le.br.biid.hriskphoneflag;
		phonedisflag             := le.br.biid.phonedisflag;
		BKFEINFLAG               := le.br.biid.BKFEINFLAG;
		bkbdidflag               := le.br.biid.bkbdidflag;
		BANKRUPTCY_COUNT         := le.br.biid.BANKRUPTCY_COUNT;
		recentbktype             := le.br.biid.recentbktype;
		recentbkdate             := le.br.biid.recentbkdate;
		LIENBDIDFLAG             := le.br.biid.LIENBDIDFLAG;
		UNRELEASEDLIENCOUNT      := le.br.biid.UNRELEASEDLIENCOUNT;
		RELEASEDLIENCOUNT        := le.br.biid.RELEASEDLIENCOUNT;
		LIEN_TOTAL               := le.br.biid.LIEN_TOTAL;
		DIST_BUSPHONE_BUSADDR    := le.br.biid.DIST_BUSPHONE_BUSADDR;
		deceasedtin              := le.br.biid.deceasedtin;
		bphonetype               := le.br.biid.bphonetype;
		ar2bi                    := le.br.biid.ar2bi;
		bnap_indicator           := le.br.biid.bnap_indicator;
		bnat_indicator           := le.br.biid.bnat_indicator;
		bnas_indicator           := le.br.biid.bnas_indicator;
		company_name             := le.br.biid.company_name;
		addr1                    := le.br.biid.addr1;
		city                     := le.br.biid.p_city_name;
		state                    := le.br.biid.st;
		zip                      := le.br.biid.z5;
		phone10                  := le.br.biid.phone10;
		cmpycount                := le.br.biid.cmpycount;
		addrcount                := le.br.biid.addrcount;
		wphonecount              := le.br.biid.wphonecount;


		pri1                     := trim(le.br.biid.pri1);
		pri2                     := trim(le.br.biid.pri2);
		pri3                     := trim(le.br.biid.pri3);
		pri4                     := trim(le.br.biid.pri4);
		pri5                     := trim(le.br.biid.pri5);
		pri6                     := trim(le.br.biid.pri6);
		pri7                     := trim(le.br.biid.pri7);
		pri8                     := trim(le.br.biid.pri8);

		dt_vendor_first_reported_min  := le.br.prs.dt_vendor_first_reported_min;
		cnt_b                         := le.br.prs.cnt_b;
		cnt_ia                        := le.br.prs.cnt_ia;
		CNT_ID                        := le.br.prs.CNT_ID;
		cnt_if                        := le.br.prs.cnt_if;
		CURRT1SRC4                    := le.br.prs.CURRT1SRC4;

		history_date	              := if( le.bs.historydate=999999, ((STRING)Std.Date.Today())[1..6], (string6)le.bs.historydate);


		 /************************************************************************************
		 *   Fields from Boca Shell 2.5                                                     *
		 ************************************************************************************/


		in_streetaddress                :=  le.bs.shell_input.in_streetaddress;
		in_zipcode                      :=  le.bs.shell_input.in_zipcode;
		in_city                         :=  le.bs.shell_input.in_city;
		in_state                        :=  le.bs.shell_input.in_state;
		in_phone10                      :=  le.bs.shell_input.phone10;
		in_dob                          :=  le.bs.shell_input.dob;
		nas_summary                     :=  le.bs.iid.nas_summary;
		nap_summary                     :=  le.bs.iid.nap_summary;
		nap_status                      :=  le.bs.iid.nap_status;
		rc_hriskphoneflag               :=  le.bs.iid.hriskphoneflag;
		rc_hphonetypeflag               :=  le.bs.iid.hphonetypeflag;
		rc_pwphonezipflag               :=  le.bs.iid.PWphonezipflag;
		rc_decsflag                     :=  le.bs.ssn_verification.validation.deceased;
		rc_pwssndobflag                 :=  le.bs.iid.PWsocsdobflag;
		rc_pwssnvalflag                 :=  le.bs.iid.pwsocsvalflag;
		rc_areacodesplitflag            :=  le.bs.iid.areacodesplitflag;
		rc_dwelltype                    :=  trim(le.bs.address_validation.dwelling_type);
		rc_sources                      :=  le.bs.iid.sources;
		rc_ssnmiskeyflag                :=  le.bs.iid.socsmiskeyflag;
		rc_cityzipflag                  :=  le.bs.iid.cityzipflag;
		rc_lnamessnmatch2               :=  le.bs.iid.lastssnmatch2;
		PR_count                        :=  le.bs.source_verification.pr_count;
		V_count                         :=  le.bs.source_verification.v_count;
		fname_sources                   :=  StringLib.StringToUppercase(trim(le.bs.Source_Verification.firstnamesources));
		lname_sources                   :=  StringLib.StringToUppercase(trim(le.bs.Source_Verification.lastnamesources));
		addr_sources                    :=  StringLib.StringToUppercase(trim(le.bs.Source_Verification.addrsources));
		add1_lres                       :=  le.bs.lres;
		add1_avm_tax_assessed_valuation :=  le.bs.AVM.Input_Address_Information.avm_tax_assessment_valuation;
		add1_avm_automated_valuation    :=  le.bs.AVM.Input_Address_Information.avm_automated_valuation;
		add1_avm_med_fips               :=  le.bs.AVM.Input_Address_Information.avm_median_fips_level;
		add1_avm_med_geo12              :=  le.bs.AVM.Input_Address_Information.avm_median_geo12_level;
		add1_naprop                     :=  le.bs.address_verification.input_address_information.naprop;
		add1_assessed_amount            :=  le.bs.address_verification.input_address_information.assessed_amount;
		property_owned_total            :=  le.bs.address_verification.owned.property_total;
		property_sold_total             :=  le.bs.address_verification.sold.property_total;
		property_ambig_total            :=  le.bs.address_verification.ambiguous.property_total;
		add2_naprop                     :=  le.bs.address_verification.address_history_1.naprop;
		add3_naprop                     :=  le.bs.address_verification.address_history_2.naprop;
		ssns_per_adl                    :=  le.bs.velocity_counters.ssns_per_adl;
		phones_per_adl                  :=  le.bs.velocity_counters.phones_per_adl;
		adlperssn_count                 :=  le.bs.SSN_Verification.adlPerSSN_count;
		addrs_per_ssn                   :=  le.bs.velocity_counters.addrs_per_ssn;
		ssns_per_addr                   :=  le.bs.velocity_counters.ssns_per_addr;
		adls_per_phone                  :=  le.bs.velocity_counters.adls_per_phone;
		ssns_per_adl_c6                 :=  le.bs.velocity_counters.ssns_per_adl_created_6months;
		ssns_per_addr_c6                :=  le.bs.velocity_counters.ssns_per_addr_created_6months;
		phones_per_addr_c6              :=  le.bs.velocity_counters.phones_per_addr_created_6months;
		adls_per_phone_c6               :=  le.bs.velocity_counters.adls_per_phone_created_6months;
		liens_historical_unreleased_ct  :=  le.bs.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bs.bjl.criminal_count;
		rel_bankrupt_count              :=  le.bs.relatives.relative_bankrupt_count;
		watercraft_count                :=  le.bs.watercraft.watercraft_count;
		wealth_index                    :=  le.bs.wealth_indicator;

		fnamepop                        := (integer)le.bs.input_validation.FirstName;
		lnamepop                        := (integer)le.bs.input_validation.LastName;
		addrpop                         := (integer)le.bs.input_validation.Address;

		reason1                         := le.bs.iid.reason1;
		reason2                         := le.bs.iid.reason2;
		reason3                         := le.bs.iid.reason3;
		reason4                         := le.bs.iid.reason4;
		reason5                         := le.bs.iid.reason5;
		reason6                         := le.bs.iid.reason6;
		

		combo_lnamecount   :=  le.bs.iid.combo_lastcount;
		combo_addrcount    :=  le.bs.iid.combo_addrcount;
		combo_hphonecount  :=  le.bs.iid.combo_hphonecount;
		combo_ssncount     :=  le.bs.iid.combo_ssncount;
		ssnlength          :=  le.bs.input_validation.ssn_length;
		rc_ssndobflag      :=  le.bs.iid.socsdobflag;
		rc_addrvalflag     :=  le.bs.iid.addrvalflag;
		rc_ssnvalflag      :=  le.bs.iid.socsvalflag;
		rc_phonetype       :=  le.bs.iid.phonetype;


		/************************************************************************************
		*   Fields from Business Census File                                               *
		************************************************************************************/
		B_censusmatch                    := le.easib.censusmatch;
		B_MED_HVAL                       := le.easib.MED_HVAL;
		B_FAMMAR_P                       := le.easib.FAMMAR_P;
		B_POP_25_34_P                    := le.easib.POP_25_34_P;
		B_ROBBERY                        := le.easib.ROBBERY;
		B_HOUSINGCPI                     := le.easib.HOUSINGCPI;
		B_AB_AV_EDU                      := le.easib.AB_AV_EDU;
		B_WORK_HOME                      := le.easib.WORK_HOME;
		B_MANY_CARS                      := le.easib.MANY_CARS;



		/************************************************************************************
		*   Fields from Consumer Census File                                               *
		************************************************************************************/
		C_censusmatch                    := le.easic.censusmatch;
		C_FAMMAR_P                       := le.easic.FAMMAR_P;
		C_POP_25_34_P                    := le.easic.POP_25_34_P;
		C_POP_55_64_P                    := le.easic.POP_55_64_P;
		C_HIGH_ED                        := le.easic.HIGH_ED;
		C_ROBBERY                        := le.easic.ROBBERY;
		C_WORK_HOME                      := le.easic.WORK_HOME;

		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);


		/************************* code starts here ******************************************/


		uv_RepPop := (fnamepop=1 and lnamepop=1 and addrpop=1);


		/* change history_date to system date in production !!! */
		_scoring_date := history_date[1..6];

		// ******************************** vermod ********************************;
			 
		joe_PR_count := map( 
			PR_count = 0 => 8,
			PR_count = 1 => 7,
			PR_count = 2 => 6,
			PR_count = 3 => 5,
			PR_count <= 5 => 4,
			PR_count <= 8 => 3,
			PR_count <= 12 => 2,
			1
		);


		_cnt_if := min( 2,
			map(
				cnt_if <=  10  => cnt_if,
				cnt_if <= 100  => roundup(cnt_if/10)*10,
				cnt_if <= 1000 => roundup(cnt_if/100)*100,
				roundup(cnt_if/1000)*1000
			)
		);
		


		cnt_ia_flag := (cnt_ia > 0);
		joe_CNT_ID := if(cnt_id=0, 1, 2);

		joe_CNT_ID_cnt_ia := map(
			~cnt_ia_flag and joe_CNT_ID=1 => 2,
			cnt_ia_flag and joe_CNT_ID=1 => 1,
			3
		);
		 

		 
		cnt_if_id_ia := map( 
			_cnt_if = 0 and joe_CNT_ID_cnt_ia = 1 => 1,
			_cnt_if = 0 and joe_CNT_ID_cnt_ia = 2 => 2,
			_cnt_if = 0 and joe_CNT_ID_cnt_ia = 3 => 4,
			_cnt_if = 1 and joe_CNT_ID_cnt_ia = 1 => 1,
			_cnt_if = 1 and joe_CNT_ID_cnt_ia = 2 => 2,
			_cnt_if = 1 and joe_CNT_ID_cnt_ia = 3 => 5,
			_cnt_if = 2 and joe_CNT_ID_cnt_ia = 1 => 1,
			_cnt_if = 2 and joe_CNT_ID_cnt_ia = 2 => 3,
			5 // no else defined in the SAS, so I'm assuming we should default to 5
		);

		cnt_if_id_ia_m := map( 
			cnt_if_id_ia = 1 => 0.0074981885,
			cnt_if_id_ia = 2 => 0.0137868419,
			cnt_if_id_ia = 3 => 0.0212161562,
			cnt_if_id_ia = 4 => 0.0363468147,
			cnt_if_id_ia = 5 => 0.0433275563,
			0.0135923414
		);

		rc_lnamessnmatch2_m := if( rc_lnamessnmatch2, 0.0116062336, 0.0227775478 );


		contrary_phone := nap_summary in [1];
		verfst_p := nap_summary in [2,3,4,8,9,10,12];
		verlst_p := nap_summary in [2,5,7,8,9,11,12];
		veradd_p := nap_summary in [3,5,6,8,10,11,12];
		verphn_p := nap_summary in [4,6,7,9,10,11,12];


		ver_phone_tree := map( 
			contrary_phone => -1,
			verphn_p and veradd_p and verlst_p and verfst_p => 4,
			verphn_p and veradd_p and verlst_p => 3,
			verphn_p and              verlst_p and verfst_p => 3,
			verphn_p and              verlst_p => 2,
						 veradd_p and verlst_p => 1,
			0
		);

		joe_ver_phone_tree := if( ver_phone_tree <= 0, 0, ver_phone_tree );
		joe_ver_phone_tree_m := map( 
			joe_ver_phone_tree = 0 => 0.0184663701,
			joe_ver_phone_tree = 1 => 0.0153495989,
			joe_ver_phone_tree = 2 => 0.0126741486,
			joe_ver_phone_tree = 3 => 0.0114258208,
			joe_ver_phone_tree = 4 => 0.0105930351,
			0.0135923414
		);


		vend := (string)dt_vendor_first_reported_min;
		
		vend_y := vend[1..4];
		vend_m := intformat( min(12, max(1, (integer)vend[5..6])), 2, 1 );
		vend_d := (integer)vend[7..8];
		vend_days  := ut.DaysSince1900( vend_y, vend_m, '01' ) + vend_d - 1;
		vend_fixed := ut.DateFrom_DaysSince1900( vend_days );


		_dt_vendor_first_reported_min := map(
			(integer)vend_y < 1800 => '',
			length(vend)=6 => vend_y + vend_m + '01',
			length(vend)=8 => vend_fixed,
			''
		);

		_bus_vendor_reported_years := ut.DaysApart(_scoring_date+'01', _dt_vendor_first_reported_min)/365.0;

		_bus_vendor_reported_years_cap := map(
			_dt_vendor_first_reported_min = '' => 1,
			_bus_vendor_reported_years    <  0 => 1,
			_bus_vendor_reported_years    > 50 => 2,
			min( 8, _bus_vendor_reported_years )
		);



		_source_fname_AK := contains_i(fname_sources, 'AK');
		_source_fname_BA := contains_i(fname_sources, 'BA');
		_source_fname_CO := contains_i(fname_sources, 'CO');
		_source_fname_DS := contains_i(fname_sources, 'DS');
		_source_fname_FF := contains_i(fname_sources, 'FF');
		_source_fname_L2 := contains_i(fname_sources, 'L2');
		_source_fname_LI := contains_i(fname_sources, 'LI');
					
		_source_lname_AK := contains_i(lname_sources, 'AK');
		_source_lname_BA := contains_i(lname_sources, 'BA');
		_source_lname_CO := contains_i(lname_sources, 'CO');
		_source_lname_DS := contains_i(lname_sources, 'DS');
		_source_lname_FF := contains_i(lname_sources, 'FF');
		_source_lname_L2 := contains_i(lname_sources, 'L2');
		_source_lname_LI := contains_i(lname_sources, 'LI');
		 
		_source_fnamefcraNeg   := sum(_source_fname_AK,_source_fname_BA,_source_fname_CO,_source_fname_DS,_source_fname_FF,_source_fname_L2,_source_fname_LI);
		_source_lnamefcraNeg   := sum(_source_lname_AK,_source_lname_BA,_source_lname_CO,_source_lname_DS,_source_lname_FF,_source_lname_L2,_source_lname_LI);
		_source_fnamefcraNeg_f := (_source_fnamefcraNeg>0);
		_source_lnamefcraNeg_f := (_source_lnamefcraNeg>0);
		_source_namefcraNeg_f  := max(_source_fnamefcraNeg_f,_source_lnamefcraNeg_f);



		_source_namefcraNeg_f_m := if( _source_namefcraNeg_f, 0.0179161141, 0.0125439385 );


		_source_tot_PL := contains_i(rc_sources, 'PL');     

		_source_tot_PL_l := map( 
			_source_tot_PL = 0 => 0.0000245503,
			_source_tot_PL = 1 => 0.0001514586,
			0.0000222144
		);

		nas_ver := nas_summary >= 10;


		nas_ver_l := map( 
			~nas_ver  => 0.0001935816,
			nas_ver   => 0.0000239641,
			0.0000222144 // this isn't possible. seems a bit pointless to have it in the SAS if we know it'll never be used.
		);

		joe_PHONEADDRCOUNT := if( phoneaddrcount=0, 2, 1 );

		_score_low := (INTEGER)(score<=55);

		_source_lname_W  := contains_i(lname_sources, 'W ');

		_source_lname_W_m := map( 
			_source_lname_W = 0 => 0.0141036193,
			_source_lname_W = 1 => 0.008262067,
			0.0135923414
		);
		 

		joe_statematchflag := if( statematchflag='N', 2, 1 );
		joe_cnamematchflag := if( cnamematchflag='N', 2, 1 );
			 
		joe_state_cname := map( 
			joe_STATEMATCHFLAG = 1 => 1,
			joe_STATEMATCHFLAG = 2 and joe_CNAMEMATCHFLAG = 1 => 3,
			2
		);

		joe_state_cname_l := map( 
			joe_state_cname = 1 => 0.0000330392,
			joe_state_cname = 2 => 0.0000578113,
			joe_state_cname = 3 => 0.0005474888,
			0.0000222144
		);

		 _source_addr_WP := contains_i(addr_sources, 'WP');

		_source_addr_WP_m := map( 
			_source_addr_WP = 0 => 0.0141236599,
			_source_addr_WP = 1 => 0.0085581395,
			0.0135923414
		);

		joe_BESTPHONESCORE := map( 
			BESTPHONESCORE = 100 => 1,
			BESTPHONESCORE = 255 => 2,
			3
		);

		joe_BESTPHONESCORE_l := case(joe_BESTPHONESCORE,
			1 => 0.0000694551,
			2 => 0.0000340019,
			3 => 0.0001538395,
			0.0000222144
		);

		joe_CURRT1SRC4 := if(CURRT1SRC4=0, 2, 1);

		 
		joe_CURRT1SRC4_m := map( 
			joe_CURRT1SRC4 = 1 => 0.0103941752,
			joe_CURRT1SRC4 = 2 => 0.0141637807,
			0.0135923414
		);

		joe_VERNOTRECENTFLAG := if ( VERNOTRECENTFLAG, 1, 2 );

		joe_VERNOTRECENTFLAG_m := map( 
			joe_VERNOTRECENTFLAG = 1 => 0.0125206751,
			joe_VERNOTRECENTFLAG = 2 => 0.0137706723,
			0.0135923414
		);
		
		joe_add1_lres := map( 
			add1_lres  = 0   => 4,
			add1_lres <= 1   => 6,
			add1_lres <= 8   => 5,
			add1_lres <= 31  => 4,
			add1_lres <= 75  => 3,
			add1_lres <= 121 => 2,
			1
		);
		
		
		joe_add1_lres_m := case( joe_add1_lres,
			1 => 0.0094281772,
			2 => 0.0113888404,
			3 => 0.0133405098,
			4 => 0.0141724147,
			5 => 0.0171061233,
			6 => 0.0181291895,
			0.0135923414
		);


		logit1 := -11.51156342
			+ joe_BESTPHONESCORE_l  * 1127.600888
			+ joe_CURRT1SRC4_m  * 37.638609624
			+ joe_PHONEADDRCOUNT  * 0.2153476564
			+ joe_state_cname_l  * 635.33349428
			+ joe_VERNOTRECENTFLAG_m  * 99.913182245
			+ _score_low  * -0.206771949
			+ _bus_vendor_reported_years_cap  * -0.08218905
			+ cnt_if_id_ia_m  * 44.241985406
			+ _source_tot_PL_l  * -4025.70542
			+ _source_lname_W_m  * 51.82072268
			+ _source_addr_WP_m  * 40.165778672
			+ _source_namefcraNeg_f_m  * 59.146906109
			+ nas_ver_l  * 1861.403327
			+ rc_lnamessnmatch2_m  * 39.690814985
			+ joe_PR_count  * 0.1432380896
			+ joe_ver_phone_tree_m  * 41.576824851
			+ joe_add1_lres_m  * 44.763457934
		;
		phat1 := (exp(logit1 )) / (1+exp(logit1 ));
		RepVerMod02 := phat1;

		  
		 // ********************************* fpmod ***************************;

		_bphonetype_bad2 := ( trim(telcordiaphonetype) = '4');
		_bphone_invalid  := ( trim(phonevalidflag) = '2');
		_bphone_wrong    := ( trim(wrongphoneflag) !='2');
		_bphone_highrisk := ( trim(hriskphoneflag) not in ['','0'] );
		_bphone_disc     := phonedisflag;


		_bphone_highrisk2 := map(
			_bphone_highrisk and _bphone_disc     => 2,
			_bphone_highrisk  or _bphonetype_bad2 => 1,
			0
		);

		_bphone_highrisk2_l := map( 
			_bphone_highrisk2 = 0 => -4.764344871,
			_bphone_highrisk2 = 1 => -4.127492284,
			_bphone_highrisk2 = 2 => -3.796079107,
			-4.284524557
		);

		 _company_inactive := ( StringLib.StringToUppercase(trim(company_status)) not in ['A'] );

		_tin_invalid := ( trim(feinvalidflag) = '2');
		_tin_dead    := ( StringLib.StringToUpperCase(trim(deceasedtin)) = 'Y' );

		_tin_prob := map(
			_tin_dead => 2,
			_tin_invalid => 1,
			0
		);


		_tin_prob_l := map( 
			_tin_prob = 0 => -4.530268785,
			_tin_prob = 1 => -4.312957343,
			_tin_prob = 2 => -2.918589379,
			-4.284524557
		);


		_con_add_highrisk := (StringLib.StringToUpperCase(trim(rc_dwelltype)) in ['A']) or rc_cityzipflag='1';

		_phone_highrisk := ( StringLib.StringToUpperCase(trim(nap_status))='D' 
			 or trim(rc_hphonetypeflag) in ['1','3','5','6'] 
			 or (integer)rc_hriskphoneflag in [1,3,4,5,6]
			 or StringLib.StringToUpperCase(trim(rc_areacodesplitflag))='Y');

		_phone_zipmismatch := ( rc_pwphonezipflag not in ['','0'] );

		_ssn_prob := ((integer)rc_pwssndobflag in [1,2]
			or (integer)rc_pwssnvalflag in [1,2,3,4,6]
			or rc_decsflag in [1,2] 
			or rc_ssnmiskeyflag in [1]
		);

		logit2 := 2.9739891546
			+ (integer)_bphone_invalid  * 0.1348491583
			+ (integer)_bphone_wrong  * 0.0725098104
			+ _bphone_highrisk2_l  * 0.9220866524
			+ (integer)_company_inactive  * 0.6208514005
			+ _tin_prob_l  * 0.939432808
			+ (integer)_con_add_highrisk  * 0.335426943
			+ (integer)_phone_highrisk  * 0.2765054649
			+ (integer)_phone_zipmismatch  * 0.1635094895
			+ (integer)_ssn_prob  * 0.2452508568
		;
		phat2 := (exp(logit2)) / (1+exp(logit2));
		RepFpMod03 := phat2;
		  
		  
		 // ***************************** prop mod *****************************;

		joe_property_sold_total := map( 
			property_sold_total >= 3 => 1,
			property_sold_total = 2 => 2,
			property_sold_total = 1 => 3,
			4
		);
		
		joe_V_count := (V_count > 0);
		joe_V_count_m := if( joe_V_count, 0.0117373948, 0.0141586765 );
		joe_watercraft_count := (watercraft_count > 0);
		joe_watercraft_count_l := if( joe_watercraft_count, 0.0001727364, 0.0000242152 );

		wealth_index_m := case( (integer)wealth_index,
			1 => 0.0272577417,
			2 => 0.0187172874,
			3 => 0.0180534968,
			4 => 0.0134147859,
			5 => 0.0075391351,
			6 => 0.0047983366,
			0.0135923414
		);

		joe_add1_assessed_amount := map( 
			add1_assessed_amount = 0 => 3,
			add1_assessed_amount <= 179000 => 4,
			add1_assessed_amount <= 256000 => 3,
			add1_assessed_amount <= 400000 => 2,
			1
		);

		joe_add1_avm_med_geo12 := map( 
			add1_avm_med_geo12 = 0 => 3,
			add1_avm_med_geo12 <= 123000 => 6,
			add1_avm_med_geo12 <= 177307 => 5,
			add1_avm_med_geo12 <= 234826 => 4,
			add1_avm_med_geo12 <= 302000 => 3,
			add1_avm_med_geo12 <= 564401 => 2,
			1
		);

		joe_add1_avm_med_geo12_l := map( 
			joe_add1_avm_med_geo12 = 1 => 0.0001579074,
			joe_add1_avm_med_geo12 = 2 => 0.0000885683,
			joe_add1_avm_med_geo12 = 3 => 0.0000485133,
			joe_add1_avm_med_geo12 = 4 => 0.0001665607,
			joe_add1_avm_med_geo12 = 5 => 0.0001684782,
			joe_add1_avm_med_geo12 = 6 => 0.0001979812,
			0.0000222144
		);

		joe_ad1_avm_tax_assess_val := map( 
			add1_avm_tax_assessed_valuation = 0 => 3,
			add1_avm_tax_assessed_valuation <= 127183 => 4,
			add1_avm_tax_assessed_valuation <= 251716 => 3,
			add1_avm_tax_assessed_valuation <= 443730 => 2,
			1
		);

		joe_ad1_avm_tax_assess_val_m := map( 
			joe_ad1_avm_tax_assess_val = 1 => 0.0070029433,
			joe_ad1_avm_tax_assess_val = 2 => 0.0095656145,
			joe_ad1_avm_tax_assess_val = 3 => 0.0143919656,
			joe_ad1_avm_tax_assess_val = 4 => 0.0229784158,
			0.0135923414
		);

		property_owned_total_x := (property_owned_total > 0);
		property_sold_total_x  := (property_sold_total > 0);
		property_ambig_total_x := (property_ambig_total > 0);

		prop_owner := (4 in [add1_naprop, add2_naprop, add3_naprop])
			or property_owned_total_x
			or property_sold_total_x
			or property_ambig_total_x
		;
		
		add1_naprop_level := map(
			add1_naprop = 4 => 2,
			add1_naprop = 3 or prop_owner => 1,
			0
		);

					   
		add1_naprop_level_m := map( 
			add1_naprop_level = 0 => 0.0228274654,
			add1_naprop_level = 1 => 0.0132110092,
			add1_naprop_level = 2 => 0.0090003399,
			0.0135923414
		);
		
		_add1_avm_med_fips_ratio := map(
			add1_avm_automated_valuation = 0 => 9999,
			add1_avm_med_fips            = 0 => 9999,
			add1_avm_automated_valuation/add1_avm_med_fips
		);

		_add1_avm_med_fips_ratiobel := (_add1_avm_med_fips_ratio != 9999 and _add1_avm_med_fips_ratio<1);
		
		_add1_avm_med_fips_ratiobel_m := if( _add1_avm_med_fips_ratiobel, 0.0155754551, 0.0131779545 );

		logit3 := -8.633386062
			+ joe_property_sold_total  * 0.0726168445
			+ joe_V_count_m  * 79.234183747
			+ joe_watercraft_count_l  * -2498.284302
			+ wealth_index_m  * 32.871303191
			+ joe_add1_assessed_amount  * 0.1610000284
			+ joe_add1_avm_med_geo12_l  * 1788.5040344
			+ joe_ad1_avm_tax_assess_val_m  * 31.131018979
			+ add1_naprop_level_m  * 46.472249178
			+ _add1_avm_med_fips_ratiobel_m  * 59.467425571
		;
		phat3 := (exp(logit3)) / (1+exp(logit3));
		RepPropMod02 := phat3;

		 
		// ********************** velo mod *************************;

		_ssns_per_adl_prob := map(
			ssns_per_adl=1 => 0,
			ssns_per_adl = 0 or ssns_per_adl<=3 => 1,
			2
		);

		_ssns_per_adl_prob_l := map( 
			_ssns_per_adl_prob = 0 => -4.325925545,
			_ssns_per_adl_prob = 1 => -4.22525962,
			_ssns_per_adl_prob = 2 => -3.800848475,
			-4.284524557
		);

		_phones_per_adl_prob := (phones_per_adl=0);     

		_adlperssn_count_prob := (adlperssn_count=0 or adlperssn_count>3);     

		_addrs_per_ssn_prob := (addrs_per_ssn>20);     

		_ssns_per_addr_prob := map( 
			ssns_per_addr between 1 and 6 => 0,
			ssns_per_addr between 7 and 12 => 1,
			ssns_per_addr=0 or ssns_per_addr<=20 => 2,
			3
		);

		_ssns_per_addr_prob_l := map( 
			_ssns_per_addr_prob = 0 => -4.669229204,
			_ssns_per_addr_prob = 1 => -4.224202136,
			_ssns_per_addr_prob = 2 => -4.020625942,
			_ssns_per_addr_prob = 3 => -3.835019504,
			-4.284524557
		);

		_adls_per_phone_prob := (adls_per_phone=0);

		_ssns_per_adl_c6_prob := (ssns_per_adl_c6>1);
		
		_ssns_per_addr_c6_prob := map(
			ssns_per_addr_c6 = 0 => 0,
			ssns_per_addr_c6 = 1 => 1,
			2
		);
			
		_ssns_per_addr_c6_prob_l := case( _ssns_per_addr_c6_prob,
			0 => -4.466982734,
			1 => -4.023274108,
			2 => -3.728181151,
			-4.284524557
		);     

		_phones_per_addr_c6_prob := case(phones_per_addr_c6,
			0 => 0,
			1 => 1,
			2
		);
			
		_phones_per_addr_c6_prob_l := case( _phones_per_addr_c6_prob,
			0 => -4.351799451,
			1 => -4.096776672,
			2 => -3.877260995,
		   -4.284524557
		);     

		_adls_per_phone_c6_prob := (adls_per_phone_c6>0);     
		 
		logit4 := 8.0938234501
			+ _ssns_per_adl_prob_l  * 0.6853039757
			+ (integer)_phones_per_adl_prob  * 0.260823405
			+ (integer)_adlperssn_count_prob  * 0.1101957832
			+ (integer)_addrs_per_ssn_prob  * 0.2059509166
			+ _ssns_per_addr_prob_l  * 0.7978083776
			+ (integer)_adls_per_phone_prob  * 0.1546048499
			+ (integer)_ssns_per_adl_c6_prob  * 0.4021291441
			+ _ssns_per_addr_c6_prob_l  * 0.8089204296
			+ _phones_per_addr_c6_prob_l  * 0.6520974664
			+ (integer)_adls_per_phone_c6_prob  * 0.11271371
		;     
		phat4 := (exp(logit4)) / (1+exp(logit4));
		RepVelocityMod03 := phat4;
			   

		// ********************** census mod ************************;

		_B_MED_HVAL_i := map( 
			(real)B_MED_HVAL <= 63429 => 7,
			(real)B_MED_HVAL <= 81321 => 6,
			(real)B_MED_HVAL <=113649 => 5,
			(real)B_MED_HVAL <=152665 => 4,
			(real)B_MED_HVAL <=177817 => 3,
			(real)B_MED_HVAL <=217857 => 2,
			(real)B_MED_HVAL <=291626 => 1,
			0
		);

	 
		_B_MED_HVAL_i_l1 := case( _B_MED_HVAL_i,
			0 => -4.737420971,
			1 => -4.628912652,
			2 => -4.440253714,
			3 => -4.376737123,
			4 => -4.315699094,
			5 => -4.185928378,
			6 => -4.032427011,
			7 => -3.923801417,
			-4.285240189
		);
		
		_C_FAMMAR_P := if( C_FAMMAR_P='-1', 100, (real)C_FAMMAR_P );
		_C_POP_25_34_P := if( C_POP_25_34_P = '-1', 9.5, min(13,(real)C_POP_25_34_P) );

		_C_POP_55_64_P := if( C_POP_55_64_P = '-1', 15, min(20,(real)C_POP_55_64_P) );
		_C_HIGH_ED2 := if( C_HIGH_ED = '-1', 55, max(1,(real)C_HIGH_ED) );

		_C_ROBBERY_i2 := map( 
			(real)C_ROBBERY <=  15 => 0,
			(real)C_ROBBERY <=  32 => 1,
			(real)C_ROBBERY <=  88 => 2,
			(real)C_ROBBERY <= 131 => 3,
			(real)C_ROBBERY <= 170 => 4,
			5
		);

		_C_ROBBERY_i2_l := case( _C_ROBBERY_i2,
			0 => -4.559590285,
			1 => -4.392640133,
			2 => -4.371597176,
			3 => -4.302551167,
			4 => -4.14472867,
			5 => -3.937016313,
			-4.285240189
		);

		 
		logit5 := 1.8399639124
			+ _B_MED_HVAL_i_l1  * 0.413149554
			+ _C_FAMMAR_P  * -0.007519963
			+ _C_POP_25_34_P  * 0.0523710986
			+ _C_POP_55_64_P  * -0.011367658
			+ _C_HIGH_ED2  * -0.005756726
			+ _C_ROBBERY_i2_l  * 0.6635315081
			+ (real)B_HOUSINGCPI  * -0.005787228
			+ (real)B_MANY_CARS  * -0.000890271
			+ (real)C_WORK_HOME  * -0.000650309
		;     
		phat5 := (exp(logit5)) / (1+exp(logit5));
		RepCenMod05 := if(c_censusmatch and b_censusmatch, phat5, 0.014);


		 // **************** final mod ***********************;


		_in_dob := map(
			(integer)in_dob[1..4] < 1800 => -1,
			length((string)(integer)in_dob)=8 => (unsigned4)in_dob,
			-1
		);

		in_dob_y := in_dob[1..4];
		in_dob_m := intformat( min(12, max(1, (integer)in_dob[5..6])), 2, 1 );
		in_dob_d := (integer)in_dob[7..8];
		in_dob_days := ut.DaysSince1900( in_dob_y, in_dob_m, '01' ) + in_dob_d - 1;
		in_dob_fixed := ut.DateFrom_DaysSince1900( in_dob_days );
		
		_in_age := if(_in_dob=-1, -1, ut.DaysApart( _scoring_date+'01', (string8)in_dob_fixed)/365);
		_in_age_cap := if( _in_age=-1, 18, max(18,min(65,_in_age)));

		_bus_bankrupt := (
			bkfeinflag
			or bkbdidflag
			or bankruptcy_count>0
			or cnt_b>0
			// !!
			or trim(recentbktype)!=''
			or trim(recentbkdate)!=''
		);

		_rep_rel_bk := (rel_bankrupt_count>0) ;

		_source_tot_L2 := contains_i(rc_sources,'L2'); 
		_source_tot_LI := contains_i(rc_sources,'LI'); 

		_rep_lien := (liens_historical_unreleased_ct>0
			or _source_tot_L2=1
			or _source_tot_LI=1);
		 
		_source_tot_FR := contains_i(rc_sources,'FR'); 
		 
		_rep_crime := ( criminal_count>0 );

		joe_DIST_BUSPHONE_BUSADDR := if( DIST_BUSPHONE_BUSADDR = 9999, 2, 1 );

				   
		logit6 := -6.915795031
			+ RepVerMod02  * 18.827233625
			+ RepFpMod03  * 30.136116676
			+ RepPropMod02  * 33.6985343
			+ RepCenMod05  * 28.66539431
			+ RepVelocityMod03  * 30.221845637
			+ _in_age_cap  * -0.008651044
			+ (integer)_bus_bankrupt  * 1.3279039127
			+ (integer)_rep_rel_bk  * 0.1619218767
			+ (integer)_rep_lien  * 0.3330035312
			+ _source_tot_FR  * 0.9629713981
			+ (integer)_rep_crime  * 0.166839911
			+ joe_DIST_BUSPHONE_BUSADDR  * 0.4265240572
		;
		phat6 := (exp(logit6 )) / (1+exp(logit6 ));
		RepAllMod04 := phat6;

		base6  := 703;
		odds6  :=  1/21;
		point6 := -40;

		RepAllMod04_score := round(point6*(log(phat6/(1-phat6)) - log(odds6))/log(2) + base6);  

		RVS811_rep := max(501, min(900, RepAllMod04_score));

		// ****************** overrides *************************;

		rc6set := [reason1,reason2,reason3,reason4,reason5,reason6];
		bothSets := rc6set;// + wc4set;

		// common code for a few of the overrides
		otherMatches := '19' in bothsets or '20' in bothsets or '21' in bothsets or '22' in bothsets or '23' in bothsets or '37' in bothsets;

		
		OR1 := rc_decsflag;
		rc19 := (integer)( combo_lnamecount=0 and combo_addrcount=0 and combo_hphonecount=0 and combo_ssncount=0 );
		rc20 := (integer)( combo_lnamecount=0 and combo_addrcount=0 and combo_hphonecount=0 and combo_ssncount>0 );
		rc21 := (integer)( lnamepop>0 and length(in_phone10)=10 and combo_lnamecount=0 and combo_addrcount>0 and combo_hphonecount=0 );
		rc22 := (integer)( lnamepop > 0 and addrpop > 0 and combo_lnamecount=0 and combo_addrcount=0 and combo_hphonecount > 0 );
		rc23 := (integer)(lnamepop > 0 and (integer)ssnlength in [4,9] and ((combo_lnamecount = 0 and combo_addrcount = 0
			and combo_hphonecount > 0 and combo_ssncount = 0) or (combo_lnamecount = 0 and combo_addrcount > 0
			and combo_hphonecount = 0 and combo_ssncount = 0) or (combo_lnamecount = 0 and combo_addrcount > 0
			and combo_hphonecount > 0 and combo_ssncount = 0)) );
		rc37 := (integer)(lnamepop = 1 and combo_lnamecount = 0 and not (combo_lnamecount = 0 and combo_addrcount = 0 and 
		combo_hphonecount = 0 and combo_ssncount = 0));

		OR2 := nas_summary in [1,2,3,4,5,8]
			and adlperssn_count > 0
			and not rc_lnamessnmatch2
			and 1 in [rc19,rc20,rc21,rc22,rc23,rc37]
		;
		OR3 := '1'=rc_ssndobflag;

		rc11 := (integer)(
			stringlib.stringtouppercase(trim(rc_addrvalflag)) = 'N'
			and ((in_city != '' and in_state != '' and in_streetaddress != '' )
			or (in_zipcode != '' and in_streetaddress != '')));
		OR4 := rc11=1 and 1 in [rc19,rc20,rc21,rc22,rc23,rc37];


		rc6 := (integer)(rc_ssnvalflag='1');
		or5 := rc6=1 and 1 in [rc19,rc20,rc21,rc22,rc23,rc37];

		rc7 := (integer)(rc_hriskphoneflag='5');
		rc8 := (integer)(length(in_phone10) > 0 and rc_phonetype != '1' );
		or6 := (rc7=1 or rc8=1) and 1 in [rc19,rc20,rc21,rc22,rc23,rc37];



		arcyears := (unsigned)history_date[1..4];
		arcmonths:= (unsigned)history_date[5..6];
		arc := arcyears*365.25 + arcmonths*30.43 + 1;

		dob_years := (unsigned)in_dob[1..4];
		dob_months:= (unsigned)in_dob[5..6];
		dob_days  := (unsigned)in_dob[7..8];
		dob := dob_years*365.25 + dob_months *30.43 + dob_days;

		age_diff := (arc - dob)/365.25;
		OR7 := in_dob != '' and age_diff < 18;

		priCodes := [pri1,pri2,pri3,pri4,pri5,pri6,pri7,pri8];
		BusOR1 := 'A4' in priCodes;
		BusOR2 := 'A6' in priCodes;

		isCode60 :=  (trim(company_name) !='' 
					and trim(addr1) !='' 
					and trim(phone10) !='' 
					and cmpycount=0 AND addrcount=0 AND wphonecount=0);

		isCode61 := (trim(company_name) !='' 
					and trim(addr1) !='' 
					and trim(phone10) !='' 
					and cmpycount=0 AND addrcount>0 AND wphonecount=0);

		isCode62 := (trim(company_name) !='' 
					and trim(addr1) !='' 
					and trim(phone10) !='' 
					and cmpycount=0 AND addrcount=0 AND wphonecount>0);


		BusOR3 := ((integer)hriskphoneflag=5) AND ( isCode60 or isCode61 or isCode62);

		biz_rc11 := 
			'N' = stringlib.stringtouppercase(trim(addrvalidflag))
			and (( trim(city) != '' and trim(state) != '' and trim(addr1) != '' )
			or    (trim(zip)  != '' and trim(addr1) != ''));
			
		BusOR4 := biz_rc11 and ( isCode60 or isCode61 or isCode62);
		
		biz_rc8 := length(phone10) > 0 and (integer)bphonetype != 1;
		BusOR5 := biz_rc8 and ( isCode60 or isCode61 or isCode62);
	 

		RVS811_0_0_part1 := map(
			OR7 => min(750,RVS811_rep),
			OR1 => min(750,RVS811_rep),
			OR3 => min(750,RVS811_rep),
			OR2 => min(750,RVS811_rep),

			BusOR1 => min(825,RVS811_rep),
			BusOR2 => min(825,RVS811_rep),
			BusOR3 => min(825,RVS811_rep),
			BusOR4 => min(825,RVS811_rep),
			BusOR5 => min(825,RVS811_rep),

			OR4 => min(825,RVS811_rep),
			OR5 => min(825,RVS811_rep),
			OR6 => min(825,RVS811_rep),
			RVS811_rep
		);

		_B_FAMMAR_P := if(B_FAMMAR_P='-1', 85, (real)B_FAMMAR_P);
		_B_POP_25_34_P := if( B_POP_25_34_P='-1', 15, min(15,(real)B_POP_25_34_P));     

		_B_ROBBERY_i := map( 
			(real)B_ROBBERY<=16 => 0,
			(real)B_ROBBERY<=88 => 1,
			(real)B_ROBBERY<=134 => 2,
			(real)B_ROBBERY<=172 => 3,
			4
		);

		_B_ROBBERY_i_l := map( 
			_B_ROBBERY_i = 0 => -4.532394077,
			_B_ROBBERY_i = 1 => -4.376171367,
			_B_ROBBERY_i = 2 => -4.289180382,
			_B_ROBBERY_i = 3 => -4.133713963,
			_B_ROBBERY_i = 4 => -3.994338034,
			-4.284671
		);
		
		_B_MED_HVAL_i_l2 := case( _B_MED_HVAL_i,
			  0 => -4.738797899,
			  1 => -4.627628755,
			  2 => -4.441817925,
			  3 => -4.376695983,
			  4 => -4.31381659,
			  5 => -4.186575342,
			  6 => -4.031898001,
			  7 => -3.922272515,
			  -4.284671
		  );
     

		logit7 := 2.2624591905
			+ _B_MED_HVAL_i_l2  * 0.5540233558
			+ _B_FAMMAR_P  * -0.007284941
			+ _B_POP_25_34_P  * 0.0360570387
			+ _B_ROBBERY_i_l  * 0.6872697096
			+ (real)B_HOUSINGCPI  * -0.004891706
			+ (real)B_AB_AV_EDU  * -0.000820179
			+ (real)B_WORK_HOME  * -0.000709131
		;
		phat7 := (exp(logit7)) / (1+exp(logit7));
		BusCenMod02 := if( b_censusmatch, phat7, 0.0137476);
		 
		/* Business Fp_Mod */

		/*_baddr_apt */
		_baddr_apt := ( StringLib.StringToUpperCase(trim(addr_type)) = 'H');

		/*_tin_dead */

		/*new_COMPANY_STATUS_m*/
		new_COMPANY_STATUS := case( COMPANY_STATUS,
			'U' => 2,
			'A' => 1,
			3
		);
		 
		new_COMPANY_STATUS_m := map( 
			new_COMPANY_STATUS = 1 => 0.0075414557,
			new_COMPANY_STATUS = 2 => 0.0144098293,
			new_COMPANY_STATUS = 3 => 0.0302824859,
			0.0135923414
		);

		/*_baddr_invalid*/
		_baddr_invalid        := ( StringLib.StringToUpperCase(trim(addrvalidflag)) != 'V');


		/* Business Vermod */
	 
		 /*joe_ADDRSCORE*/
		joe_ADDRSCORE := map( 
			ADDRSCORE = 0 => 3,
			ADDRSCORE < 100 => 2,
			1
		);

		/*_bus_vendor_reported_years_cap*/
		_scoring_year := _scoring_date[1..4];



		/* _dt_vendor_first_reported_min; */
		 
		joe_DIST_BUSPHONE_BUSADDR_m := map( 
			joe_DIST_BUSPHONE_BUSADDR = 1 => 0.0090366565,
			joe_DIST_BUSPHONE_BUSADDR = 2 => 0.018884897,
			0.0135923414
		);
		
		joe_bad_behavior := BKFEINFLAG
			or bkbdidflag
			or BANKRUPTCY_COUNT > 0
			or (real)RECENTBKTYPE > 0
			or LIENBDIDFLAG
			or UNRELEASEDLIENCOUNT > 0
			or RELEASEDLIENCOUNT > 0
			or LIEN_TOTAL > 0
		;
		 
		mod1bus_phonemod := -5.853980356
			+ (real)_baddr_apt  * 0.3697702706
			+ (real)_tin_dead  * 1.3247872017
			+ new_COMPANY_STATUS_m  * 55.632167383
			+ (real)_baddr_invalid  * 0.1695406493
			+ (real)_bphone_invalid  * 0.2690110672
			+ (real)_bphone_highrisk  * 0.728206474
			+ (real)_tin_invalid  * 0.2466566429
		;

		
		mod1bus_vermod := -7.328442369
			+ joe_BESTPHONESCORE_l  * 1280.7993728
			+ joe_ADDRSCORE  * 0.0763717141
			+ joe_CURRT1SRC4_m  * 54.580929321
			+ joe_PHONEADDRCOUNT  * 0.1813205408
			+ joe_state_cname_l  * 838.11404884
			+ joe_VERNOTRECENTFLAG_m  * 96.350763153
			+ _score_low  * -0.23870397
			+ _bus_vendor_reported_years_cap  * -0.095496591
			+ cnt_if_id_ia_m  * 48.942053462
		; 
		 
		base8  := 703;
		odds8  := 1/21;
		point8 := -40;     

		mod1combined_rvbus := 1.06540647
			+ (real)joe_bad_behavior  * 1.0668724389
			+ BusCenMod02  * 57.169896659
			+ mod1bus_phonemod  * 0.8162977059
			+ mod1bus_vermod  * 0.7558316785
			+ joe_DIST_BUSPHONE_BUSADDR_m  * 35.748569308
		;
		 
		phat8 := 1/(1+exp(-mod1combined_rvbus));

		bus_crd_def := round((point8*(log(phat8/(1-phat8)) - log(odds8))/log(2) + base8));

		RVS811_bus  := max(501,min(900,bus_crd_def));

		// *************** overrides ********************;

		RVS811_bus_override := if( BusOR1 or BusOR2 or BusOR3 or BusOR4 or BusOR5, min(825,RVS811_bus), RVS811_bus );   
		RVS811_0_0_part2 := RVS811_bus_override;

		RVS811_0_0 := if(uv_reppop, RVS811_0_0_part1, RVS811_0_0_part2);

		RVS811_0_2 := if(
			(integer)bnap_indicator < 4
			and (integer)bnat_indicator < 4
			and (integer)bnas_indicator < 1
			and (integer)ar2bi < 20, 222, RVS811_0_0 );

		self.seq         := if(le.bs.seq=0, le.br.biid.seq, le.bs.seq);
		self.name        := 'RVS811_0';
		self.description := 'LexisNexis Small Business Risk Score';
		
		rep_rc  := LNSmallBusiness.lnsbReasons_Rep( le.bs );
		bus_rc  := LNSmallBusiness.lnsbReasons_Bus( le.br );
		billIdx := Risk_Indicators.BillingIndex.RVFSB_generic;
		
		sco := dataset( [ { '0-999', RVS811_0_2, billIdx, bus_rc, rep_rc }], iesp.ws_analytics.t_SmallBusinessScoreHRI );
		self.scores := sco;
	end;
	
	model := project( withCensusB, doModel(LEFT) );

	return model;
end;