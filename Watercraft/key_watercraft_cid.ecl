import watercraft, doxie, ut, fcra,data_services;

export key_watercraft_cid (boolean IsFCRA = false) := function

  // fcra-restricted states:
  states := fcra.compliance.watercrafts.restricted_states;
	source := fcra.compliance.watercrafts.restricted_sources;

  base_file := watercraft.File_Base_Coastguard_Dev (~IsFCRA or (state_origin NOT IN states and source_code NOT IN source));

	// DF-21844 Blank out specified fields in thor_data400::key::watercraft::fcra::cid_qa
	ut.MAC_CLEAR_FIELDS(base_file, base_file_cleared, Watercraft.Constants.fields_to_clear_cid);
	
	base_file_sel := if (IsFCRA,base_file_cleared, base_file);   
	
	file_prefix := if (IsFCRA, 
                    data_services.data_location.prefix('watercraft') +'thor_data400::key::watercraft::fcra::cid_',
                    data_services.data_location.prefix('watercraft') +'thor_data400::key::watercraft_cid_');
       
  return index (base_file_sel, {state_origin,watercraft_key,sequence_key}, {base_file_sel},
                file_prefix + doxie.Version_SuperKey);
end;  
