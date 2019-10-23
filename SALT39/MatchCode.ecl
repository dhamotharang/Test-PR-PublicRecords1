EXPORT MatchCode := MODULE
  SHARED Code_Base         := 0;
  EXPORT OneComponentNull := Code_Base + 0;
	EXPORT OneSideNull := Code_Base + 1;
	EXPORT InitialMatch := Code_Base + 2;
	EXPORT HyphenMatch := Code_Base + 3;
	EXPORT EditdistanceMatch := Code_Base + 4;
	EXPORT WordbagMatch := Code_Base + 5;
	EXPORT CustomFuzzyMatch := Code_Base + 6;
	EXPORT ExactMatch := Code_Base + 7;	
	EXPORT YearMatch := Code_Base + 8;
	EXPORT MonthDaySwitch := Code_Base + 9;	
	EXPORT SoftMatch := Code_Base + 10;	
	EXPORT ContextInvolved := Code_Base + 11;	
	EXPORT ParentInvolved := Code_Base + 12;		
	EXPORT PhoneticMatch := Code_Base + 13;	
	EXPORT WithinDaysMatch := Code_Base + 14;	
	EXPORT DateAggregate := Code_Base + 15;	
	EXPORT Overlap := Code_Base + 16;	
	EXPORT WildMatch := Code_Base + 17;
	EXPORT LatLongDistanceMatch := Code_Base + 18;
	EXPORT RangeMatch := Code_Base +19;
	EXPORT OutsideRangeFieldMatch := Code_Base + 20;
	EXPORT WithinRangeFieldMatch := Code_Base + 21;
	EXPORT ContextNoMatch := Code_Base + 96;
	EXPORT GenerationNoMatch := Code_Base + 97;	
	EXPORT ForcedNoMatch := Code_Base + 98;	
	EXPORT NoMatch := Code_Base + 99;
	EXPORT Expand(UNSIGNED code) := CASE(code,OneComponentNull=>'',OneSideNull=>'',InitialMatch=>'IN',HyphenMatch=>'HY',EditdistanceMatch=>'FZ',WordbagMatch=>'WB',CustomFuzzyMatch=>'CF',
	ExactMatch=>'EX',YearMatch=>'YR',MonthDaySwitch=>'MD',SoftMatch=>'SF',ContextInvolved=>'CX',ParentInvolved=>'PI',
	PhoneticMatch=>'PH',WithinDaysMatch=>'WD',DateAggregate=>'DA',Overlap=>'OV',WildMatch=>'WM',LatLongDistanceMatch=>'LL', 
	RangeMatch=>'RM',OutsideRangeFieldMatch=>'OR',WithinRangeFieldMatch=>'WR',GenerationNoMatch=>'GN',ForcedNoMatch=>'FN',NoMatch=>'NM','XX');
		
	//Function to map match codes to Header Search Codes
	EXPORT GroupHeaderSearchCodes(UNSIGNED code) := CASE(code, ContextNoMatch => HeaderSearchMatchCode.NoMatch, GenerationNoMatch => HeaderSearchMatchCode.NoMatch, 
	ForcedNoMatch => HeaderSearchMatchCode.NoMatch, NoMatch => HeaderSearchMatchCode.NoMatch, ContextInvolved => HeaderSearchMatchCode.NoMatch, 
	ParentInvolved => HeaderSearchMatchCode.NoMatch, ExactMatch => HeaderSearchMatchCode.Match, Overlap => HeaderSearchMatchCode.Match, 
	RangeMatch => HeaderSearchMatchCode.Match, LatLongDistanceMatch => HeaderSearchMatchCode.Match, OutsideRangeFieldMatch => HeaderSearchMatchCode.Match,
	WithinRangeFieldMatch => HeaderSearchMatchCode.Match, HeaderSearchMatchCode.FuzzyMatch);
END;
