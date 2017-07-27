import risk_indicators;

/* Given two reason code sets, get four RCs as fairly as possible */
export getFourReasons( dataset(risk_indicators.Layout_Desc) bus, dataset(risk_indicators.Layout_Desc) con ) := FUNCTION

	// how many non-zero business and consumer reason codes
	cntBus := COUNT( bus( hri != '00' ) );
	cntCon := COUNT( con( hri != '00' ) );

	combined := map(
		cntBus >= 2 and cntCon >= 2 => CHOOSEN( bus, 2 ) + CHOOSEN( con, 2 ),		// two from each set
		cntBus > 2  and cntCon =  1 => CHOOSEN( bus, 3 ) + CHOOSEN( con, 1 ),		// the first three bus and the one consumer RC 
		cntBus > 3  and cntCon =  0 => CHOOSEN( bus, 4 ),							// all bus RCs
		cntBus = 1  and cntCon >  2 => CHOOSEN( bus, 1 ) + CHOOSEN( con, 3 ),		// one bus and the rest consumer
		cntBus = 0  and cntCon >  3 => CHOOSEN( con, 4 ),							// all consumer
		CHOOSEN( 
			bus( hri != '00' ) + con( hri != '00' ) + DATASET( [{'00',''},{'00',''},{'00',''},{'00',''}], risk_indicators.Layout_Desc),
			4
		) // fallback with a combination of everything we've got, padded with blank records, limited to four
	);

	return combined;
END;