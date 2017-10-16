//spk := spokeo.File_Processed;

EXPORT Stats(dataset(spokeo.Layout_Temp) spk = spokeo.File_Processed) := FUNCTION
	lspk := DEDUP(SORT(DISTRIBUTE(spk(LexId<>0), LexId), LexId, LOCAL), LexId, Local);
	hspk := DEDUP(SORT(DISTRIBUTE(spk(hhid<>0), hhid), hhid, LOCAL), hhid, Local);
	aspk := DEDUP(SORT(DISTRIBUTE(spk(LexId<>0,address_source='S'), LexId), LexId, address_id, LOCAL), LexId, address_id, Local);

	return DATASET([
	{'Total input records', COUNT(spokeo.File_Spokeo_In)},
	{'Total output records', COUNT(spk)},
	{'Inserted LN records', COUNT(spk(address_source='L')),'Count of when LN returned a better address for a consumer'},
	{'Records with a LexID', COUNT(spk(LexId<>0)),'Includes low quality matches which they asked for (and we flagged accordingly'},
	{'Records with a LOW quality LexID', COUNT(spk(LexId<>0,LexId_Score='LOW')),'Includes low quality matches which they asked for (and we flagged accordingly'},
	{'LexID hit rate (%)',100*COUNT(spk(LexId<>0,address_source<>'L')) div COUNT(spk(address_source<>'L'))},
	{'Unique LexIDs', COUNT(lspk)},
	{'Deceased LexIDs', COUNT(lspk(deceased=true))},
	{'Unique Households', COUNT(hspk)},
	{'Consumers with a current address', COUNT(aspk(current_address_flag='Y')),'Defined as current or most recent on file for the consumer'},
	{'Consumers with a confirmed address', COUNT(aspk(confirmed_address_flag='Y')),'This is a count where LN confirmed the Spokeo address matched the DTC Best Address'},
	{'Consumers with a better address', COUNT(aspk(better_address_flag='Y')),'This is a count where LN has a better address but cannot return due to restrictions'}
	], {string Stats, unsigned8 Count_or_Percent, string Comments := ''});
END;