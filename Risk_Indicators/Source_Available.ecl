IMPORT VotersV2;
export Source_Available :=
MODULE



	export DL(STRING2 st) :=
							st IN ['MO', 'MN', 'FL', 'OH', 'TX', 'NE', 
										 'ID', 'ME', 'WV', 'MI', 'LA', 'NC', 
										 'MA', 'TN', 'WY', 'KY', 'CT', 'WI'];

	export Emerges(STRING2 st) :=
							st IN ['AK','AR','CO','CT','DC','DE','FL',
										 'HI','LA','MA','MI','NC','NJ','NV','NY',
										 'OH','OK','RI','SC','TX','UT','WI'];

  // for shell version 5.0 and higher, check the lookup key,
	// otherwise use the old hard coded list of valid states	
export VoterSrcSt(STRING2 st, integer bsversion, boolean isFCRA, INTEGER historydate ) := FUNCTION 
		myGetDate := risk_indicators.iid_constants.myGetDate((UNSIGNED) historydate);
		voterKeyInfo := choosen(VotersV2.Key_Voters_States(isFCRA)(keyed(state=st) and date_first_seen[1..6] < myGetDate[1..6]), 1);
		voterInfo := if(bsversion>=50,
			count(voterKeyInfo) > 0,
			emerges(st)
		); 
	return voterInfo ;
	end;

END;