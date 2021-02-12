IMPORT $;

EXPORT Batch_Records(DATASET($.Layouts.batch_input) ds_batch_in) := FUNCTION

  recs_courtlink := $.GetCourtLinkRecords(ds_batch_in);
  ds_results_grouped := GROUP(recs_courtlink, acctno);

  // At this point, 'flatten' the resultant records into the specified output layout using ostensibly
  ds_results_rolled_flat := ROLLUP(ds_results_grouped, GROUP, $.Functions.FlattenBatch(LEFT, ROWS(LEFT)));

  RETURN ds_results_rolled_flat;

END;
