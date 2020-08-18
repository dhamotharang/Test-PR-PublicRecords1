IMPORT doxie, FCRA, FFD;

/*
  A function to merge flag file with suppressions coming from person context.
*/
EXPORT GetFlagFile(dataset (doxie.layout_best) ds_best,
                   dataset(FFD.Layouts.PersonContextBatch) pc_recs = dataset([], FFD.Layouts.PersonContextBatch)) :=
FUNCTION

  ds_flags_ext := FFD.Functions.GetFlagFileCombined(ds_best, pc_recs);

  ds_flags := PROJECT(ds_flags_ext, TRANSFORM(fcra.Layout_override_flag,
            SELF.flag_file_id := IF(LEFT.isSuppressed, '', LEFT.flag_file_id),
            SELF:=LEFT)
    );

  RETURN ds_flags;

END;
