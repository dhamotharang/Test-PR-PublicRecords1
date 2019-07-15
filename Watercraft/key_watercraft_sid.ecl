import watercraft, doxie, ut, fcra,data_services;

export key_watercraft_sid (boolean IsFCRA = false) := function

  base_file := Watercraft.File_Base_Search_Dev_Ph_Supressed_bdid;

  // fcra-restricted states:
  states := fcra.compliance.watercrafts.restricted_states;
	source := fcra.compliance.watercrafts.restricted_sources;

  base := base_file (~IsFCRA or (state_origin NOT IN states and source_code NOT IN source));

	// DF-21844 Blank out specified fields in thor_data400::key::watercraft::fcra::sid_qa
	ut.MAC_CLEAR_FIELDS(base, base_cleared, Watercraft.Constants.fields_to_clear_sid);
	
	base_sel := if (IsFCRA,base_cleared, base);
	
  file_prefix := if (IsFCRA, 
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft::fcra::sid_',
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft_sid_');

  return index (base_sel, {state_origin, watercraft_key, sequence_key}, {base_sel}-{watercraft.layout_exclusions},
                file_prefix + doxie.Version_SuperKey);

end;