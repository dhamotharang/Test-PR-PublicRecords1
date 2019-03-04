IMPORT Business_Risk_BIP, BusinessInstantID20_Services;

EXPORT mod_CalculateRiskIndicators( Business_Risk_BIP.Layouts.Shell le, STRING2 bvi = '0', STRING4 bvi_desc_key = '0', BOOLEAN useSBFE = FALSE ) :=
	MODULE

	// This function was created for Business InstantID 2.0 to accomodate the new method of producing
	// reason codes.  Each reason code has an overall 'priority' which is used to help determine 
	// which reason codes are returned.  This function is used to look up the priority.

	// Suppress Risk Indicators and descriptions if there has been a no-hit. The system must return a 
	// no-hit response.
	SHARED is_noHit := bvi IN Business_Risk_BIP.Constants.BVI_NOHIT_VALUES OR 
			bvi_desc_key IN Business_Risk_BIP.Constants.BVI_DESC_KEY_NOHIT_VALUES;
		
	SHARED isSuppressable(STRING4 HRIcode) := is_noHit AND 
			HRIcode IN Business_Risk_BIP.Constants.SUPPRESSABLE_RISK_CODES;

	SHARED ds_HRICodes := 
		DATASET(	
			[
				{'10'}, {'11'}, {'12'}, {'13'}, {'14'}, {'15'}, {'16'}, {'17'}, {'18'}, {'19'}, 
				{'20'}, {'21'}, {'22'}, {'23'}, {'24'}, {'25'}, {'26'}, {'27'}, {'28'}, {'29'}, 
				{'30'}, {'31'}, {'32'}, {'33'}, {'34'}, {'35'}, {'36'}, {'37'}, {'38'}, {'39'}, 
				{'40'}, {'41'}, {'42'}, {'43'}, {'44'}, {'45'}, {'46'}, {'47'}, {'48'}, {'49'}, 
				{'50'}, {'51'}, {'52'}, {'53'}, {'54'}
			], { STRING2 HRIcode }
		);

	SHARED getHRIPriority(STRING4 rc) := 
		CASE(TRIM(rc),	
			'10' =>  1, '11' =>  2, '12' =>  3, '13' =>  4, '14' =>  5, '15' =>  6, '16' =>  7, '17' =>  8, '18' =>  9, '19' => 10, 
			'20' => 11, '21' => 12, '22' => 13, '23' => 14, '24' => 15, '25' => 16, '26' => 17, '27' => 18, '28' => 19, '29' => 20, 
			'30' => 21, '31' => 22, '32' => 23, '33' => 24, '34' => 25, '35' => 26, '36' => 27, '37' => 28, '38' => 29, '39' => 30, 
			'40' => 31, '41' => 32, '42' => 33, '43' => 34, '44' => 35, '45' => 36, '46' => 37, '47' => 38, '48' => 39, '49' => 40, 
			'50' => 41, '51' => 42, '52' => 43, '53' => 44, '54' => 45, /* default => */ 99);

	SHARED getWaterfallGroup(STRING4 rc) := 
		CASE(TRIM(rc),	
			'10' => 'D', '11' => 'D', '12' => 'A', '13' => 'A', '14' => 'A', '15' => 'A', '16' => 'D', '17' => 'D', '18' => 'D', '19' => 'D', 
			'20' => 'D', '21' => 'D', '22' => 'D', '23' => 'C', '24' => 'C', '25' => 'D', '26' => 'D', '27' => 'D', '28' => 'D', '29' => 'D', 
			'30' => 'D', '31' => 'D', '32' => 'D', '33' => 'D', '34' => 'D', '35' => 'D', '36' => 'D', '37' => 'D', '38' => 'B', '39' => 'B', 
			'40' => 'B', '41' => 'D', '42' => 'D', '43' => 'D', '44' => 'D', '45' => 'D', '46' => 'D', '47' => 'D', '48' => 'D', '49' => 'D', 
			'50' => 'D', '51' => 'D', '52' => 'D', '53' => 'D',' 54' => 'D', /* default => */ 'D');

	EXPORT getHRIDescription(STRING4 rc) := 
		CASE(TRIM(rc),	
			'10' => 'The input business name matches OFAC file',
			'11' => 'The input business name matches non-OFAC global watchlist(s)',
			'12' => 'Bankruptcy on record suggests the business may be defunct',
			'13' => 'Business not in good standing according to Secretary of State',
			'14' => 'Business inactive according to Secretary of State',
			'15' => 'Business is not registered at Secretary of State of input business state',
			'16' => 'The input business TIN is associated with a different business name and address',
			'17' => 'Unable to verify business name, address, TIN and phone on business records',
			'18' => 'Unable to verify business name on business records, but alternate business name found in business records',
			'19' => 'Unable to verify business name on business records',
			'20' => 'Unable to verify business address on business records',
			'21' => 'Unable to verify business TIN on business records',
			'22' => 'Unable to verify business phone number on business records',
			'23' => 'Business first reported in last 12 months',
			'24' => 'Business first reported in last 24 months',
			'25' => 'The input business address may be a previous address',
			'26' => 'Address mismatch between the input business city/state and zip code',
			'27' => 'The input business address is a vacant address',
			'28' => 'The input business phone number may be disconnected',
			'29' => 'The input phone number is associated with a different name and address',
			'30' => 'The input business may be associated with a post office box',
			'31' => 'The input business phone number is a mobile number',
			'32' => 'The input business zip code has a prison within the zip code area',
			'33' => 'The input business zip code is a military only zip code',
			'34' => 'The input business address may be a residential address (single family dwelling)',
			'35' => 'The input business phone number may be associated with a residential listing',
			'36' => 'The input business phone number and business address on record are geographically distant (> 10 miles)',
			'37' => 'The input business TIN is not found',
			'38' => 'No updates to business record in the past 36 months',
			'39' => 'No updates to business record in the past 24 months',
			'40' => 'No updates to business record in the past 12 months',
			'41' => 'Business operates or has operated at multiple locations ',
			'42' => 'Business has been banned from doing business with the government',
			'43' => 'The input business address may be invalid according to postal specifications',
			'44' => 'The input business phone number is potentially invalid',
			'45' => 'The input business TIN is potentially invalid',
			'46' => 'The input business name matches the input alternate business name',
			'47' => 'The input business name may have been miskeyed',
			'48' => 'The input business address may have been miskeyed',
			'49' => 'The input business phone number may have been miskeyed',
			'50' => 'The input business TIN may have been miskeyed',
			'51' => 'The input business name was missing',
			'52' => 'The input business address was missing',
			'53' => 'The input business phone was missing or incomplete',
			'54' => 'The input business TIN was missing or incomplete',
							'');
						
			SHARED mod_rcSet := Business_Risk_BIP.rcSet( le, useSBFE, bvi_desc_key );

			SHARED BOOLEAN getWhetherRiskIndicator(STRING4 rc) := 
				NOT isSuppressable(rc) AND 
				CASE( TRIM(rc), 
					'10' => mod_rcSet.isCode10,
					'11' => mod_rcSet.isCode11,
					'12' => mod_rcSet.isCode12,
					'13' => mod_rcSet.isCode13,
					'14' => mod_rcSet.isCode14,
					'15' => mod_rcSet.isCode15,
					'16' => mod_rcSet.isCode16,
					'17' => mod_rcSet.isCode17,
					'18' => mod_rcSet.isCode18,
					'19' => mod_rcSet.isCode19,
					'20' => mod_rcSet.isCode20,
					'21' => mod_rcSet.isCode21,
					'22' => mod_rcSet.isCode22,
					'23' => mod_rcSet.isCode23,
					'24' => mod_rcSet.isCode24,
					'25' => mod_rcSet.isCode25,
					'26' => mod_rcSet.isCode26,
					'27' => mod_rcSet.isCode27,
					'28' => mod_rcSet.isCode28,
					'29' => mod_rcSet.isCode29,
					'30' => mod_rcSet.isCode30,
					'31' => mod_rcSet.isCode31,
					'32' => mod_rcSet.isCode32,
					'33' => mod_rcSet.isCode33,
					'34' => mod_rcSet.isCode34,
					'35' => mod_rcSet.isCode35,
					'36' => mod_rcSet.isCode36,
					'37' => mod_rcSet.isCode37,
					'38' => mod_rcSet.isCode38,
					'39' => mod_rcSet.isCode39,
					'40' => mod_rcSet.isCode40,
					'41' => mod_rcSet.isCode41,
					'42' => mod_rcSet.isCode42,
					'43' => mod_rcSet.isCode43,
					'44' => mod_rcSet.isCode44,
					'45' => mod_rcSet.isCode45,
					'46' => mod_rcSet.isCode46,
					'47' => mod_rcSet.isCode47,
					'48' => mod_rcSet.isCode48,
					'49' => mod_rcSet.isCode49,
					'50' => mod_rcSet.isCode50,
					'51' => mod_rcSet.isCode51,
					'52' => mod_rcSet.isCode52,
					'53' => mod_rcSet.isCode53,
					'54' => mod_rcSet.isCode54,
					        FALSE
				);
				
			// For Business InstantID 2.0, reason codes are categorized into 4 groups which were 
			// set by the Modeling team.
			SHARED layout_RiskIndicators_temp := RECORD
				STRING2 risk_indicator_code;
				BOOLEAN is_risk_indicator;
				STRING1 waterfall_group;
				UNSIGNED1 risk_indicator_priority;
				STRING110 risk_indicator_desc; 
			END;
			
			SHARED ds_RiskIndicators := 
				PROJECT(
					ds_HRICodes,
					TRANSFORM( layout_RiskIndicators_temp,
						SELF.risk_indicator_code     := LEFT.HRIcode;
						SELF.is_risk_indicator       := getWhetherRiskIndicator(LEFT.HRIcode);
						SELF.waterfall_group         := getWaterfallGroup(LEFT.HRIcode);
						SELF.risk_indicator_priority := getHRIPriority(LEFT.HRIcode);
						SELF.risk_indicator_desc     := getHRIDescription(LEFT.HRIcode);						
					)
				);
			
			SHARED ds_TrueRiskIndicators := ds_RiskIndicators(is_risk_indicator = TRUE);
			
			SHARED ds_TrueRiskIndicatorsGroupA := ds_TrueRiskIndicators(waterfall_group = 'A');
			SHARED ds_TrueRiskIndicatorsGroupB := ds_TrueRiskIndicators(waterfall_group = 'B');
			SHARED ds_TrueRiskIndicatorsGroupC := ds_TrueRiskIndicators(waterfall_group = 'C');
			SHARED ds_TrueRiskIndicatorsGroupD := ds_TrueRiskIndicators(waterfall_group = 'D');
			
			SHARED ds_TopRiskIndicatorsGroupA := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupA,risk_indicator_priority),1);
			SHARED ds_TopRiskIndicatorsGroupB := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupB,risk_indicator_priority),1);
			SHARED ds_TopRiskIndicatorsGroupC := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupC,risk_indicator_priority),1);
			SHARED ds_TopRiskIndicatorsGroupD := CHOOSEN(SORT(ds_TrueRiskIndicatorsGroupD,risk_indicator_priority),34);

			SHARED ds_TopRiskIndicatorsEmpty := 
				DATASET(
					[
						{'00',FALSE,'E',99,''},{'00',FALSE,'E',99,''},{'00',FALSE,'E',99,''},{'00',FALSE,'E',99,''},
						{'00',FALSE,'E',99,''},{'00',FALSE,'E',99,''},{'00',FALSE,'E',99,''},{'00',FALSE,'E',99,''}
					], 
					layout_RiskIndicators_temp
				);
	
			SHARED ds_TopRiskIndicators := 
				SORT( 
					(ds_TopRiskIndicatorsGroupA + ds_TopRiskIndicatorsGroupB + ds_TopRiskIndicatorsGroupC + ds_TopRiskIndicatorsGroupD + ds_TopRiskIndicatorsEmpty), 
					risk_indicator_priority
				);

			EXPORT rw_Risk_Indicators :=
				ROW(
					{
						le.Seq,
						ds_TopRiskIndicators[1].risk_indicator_code,
						ds_TopRiskIndicators[1].risk_indicator_desc,
						ds_TopRiskIndicators[2].risk_indicator_code,
						ds_TopRiskIndicators[2].risk_indicator_desc,
						ds_TopRiskIndicators[3].risk_indicator_code,
						ds_TopRiskIndicators[3].risk_indicator_desc,
						ds_TopRiskIndicators[4].risk_indicator_code,
						ds_TopRiskIndicators[4].risk_indicator_desc,
						ds_TopRiskIndicators[5].risk_indicator_code,
						ds_TopRiskIndicators[5].risk_indicator_desc,
						ds_TopRiskIndicators[6].risk_indicator_code,
						ds_TopRiskIndicators[6].risk_indicator_desc,
						ds_TopRiskIndicators[7].risk_indicator_code,
						ds_TopRiskIndicators[7].risk_indicator_desc,
						ds_TopRiskIndicators[8].risk_indicator_code,
						ds_TopRiskIndicators[8].risk_indicator_desc
					},
					BusinessInstantID20_Services.Layouts.RiskIndicatorLayout
				);
			
		END;
		