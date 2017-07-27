import doxie, watercraftV2_services, fcra, FFD;

// FCRA: note, default value for the flag-file is just a convenience.
//       If this attribute is called on FCRA-side, proper flag-file MUST be passed in.

export watercraft_records (
  DATASET (doxie.layout_references) dids,
  string6 ssn_mask = 'NONE',
  boolean IsFCRA = false,
  dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
	boolean include_non_regulated_watercraft_sources = false,
	dataset(FFD.Layouts.PersonContextBatchSlim ) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
	) := function
	
  raw := WatercraftV2_Services.WatercraftV2_raw.Report_View.by_did (dids,ssn_mask,true, IsFCRA, flagfile,, 
		include_non_regulated_watercraft_sources, slim_pc_recs(datagroup in FFD.Constants.DataGroupSet.WATERCRAFT), inFFDOptionsMask);
	
  return raw;
end;
