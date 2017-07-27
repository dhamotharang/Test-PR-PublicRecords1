import Business_Header;
rec := doxie_cbrs.layout_references;
export getGroupRelatives(dataset(rec) thebdids) := 
FUNCTION

precs := thebdids;

bhrl := doxie_cbrs.layout_relatives;
// bhrf := Business_Header.File_Business_Relatives_Plus;
bhkr := Business_Header.Key_Business_Relatives;

rec tGetRelatives(precs l, bhkr r) := TRANSFORM
	SELF.bdid := r.bdid2;
END;

relatives := JOIN(precs, bhkr,
				keyed(LEFT.bdid = RIGHT.bdid1) and 
				business_header.mac_isGroupRel(right),
				tGetRelatives(left, RIGHT), limit(10000, skip), keep(1000));

RETURN relatives;

END;