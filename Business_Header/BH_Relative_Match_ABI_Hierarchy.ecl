IMPORT INFOUSA, ut;

// Initialize match file
BH_File := Business_Header.BH_Basic_Match_ForRels;

Layout_IH_Match := RECORD
	UNSIGNED6 bdid;           // Seisint Business Identifier
	UNSIGNED4 ABI_NUMBER;           // ABI_NUMBER number from source_group
	UNSIGNED4 ULTIMATE_PARENT_NUM := 0;
END;

Layout_IH_Match InitMatchFile(BH_File L) := TRANSFORM
	SELF.ABI_NUMBER := (UNSIGNED4) l.source_group;
	SELF := l;
END;

Match_Init := PROJECT(	BH_File(source = 'IA', source_group <> ''), 
						InitMatchFile(LEFT));

Match_Init_Dedup := DISTRIBUTE(
	DEDUP(Match_Init, bdid, ABI_NUMBER, ALL), HASH(ABI_NUMBER));

Layout_IH_Match AddUltimateABI_NUMBER(
			Layout_IH_Match l, 
			INFOUSA.Layout_ABI_To_Ultimate_ABI r) := TRANSFORM
	SELF.ULTIMATE_PARENT_NUM := r.ULTIMATE_PARENT_NUM;
	SELF := l;
END;

ud_joined := JOIN(Match_Init_Dedup, INFOUSA.ABI_to_Ultimate_ABI,
				LEFT.ABI_NUMBER = RIGHT.ABI_NUMBER,
				AddUltimateABI_NUMBER(LEFT, RIGHT), LOCAL);

// Dedup again by bdid & ultimate ABI_NUMBER
ud_joined_ded := DEDUP(ud_joined, bdid, ULTIMATE_PARENT_NUM, ALL);

ud_joined_dist_ult := DISTRIBUTE(ud_joined_ded, HASH(ULTIMATE_PARENT_NUM));
ut.MAC_Split_Withdups_Local(ud_joined_dist_ult, ULTIMATE_PARENT_NUM, 4000, ud_match, ud_remainder)

// Relate all bdids with the same ultimate ABI_NUMBER
Layout_Relative_Match MatchIH(
		Layout_IH_Match l, Layout_IH_Match r) := TRANSFORM
	SELF.bdid1 := l.bdid;
	SELF.bdid2 := r.bdid;
	SELF.match_type := 'IH';
END;

IH_relatives := JOIN(ud_match, ud_match,
				LEFT.ULTIMATE_PARENT_NUM = RIGHT.ULTIMATE_PARENT_NUM AND
				LEFT.bdid > RIGHT.bdid,
				MatchIH(LEFT ,RIGHT),
				HASH);

IH_relatives_ded := DEDUP(IH_relatives, bdid1, bdid2, ALL);

EXPORT BH_Relative_Match_ABI_Hierarchy := IH_relatives_ded
				 : PERSIST(persistnames.BHRelativeMatchABIHierarchy);
