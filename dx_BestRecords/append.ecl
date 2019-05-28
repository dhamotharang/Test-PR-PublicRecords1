// NOTE: The use_distributed option will use a hash(did_field) on input records (not a hash32 or hash64).
// If the input is already distributed with a hash() on the did_field value,
//  the operation should be suitably efficient

EXPORT append(did_ds, did_field, permission_type, left_outer = 'true', use_distributed = 'false') := FUNCTIONMACRO

  // ut is used in mac_join macros. mac_joins should never be called directly.
  IMPORT ut, infutor, dx_BestRecords;

  //Infutor data not included in the new key.
  LOCAL best_data := IF(permission_type = dx_BestRecords.Constants.PERM_TYPE.infutor,
    dx_BestRecords.mac_join(did_ds, did_field, infutor.key_infutor_best_did, use_distributed, left_outer),
    dx_BestRecords.mac_join_V2(did_ds, did_field, dx_BestRecords.key_watchdog(), use_distributed, left_outer, permission_type));

  RETURN best_data;

ENDMACRO;
