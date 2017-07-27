import ut, riskwise, risk_indicators;

export APF912_0_0( dataset(risk_indicators.layout_boca_shell) clam ) := FUNCTION

	APF_DEBUG := false;
	
	#if(APF_DEBUG)
		layout_debug := record
			risk_indicators.layout_boca_shell clam;
			
			Integer property_owned_purchase_total;
			Integer EQ_count;
			Integer addrs_per_adl;
			Integer dist_a1toa3;
			Integer ssns_per_addr;
			Integer ssns_per_adl;
			String mobility_indicator;
			Integer add2_date_first_seen;
			String rc_ssnlowissue;
			Boolean Bankrupt;
			Boolean securityFreeze;
			Boolean securityAlert;
			Boolean idtheftflag;
			Boolean disputeFlag;
			Boolean negativeAlert;
			String rc_decsflag;
			Integer NAP_Summary;
			Integer NAS_Summary;
			Integer add1_naprop;
			unsigned3 archive_date;
			Integer IADateLastReported;
			Integer CAaddrChooser;
			Integer CADateFirstReported;
			Integer CADateLastReported;
			Integer CALenOfRes;
			Integer fullDate;
			Integer IALastSaleDate;
			String secondseendate2;
			Integer ts_secondseendate2;
			String iadatelastreported2;
			Integer ts_iadatelastreported;
			String low_issue_year;
			Integer ts_low_issue_year;
			String ialastsaledate2;
			Integer ts_ialastsaledate;
			Real PTS_EQ_count;
			Real PTS_propertyownedpurchasetotal;
			Real PTS_addrs_per_adl;
			Real PTS_ts_secondseendate2;
			Real PTS_dist_a1toa3;
			Real PTS_ts_low_issue_year;
			Real PTS_ts_iadatelastreported;
			Real PTS_calenofres;
			Real PTS_ssns_per_addr;
			Real PTS_ssns_per_adl;
			Real PTS_ts_ialastsaledate;
			Real PTS_mobility_indicator;
			Real PTS_bankrupt;
			Real PRLR6;
			real ATTRNC6;
			Integer ATTRPR6;



			real4 AVG_EQ_count;
			real4 AVG_propertyownedpurchasetotal;
			real4 AVG_addrs_per_adl;
			real4 AVG_ts_secondseendate2;
			real4 AVG_dist_a1toa3;
			real4 AVG_ts_low_issue_year;
			real4 AVG_ts_IADateLastReported;
			real4 AVG_CALenOfRes;
			real4 AVG_ssns_per_addr;
			real4 AVG_ssns_per_adl;
			real4 AVG_ts_ialastsaledate;
			real4 AVG_mobility_indicator;
			real4 AVG_Bankrupt;
			real4 BST_EQ_count;
			real4 BST_propertyownedpurchasetotal;
			real4 BST_addrs_per_adl;
			real4 BST_ts_secondseendate2;
			real4 BST_dist_a1toa3;
			real4 BST_ts_low_issue_year;
			real4 BST_ts_IADateLastReported;
			real4 BST_CALenOfRes;
			real4 BST_ssns_per_addr;
			real4 BST_ssns_per_adl;
			real4 BST_ts_ialastsaledate;
			real4 BST_mobility_indicator;
			real4 BST_Bankrupt;
			real4 DPT_EQ_count;
			real4 DPT_propertyownedpurchasetotal;
			real4 DPT_addrs_per_adl;
			real4 DPT_ts_secondseendate2;
			real4 DPT_dist_a1toa3;
			real4 DPT_ts_low_issue_year;
			real4 DPT_ts_iadatelastreported;
			real4 DPT_calenofres;
			real4 DPT_ssns_per_addr;
			real4 DPT_ssns_per_adl;
			real4 DPT_ts_ialastsaledate;
			real4 DPT_mobility_indicator;
			real4 DPT_bankrupt;
			real4 DBEST_EQ_count;
			real4 DBEST_propertyownedpurchasetotal;
			real4 DBEST_addrs_per_adl;
			real4 DBEST_ts_secondseendate2;
			real4 DBEST_dist_a1toa3;
			real4 DBEST_ts_low_issue_year;
			real4 DBEST_ts_iadatelastreported;
			real4 DBEST_calenofres;
			real4 DBEST_ssns_per_addr;
			real4 DBEST_ssns_per_adl;
			real4 DBEST_ts_ialastsaledate;
			real4 DBEST_mobility_indicator;
			real4 DBEST_bankrupt;
			string4 rc1;
			string4 rc2;
			string4 rc3;
			string4 rc4;

		end;
		layout_debug doModel( clam le ) := TRANSFORM
	#else
		layout_modelout doModel( clam le ) := TRANSFORM // probably not the right layout to use
	#end

		/*score produced is called  ATTRNC6, range 212-997*/

		property_owned_purchase_total       :=  le.address_verification.owned.property_owned_purchase_total;
		EQ_count                            :=  le.Source_Verification.eq_count;
		addrs_per_adl                       :=  le.velocity_counters.addrs_per_adl;
		dist_a1toa3                         :=  le.address_verification.distance_in_2_h2;
		ssns_per_addr                       :=  le.velocity_counters.ssns_per_addr;
		ssns_per_adl                        :=  le.velocity_counters.ssns_per_adl;
		mobility_indicator                  :=  le.mobility_indicator;
		add2_date_first_seen                :=  le.address_verification.address_history_1.date_first_seen;
		rc_ssnlowissue                      :=  le.iid.socllowissue;
		bankrupt                            :=  le.bjl.bankrupt;

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
			getPreviousMonth(unsigned histdate) := FUNCTION
				rollBack := trim((string)(histdate)[5..6])='01';
				histYear := if(rollBack, (unsigned)((trim((string)histdate)[1..4]))-1, (unsigned)(trim((string)histdate)[1..4]));
				histMonth := if(rollBack, 12, (unsigned)((trim((string)histdate)[5..6]))-1);
				return (unsigned)(intformat(histYear,4,1) + intformat(histMonth,2,1));
			END;
			checkDate6(unsigned3 foundDate) := if(foundDate >= archive_date, getPreviousMonth(archive_date), foundDate);

			IADateLastReported              := checkDate6(le.address_verification.input_address_information.date_last_seen);
			
			/**********************************************************************************************************/
			CAaddrChooser := map(le.address_verification.input_address_information.isbestmatch => 1, // input is current
												 le.address_verification.address_history_1.isbestmatch => 2, // hist 1 is current
												 le.address_verification.address_history_2.isbestmatch => 3, // hist 2 is current
												 4);	// don't know what the current address is
			CADateFirstReported := map(
				CAaddrChooser=1 => le.address_verification.input_address_information.date_first_seen,
				CAaddrChooser=2 => le.address_verification.address_history_1.date_first_seen,
				CAaddrChooser=3 => le.address_verification.address_history_2.date_first_seen,
				0
			);
			CADateLastReported := checkDate6(map( 
				CAaddrChooser=1 => le.address_verification.input_address_information.date_last_seen,
				CAaddrChooser=2 => le.address_verification.address_history_1.date_last_seen,
				CAaddrChooser=3 => le.address_verification.address_history_2.date_last_seen,
				0)
			);

			CALenOfRes := if(CADateFirstReported <> 0 and CADateLastReported <> 0,
				round( ut.DaysApart((string)CADateFirstReported, (string)CADateLastReported) / 30), 0);
			/**********************************************************************************************************/
			fulldate := (unsigned4)((STRING6)archive_date+'01');

			IALastSaleDate := if(le.address_verification.input_address_information.purchase_date>fullDate, 0,
				le.address_verification.input_address_information.purchase_date);
		/* ATTRIBUTES */



		// secondseendate2 := common.readDate( (string)add2_date_first_seen ); // cleanup the date
		secondseendate2 := if(0=(integer1)add2_date_first_seen[5..6], '', (string)add2_date_first_seen );
		ts_secondseendate2 := if( secondseendate2='', -1, getYears((string)fulldate, secondseendate2));

		// iadatelastreported2 := common.readDate( (string)iadatelastreported );
		iadatelastreported2 := if( 0=(integer1)iadatelastreported[5..6], '', (string)iadatelastreported );
		ts_iadatelastreported := if( iadatelastreported2='', -1, getMonths((string)fulldate,iadatelastreported2) );

		low_issue_year := common.readDate( rc_ssnlowissue );
		ts_low_issue_year := if( low_issue_year='', -1, getYears((string)fulldate, low_issue_year ));

		// ialastsaledate2 := common.readDate( (string)ialastsaledate );
		ialastsaledate2 := if( 0 in [(integer1)ialastsaledate[5..6],(integer1)ialastsaledate[7..8]], '', (string)ialastsaledate );
		ts_ialastsaledate := if( ialastsaledate2='', -1, getMonths((string)fulldate,ialastsaledate2) );



		/***** Assign POINTS ********/
		PTS_EQ_count := map(
			EQ_count< 0  => Common.round(0, .000001),
			EQ_count<= 2 => Common.round(-0.063211437, .000001),
			EQ_count<= 5 => Common.round(-0.032502022, .000001),
			EQ_count<= 9 => Common.round(-0.02262799, .000001),
			EQ_count<=13 => Common.round(0.009580162, .000001),
			EQ_count<=20 => Common.round(0.039613676, .000001),
			Common.round(0.119575703, .000001)
		);

		PTS_propertyownedpurchasetotal := map(
			property_owned_purchase_total<0  => Common.round(0, .000001),
			property_owned_purchase_total=0  => Common.round(0.007862257, .000001),
			property_owned_purchase_total<=106240 => Common.round(-0.089317786, .000001),
			property_owned_purchase_total<=173490 => Common.round(-0.057168476, .000001),
			property_owned_purchase_total<=313000 => Common.round(-0.013941978, .000001),
			property_owned_purchase_total< 1999999998 => Common.round(0.07130144, .000001),
			0
		);

		PTS_addrs_per_adl := map(
			addrs_per_adl<0  => Common.round(0, .000001),
			addrs_per_adl<=1 => Common.round(0.02582372, .000001),
			addrs_per_adl<=3 => Common.round(0.013350376, .000001),
			addrs_per_adl<=7 => Common.round(-0.000353249, .000001),
			addrs_per_adl<=9 => Common.round(-0.009976239, .000001),
			Common.round(-0.025531376, .000001)
		);

		PTS_ts_secondseendate2 := map(
			ts_secondseendate2<0 => Common.round(0, .000001),
			ts_secondseendate2=0 => Common.round(0.052019346, .000001),
			ts_secondseendate2=1 => Common.round(0.034588332, .000001),
			ts_secondseendate2<=4 => Common.round(0.009904374, .000001),
			ts_secondseendate2<=9 => Common.round(-0.00461862, .000001),
			ts_secondseendate2<=16 => Common.round(-0.007543746, .000001),
			Common.round(-0.031663206, .000001)
		);

		PTS_dist_a1toa3 := map(
			dist_a1toa3<0     => Common.round(0, .000001),
			dist_a1toa3<=6    => Common.round(0.023164064, .000001),
			dist_a1toa3<=25   => Common.round(0.059151092, .000001),
			dist_a1toa3<=239  => Common.round(0.023728124, .000001),
			dist_a1toa3<=9998 => Common.round(-0.04437272, .000001),
			0
		);

		PTS_ts_low_issue_year := map(
			ts_low_issue_year<0   => Common.round(0, .000001),
			ts_low_issue_year<=18 => Common.round(0.117153562, .000001),
			ts_low_issue_year<=28 => Common.round(0.038218259, .000001),
			ts_low_issue_year<=40 => Common.round(0.010468594, .000001),
			ts_low_issue_year<=50 => Common.round(-0.031090146, .000001),
			Common.round(-0.12283501, .000001)
		);

		PTS_ts_iadatelastreported := map(
			ts_iadatelastreported<0  => Common.round(0, .000001),
			ts_iadatelastreported<=1 => Common.round(0.002298828, .000001),
			Common.round(-0.099396944, .000001)
		);

		PTS_calenofres := map(
			calenofres<0  => Common.round(0, .000001),
			calenofres=0  => Common.round(-0.00504485, .000001),
			calenofres<=7 => Common.round(-0.0373876, .000001),
			calenofres<=24 => Common.round(-0.01358705, .000001),
			calenofres<=55 => Common.round(0.0013618, .000001),
			calenofres<=98 => Common.round(0.01395845, .000001),
			Common.round(0.0304548, .000001)
			// calenofres<255 => Common.round(0.0304548, .000001),
			// 0.000000
		);

		PTS_ssns_per_addr := map(
			ssns_per_addr<0 => 0,
			ssns_per_addr=0 => Common.round(0.011636526, .000001),
			ssns_per_addr<=2 => Common.round(-0.110411114, .000001),
			ssns_per_addr<=5 => Common.round(-0.028016604, .000001),
			ssns_per_addr<=7 => Common.round(-0.01791185, .000001),
			ssns_per_addr<=9 => Common.round(0.024063644, .000001),
			ssns_per_addr<=15 => Common.round(0.03792371, .000001),
			ssns_per_addr<255 => Common.round(0.060579112, .000001),
			0
		);

		PTS_ssns_per_adl := map(
			ssns_per_adl<0 => Common.round(0, .000001),
			ssns_per_adl=0 => Common.round(-0.051692614, .000001),
			ssns_per_adl=1 => Common.round(-0.00354059, .000001),
			ssns_per_adl=2 => Common.round(0.0156026, .000001),
			Common.round(0.048476078, .000001)
		);

		PTS_ts_ialastsaledate := map(
			ts_ialastsaledate<0   => 0,
			ts_ialastsaledate<=10 => Common.round(0.1351073, .000001),
			ts_ialastsaledate<=49 => Common.round(0.0505988, .000001),
			ts_ialastsaledate<=86 => Common.round(0.0412444, .000001),
			Common.round(0.028196075, .000001)
		);

		PTS_mobility_indicator := map(
			trim(mobility_indicator)      ='' => 0,
			(integer1)mobility_indicator  =0  => Common.round(-0.05771117, .000001),
			(integer1)mobility_indicator  =1  => Common.round(0.056581316, .000001),
			(integer1)mobility_indicator <=3  => Common.round(0.031370064, .000001),
			(integer1)mobility_indicator  =4  => Common.round(-0.001572934, .000001),
			(integer1)mobility_indicator  =5  => Common.round(-0.029154664, .000001),
			Common.round(-0.061743198, .000001)
		);

		PTS_bankrupt := if(not bankrupt, Common.round(-0.004428928, .000001), Common.round(0.059039192, .000001));


		/****** Scoring equation *******/
		PRLR6 := Common.round(exp(       
			-0.5924                        +
			PTS_EQ_count                   +
			PTS_propertyownedpurchasetotal +
			PTS_addrs_per_adl              + 
			PTS_ts_secondseendate2         +
			PTS_dist_a1toa3                +
			PTS_ts_low_issue_year          +
			PTS_ts_iadatelastreporteD      +
			PTS_calenofres                 +
			PTS_ssns_per_addr              +
			PTS_ssns_per_adl               +
			PTS_ts_ialastsaledate          +
			PTS_mobility_indicator         +
			PTS_bankrupt                      ),.0001);

		/***** Rescale raw score *******/
		ATTRNC6 := min(997,max(200,
			map(
			PRLR6<=0.503000000 => round((((808-997)/(0.503000000-0.309500000))*(PRLR6-0.309500000)+997)),
			PRLR6<=0.543400000 => round((((764-807)/(0.543400000-0.503100000))*(PRLR6-0.503100000)+807)),
			PRLR6<=0.573800000 => round((((733-763)/(0.573800000-0.543500000))*(PRLR6-0.543500000)+763)),
			PRLR6<=0.598300000 => round((((705-732)/(0.598300000-0.573900000))*(PRLR6-0.573900000)+732)),
			PRLR6<=0.620200000 => round((((680-704)/(0.620200000-0.598400000))*(PRLR6-0.598400000)+704)),
			PRLR6<=0.641300000 => round((((655-679)/(0.641300000-0.620300000))*(PRLR6-0.620300000)+679)),
			PRLR6<=0.663500000 => round((((628-654)/(0.663500000-0.641400000))*(PRLR6-0.641400000)+654)),
			PRLR6<=0.689900000 => round((((596-627)/(0.689900000-0.663600000))*(PRLR6-0.663600000)+627)),
			PRLR6<=0.728900000 => round((((552-595)/(0.728900000-0.690000000))*(PRLR6-0.690000000)+595)),
			round((((212-551)/(1.139200000-0.729000000))*(PRLR6-0.729000000)+551))
			
			// PRLR6<=0.503000000 =>  -976.7441860465116 *(PRLR6-0.309500000)+997,
			// PRLR6<=0.543400000 => -1066.9975186104218 *(PRLR6-0.503100000)+807,
			// PRLR6<=0.573800000 =>  -990.0990099009903 *(PRLR6-0.543500000)+763,
			// PRLR6<=0.598300000 => -1106.5573770491762 *(PRLR6-0.573900000)+732,
			// PRLR6<=0.620200000 => -1100.917431192664  *(PRLR6-0.598400000)+704,
			// PRLR6<=0.641300000 => -1142.8571428571418 *(PRLR6-0.620300000)+679,
			// PRLR6<=0.663500000 => -1176.4705882352937 *(PRLR6-0.641400000)+654,
			// PRLR6<=0.689900000 => -1178.7072243346013 *(PRLR6-0.663600000)+627,
			// PRLR6<=0.728900000 => -1105.3984575835464 *(PRLR6-0.690000000)+595,
			// -826.4261335933691*(PRLR6-0.729000000)+551
			))
		);


		ATTRPR6 := map(
			securityFreeze    => 101,
			securityAlert     => 102,
			idTheftFlag       => 103,
			disputeFlag       => 104,
			rc_decsflag = '1' => 106, 
			nas_summary <= 4 and nap_summary <= 4 and add1_naprop <= 2 => 999,
			ATTRNC6
		);








		AVG_EQ_count                         := Common.round(-0.000229236320071366, .000001);
		AVG_propertyownedpurchasetotal       := Common.round(-4.19715868444173E-05, .000001);
		AVG_addrs_per_adl                    := Common.round(5.12126640345471E-05, .000001);
		AVG_ts_secondseendate2               := Common.round(0.00473780925510204, .000001);
		AVG_dist_a1toa3                      := Common.round(0.013098425561277, .000001);
		AVG_ts_low_issue_year                := Common.round(0.00506758325141803, .000001);
		AVG_ts_IADateLastReported            := Common.round(-0.00198322417133221, .000001);
		AVG_CALenOfRes                       := Common.round(-5.97545086512882E-05, .000001);
		AVG_ssns_per_addr                    := Common.round(5.11250622429911E-05, .000001);
		AVG_ssns_per_adl                     := Common.round(-7.63222182070551E-06, .000001);
		AVG_ts_ialastsaledate                := Common.round(0.0150950009602105, .000001);
		AVG_mobility_indicator               := Common.round(-4.67470093215433E-05, .000001);
		AVG_Bankrupt                         := Common.round(-2.23532202535985E-05);
											   
		BST_EQ_count                         := Common.round(-0.063211437, .000001);
		BST_propertyownedpurchasetotal       := Common.round(-0.089317786, .000001);
		BST_addrs_per_adl                    := Common.round(-0.025531376, .000001);
		BST_ts_secondseendate2               := Common.round(-0.031663206, .000001);
		BST_dist_a1toa3                      := Common.round(-0.04437272, .000001);
		BST_ts_low_issue_year                := Common.round(-0.12283501, .000001);
		BST_ts_IADateLastReported            := Common.round(-0.099396944, .000001);
		BST_CALenOfRes                       := Common.round(-0.0373876, .000001);
		BST_ssns_per_addr                    := Common.round(-0.110411114, .000001);
		BST_ssns_per_adl                     := Common.round(-0.051692614, .000001);
		BST_ts_ialastsaledate                := Common.round(0, .000001);
		BST_mobility_indicator               := Common.round(-0.061743198, .000001);
		BST_Bankrupt                         := Common.round(-0.004428928, .000001);
		// Note: avg is always > bst


		DPT_EQ_count                      := PTS_EQ_count                   - AVG_EQ_count;
		DPT_propertyownedpurchasetotal    := PTS_propertyownedpurchasetotal - AVG_propertyownedpurchasetotal;
		DPT_addrs_per_adl                 := PTS_addrs_per_adl              - AVG_addrs_per_adl;
		DPT_ts_secondseendate2            := PTS_ts_secondseendate2         - AVG_ts_secondseendate2;
		DPT_dist_a1toa3                   := PTS_dist_a1toa3                - AVG_dist_a1toa3;
		DPT_ts_low_issue_year             := PTS_ts_low_issue_year          - AVG_ts_low_issue_year;
		DPT_ts_iadatelastreported         := PTS_ts_iadatelastreported      - AVG_ts_iadatelastreported;
		DPT_calenofres                    := PTS_calenofres                 - AVG_calenofres;
		DPT_ssns_per_addr                 := PTS_ssns_per_addr              - AVG_ssns_per_addr;
		DPT_ssns_per_adl                  := PTS_ssns_per_adl               - AVG_ssns_per_adl;
		DPT_ts_ialastsaledate             := PTS_ts_ialastsaledate          - AVG_ts_ialastsaledate;
		DPT_mobility_indicator            := PTS_mobility_indicator         - AVG_mobility_indicator;
		DPT_bankrupt                      := PTS_bankrupt                   - AVG_bankrupt;

		DBEST_EQ_count                    := PTS_EQ_count                   - BST_EQ_count;
		DBEST_propertyownedpurchasetotal  := PTS_propertyownedpurchasetotal - BST_propertyownedpurchasetotal;
		DBEST_addrs_per_adl               := PTS_addrs_per_adl              - BST_addrs_per_adl;
		DBEST_ts_secondseendate2          := PTS_ts_secondseendate2         - BST_ts_secondseendate2;
		DBEST_dist_a1toa3                 := PTS_dist_a1toa3                - BST_dist_a1toa3;
		DBEST_ts_low_issue_year           := PTS_ts_low_issue_year          - BST_ts_low_issue_year;
		DBEST_ts_iadatelastreported       := PTS_ts_iadatelastreported      - BST_ts_iadatelastreported;
		DBEST_calenofres                  := PTS_calenofres                 - BST_calenofres;
		DBEST_ssns_per_addr               := PTS_ssns_per_addr              - BST_ssns_per_addr;
		DBEST_ssns_per_adl                := PTS_ssns_per_adl               - BST_ssns_per_adl;
		DBEST_ts_ialastsaledate           := PTS_ts_ialastsaledate          - BST_ts_ialastsaledate;
		DBEST_mobility_indicator          := PTS_mobility_indicator         - BST_mobility_indicator;
		DBEST_bankrupt                    := PTS_bankrupt                   - BST_bankrupt;

		


		/*
		Per Tiana Pan:
		1. If PTS1=Best1, PTS2=BEST2, ….,PTS9=BEST9  then no reason codes should be generated.
		2. If PTS1>Avg1, PTS2>Avg2, ……PTS9>Avg9, then generate 1 reason code (take the worse attribute)
		3. Everything else can take as many as 4 reason codes.
		*/
		rclayout := {real point, string4 rc};
		
		allReasons := dataset( [
			{DPT_EQ_count                  , '0001'},
			{DPT_propertyownedpurchasetotal, '0002'},
			{DPT_addrs_per_adl             , '0003'},
			{DPT_ts_secondseendate2        , if(ts_secondseendate2=-1, '004A', '004B') },
			{DPT_dist_a1toa3               , if(dist_a1toa3 = 9999, '050A', '050B') },
			{DPT_ts_low_issue_year         , if(ts_low_issue_year=-1, '006A', '006B') },
			{DPT_ts_iadatelastreported     , if(ts_iadatelastreported=-1, '049A', '049B') },
			{DPT_calenofres                , '0049'},
			{DPT_ssns_per_addr             , if(ssns_per_addr in [0,255], '0009', '0021') },
			{DPT_ssns_per_adl              , '0055'},
			{DPT_ts_ialastsaledate         , if(ts_ialastsaledate=-1, 'A05A', 'A05B') },
			{DPT_mobility_indicator        , '0050'},
			{DPT_bankrupt                  , '0013'}
			], rclayout );
		bestReasons := dataset( [
			{DBEST_EQ_count                  , '0001'},
			{DBEST_propertyownedpurchasetotal, '0002'},
			{DBEST_addrs_per_adl             , '0003'},
			{DBEST_ts_secondseendate2        , if(ts_secondseendate2=-1, '004A', '004B') },
			{DBEST_dist_a1toa3               , if(dist_a1toa3 = 9999, '050A', '050B') },
			{DBEST_ts_low_issue_year         , if(ts_low_issue_year=-1, '006A', '006B') },
			{DBEST_ts_iadatelastreported     , if(ts_iadatelastreported=-1, '049A', '049B') },
			{DBEST_calenofres                , '0049'},
			{DBEST_ssns_per_addr             , if(ssns_per_addr in [0,255], '0009', '0021') },
			{DBEST_ssns_per_adl              , '0055'},
			{DBEST_ts_ialastsaledate         , if(ts_ialastsaledate=-1, 'A05A', 'A05B') },
			{DBEST_mobility_indicator        , '0050'},
			{DBEST_bankrupt                  , '0013'}
			], rclayout );
		

		reasons := map(
			ATTRPR6 = 101 => dataset( [{0, 'E091'}], rcLayout ),
			ATTRPR6 = 102 => dataset( [{0, 'E092'}], rcLayout ),
			ATTRPR6 = 103 => dataset( [{0, 'E093'}], rcLayout ),
			ATTRPR6 = 104 => dataset( [{0, 'E094'}], rcLayout ),
			ATTRPR6 = 106 => dataset( [{0, 'E002'}], rcLayout ),
			ATTRPR6 = 999 => dataset( [{0, 'E019'}], rcLayout ),
			ATTRPR6 = 997 => dataset( [], rcLayout ),
			
			EXISTS( allReasons(point>0) ) => CHOOSEN(SORT(allReasons(point>0), -point), 4 ),
			CHOOSEN( SORT(bestReasons(point>0), -point), 1 )
		);

		#if(apf_debug)
			self.property_owned_purchase_total := property_owned_purchase_total;
			self.EQ_count := EQ_count;
			self.addrs_per_adl := addrs_per_adl;
			self.dist_a1toa3 := dist_a1toa3;
			self.ssns_per_addr := ssns_per_addr;
			self.ssns_per_adl := ssns_per_adl;
			self.mobility_indicator := mobility_indicator;
			self.add2_date_first_seen := add2_date_first_seen;
			self.rc_ssnlowissue := rc_ssnlowissue;
			self.bankrupt := bankrupt;
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
			self.IADateLastReported := IADateLastReported;
			self.CAaddrChooser := CAaddrChooser;
			self.CADateFirstReported := CADateFirstReported;
			self.CADateLastReported := CADateLastReported;
			self.CALenOfRes := CALenOfRes;
			self.fulldate := fulldate;
			self.IALastSaleDate := IALastSaleDate;
			self.secondseendate2 := secondseendate2;
			self.ts_secondseendate2 := ts_secondseendate2;
			self.iadatelastreported2 := iadatelastreported2;
			self.ts_iadatelastreported := ts_iadatelastreported;
			self.low_issue_year := low_issue_year;
			self.ts_low_issue_year := ts_low_issue_year;
			self.ialastsaledate2 := ialastsaledate2;
			self.ts_ialastsaledate := ts_ialastsaledate;
			self.PTS_EQ_count := PTS_EQ_count;
			self.PTS_propertyownedpurchasetotal := PTS_propertyownedpurchasetotal;
			self.PTS_addrs_per_adl := PTS_addrs_per_adl;
			self.PTS_ts_secondseendate2 := PTS_ts_secondseendate2;
			self.PTS_dist_a1toa3 := PTS_dist_a1toa3;
			self.PTS_ts_low_issue_year := PTS_ts_low_issue_year;
			self.PTS_ts_iadatelastreported := PTS_ts_iadatelastreported;
			self.PTS_calenofres := PTS_calenofres;
			self.PTS_ssns_per_addr := PTS_ssns_per_addr;
			self.PTS_ssns_per_adl := PTS_ssns_per_adl;
			self.PTS_ts_ialastsaledate := PTS_ts_ialastsaledate;
			self.PTS_mobility_indicator := PTS_mobility_indicator;
			self.PTS_bankrupt := PTS_bankrupt;
			self.PRLR6 := PRLR6;
			self.ATTRNC6 := ATTRNC6;
			self.ATTRPR6 := ATTRPR6;

			self.AVG_EQ_count := AVG_EQ_count;
			self.AVG_propertyownedpurchasetotal := AVG_propertyownedpurchasetotal;
			self.AVG_addrs_per_adl := AVG_addrs_per_adl;
			self.AVG_ts_secondseendate2 := AVG_ts_secondseendate2;
			self.AVG_dist_a1toa3 := AVG_dist_a1toa3;
			self.AVG_ts_low_issue_year := AVG_ts_low_issue_year;
			self.AVG_ts_IADateLastReported := AVG_ts_IADateLastReported;
			self.AVG_CALenOfRes := AVG_CALenOfRes;
			self.AVG_ssns_per_addr := AVG_ssns_per_addr;
			self.AVG_ssns_per_adl := AVG_ssns_per_adl;
			self.AVG_ts_ialastsaledate := AVG_ts_ialastsaledate;
			self.AVG_mobility_indicator := AVG_mobility_indicator;
			self.AVG_Bankrupt := AVG_Bankrupt;

			self.BST_EQ_count := BST_EQ_count;
			self.BST_propertyownedpurchasetotal := BST_propertyownedpurchasetotal;
			self.BST_addrs_per_adl := BST_addrs_per_adl;
			self.BST_ts_secondseendate2 := BST_ts_secondseendate2;
			self.BST_dist_a1toa3 := BST_dist_a1toa3;
			self.BST_ts_low_issue_year := BST_ts_low_issue_year;
			self.BST_ts_IADateLastReported := BST_ts_IADateLastReported;
			self.BST_CALenOfRes := BST_CALenOfRes;
			self.BST_ssns_per_addr := BST_ssns_per_addr;
			self.BST_ssns_per_adl := BST_ssns_per_adl;
			self.BST_ts_ialastsaledate := BST_ts_ialastsaledate;
			self.BST_mobility_indicator := BST_mobility_indicator;
			self.BST_Bankrupt := BST_Bankrupt;

			self.DPT_EQ_count := DPT_EQ_count;
			self.DPT_propertyownedpurchasetotal := DPT_propertyownedpurchasetotal;
			self.DPT_addrs_per_adl := DPT_addrs_per_adl;
			self.DPT_ts_secondseendate2 := DPT_ts_secondseendate2;
			self.DPT_dist_a1toa3 := DPT_dist_a1toa3;
			self.DPT_ts_low_issue_year := DPT_ts_low_issue_year;
			self.DPT_ts_iadatelastreported := DPT_ts_iadatelastreported;
			self.DPT_calenofres := DPT_calenofres;
			self.DPT_ssns_per_addr := DPT_ssns_per_addr;
			self.DPT_ssns_per_adl := DPT_ssns_per_adl;
			self.DPT_ts_ialastsaledate := DPT_ts_ialastsaledate;
			self.DPT_mobility_indicator := DPT_mobility_indicator;
			self.DPT_bankrupt := DPT_bankrupt;

			self.DBEST_EQ_count := DBEST_EQ_count;
			self.DBEST_propertyownedpurchasetotal := DBEST_propertyownedpurchasetotal;
			self.DBEST_addrs_per_adl := DBEST_addrs_per_adl;
			self.DBEST_ts_secondseendate2 := DBEST_ts_secondseendate2;
			self.DBEST_dist_a1toa3 := DBEST_dist_a1toa3;
			self.DBEST_ts_low_issue_year := DBEST_ts_low_issue_year;
			self.DBEST_ts_iadatelastreported := DBEST_ts_iadatelastreported;
			self.DBEST_calenofres := DBEST_calenofres;
			self.DBEST_ssns_per_addr := DBEST_ssns_per_addr;
			self.DBEST_ssns_per_adl := DBEST_ssns_per_adl;
			self.DBEST_ts_ialastsaledate := DBEST_ts_ialastsaledate;
			self.DBEST_mobility_indicator := DBEST_mobility_indicator;
			self.DBEST_bankrupt := DBEST_bankrupt;

			self.rc1 := reasons[1].rc;
			self.rc2 := reasons[2].rc;
			self.rc3 := reasons[3].rc;
			self.rc4 := reasons[4].rc;
			
			self.clam := le;
		#else
			self.ri := project( reasons, transform( Risk_Indicators.Layout_Desc,
				self.hri  := left.rc,
				self.desc := risk_indicators.getHRIDesc(left.rc)
			));
			self.score := (string3)ATTRPR6;
			self.seq := le.seq;
		#end
		// self := [];
	end;
	
	model := project( clam, doModel(left) );
	
	return model;
end;