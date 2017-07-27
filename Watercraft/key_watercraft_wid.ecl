import watercraft, doxie, ut, fcra,data_services;

export key_watercraft_wid (boolean IsFCRA = false) := function

  // fcra-restricted states:
  states := fcra.compliance.watercrafts.restricted_states;

  base_file := watercraft.file_base_main_dev (~IsFCRA or state_origin NOT IN states);

  file_prefix := if (IsFCRA, 
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft::fcra::wid_',
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft_wid_');

       
  return index (base_file, {state_origin,watercraft_key,sequence_key},
                {base_file},
                file_prefix + doxie.Version_SuperKey);
end;
