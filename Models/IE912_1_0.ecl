import risk_indicators, ut, easi, riskwise, riskwisefcra;

export IE912_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia ) := FUNCTION

	// this model is basically a scaled version of IE912_0_0
	Models.Layout_ModelOut doModel( clam le ) := TRANSFORM

		rcs := riskwise.Reasons(le, isCalifornia:=isCalifornia);
		// corr :=
			  // if( rcs.rc91, rcs.makeRC('91') )
			// + if( rcs.rc92, rcs.makeRC('92') )
			// + if( rcs.rc93, rcs.makeRC('93') )
			// + if( rcs.rc94, rcs.makeRC('94') )
		// ;
		// inexplicably, the above code doesn't work
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
			le.estimated_income = 19999 => '19',
			le.estimated_income = 250999 => '251',
			(string)roundup(le.estimated_income/1000)
		);

	END;
	
	results := project(clam, doModel(left));

	return results;
END;