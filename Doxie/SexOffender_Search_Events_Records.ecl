import doxie, doxie_raw, FFD;

export SexOffender_Search_Events_Records (
	DATASET(doxie.Layout_SexOffender_SearchPerson) persons,
  DATASET (doxie.layout_best) ds_best = DATASET ([], doxie.layout_best),	
  boolean IsFCRA = false,
	dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0
	) := function

doxie.MAC_Header_Field_Declare (IsFCRA);

offs := doxie_raw.SexOffender_Events_Raw(persons, '', //sid_value; not used
	dateVal,dppa_purpose,glb_purpose,application_type_value, IsFCRA, ds_best, 
	slim_pc_recs, inFFDOptionsMask);
		
//-----------------[ done ]----------------

return offs;
end;