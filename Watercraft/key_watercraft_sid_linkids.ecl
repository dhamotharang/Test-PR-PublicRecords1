import watercraft, doxie, ut, fcra,data_services, BIPV2;

export key_watercraft_sid_linkids (boolean IsFCRA = false) := function


//From Watercraft.File_Base_Search_Dev_Ph_Supressed_bdid
  base_file := 	project(File_Base_Search_Dev_Ph_Supressed,
		transform({Layout_Watercraft_Search_Base_slim ,BIPV2.IDlayouts.l_xlink_ids},
			self.bdid := left.bdid,
			self := left));

  // fcra-restricted states:
  states := fcra.compliance.watercrafts.restricted_states;

  base := base_file (~IsFCRA or state_origin NOT IN states);

  file_prefix := if (IsFCRA, 
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft::fcra::sid',
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft_sid');

  return index (base, {state_origin, watercraft_key, sequence_key}, {base_file}-{watercraft.layout_exclusions},
                file_prefix +'::linkids_'+ doxie.Version_SuperKey );

end;