import watercraft, doxie, ut, fcra,data_services;

export key_watercraft_wid (boolean IsFCRA = false) := function

  // fcra-restricted states:
  states := fcra.compliance.watercrafts.restricted_states;
	source := fcra.compliance.watercrafts.restricted_sources;

  base_file := watercraft.file_base_main_dev (~IsFCRA or (state_origin NOT IN states and source_code NOT IN source));

	// DF-21844 Blank out specified fields in thor_data400::key::watercraft::fcra::wid_qa
	ut.MAC_CLEAR_FIELDS(base_file, base_file_cleared, Watercraft.Constants.fields_to_clear_wid);
	
	base_file_sel := if (IsFCRA,base_file_cleared, base_file);

  file_prefix := if (IsFCRA, 
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft::fcra::wid_',
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft_wid_');

       
  return index (base_file_sel, {state_origin,watercraft_key,sequence_key},
                {base_file_sel},
                file_prefix + doxie.Version_SuperKey);
end;
