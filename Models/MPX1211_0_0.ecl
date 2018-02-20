/*Now (cmandan)
Text In Open Window
*/
import risk_indicators, ut, riskwise, std;

export MPX1211_0_0( dataset(risk_indicators.layout_boca_shell) clam ) := FUNCTION

	MPX1211_DEBUG := false;

	#if(MPX1211_DEBUG)
	layout_debug := record
		integer seq;
		real4 score;
		Integer add1_avm_med_fips; 		
		Integer criminal_last_date_mn;
		Integer add2_avm_confidence_score;
		Integer PhoneOtherAgeOldestRecord;
		Integer rv4_t;
		Integer SSNAddrCount;
		integer email_domain_free_count;
		string prevaddrdwelltype;
		string add2_style_code;
		string add1_mortgage_type;
    string rc_addrvalflag;
		string ams_college_major;
		Integer add1_no_of_rooms;
		string bankruptcytype;
		Integer rv2_g;
		Integer invaliddl;
		Integer attr_num_proflic_exp90;
		Integer attr_derog_age;
		Integer rc_ssnhighissue_mn;
		Integer subjectssncount;
		REAL add1_avm_med_fips_points; 		
		REAL criminal_last_date_mn_points;
		REAL add2_avm_confidence_score_points;
		REAL PhoneOtherAgeOldestRecord_points;
		REAL rv4_t_points;
		REAL SSNAddrCount_points;
		REAL email_domain_free_count_points;
		REAL prevaddrdwelltype_points;
		REAL add2_style_code_points;
		REAL add1_mortgage_type_points;
    REAL rc_addrvalflag_points;
		REAL ams_college_major_points;
		REAL add1_no_of_rooms_points;
		REAL bankruptcytype_points;
		REAL rv2_g_points;
		REAL invaliddl_points;
		REAL attr_num_proflic_exp90_points;
		REAL attr_derog_age_points;
		REAL rc_ssnhighissue_mn_points;
		REAL subjectssncount_points;
	end;
	
	layout_debug doModel( clam le) := TRANSFORM
	#else
	
	layout_mvr := record
		integer seq;
		real4 score;
	end;
	layout_mvr doModel( clam le) := TRANSFORM
	#end

		add1_avm_med_fips                := le.AVM.Input_Address_Information.avm_median_fips_level;
		criminal_last_date               := le.bjl.last_criminal_date;
		add2_avm_confidence_score        := le.avm.address_history_1.avm_confidence_score;
		rv4_t														 := (integer)le.rv_scores.telecomv4;
		email_domain_free_count					 := le.email_summary.email_domain_free_ct;
		add2_style_code									 := le.address_verification.address_history_1.style_code;
		add1_mortgage_type							 :=	le.address_verification.input_address_information.mortgage_type;
		rc_addrvalflag									 := le.iid.addrvalflag;
		ams_college_major								 := le.Student.college_major;
		add1_no_of_rooms								 :=	le.address_verification.input_address_information.no_of_rooms;
		bankruptcytype									 :=	le.bjl.filing_type;
		rv2_g														 :=	(integer)le.rv_scores.msbv2;
		attr_num_proflic_exp90					 :=	le.professional_license.expire_count90;
		
		//Attributes from Attributes_Master
		history_date := if( le.historydate=999999, ((STRING)Std.Date.Today())[1..6], (string6)le.historydate );
		NULL := -1;
		getMonths( unsigned date ) := if(date=0, NULL, max(0,((integer)history_date[1..4] - (integer)((STRING)date)[1..4])*12
																			+ (integer)history_date[5..6] - (integer)((STRING)date)[5..6]));		
		
		attr 														 := Models.Attributes_Master(le,true);
		SSNAddrCount										 := (integer)attr.SSNAddrCount;
		prevaddrdwelltype								 := attr.PrevAddrDwellType;
		invaliddl 											 := (integer)attr.InvalidDL;
		PhoneOtherAgeOldestRecord				 := (integer)attr.PhoneOtherAgeOldestRecord;		
		attr_derog_age                   := (integer)attr.DerogAge;
		subjectssncount									 := (integer)attr.SubjectSSNCount;
		criminal_last_date_mn            := getMonths(criminal_last_date);
		rc_ssnhighissue_mn							 := getMonths((real)le.iid.soclhighissue);
				
		add1_avm_med_fips_points := map(
		  add1_avm_med_fips >= 195692 => -0.114850,
			add1_avm_med_fips >= 156201 => -0.111093,
			add1_avm_med_fips >= 151511 => -0.080454,
			add1_avm_med_fips >= 141756 =>  0.029239,
			add1_avm_med_fips >= 139539 =>  0.033774,
			add1_avm_med_fips >= 122652 =>  0.111475,
			add1_avm_med_fips >= 120756 =>  0.160941,
			add1_avm_med_fips >= 118528 =>  0.757319,
			add1_avm_med_fips >= 110370 =>  0.215392,
			add1_avm_med_fips >=  96583 =>  0.161065,
			add1_avm_med_fips >=  94724 =>  0.140084,
			add1_avm_med_fips >=  93046 =>  0.074586,
			add1_avm_med_fips >=  92755 =>  0.007527,
			add1_avm_med_fips >=  82501 => -0.008116,
			add1_avm_med_fips >=  54131 => -0.013943,
			add1_avm_med_fips >=  52810 => -0.020462,
			add1_avm_med_fips >=  52261 => -0.021448,
			add1_avm_med_fips >=      1 => -0.083875,
			-0.182098
		);
		
		criminal_last_date_mn_points := map(
			criminal_last_date_mn= NULL =>  0.000579,
			criminal_last_date_mn >= 59 =>  0.486251,
		  criminal_last_date_mn >= 59 =>  0.486251,
			criminal_last_date_mn >= 25 =>  0.374800,
			criminal_last_date_mn >= 20 => -0.313015,
			criminal_last_date_mn >= 15 => -0.448530,
			criminal_last_date_mn >= 10 => -0.897273,
			criminal_last_date_mn >=  5 => -1.217764,
			-1.487016
		);
		
		add2_avm_confidence_score_points := map(
			add2_avm_confidence_score >= 78 =>  -0.033744,
		  add2_avm_confidence_score >= 76 =>   0.009430,
			add2_avm_confidence_score >= 67 =>   0.059004,
			add2_avm_confidence_score >= 62 =>   0.194773,
			add2_avm_confidence_score >= 60 =>   0.142973,
			add2_avm_confidence_score >= 46 =>   0.110801,
			add2_avm_confidence_score >=  1 =>   0.055864,
			-0.030762
		);
		
		PhoneOtherAgeOldestRecord_points := map(
			PhoneOtherAgeOldestRecord = NULL OR 
			PhoneOtherAgeOldestRecord =   -1 =>  0.042228,
			PhoneOtherAgeOldestRecord >= 173 => -0.343820,
		  PhoneOtherAgeOldestRecord >= 139 => -0.288405,
			PhoneOtherAgeOldestRecord >= 110 => -0.265977,
			PhoneOtherAgeOldestRecord >= 103 => -0.135706,
			PhoneOtherAgeOldestRecord >=  74 => -0.097915,
			PhoneOtherAgeOldestRecord  =  73 => -0.068581,
			PhoneOtherAgeOldestRecord >=  64 => -0.047051,
			PhoneOtherAgeOldestRecord  =  63 => -0.029008,
			PhoneOtherAgeOldestRecord >=   4 => -0.002016,
			0.297084
		);


		rv4_t_points := map(
			rv4_t >= 795 =>  0.534370,
		  rv4_t >= 703 =>  0.263519,
			rv4_t >= 692 =>  0.250440,
			rv4_t >= 674 =>  0.075769,
			rv4_t >= 658 =>  0.051405,
			rv4_t >= 639 =>  0.018266,
			rv4_t >= 590 => -0.033934,
			rv4_t >= 563 => -0.113916,
			rv4_t >= 544 => -0.132407,
			rv4_t >= 524 => -0.103083,
			rv4_t >= 504 => -0.061676,
			rv4_t >= 223 =>  0.060737,
			0.165230
		);

		SSNAddrCount_points := map(
			SSNAddrCount >= 26 => -0.564796,
			SSNAddrCount >= 24 => -0.524722,
			SSNAddrCount >= 18 => -0.351697,
			SSNAddrCount >= 15 => -0.269605,
			SSNAddrCount >= 13 => -0.158131,
			SSNAddrCount >=  9 => -0.043492,
			SSNAddrCount >=  7 => -0.004380,
			SSNAddrCount >=  4 =>  0.073511,
			SSNAddrCount  =  3 =>  0.145759,
			SSNAddrCount >=  1 =>  0.066983,
			-0.079776
		);
		
		email_domain_free_count_points := map(
			email_domain_free_count >= 10 => -0.417035,
			email_domain_free_count >=  6 => -0.367923,
			email_domain_free_count >=  4 => -0.319941,
			email_domain_free_count  =  3 => -0.266689,
			email_domain_free_count  =  2 => -0.105152,
			0.029576
		);
		
		prevaddrdwelltype_points := map(
			prevaddrdwelltype = 'S' => -0.122150,
			0.000000
		);
		
		add2_style_code_points := map(
			add2_style_code = 'T' => 0.674020,
			0.000000
		);
		
		add1_mortgage_type_points := map(
			add1_mortgage_type =  '1' => 0.671072,
			add1_mortgage_type = 'VA' => 0.685296,
			0.000000
		);
		
		rc_addrvalflag_points := map(
			rc_addrvalflag = 'N' => -0.746085,
			0.000000
		);
		
		ams_college_major_points := map(
			ams_college_major = 'E' => 1.077019,
			0.000000
		);
		
		add1_no_of_rooms_points := map(
			add1_no_of_rooms >= 16 => -1.027862,
			add1_no_of_rooms >= 13 => -0.483889,
			add1_no_of_rooms >=  9 => -0.220323,
			add1_no_of_rooms >=  7 => -0.089224,
			add1_no_of_rooms >=  5 => -0.008785,
			add1_no_of_rooms  =  4 =>  0.008806,
			add1_no_of_rooms  =  3 =>  0.442062,
			0.012074
		);
		
		bankruptcytype_points := map(
			bankruptcytype = 'I' => 0.344896,
			0.000000
		);
		
		rv2_g_points := map(
			rv2_g >= 673 =>  0.219216,
		  rv2_g >= 654 =>  0.205396,
			rv2_g >= 652 =>  0.193978,
			rv2_g >= 646 =>  0.031495,
			rv2_g >= 639 =>  0.004533,
			rv2_g >= 623 => -0.019590,
			rv2_g >= 606 => -0.052273,
			rv2_g >= 600 => -0.092066,
			rv2_g >= 597 => -0.152084,
			rv2_g  = 596 => -0.132107,
			rv2_g >= 591 => -0.105746,
			rv2_g >= 586 => -0.089274,
			rv2_g >= 582 => -0.056672,
			rv2_g >= 572 =>  0.006529,
			rv2_g >= 570 =>  0.052800,
			rv2_g >= 539 =>  0.090062,
			rv2_g >= 534 =>  0.114307,			
			rv2_g >= 223 =>  0.124498,
			-0.181744
		);
		
		invaliddl_points := map(
			invaliddl >= 1 => -0.292839,
			0.000000
		);
		
		attr_num_proflic_exp90_points := map(
			attr_num_proflic_exp90 >= 1 => 1.366343,
			0.000000
		);
		
		attr_derog_age_points := map(
			attr_derog_age  =  -1 =>  -0.008423,
			attr_derog_age >= 108 =>  -0.396865,
		  attr_derog_age >= 100 =>  -0.185530,
			attr_derog_age >=  90 =>  -0.131815,
			attr_derog_age >=  86 =>  -0.101139,
			attr_derog_age >=  83 =>  -0.030509,
			attr_derog_age >=  68 =>   0.028546,
			attr_derog_age >=  56 =>   0.059529,
			attr_derog_age >=  42 =>   0.150667,
			attr_derog_age >=  40 =>   0.123627,
			attr_derog_age >=  30 =>   0.099299,
			attr_derog_age >=  19 =>   0.071800,
			attr_derog_age >=  10 =>   0.005317,
			attr_derog_age >=   4 =>   0.002371,
			-0.037795
		);
		
		rc_ssnhighissue_mn_points := map(
			rc_ssnhighissue_mn  =  -1 =>  -0.017283,
			rc_ssnhighissue_mn >= 632 =>  -0.006743,
		  rc_ssnhighissue_mn >= 536 =>  -0.015619,
			rc_ssnhighissue_mn >= 526 =>  -0.128075,
			rc_ssnhighissue_mn >= 512 =>  -0.040057,
			rc_ssnhighissue_mn >= 430 =>  -0.030003,
			rc_ssnhighissue_mn >= 380 =>  -0.020094,
			rc_ssnhighissue_mn >= 357 =>  -0.002870,
			rc_ssnhighissue_mn >= 202 =>   0.009249,
			rc_ssnhighissue_mn >= 157 =>   0.039300,
			rc_ssnhighissue_mn >= 139 =>   0.050300,
			rc_ssnhighissue_mn >= 135 =>   0.059653,
			rc_ssnhighissue_mn >= 116 =>   0.098239,
			rc_ssnhighissue_mn >= 114 =>   0.118668,
			rc_ssnhighissue_mn >=  90 =>   0.135450,
			0.218385
		);

		subjectssncount_points := map(
			subjectssncount >= 7 => -0.394380,
			subjectssncount >= 4 => -0.170210,
			subjectssncount  = 3 => -0.098582,
			subjectssncount  = 2 => -0.052951,
			0.028781
		);
		
		ind := if( models.common.isRV3Unscorable(le), 'Un-scorable', 'Scorable' );
			
		boca := if( ind='Un-scorable', 999,
			 add1_avm_med_fips_points        
     + criminal_last_date_mn_points     
     + add2_avm_confidence_score_points              
     + PhoneOtherAgeOldestRecord_points            
     + rv4_t_points    
     + SSNAddrCount_points               
     + email_domain_free_count_points           
     + prevaddrdwelltype_points  
     + add2_style_code_points  
     + add1_mortgage_type_points  
     + rc_addrvalflag_points        
     + ams_college_major_points    
     + add1_no_of_rooms_points           
     + bankruptcytype_points         
     + rv2_g_points             
     + invaliddl_points
		 + attr_num_proflic_exp90_points
		 + attr_derog_age_points
		 + rc_ssnhighissue_mn_points
		 + subjectssncount_points
			);

		#if(MPX1211_DEBUG)
		SELF.seq := le.seq;
		SELF.score := boca;
		SELF.add1_avm_med_fips := add1_avm_med_fips; 		
		SELF.criminal_last_date_mn := criminal_last_date_mn;
		SELF.add2_avm_confidence_score := add2_avm_confidence_score;
		SELF.PhoneOtherAgeOldestRecord := PhoneOtherAgeOldestRecord;
		SELF.rv4_t := rv4_t;
		SELF.SSNAddrCount := SSNAddrCount;
		SELF.email_domain_free_count := email_domain_free_count;
		self.prevaddrdwelltype := prevaddrdwelltype;
		self.add2_style_code := add2_style_code;
		self.add1_mortgage_type := add1_mortgage_type;
    self.rc_addrvalflag := rc_addrvalflag;
		self.ams_college_major := ams_college_major;
		SELF.add1_no_of_rooms := add1_no_of_rooms;
		self.bankruptcytype := bankruptcytype;
		SELF.rv2_g := rv2_g;
		SELF.invaliddl := invaliddl;
		SELF.attr_num_proflic_exp90 := attr_num_proflic_exp90;
		SELF.attr_derog_age := attr_derog_age;
		SELF.rc_ssnhighissue_mn := rc_ssnhighissue_mn;
		SELF.subjectssncount := subjectssncount;

		self.add1_avm_med_fips_points	:=  	add1_avm_med_fips_points	; 
		self.criminal_last_date_mn_points	:=  	criminal_last_date_mn_points	; 
		self.add2_avm_confidence_score_points	:=  	add2_avm_confidence_score_points	; 
		self.PhoneOtherAgeOldestRecord_points	:=  	PhoneOtherAgeOldestRecord_points	; 
		self.rv4_t_points	:=  	rv4_t_points	; 
		self.SSNAddrCount_points	:=  	SSNAddrCount_points	; 
		self.email_domain_free_count_points	:=  	email_domain_free_count_points	; 
		self.prevaddrdwelltype_points	:=  	prevaddrdwelltype_points	; 
		self.add2_style_code_points	:=  	add2_style_code_points	; 
		self.add1_mortgage_type_points	:=  	add1_mortgage_type_points	; 
		self.rc_addrvalflag_points	:=  	rc_addrvalflag_points	; 
		self.ams_college_major_points	:=  	ams_college_major_points	; 
		self.add1_no_of_rooms_points	:=  	add1_no_of_rooms_points	; 
		self.bankruptcytype_points	:=  	bankruptcytype_points	; 
		self.rv2_g_points	:=  	rv2_g_points	; 
		self.invaliddl_points	:=  	invaliddl_points	; 
		self.attr_num_proflic_exp90_points	:=  	attr_num_proflic_exp90_points	; 
		self.attr_derog_age_points	:=  	attr_derog_age_points	; 
		self.rc_ssnhighissue_mn_points	:=  	rc_ssnhighissue_mn_points	; 
		self.subjectssncount_points	:=  	subjectssncount_points	; 
		#else
		self.seq := le.seq;
		self.score := boca;
		#end;

	END;
		
	model := project( clam, doModel(LEFT) );
	
	return model;
END;
