import risk_indicators, riskwise, ut;

EXPORT APT002_0_0( dataset(risk_indicators.layout_boca_shell) clam ) := FUNCTION

	// NCF: ATTRACT Public Record Auto No File/Thin File FCRA called by Models.FCRAInsurance_Service

	APT_DEBUG := false;
	
	#if(APT_DEBUG)
		layout_debug := record
			integer seq;
			
			Integer EQ_count;
			Integer ssns_per_addr;
			String mobility_indicator;
			Integer add2_date_first_seen;
			String rc_ssnlowissue;
			Boolean securityFreeze;
			Boolean securityAlert;
			Boolean idtheftflag;
			Boolean disputeFlag;
			Boolean negativeAlert;
			String rc_decsflag;
			Integer NAP_Summary;
			Integer NAS_Summary;
			Integer add1_naprop;
			Integer archive_date;
			Integer fulldate;
			Integer IALastSaleDate;
			String secondseendate2;
			Integer ts_secondseendate2;
			String low_issue_year;
			Integer ts_low_issue_year;
			String ialastsaledate2;
			Integer ts_ialastsaledate;
			Real EQ_count_WOE;
			Real ts_secondseendate2_WOE;
			Real ts_low_issue_year_WOE;
			Real ssns_per_addr_WOE;
			Real ts_ialastsaledate_WOE;
			Real mobility_indicator_WOE;
			Real score;
			Real scr;
			Integer APT002_0_0;
			Real PTS_EQ_COUNT;
			Real PTS_ts_secondseendate2;
			Real PTS_ts_low_issue_year;
			Real PTS_ssns_per_addr;
			Real PTS_ts_ialastsaledate;
			Real PTS_mobility_indicator;
			Real AVG_EQ_count;
			Real AVG_ts_secondseendate2;
			Real AVG_ts_low_issue_year;
			Real AVG_ssns_per_addr;
			Real AVG_ts_ialastsaledate;
			Real AVG_mobility_indicator;
			Real BST_EQ_count;
			Real BST_ts_secondseendate2;
			Real BST_ts_low_issue_year;
			Real BST_ssns_per_addr;
			Real BST_ts_ialastsaledate;
			Real BST_mobility_indicator;
			Real DPT_EQ_count;
			Real DPT_ts_secondseendate2;
			Real DPT_ts_low_issue_year;
			Real DPT_ssns_per_addr;
			Real DPT_ts_ialastsaledate;
			Real DPT_mobility_indicator;
			Real DBEST_EQ_count;
			Real DBEST_ts_secondseendate2;
			Real DBEST_ts_low_issue_year;
			Real DBEST_ssns_per_addr;
			Real DBEST_ts_ialastsaledate;
			Real DBEST_mobility_indicator;
			Real reason1_pt;
			String4 reason1_rc;
			Real reason2_pt;
			String4 reason2_rc;
			Real reason3_pt;
			String4 reason3_rc;
			Real reason4_pt;
			String4 reason4_rc;
		end;
		layout_debug doModel(clam le) := TRANSFORM
	#else
		Models.Layout_modelout doModel(clam le) := TRANSFORM
	#end
	
		EQ_count                            :=  le.Source_Verification.eq_count;
		ssns_per_addr                       :=  le.velocity_counters.ssns_per_addr;
		mobility_indicator                  :=  le.mobility_indicator;
		add2_date_first_seen                :=  le.address_verification.address_history_1.date_first_seen;
		rc_ssnlowissue                      :=  le.iid.socllowissue;

		securityFreeze                      :=  le.consumerflags.security_freeze;
		securityAlert                       :=  le.consumerflags.security_alert;
		idTheftFlag                         :=  le.consumerflags.id_theft_flag;
		disputeFlag                         :=  le.consumerflags.dispute_flag;
		negativeAlert                       :=  le.consumerflags.negative_alert;
		rc_decsflag                         :=  le.iid.decsflag;
		nap_summary                         :=  le.iid.nap_summary;
		nas_summary                         :=  le.iid.nas_summary;
		add1_naprop                         :=  le.address_verification.input_address_information.naprop;
		archive_date                        :=  if(le.historydate=999999, (unsigned3)ut.getdate[1..6], le.historydate);


		// code to calculate the # months between two days. validated against data from Tiana Pan to ensure it matches the results of intck('month',dt1,dt2)
		integer2 getMonths( string dt1, string dt2 ) := 12*( (integer2)dt1[1..4] - (integer2)dt2[1..4] ) + (integer2)dt1[5..6] - (integer2)dt2[5..6];
		integer1 getYears( string dt1, string dt2 ) := (integer2)dt1[1..4] - (integer2)dt2[1..4];

		/* ATTRIBUTES */
			fulldate := (unsigned4)((STRING6)archive_date+'01');

			IALastSaleDate := if(le.address_verification.input_address_information.purchase_date>fullDate, 0,
				le.address_verification.input_address_information.purchase_date);
		/* ATTRIBUTES */


		secondseendate2 := if(0=(integer1)add2_date_first_seen[5..6], '', (string)add2_date_first_seen );
		ts_secondseendate2 := if( secondseendate2='', -1, getYears((string)fulldate, secondseendate2));

		low_issue_year := common.readDate( rc_ssnlowissue );
		ts_low_issue_year := if( low_issue_year='', -1, getYears((string)fulldate, low_issue_year ));

		ialastsaledate2 := if( 0 in [(integer1)ialastsaledate[5..6],(integer1)ialastsaledate[7..8]], '', (string)ialastsaledate );
		ts_ialastsaledate := if( ialastsaledate2='', -1, getMonths((string)fulldate,ialastsaledate2) );


			
		EQ_count_WOE := map(
			EQ_count<=2  => -0.02151,
			EQ_count<=5   => -0.01106,
			EQ_count<=9   => -0.0077,
			EQ_count<=13  =>  0.00326,
			EQ_count<=20 =>  0.01348,
			0.04069
		);

		ts_secondseendate2_WOE := map(
			ts_secondseendate2 <= -1 => 0,
			ts_secondseendate2  =  0 => 0.03041,
			ts_secondseendate2  =  1 => 0.02022,
			ts_secondseendate2 <=  4 => 0.00579,
			ts_secondseendate2 <=  9 => -0.0027,
			ts_secondseendate2 <= 16 => -0.00441,
			-0.01851
		);

		ts_low_issue_year_WOE := map(
			ts_low_issue_year  =-1     => 0,
			ts_low_issue_year <=18 => 0.04454,
			ts_low_issue_year <=28 => 0.01453,
			ts_low_issue_year <=40 => 0.00398,
			ts_low_issue_year <=50 => -0.01182,
			-0.0467
		);

		ssns_per_addr_WOE := map(
			ssns_per_addr <=   0 =>  0.00471,
			ssns_per_addr <=   2 => -0.04469,
			ssns_per_addr <=   5 => -0.01134,
			ssns_per_addr <=   7 => -0.00725,
			ssns_per_addr <=   9 =>  0.00974,
			ssns_per_addr <=  15 =>  0.01535,
			ssns_per_addr <= 254 =>  0.02452,
			0
		);

		ts_ialastsaledate_WOE := map(
			ts_ialastsaledate <= -1 => 0,
			ts_ialastsaledate <= 10 => 0.05084,
			ts_ialastsaledate <= 49 => 0.01904,
			ts_ialastsaledate <= 86 => 0.01552,
			0.01061
		);

		mobility_indicator_WOE := map(
			(integer1)mobility_indicator  =0 => -0.02605,
			(integer1)mobility_indicator  =1 =>  0.02554,
			(integer1)mobility_indicator <=3 =>  0.01416,
			(integer1)mobility_indicator  =4 => -0.00071,
			(integer1)mobility_indicator  =5 => -0.01316,
			-0.02787
		);



		/****** Scoring equation *******/

		score:= Common.ROUND(EXP(-0.7247
			+ EQ_count_WOE		*	3.2074
			+ ts_secondseendate2_Woe*	4.4984
			+ ts_low_issue_year_WOE	*	4.0491
			+ ssns_per_addr_WOE	*	3.2027
			+ ts_ialastsaledate_WOE *	6.8124
			+ mobility_indicator_WOE*4.6752),0.0001);

		/***** Rescale raw score *******/
		scr := map(
			score <= 0.4552 => ((808 - 997)/(0.4552 - 0.2816))*(score - 0.2816) + 997,
			score <= 0.5089 => ((764 - 807)/(0.5089 - 0.4553))*(score - 0.4553) + 807,
			score <= 0.5465 => ((733 - 763)/(0.5465 - 0.5090))*(score - 0.5090) + 763,
			score <= 0.5818 => ((705 - 732)/(0.5818 - 0.5466))*(score - 0.5466) + 732,
			score <= 0.6171 => ((680 - 704)/(0.6171 - 0.5819))*(score - 0.5819) + 704,
			score <= 0.6519 => ((655 - 679)/(0.6519 - 0.6172))*(score - 0.6172) + 679,
			score <= 0.6882 => ((628 - 654)/(0.6882 - 0.6520))*(score - 0.6520) + 654,
			score <= 0.7279 => ((596 - 627)/(0.7279 - 0.6883))*(score - 0.6883) + 627,
			score <= 0.7896 => ((552 - 595)/(0.7896 - 0.7280))*(score - 0.7280) + 595,
			((212 - 551)/(1.3063 - 0.7897))*(score - 0.7897) + 551
		);


		 /*Minimize/Maximize the score to 200-997. Create default scores*/
		APT002_0_0 := map(
			securityFreeze  => 101,
			securityAlert   => 102,
			idTheftFlag     => 103,
			disputeFlag     => 104,
			rc_decsflag='1' => 106,
			nas_summary <= 4 and nap_summary <= 4 and add1_naprop <= 2 => 999,
			min(max(200,round(scr)),997)
		);


		/***** Assign POINTS ********/

		PTS_EQ_COUNT := map(
			EQ_COUNT<0 =>0,
			EQ_count<=2  => Common.round(-0.068991174, .000001),
			EQ_count<=5  => Common.round(-0.035473844, .000001),
			EQ_count<=9  => Common.round(-0.02469698, .000001),
			EQ_count<=13 => Common.round(0.010456124, .000001),
			EQ_count<=20 => Common.round(0.043235752, .000001),
			Common.round(0.130509106, .000001)
		);

		PTS_ts_secondseendate2 := map(
			ts_secondseendate2<0   => Common.round(0, .000001),
			ts_secondseendate2=0   => Common.round(0.136796344, .000001),
			ts_secondseendate2=1   => Common.round(0.090957648, .000001),
			ts_secondseendate2<=4  => Common.round(0.026045736, .000001),
			ts_secondseendate2<=9  => Common.round(-0.01214568, .000001),
			ts_secondseendate2<=16 => Common.round(-0.019837944, .000001),
			Common.round(-0.083265384, .000001)
		);

		PTS_ts_low_issue_year := map(
			ts_low_issue_year < 0  => Common.round(0, .000001),
			ts_low_issue_year <=18 => Common.round(0.180346914, .000001),
			ts_low_issue_year <=28 => Common.round(0.058833423, .000001),
			ts_low_issue_year <=40 => Common.round(0.016115418, .000001),
			ts_low_issue_year <=50 => Common.round(-0.047860362, .000001),
			Common.round(-0.18909297, .000001)
		);

		PTS_ssns_per_addr := map(
			SSNS_PER_ADDR <    0 => Common.round(0, .000001),
			ssns_per_addr =    0 => Common.round(0.015084717, .000001),
			ssns_per_addr <=   2 => Common.round(-0.143128663, .000001),
			ssns_per_addr <=   5 => Common.round(-0.036318618, .000001),
			ssns_per_addr <=   7 => Common.round(-0.023219575, .000001),
			ssns_per_addr <=   9 => Common.round(0.031194298, .000001),
			ssns_per_addr <=  15 => Common.round(0.049161445, .000001),
			ssns_per_addr <= 254 => Common.round(0.078530204, .000001),
			Common.round(0, .000001)
		);

		PTS_ts_ialastsaledate := map(
			ts_ialastsaledate<0   =>Common.round(0, .000001),
			ts_ialastsaledate<=10 =>Common.round(0.346342416, .000001),
			ts_ialastsaledate<=49 =>Common.round(0.129708096, .000001),
			ts_ialastsaledate<=86 =>Common.round(0.105728448, .000001),
			Common.round(0.072279564, .000001)
		);

		PTS_mobility_indicator := map(
			MOBILITY_INDICATOR='' =>Common.round(0, .000001),
			(integer1)mobility_indicator =0 => Common.round(-0.12178896, .000001),
			(integer1)mobility_indicator =1 => Common.round(0.119404608, .000001),
			(integer1)mobility_indicator<=3 => Common.round(0.066200832, .000001),
			(integer1)mobility_indicator =4 => Common.round(-0.003319392, .000001),
			(integer1)mobility_indicator =5 => Common.round(-0.061525632, .000001),
			Common.round(-0.130297824, .000001)
		);

		AVG_EQ_count            := Common.round(0.009173164, .000001);
		AVG_ts_secondseendate2  := Common.round(0.01979296, .000001);
		AVG_ts_low_issue_year   := Common.round(0.003057071, .000001);
		AVG_ssns_per_addr       := Common.round(-0.003587024, .000001);
		AVG_ts_ialastsaledate   := Common.round(0.130811705, .000001);
		AVG_mobility_indicator  := Common.round(-0.021887728, .000001);

		BST_EQ_count            := Common.round(-0.068991174, .000001);
		BST_ts_secondseendate2  := Common.round(-0.083265384, .000001);
		BST_ts_low_issue_year   := Common.round(-0.18909297, .000001);
		BST_ssns_per_addr       := Common.round(-0.143128663, .000001);
		BST_ts_ialastsaledate   := Common.round(0, .000001);
		BST_mobility_indicator  := Common.round(-0.130297824, .000001);

		DPT_EQ_count                      := PTS_EQ_count                   - AVG_EQ_count;
		DPT_ts_secondseendate2            := PTS_ts_secondseendate2         - AVG_ts_secondseendate2;
		DPT_ts_low_issue_year             := PTS_ts_low_issue_year          - AVG_ts_low_issue_year;
		DPT_ssns_per_addr                 := PTS_ssns_per_addr              - AVG_ssns_per_addr;
		DPT_ts_ialastsaledate             := PTS_ts_ialastsaledate          - AVG_ts_ialastsaledate;
		DPT_mobility_indicator            := PTS_mobility_indicator         - AVG_mobility_indicator;

		DBEST_EQ_count                    := PTS_EQ_count                   - BST_EQ_count;
		DBEST_ts_secondseendate2          := PTS_ts_secondseendate2         - BST_ts_secondseendate2;
		DBEST_ts_low_issue_year           := PTS_ts_low_issue_year          - BST_ts_low_issue_year;
		DBEST_ssns_per_addr               := PTS_ssns_per_addr              - BST_ssns_per_addr;
		DBEST_ts_ialastsaledate           := PTS_ts_ialastsaledate          - BST_ts_ialastsaledate;
		DBEST_mobility_indicator          := PTS_mobility_indicator         - BST_mobility_indicator;

		/*
		Per Tiana Pan:
		1. If PTS1=Best1, PTS2=BEST2, ..., PTS9=BEST9  then no reason codes should be generated.
		2. If PTS1>Avg1, PTS2>Avg2, ..., PTS9>Avg9, then generate 1 reason code (take the worse attribute)
		3. Everything else can take as many as 4 reason codes.
		*/
		rclayout := {real point, string4 rc};
		
		allReasons := dataset( [
			{DPT_EQ_count                  , 'A001'},
			{DPT_ts_secondseendate2        , if(ts_secondseendate2=-1, 'A02A', 'A02B') },
			{DPT_ts_low_issue_year         , if(ts_low_issue_year=-1, 'A03A', 'A03B') },
			{DPT_ssns_per_addr             , if(ssns_per_addr in [0,255], 'A009', 'A021') },
			{DPT_ts_ialastsaledate         , if(ts_ialastsaledate=-1, 'A05A', 'A05B') },
			{DPT_mobility_indicator        , 'A050'}
			], rclayout );
		bestReasons := dataset( [
			{DBEST_EQ_count                  , 'A001'},
			{DBEST_ts_secondseendate2        , if(ts_secondseendate2=-1, 'A02A', 'A02B') },
			{DBEST_ts_low_issue_year         , if(ts_low_issue_year=-1, 'A03A', 'A03B') },
			{DBEST_ssns_per_addr             , if(ssns_per_addr in [0,255], 'A009', 'A021') },
			{DBEST_ts_ialastsaledate         , if(ts_ialastsaledate=-1, 'A05A', 'A05B') },
			{DBEST_mobility_indicator        , 'A050'}
			], rclayout );

		reasons := map(
			APT002_0_0 = 101 => dataset( [{0, 'E091'}], rcLayout ),
			APT002_0_0 = 102 => dataset( [{0, 'E092'}], rcLayout ),
			APT002_0_0 = 103 => dataset( [{0, 'E093'}], rcLayout ),
			APT002_0_0 = 104 => dataset( [{0, 'E094'}], rcLayout ),
			APT002_0_0 = 106 => dataset( [{0, 'E002'}], rcLayout ),
			APT002_0_0 = 999 => dataset( [{0, 'E019'}], rcLayout ),
			APT002_0_0 = 997 => dataset( [], rcLayout ),
			
			EXISTS( allReasons(point>0) ) => CHOOSEN(SORT(allReasons(point>0), -point), 4 ),
			CHOOSEN( SORT(bestReasons(point>0), -point), 1 )
		);


		#if(APT_DEBUG)
			self.EQ_count := EQ_count;
			self.ssns_per_addr := ssns_per_addr;
			self.mobility_indicator := mobility_indicator;
			self.add2_date_first_seen := add2_date_first_seen;
			self.rc_ssnlowissue := rc_ssnlowissue;
			self.securityFreeze := securityFreeze;
			self.securityAlert := securityAlert;
			self.idTheftFlag := idTheftFlag;
			self.disputeFlag := disputeFlag;
			self.negativeAlert := negativeAlert;
			self.rc_decsflag := rc_decsflag;
			self.nap_summary := nap_summary;
			self.nas_summary := nas_summary;
			self.add1_naprop := add1_naprop;
			self.archive_date := archive_date;
			self.fulldate := fulldate;
			self.IALastSaleDate := IALastSaleDate;
			self.secondseendate2 := secondseendate2;
			self.ts_secondseendate2 := ts_secondseendate2;
			self.low_issue_year := low_issue_year;
			self.ts_low_issue_year := ts_low_issue_year;
			self.ialastsaledate2 := ialastsaledate2;
			self.ts_ialastsaledate := ts_ialastsaledate;
			self.EQ_count_WOE := EQ_count_WOE;
			self.ts_secondseendate2_WOE := ts_secondseendate2_WOE;
			self.ts_low_issue_year_WOE := ts_low_issue_year_WOE;
			self.ssns_per_addr_WOE := ssns_per_addr_WOE;
			self.ts_ialastsaledate_WOE := ts_ialastsaledate_WOE;
			self.mobility_indicator_WOE := mobility_indicator_WOE;
			self.score := score;
			self.scr := scr;
			self.APT002_0_0 := APT002_0_0;
			self.PTS_EQ_COUNT := PTS_EQ_COUNT;
			self.PTS_ts_secondseendate2 := PTS_ts_secondseendate2;
			self.PTS_ts_low_issue_year := PTS_ts_low_issue_year;
			self.PTS_ssns_per_addr := PTS_ssns_per_addr;
			self.PTS_ts_ialastsaledate := PTS_ts_ialastsaledate;
			self.PTS_mobility_indicator := PTS_mobility_indicator;
			self.AVG_EQ_count := AVG_EQ_count;
			self.AVG_ts_secondseendate2 := AVG_ts_secondseendate2;
			self.AVG_ts_low_issue_year := AVG_ts_low_issue_year;
			self.AVG_ssns_per_addr := AVG_ssns_per_addr;
			self.AVG_ts_ialastsaledate := AVG_ts_ialastsaledate;
			self.AVG_mobility_indicator := AVG_mobility_indicator;
			self.BST_EQ_count := BST_EQ_count;
			self.BST_ts_secondseendate2 := BST_ts_secondseendate2;
			self.BST_ts_low_issue_year := BST_ts_low_issue_year;
			self.BST_ssns_per_addr := BST_ssns_per_addr;
			self.BST_ts_ialastsaledate := BST_ts_ialastsaledate;
			self.BST_mobility_indicator := BST_mobility_indicator;
			self.DPT_EQ_count := DPT_EQ_count;
			self.DPT_ts_secondseendate2 := DPT_ts_secondseendate2;
			self.DPT_ts_low_issue_year := DPT_ts_low_issue_year;
			self.DPT_ssns_per_addr := DPT_ssns_per_addr;
			self.DPT_ts_ialastsaledate := DPT_ts_ialastsaledate;
			self.DPT_mobility_indicator := DPT_mobility_indicator;
			self.DBEST_EQ_count := DBEST_EQ_count;
			self.DBEST_ts_secondseendate2 := DBEST_ts_secondseendate2;
			self.DBEST_ts_low_issue_year := DBEST_ts_low_issue_year;
			self.DBEST_ssns_per_addr := DBEST_ssns_per_addr;
			self.DBEST_ts_ialastsaledate := DBEST_ts_ialastsaledate;
			self.DBEST_mobility_indicator := DBEST_mobility_indicator;
			self.reason1_pt := reasons[1].point;
			self.reason1_rc := reasons[1].rc;
			self.reason2_pt := reasons[2].point;
			self.reason2_rc := reasons[2].rc;
			self.reason3_pt := reasons[3].point;
			self.reason3_rc := reasons[3].rc;
			self.reason4_pt := reasons[4].point;
			self.reason4_rc := reasons[4].rc;
		#else
			self.seq := le.seq;
			self.score := (string3)APT002_0_0;
			self.ri := project( reasons, transform( risk_indicators.Layout_Desc, self.hri := left.rc, self.desc := risk_indicators.getHRIDesc(left.rc) ));
		#end

	end;
	
	model := project( clam, doModel(left) );
	
	return model;
end;
