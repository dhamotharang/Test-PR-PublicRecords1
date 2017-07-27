//============================================================================
// Attribute: Dea_raw.  Used by view source service and comp-report.
// Function to get dea records by did or bdid.
// Return: dataset.  Layout: Doxie_Raw.Layout_Dea_Raw.
//============================================================================

import Doxie, dea, codes, suppress, ut;

export Dea_Raw(
    dataset(Doxie.layout_references) dids,
	dataset(Doxie.Layout_ref_bdid) bdids,
	unsigned3 dateVal = 0,
	unsigned1 dppa_purpose = 0,
	unsigned1 glb_purpose = 0,
	string6 ssn_mask_value = 'NONE'
) := FUNCTION

F1 := join(dids,dea.key_dea_did,
           keyed (left.did=right.my_did) and
           (dateVal = 0 OR (unsigned3)(right.date_first_reported[1..6]) <= dateVal),
           TRANSFORM (dea.layout_DEA_Out, SELF := RIGHT),
           LIMIT (ut.limits.DEA_PER_DID, SKIP));

F2 := join(bdids,dea.Key_DEA_Bdid,
           keyed (left.bdid=right.bd) and
           (dateVal = 0 OR (unsigned3)(right.date_first_reported[1..6]) <= dateVal),
           TRANSFORM (dea.layout_DEA_Out, SELF := RIGHT),
           LIMIT (ut.limits.DEA_PER_BDID, SKIP));

f3 := f1 + f2;

Doxie_Raw.Layout_Dea_Raw into_out(f3 L) := transform
    self.business_activity_code_mapped := codes.DEA_REGISTRATION.business_activity_code(L.business_activity_code);
    self := L;
end;

outFile := project(f3,into_out(LEFT));

out_f := sort(outFile, whole record);

doxie.MAC_PruneOldSSNs(out_f, out_f_pruned, best_ssn, did);
suppress.MAC_Mask(out_f_pruned, out_mskd, best_ssn, blank, true, false);

return out_mskd;

END;