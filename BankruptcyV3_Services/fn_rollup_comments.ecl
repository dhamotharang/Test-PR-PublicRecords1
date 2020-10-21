IMPORT bankruptcyv3;
EXPORT fn_rollup_comments(
  DATASET(RECORDOF(bankruptcyv3.key_bankruptcyv3_main_full())) in_records) :=
    FUNCTION
      temp_comments_slim :=
        NORMALIZE(
          in_records,
          COUNT(LEFT.comments),
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_comment_ext,
            SELF := LEFT.comments[COUNTER],
            SELF := LEFT));
      temp_comments_dedup :=
        DEDUP(
          SORT(
            temp_comments_slim(filing_date != '' OR description != ''),
            tmsid,-filing_date,description),
          tmsid,filing_date,description);
      temp_comments_keep :=
          SORT(
            temp_comments_dedup,
            tmsid,-filing_date,description);
      temp_comments_roll :=
        ROLLUP(
          GROUP(temp_comments_keep,tmsid),
          GROUP,
          TRANSFORM(
            bankruptcyv3_services.layouts.layout_comment_roll,
            SELF.comments := CHOOSEN(PROJECT(ROWS(LEFT),bankruptcyv3_services.layouts.layout_comment),
                                     bankruptcyv3_services.consts.COMMENTS_PER_ROLLUP),
            SELF := LEFT));
      RETURN
        temp_comments_roll;
    END;
    
