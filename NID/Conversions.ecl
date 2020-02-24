EXPORT Conversions := MODULE
	shared set of string1 Types :=  ['T', 'B', 'P', 'D', 'U', 'I', ''];

	export string1 NameTypeToChar(MatchType type) := Types[type];

	export NameTypeToCode(string1 type) := CASE(type,
							'B' => MatchType.Business,
							'P' => MatchType.Person,
							'D' => MatchType.Dual,
							'I' => MatchType.Inv,
							'T' => MatchType.Trust,
							'U' => MatchType.Unclass,
							MatchType.NoMatch);
END;