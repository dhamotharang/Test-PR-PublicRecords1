import risk_indicators, ut, easi, RiskWiseFCRA, riskwise;

export IED1002_0_9( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := FUNCTION

Models.Layout_ModelOut doModel( clam le ) := TRANSFORM

		rcs := riskwise.Reasons(le, isCalifornia:=isCalifornia);

		corr := riskwisefcra.corrReasonCodes( le.consumerflags, 4 );
		corr_filtered := corr( hri not in ['00','96'] );

		ri := map(
			exists(corr_filtered) => corr_filtered,
			rcs.rc35 => rcs.makeRC('35'), // CA in-person
			models.common.isRV3Unscorable(le) => rcs.makeRC('19'), // unscorable
			dataset( [], risk_indicators.Layout_Desc )
		);
		
		self.seq := le.seq;
		self.ri := ri;
		self.score := map(
			exists(ri) => '0', // any exceptional cases get a score of 0
			le.estimated_income = 0 => '0',
			le.estimated_income between 1 and 19999 => '19',
			le.estimated_income > 250999 => '251',
			(string)roundup(le.estimated_income/1000)
		);

	END;
	
	results := project(clam, doModel(left));

	return results;
END;