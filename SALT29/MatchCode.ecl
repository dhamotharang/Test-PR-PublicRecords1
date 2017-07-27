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
	EXPORT ForcedNoMatch := Code_Base + 98;	
	EXPORT NoMatch := Code_Base + 99;
END;
