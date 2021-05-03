IMPORT ut, MDR, OneKey;
EXPORT Rollup_Base(DATASET(OneKey.Layouts.Base) pDataset) := FUNCTION

  pDataset_Dist := DISTRIBUTE(pDataset, source_rec_id);
  pDataset_sort := SORT(pDataset_Dist, source_rec_id, -dt_vendor_last_reported, LOCAL);
	
  OneKey.Layouts.Base RollupUpdate(OneKey.Layouts.Base l, OneKey.Layouts.Base r) := TRANSFORM
    SELF.dt_vendor_last_reported 	:= MAX(l.dt_vendor_last_reported	,r.dt_vendor_last_reported	);
    SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported	,r.dt_vendor_first_reported	);
    SELF.record_type							:= IF(l.record_type = 'C' OR r.record_type = 'C', 'C', 'H');
    SELF.source_rec_id						:= IF(l.source_rec_id = 0, r.source_rec_id, l.source_rec_id);
    SELF := l;
  END;

  pDataset_rollup := ROLLUP(pDataset_sort, RollupUpdate(LEFT, RIGHT), source_rec_id, LOCAL);
	
  // --for update that is not full file
  dNotFull_sort        := SORT(pDataset_rollup, source_rec_id, LOCAL);
  dNotFull_group       := GROUP(dNotFull_sort, source_rec_id, LOCAL);
  dNotFull_sort_group  := SORT(dNotFull_group, -dt_vendor_last_reported);

	OneKey.Layouts.Base SetRecordType(OneKey.Layouts.Base L, OneKey.Layouts.Base R) := TRANSFORM
    SELF.record_type   := IF(L.record_type = '', 'C', R.record_type);
    SELF               := R;
  END;

	dSetRecordType := GROUP(ITERATE(dNotFull_sort_group, SetRecordType(LEFT, RIGHT)));

  output_dataset := IF(OneKey._Flags.IsUpdateFullFile, pDataset_rollup, dSetRecordType);

	RETURN output_dataset;

END;