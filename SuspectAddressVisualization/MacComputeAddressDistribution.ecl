EXPORT MacComputeAddressDistribution(AddressScoreData, StateField, ScoreRangeGroupField, RangeAddressCountField) := FUNCTIONMACRO
  AddressScoreDataSorted := sort(AddressScoreData, addresskey);
  AddressScoreDataDedupped := dedup(AddressScoreDataSorted, addresskey);
  
  originalLayout := record
    string2 state;
    integer1 scorerangegroup;
	end;
  original := project(AddressScoreDataDedupped, transform(originalLayout,
    SELF.state := LEFT.StateField;
    SELF.scorerangegroup := LEFT.ScoreRangeGroupField;
  ));

  recountLayout := record
    string2 state := original.state;
    integer1 scorerangegroup := original.scorerangegroup;
    integer8 rangeaddresscount := count(GROUP);
  end;
	recount := table(original(scorerangegroup in [1, 2, 3, 4, 5]), recountLayout, state, scorerangegroup);

  stateLayout := record
	  string2 state;
		integer8 stateaddresscount := 0;
  end;
  states := dataset([
	  {'AK', 0},
	  {'AL', 0},
	  {'AZ', 0},
	  {'AR', 0},
	  {'CA', 0},
	  {'CO', 0},
	  {'CT', 0},
	  {'DE', 0},
	  {'FL', 0},
	  {'GA', 0},
	  {'HI', 0},
	  {'ID', 0},
	  {'IL', 0},
	  {'IN', 0},
	  {'IA', 0},
	  {'KS', 0},
	  {'KY', 0},
	  {'LA', 0},
	  {'ME', 0},
	  {'MD', 0},
	  {'MA', 0},
	  {'MI', 0},
	  {'MN', 0},
	  {'MS', 0},
	  {'MO', 0},
	  {'MT', 0},
	  {'NE', 0},
	  {'NV', 0},
	  {'NH', 0},
	  {'NJ', 0},
	  {'NM', 0},
	  {'NY', 0},
	  {'NC', 0},
	  {'ND', 0},
	  {'OH', 0},
	  {'OK', 0},
	  {'OR', 0},
	  {'PA', 0},
	  {'RI', 0},
	  {'SC', 0},
	  {'SD', 0},
	  {'TN', 0},
	  {'TX', 0},
	  {'UT', 0},
	  {'VT', 0},
	  {'VA', 0},
	  {'WA', 0},
	  {'WV', 0},
	  {'WI', 0},
	  {'WY', 0}
  ], stateLayout);

  rangeLayout := record
	  string8 addressscorerange;
	  integer1 addressscorerangegroup;
  end;
  ranges := dataset([
	  {'81 - 100', 1},
	  {'61 - 80', 2},
	  {'41 - 60', 3},
	  {'21 - 40', 4},
	  {'1  - 20', 5}
  ], rangeLayout);

  stateRangeLayout := record
	  stateLayout;
	  rangeLayout;
  end;
  stateRangeTemplate := join(states, ranges, TRUE, ALL);

  stateDistributeLayout := record
	  recount.state;
	  integer8 stateaddresscount := sum(GROUP, recount.rangeaddresscount);
  end;
  stateDistribute := table(recount, stateDistributeLayout, state);

  allStateDistribute := join(stateRangeTemplate, stateDistribute, LEFT.state = RIGHT.StateField, 
	  transform(stateRangeLayout,
		  SELF.stateaddresscount := RIGHT.stateaddresscount;
			SELF := LEFT;
	  ), 
		LEFT OUTER, 
	  HASH
	);

  allDistributeLayout := record
	  string2 state;
	  integer8 stateaddresscount;
	  string8 addressscorerange;
	  integer1 addressscorerangegroup;
	  integer8 rangeaddresscount := 0;
  end;
  allDistribute := join(allStateDistribute, recount, LEFT.state = RIGHT.state and LEFT.addressscorerangegroup = RIGHT.scorerangegroup, 
 	  transform(allDistributeLayout,
	    SELF.rangeaddresscount := RIGHT.rangeaddresscount;
	    SELF := LEFT;
		), 
	  LEFT OUTER, 
	  HASH
  );

  return allDistribute;
ENDMACRO;