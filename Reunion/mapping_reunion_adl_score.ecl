//-----------------------------------------------------------------------------
// Builds the adl score file
//-----------------------------------------------------------------------------


dsAdlScore := PROJECT(reunion.reunion_clean(did<>0), TRANSFORM(Reunion.layouts.lADLScore,
									self.adl := INTFORMAT(LEFT.did,12,1);
									self.adl_score := INTFORMAT(LEFT.did_score,3,1);
									self.source_record_type := IF(LEFT.vendor='1','1','2');	//â€™1â€™ or â€˜2â€™
									self.orig_user_num := left.orig_vendor_id;
									));


EXPORT mapping_reunion_adl_score := DEDUP(dsAdlScore,ALL);
