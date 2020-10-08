IMPORT Business_Header;
rec := doxie_cbrs.layout_references;
EXPORT getGroupRelatives(DATASET(rec) thebdids) :=
FUNCTION

precs := thebdids;

bhrl := doxie_cbrs.layout_relatives;
// bhrf := Business_Header.File_Business_Relatives_Plus;
bhkr := Business_Header.Key_Business_Relatives;

rec tGetRelatives(precs l, bhkr r) := TRANSFORM
  SELF.bdid := r.bdid2;
END;

relatives := JOIN(precs, bhkr,
        KEYED(LEFT.bdid = RIGHT.bdid1) AND
        business_header.mac_isGroupRel(RIGHT),
        tGetRelatives(LEFT, RIGHT), LIMIT(10000, SKIP), KEEP(1000));

RETURN relatives;

END;
