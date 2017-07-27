IMPORT DNB, ut;

// Initialize match file
BH_File := Business_Header.BH_Basic_Match_ForRels;

Layout_DT_Match := RECORD
	UNSIGNED6 bdid;           // Seisint Business Identifier
	UNSIGNED4 duns;           // DUNS number from source_group
	UNSIGNED4 ultimate_duns := 0;
END;

Layout_DT_Match InitMatchFile(BH_File L) := TRANSFORM
	SELF.duns := (UNSIGNED4) l.source_group;
	SELF := l;
END;

Match_Init := PROJECT(	BH_File(source = 'D', source_group <> '',
								source_group[1] != 'D'), 
						InitMatchFile(LEFT));

Match_Init_Dedup := DISTRIBUTE(
	DEDUP(Match_Init, bdid, duns, ALL), HASH(duns));

Layout_DT_Match AddUltimateDUNS(
			Layout_DT_Match l, 
			DNB.Layout_DUNS_To_Ultimate_DUNS r) := TRANSFORM
	SELF.ultimate_duns := r.ultimate_duns_number;
	SELF := l;
END;

ud_joined := JOIN(Match_Init_Dedup, DNB.DUNS_To_Ultimate_DUNS,
				LEFT.duns = RIGHT.duns_number,
				AddUltimateDUNS(LEFT, RIGHT), LOCAL);

// Dedup again by bdid & ultimate duns
ud_joined_ded := DEDUP(ud_joined, bdid, ultimate_duns, ALL);

ud_joined_dist_ult := DISTRIBUTE(ud_joined_ded, HASH(ultimate_duns));
ut.MAC_Split_Withdups_Local(ud_joined_dist_ult, ultimate_duns, 4000, ud_match, ud_remainder)

// Relate all bdids with the same ultimate duns number
Layout_Relative_Match MatchDT(
		Layout_DT_Match l, Layout_DT_Match r) := TRANSFORM
	SELF.bdid1 := l.bdid;
	SELF.bdid2 := r.bdid;
	SELF.match_type := 'DT';
END;

dt_relatives := JOIN(ud_match, ud_match,
				LEFT.ultimate_duns = RIGHT.ultimate_duns AND
				LEFT.bdid > RIGHT.bdid,
				MatchDT(LEFT ,RIGHT),
				HASH);

dt_relatives_ded := DEDUP(dt_relatives, bdid1, bdid2, ALL);

EXPORT BH_Relative_Match_DUNS_Tree := dt_relatives_ded
				 : PERSIST('TEMP::BH_Relative_Match_DUNS_Tree');