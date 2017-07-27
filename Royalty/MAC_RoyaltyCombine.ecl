
EXPORT MAC_RoyaltyCombine(inRoyalties1, inRoyalties2) := FUNCTIONMACRO
	inputRoyalties := SORT(inRoyalties1 + inRoyalties2, Royalty_type_code);

	Royalty.Layouts.Royalty	xCombine(Royalty.Layouts.Royalty L, Royalty.Layouts.Royalty R) := TRANSFORM
		SELF.Royalty_type_code := L.Royalty_type_code;
		SELF.Royalty_type := L.Royalty_type;
		SELF.Royalty_count := L.Royalty_count + R.Royalty_count;
		SELF.non_Royalty_count := L.non_Royalty_count + R.non_Royalty_count;
		SELF.count_entity := L.count_entity + R.count_entity;
	END;

	CombinedRoyalties := rollup(inputRoyalties, LEFT.Royalty_type_code = RIGHT.Royalty_type_code, xCombine(LEFT, RIGHT));
	RETURN CombinedRoyalties;
ENDMACRO;