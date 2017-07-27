import doxie, fcra, Doxie_Raw, FFD;

export Faa_Aircraft_records (
  DATASET (doxie.layout_references) in_dids,
  boolean IsFCRA = false,
  dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0 
	) := function

  doxie.MAC_Header_Field_Declare (IsFCRA);

  // in this scenario only registration records associated with "this" DID will be returned.
  f := Doxie_Raw.AirCraft_Raw (in_dids, dataset ([], doxie.layout_ref_bdid),
                               dateVal,dppa_purpose,glb_purpose,ssn_mask_value,
                               application_type_value, IsFCRA, flagfile,,, 
															 slim_pc_recs(datagroup = FFD.Constants.DataGroups.AIRCRAFT), inFFDOptionsMask);

  return f;
end;

