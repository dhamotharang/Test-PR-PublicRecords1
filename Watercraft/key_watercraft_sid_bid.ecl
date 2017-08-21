import watercraft, doxie, ut, fcra,data_services;

export key_watercraft_sid_bid (boolean IsFCRA = false) := function

  base_file := Watercraft.File_Base_Search_Dev_Ph_Supressed_bid;

  // fcra-restricted states:
  states := fcra.compliance.watercrafts.restricted_states;

  base := base_file (~IsFCRA or state_origin NOT IN states);

  file_prefix := if (IsFCRA, 
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft::fcra::sid_bid',
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft_sid_bid');

  return index (base, {state_origin, watercraft_key, sequence_key}, {base_file}-{watercraft.layout_exclusions},
                file_prefix + doxie.Version_SuperKey);

end;