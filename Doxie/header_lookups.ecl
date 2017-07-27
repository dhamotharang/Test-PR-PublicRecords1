IMPORT doxie;

EXPORT header_lookups(DATASET(doxie.layout_references) d) := FUNCTION

doxie.Key_Did_Lookups_v2 getlook(doxie.Key_did_Lookups_v2 ri) :=
TRANSFORM
	self.prop_count :=if (doxie.DataRestriction.Fares,ri.nonfares_prop_count,ri.prop_count);
	self.prop_asses_count := if(doxie.DataRestriction.Fares,ri.nofares_prop_asses_count,ri.prop_asses_count); 
	self.prop_deeds_count := if(doxie.DataRestriction.Fares,ri.nofares_prop_deeds_count,ri.prop_deeds_count);
	SELF := ri;
END;


RETURN JOIN (d, doxie.Key_Did_Lookups_v2,
             KEYED (LEFT.did = RIGHT.did),
             getlook( RIGHT),
             KEEP(1), LIMIT(0));

END;