import watercraft, doxie, ut, fcra,data_services, vault, _control;


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export key_watercraft_did (boolean isFCRA = false) := vault.watercraft.key_watercraft_did(isFCRA);

#ELSE
export key_watercraft_did (boolean isFCRA = false) := function

  base_file := watercraft.file_base_search_dev((unsigned6)did<>0);

  base_slim := table (base_file, {base_file.did, base_file.state_origin,
                                  base_file.watercraft_key, base_file.sequence_key});

  // fcra-restricted states:
  states := fcra.compliance.watercrafts.restricted_states;

  base_srt := sort (base_slim (~isFCRA or state_origin NOT IN states), record);
  base_dep := dedup (base_srt, record);

  file_prefix := if (IsFCRA, 
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft::fcra::did_',
                     data_services.data_location.prefix('watercraft')+'thor_data400::key::watercraft_did_');

  return index (base_dep, {l_did := (unsigned6) did}, {state_origin, watercraft_key,sequence_key},
                file_prefix + doxie.Version_SuperKey);
end;

#END;

