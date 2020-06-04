EXPORT mapping_reunion_adl_score(unsigned1 mode, STRING sVersion) := MODULE

clean := reunion.reunion_clean(mode);
//-----------------------------------------------------------------------------
// Builds the adl score file
//-----------------------------------------------------------------------------
dsAdlScore := PROJECT(clean(did<>0), TRANSFORM(Reunion.layouts.lADLScore,
									self.adl := INTFORMAT(LEFT.did,12,1);
									self.adl_score := INTFORMAT(LEFT.did_score,3,1);
									self.source_record_type := IF(LEFT.vendor='1','1','2');	//’1’ or ‘2’
									self.orig_user_num := left.orig_vendor_id;
									));
									
dsAdlScore_deduped := DEDUP(dsAdlScore,ALL);

score := DISTRIBUTE(dsAdlScore_deduped, hash32(adl));
main := DISTRIBUTE(reunion.Files(mode).dMain((unsigned6)adl<>0), hash32(adl));

// match up to main, in order to remove minors
EXPORT all := JOIN(score, main, left.adl=right.adl,
						transform(recordof(score), self := left;),
						inner, keep(1), local);

END;
