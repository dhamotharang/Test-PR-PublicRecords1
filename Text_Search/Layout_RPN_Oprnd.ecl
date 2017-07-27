export Layout_RPN_Oprnd := RECORD
	Types.WordStr				searchArg;
	Types.WordList			terms{MAXCOUNT(Limits.Max_Wild)};			// empty if stack
	Types.NominalList 	nominals{MAXCOUNT(Limits.Max_Wild)};  // empty if stack
	Types.NominalSuffixList	suffixes{MAXCOUNT(Limits.Max_Wild)};
	Types.WordType			typ;
	Types.Stage					stageIn;	// 0 if term, simulates a stack
	Types.TermID				id;
	Types.SegmentList 	segList{MAXCOUNT(64)};	
	Types.NominalFilter filterType;
	Types.PrepAction		action;
	Types.Freq          freq;
	Types.Freq					docFreq;
	Types.Distance			leftWindow;
	Types.Distance			rightWindow;
	Types.HitCount			atl;
	BOOLEAN							deferWildCard := FALSE;
END;