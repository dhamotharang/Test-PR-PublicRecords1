import STD;

export fn_isPerson(string name, $.NameStatus quality) :=
		CASE(quality,
			$.NameStatus.ProbableName => MatchType.Person,
			$.NameStatus.PossibleName => MatchType.Person,
			$.NameStatus.PossibleDualName => MatchType.Inv,		//MatchType.Dual,	// MatchType.Business,
			$.NameStatus.InvalidNameFormat => if(NameTester.LikelyBizWord(name),	// OR REGEXFIND(rgxFirm4,name),	
																									MatchType.Business,MatchType.Inv),
			$.NameStatus.StandaloneName => // single word name,
																				if($.NameTester.PossibleBizWord(name) OR
																									REGEXFIND('^[A-Z]{3,4}$',name),
																				MatchType.Business,MatchType.Inv),
			MatchType.Inv
		);

