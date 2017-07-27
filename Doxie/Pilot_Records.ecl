import doxie, doxie_raw, FCRA, FFD;

export Pilot_Records (dataset(doxie.layout_references) dids, 
                      unsigned3 dateVal = 0,
                      string6 ssn_mask_value = 'NONE',
                      boolean IsFCRA = false,
                      dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
											dataset(FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim, 
											integer8 inFFDOptionsMask = 0 
											) := function

	outfile := Doxie_Raw.Pilot_Raw(dids, dateVal, , , ssn_mask_value, IsFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
	return outfile;
end;
