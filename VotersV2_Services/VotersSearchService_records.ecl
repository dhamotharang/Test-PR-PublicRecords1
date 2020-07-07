IMPORT doxie;

doxie.MAC_Header_Field_Declare(); //deep-dive flag can be taken here, IF needed later
UNSIGNED2 pt := 10 : STORED('PenaltThreshold');

includeDeepDive := ~noDeepDive;
    
ids := VotersV2_services.VotersSearchService_ids (includeDeepDive);
vtids := DEDUP (PROJECT (ids, VotersV2_services.Layout_vtid), vtid, ALL);
//accnto='' here. At least it looks like it, since search isn't supposed to be used in a batch mode.

ds_voters := VotersV2_services.raw.search_view.by_vtid (vtids, ssn_mask_value);

ds_dived := JOIN (ds_voters, DEDUP (SORT (ids, vtid, IF (IsDeepDive, 1, 0)), vtid),
                  LEFT.vtid = RIGHT.vtid,
                  TRANSFORM ({ids.isDeepDive, ds_voters}, SELF.isDeepDive := RIGHT.isDeepDive, SELF := LEFT),
                  LEFT OUTER);

// required sort by penalty and deep-dive
res_sorted := SORT (ds_dived (penalt <= pt), IF (isDeepDive, 1, 0), penalt, -LastDateVote, vtid);

EXPORT VotersSearchService_records := res_sorted;
