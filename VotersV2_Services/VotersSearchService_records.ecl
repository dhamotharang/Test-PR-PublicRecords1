IMPORT doxie;

doxie.MAC_Header_Field_Declare(); //deep-dive flag can be taken here, if needed later
unsigned2 pt := 10 : stored('PenaltThreshold');

includeDeepDive := ~noDeepDive;
		
ids := VotersV2_services.VotersSearchService_ids (includeDeepDive);
vtids := DEDUP (PROJECT (ids, VotersV2_services.Layout_vtid), vtid, ALL);
//accnto='' here. At least it looks like it, since search isn't supposed to be used in a batch mode.

ds_voters := VotersV2_services.raw.search_view.by_vtid (vtids, ssn_mask_value);

ds_dived := JOIN (ds_voters, DEDUP (SORT (ids, vtid, if (IsDeepDive, 1, 0)), vtid),
                  Left.vtid = Right.vtid,
                  transform ({ids.isDeepDive, ds_voters}, Self.isDeepDive := Right.isDeepDive, Self := Left),
                  LEFT OUTER);

// required sort by penalty and deep-dive
res_sorted := SORT (ds_dived (penalt <= pt), if (isDeepDive, 1, 0), penalt, -LastDateVote, vtid);

// doxie.MAC_Marshall_Results (res_sorted, res_marshalled);

// EXPORT VotersSearchService_records := res_marshalled;

EXPORT VotersSearchService_records := res_sorted;