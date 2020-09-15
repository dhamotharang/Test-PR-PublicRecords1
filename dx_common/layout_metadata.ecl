EXPORT layout_metadata := record
  UNSIGNED8 record_sid;
  UNSIGNED4 global_sid;
  UNSIGNED4 dt_effective_first;
  UNSIGNED4 dt_effective_last;
  UNSIGNED1 delta_ind := 0; // 0 - main record, 1 - incremental
END;
