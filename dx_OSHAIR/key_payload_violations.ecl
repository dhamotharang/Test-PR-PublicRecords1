IMPORT doxie, data_services;

//-----------------------------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
// $.keys_delta_rid.Violations
//-----------------------------------------------------------------------------------
key_rec := RECORD
  Layouts.Layout_violations;
  integer1 __internal_fpos__ := 0;    //for platform?
END;

EXPORT key_payload_violations := INDEX({key_rec.Activity_Number}, key_rec, names().violations);
