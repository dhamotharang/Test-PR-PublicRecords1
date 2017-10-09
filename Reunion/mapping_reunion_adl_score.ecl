//-----------------------------------------------------------------------------
// Builds the adl score file
//-----------------------------------------------------------------------------


dsAdlScore := PROJECT(reunion.reunion_clean(did<>0), TRANSFORM(Reunion.layouts.lADLScore,
									self.adl := INTFORMAT(LEFT.did,12,1);
									self.adl_score := INTFORMAT(LEFT.did_score,3,1);
									self.source_record_type := IF(LEFT.vendor='1','1','2');	//’1’ or ‘2’
									self.orig_user_num := left.orig_vendor_id;
									));
									
dsAdlScore_deduped := DEDUP(dsAdlScore,ALL);

score := DISTRIBUTE(dsAdlScore_deduped, hash32(adl));
main := DISTRIBUTE(reunion.Files.dMain((unsigned6)adl<>0), hash32(adl));

// match up to main, in order to remove minors
result := JOIN(score, main, left.adl=right.adl,
						transform(recordof(score), self := left;),
						inner, keep(1), local);

EXPORT mapping_reunion_adl_score := result;
