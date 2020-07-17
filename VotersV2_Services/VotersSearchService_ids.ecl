IMPORT doxie;

EXPORT VotersSearchService_ids (BOOLEAN includeDeepDive = TRUE) := FUNCTION
 doxie.MAC_Header_Field_Declare();
  
  //autokeys
  byak := Votersv2_services.Get_ids (FALSE, FALSE, includeDeepDive);

  // vtid from input
  STRING14 vtid_value := '' : STORED('vtid');
  byvtid := IF (vtid_value <> '', DATASET ([{vtid_value, ''}], Votersv2_services.layout_vtid));

  did := (UNSIGNED6) did_value;
  dids := DATASET ([{did}], doxie.layout_references);
  by_did := votersV2_services.raw.Get_vtids_from_dids (dids);


  outrec := Votersv2_services.layout_search_IDs;
  all_vtids := byak
               +
               PROJECT (byvtid, TRANSFORM (outrec, SELF.isDeepDive := FALSE, SELF := LEFT))
               +
               PROJECT (by_did, TRANSFORM (outrec, SELF.isDeepDive := FALSE, SELF := LEFT));
                      

  res_ids := DEDUP (SORT (all_vtids, vtid, IF (isDeepDive, 1, 0)), vtid);

  RETURN res_ids;

END;
