#warning('Deprecated. Logic moved to doxie.SexOffender_Search_Events_Records')
import doxie_raw, SexOffender;

// This attribute still used by doxie.sexoffender_search  service and need to be maintained
export sexoffender_search_events_local (
  DATASET (doxie.layout_best) ds_best  = DATASET ([], doxie.layout_best),
  boolean IsFCRA = false) := function

SexOffender.MAC_Header_Field_Declare(IsFCRA);

persons := doxie.sexoffender_search_people_local (ds_best, IsFCRA);


offs := doxie_raw.SexOffender_Events_Raw(persons,sid_value,
	dateVal,dppa_purpose,glb_purpose,application_type_value, IsFCRA);
		
//-----------------[ done ]----------------

return offs;
end;