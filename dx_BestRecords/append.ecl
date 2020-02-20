// NOTE: The use_distributed option will use a hash(did_field) on input records (not a hash32 or hash64).
// If the input is already distributed with a hash() on the did_field value,
//  the operation should be suitably efficient

EXPORT append(did_ds, did_field, permission_type, left_outer = 'true', use_distributed = 'false') := FUNCTIONMACRO

  IMPORT infutor, dx_BestRecords, watchdog, _Control;

// on Vault, we're only choosing between just these 2 files, and since they are ingested files instead of roxie keys,
// and when the rest of them exist as roxie keys, you get an error stating the branches aren't the same
#IF(_Control.Environment.onVault)
  LOCAL out_glb := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_watchdog_glb, use_distributed, left_outer);
  LOCAL out_glb_nonexp := dx_BestRecords.mac_join(did_ds, did_field, watchdog.Key_Watchdog_GLB_nonExperian, use_distributed, left_outer);

    LOCAL best_data := MAP(
    permission_type = dx_BestRecords.Constants.perm_type.glb => out_glb,
    permission_type = dx_BestRecords.Constants.perm_type.glb_nonen => out_glb_nonexp
    );

#ELSE
  //Infutor data not included in the new key.
  LOCAL best_data := IF(permission_type = dx_BestRecords.Constants.PERM_TYPE.infutor,
    dx_BestRecords.mac_join(did_ds, did_field, infutor.key_infutor_best_did, use_distributed, left_outer),
    dx_BestRecords.mac_join_V2(did_ds, did_field, dx_BestRecords.key_watchdog(), use_distributed, left_outer, permission_type));
#END;

  RETURN best_data;

ENDMACRO;






