IMPORT doxie, votersv2_services;

doxie.MAC_Header_Field_Declare();

EXPORT VotersV2_raw (
  dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
  unsigned3 dateVal = 0,
  string6 ssn_mask_value = 'NONE',
	dataset(VotersV2_services.layout_vtid) in_vtids = dataset([],VotersV2_services.layout_vtid)
) := FUNCTION

  string14 vtid_value := '' : stored('vtid');

  // Get voters' ids by input
  by_did	:= Votersv2_services.raw.Get_vtids_from_dids (dids);
	by_vtid	:= IF (vtid_value <> '', dataset([{(unsigned6) vtid_value}], votersv2_services.layout_vtid));
  vtids		:= by_did + by_vtid + in_vtids;

  // Get records by voter id
  res := Votersv2_services.raw.source_view.by_vtid (vtids, ssn_mask_value,,application_type_value);
		  
  RETURN res (dateVal = 0 OR (unsigned3)(process_date[1..6]) <= dateVal);

END;