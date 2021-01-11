IMPORT bankruptcyv3;
EXPORT fn_rollup_statuses(
  DATASET(RECORDOF(bankruptcyv3.key_bankruptcyv3_main_full())) in_records) :=
    FUNCTION
      temp_status_slim :=
        NORMALIZE(
          in_records,
          COUNT(LEFT.status),
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_status_ext,
            SELF := LEFT.status[COUNTER],
            SELF := LEFT));
      temp_status_dedup :=
        DEDUP(
          SORT(
            temp_status_slim(status_date != '' OR status_type != ''),
            tmsid,-status_date,status_type),
          tmsid,status_date,status_type);
      temp_status_keep :=
          SORT(
            temp_status_dedup,
            tmsid,-status_date,status_type);
      temp_status_roll :=
        ROLLUP(
          GROUP(temp_status_keep,tmsid),
          GROUP,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_status_roll,
            SELF.statuses := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv3_services.layouts.layout_status),
                                     bankruptcyv3_services.consts.STATUSES_PER_ROLLUP),
            SELF := LEFT));
      RETURN
        temp_status_roll;
    END;
    
