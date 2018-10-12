// Macro to get a snapshot of a dataset, defined as no more than one output record per rid_field
// Snapshot is produced with effective (or "as of" date provided)- defaults to today/now if no date is provided
//  (and "today/now" is either YYYYMMDDHHMMSS or YYYYMMDD depending upon dt_resolution)
// Snapshots can be in the context of individual inquiries with different effective dates
//
// Input Parameters:
// dsIn is the input dataset
// rid_field is the unique record ID field
// did_field is the unique entity ID field
// uniqueid_field is a field for a unique ID (from a particular search record, for example, in a fetch case)
//  (if no value is provided, assumes that snapshot is being created across all data)
// dt_early and dt_late are the first/last date fields searched for data snapshot
// asofdate_field is the effective date field for the snapshot (if no field is provided, defaults to today/now)
//  (should be the SAME RESOLUTION at dt_early and dt_late)
// dt_resolution should be either YYYYMMDD or YYYYMMDDHHMMS, depending upon desired date resolution
//  (only used if no asofDate is specified)
// useLocal governs whether dataset operations in macro are performed with DISTRIBUTE/LOCAL (for THOR processes) or not (for ROXIE processes)
EXPORT MAC_DatasetAsOf(dsIn, rid_field, did_field, uniqueid_field = '', dt_early, dt_late, asofdate_field = '', dt_resolution, useLocal) := FUNCTIONMACRO
	IMPORT STD;

	hasAsOfDateField := TRIM(#TEXT(asofdate_field)) > '';
	nowDateUse := STD.Date.CurrentDate(TRUE);
	nowTimeUse := STD.Date.CurrentTime(TRUE);
	nowDateTimeUse := (UNSIGNED6)(INTFORMAT(nowDateUse,8,1) + INTFORMAT(nowTimeUse,6,1));
	
	asofDateUse := MAP(dt_resolution = 'YYYYMMDDHHMMSS' => (UNSIGNED6)nowDateTimeUse,
	                   dt_resolution = 'YYYYMMDD' => (UNSIGNED6)nowDateUse,
										 0);

	hasUniqueIDField := TRIM(#TEXT(uniqueid_field)) > '';
	#IF (hasUniqueIDField)
		uniqueKey := #TEXT(rid_field) + ',' + #TEXT(uniqueid_field);
	#ELSE
		uniqueKey := #TEXT(rid_field);
	#END
	// first dedup is to get biggest non-zero (if there is one) dt_late for every rid_field/did_field/dt_early combo
	#IF (useLocal)
		dsDedup1 := DEDUP(SORT(DISTRIBUTE(dsIn, HASH(#EXPAND(uniqueKey))), #EXPAND(uniqueKey), did_field, dt_early, -dt_late, LOCAL), #EXPAND(uniqueKey), did_field, dt_early, LOCAL);
	#ELSE
		dsDedup1 := DEDUP(SORT(dsIn, #EXPAND(uniqueKey), did_field, dt_early, -dt_late), #EXPAND(uniqueKey), did_field, dt_early);
	#END
	
	// now filter using asofDate (effective date)
	#IF (hasAsOfDateField)
		dsAsOf := dsDedup1((asofdate_field >= dt_early OR dt_early = 0) AND (asofdate_field <= dt_late OR dt_late = 0));
	#ELSE
		dsAsOf := dsDedup1((asofDateUse >= dt_early OR dt_early = 0) AND (asofDateUse <= dt_late OR dt_late = 0));
	#END
	
	// final dedup just in case, to ensure only one record per rid_field
	#IF (useLocal)
		dsOut := DEDUP(SORT(dsAsOf, #EXPAND(uniqueKey), -dt_early, did_field, LOCAL), #EXPAND(uniqueKey), LOCAL);
	#ELSE
		dsOut := DEDUP(SORT(dsAsOf, #EXPAND(uniqueKey), -dt_early, did_field), #EXPAND(uniqueKey));
	#END
	
	RETURN dsOut;
ENDMACRO;