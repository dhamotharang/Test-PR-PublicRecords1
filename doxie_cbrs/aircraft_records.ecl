IMPORT doxie_cbrs, doxie_raw, doxie;

doxie.MAC_Header_Field_Declare();

EXPORT aircraft_records(DATASET(doxie_cbrs.layout_references) bdids) :=
  // in this scenario only registration records associated with t"this" BDID will be returned
  Doxie_Raw.AirCraft_Raw( doxie_raw.ds_EmptyDIDs,PROJECT(bdids,doxie.Layout_ref_bdid),
                          dateVal,dppa_purpose,glb_purpose,
                          ssn_mask_value, application_type_value);
