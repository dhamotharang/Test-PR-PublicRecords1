import doxie;

EXPORT VotersSearchService_ids (boolean includeDeepDive = true) := FUNCTION
 doxie.MAC_Header_Field_Declare();
  
  //autokeys
  byak := Votersv2_services.Get_ids (false, false, includeDeepDive);

  // vtid from input
  string14 vtid_value := '' : stored('vtid');
  byvtid := IF (vtid_value <> '', DATASET ([{vtid_value, ''}], Votersv2_services.layout_vtid));

  did := (unsigned6) did_value;
	dids := DATASET ([{did}], doxie.layout_references);
	by_did := votersV2_services.raw.Get_vtids_from_dids (dids);


  outrec := Votersv2_services.layout_search_IDs;
  all_vtids := byak 
	             + 
               PROJECT (byvtid, transform (outrec, self.isDeepDive := FALSE, Self := Left))
	             +
	             PROJECT (by_did, transform (outrec, self.isDeepDive := FALSE, Self := Left));
											

  res_ids := DEDUP (SORT (all_vtids, vtid, if (isDeepDive, 1, 0)), vtid);

  RETURN res_ids;

END;
