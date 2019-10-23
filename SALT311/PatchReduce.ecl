IMPORT SALT311;
EXPORT PatchReduce := MODULE
	// parent id1 merges into parent id2 (id1>id2)
	EXPORT PatchRec := RECORD
		SALT311.UIDType id1;
		SALT311.UIDType id2;
	END;
	// If id1 wants to change to id2 but id2 wants to change to something else,
	// then reduction is required...
	SHARED needed(DATASET(PatchRec) ds) := EXISTS(JOIN(ds,ds,LEFT.id2=RIGHT.id1,TRANSFORM(LEFT),HASH));
	
	// Reduce patch records adjacent to leaves
	SHARED leaves(DATASET(PatchRec) ds) := FUNCTION
		result := JOIN(ds,ds,LEFT.id2=RIGHT.id1,TRANSFORM(LEFT),HASH,LEFT ONLY);
		// OUTPUT(DATASET([{COUNT(result)}],{UNSIGNED cnt}), NAMED('LeafCount'), EXTEND); // DEBUG
		RETURN result;
	END;
	PatchRec do(PatchRec L,PatchRec R) := TRANSFORM
		SELF.id1 := L.id1;
		SELF.id2 := IF(R.id2=0,L.id2,R.id2);
	END;
	SHARED reduce_link(DATASET(PatchRec) ds, UNSIGNED C=0) := FUNCTION
		// OUTPUT(DATASET([{C}],{UNSIGNED cnt}), NAMED('BodyCount'), EXTEND); // DEBUG
		RETURN JOIN(ds,leaves(ds),LEFT.id2=RIGHT.id1,do(LEFT,RIGHT),HASH,LEFT OUTER,KEEP(1));
	END;
	// Reduce chained patch records until all we have left are leaves
	// Example: {4,3},{3,2},{2,1} => {4,3},{3,1},{2,1} => {4,1},{3,1},{2,1}
	EXPORT reduce_chain(DATASET(PatchRec) ds) := FUNCTION
		ds1 := LOOP(ds, needed(ROWS(LEFT)), reduce_link(ROWS(LEFT),COUNTER));
		ds2 := DISTRIBUTE(ds1, HASH32(id1));
		ds3 := DEDUP(SORT(ds2, id1, id2, LOCAL), id1, id2, LOCAL);
		RETURN ds3;
	END;
	
	// Reduce high-values having trouble deciding where to go
	// Example: {44,33},{44,22},{44,11} => {33,11},{22,11},{44,11}
	SHARED reduce_high_needed(DATASET(PatchRec) ds) := EXISTS(JOIN(ds,ds,LEFT.id1=RIGHT.id1 AND LEFT.id2<>RIGHT.id2,TRANSFORM(LEFT),HASH));
	SHARED reduce_high_once(DATASET(PatchRec) ds, UNSIGNED C=0) := FUNCTION
		ds_min := TABLE(ds,{id1, min_id2:=MIN(GROUP,id2), cnt:=COUNT(GROUP)},id1,MERGE)(cnt>1);
		ds_reduce := JOIN(
			ds,ds_min,
			LEFT.id1=RIGHT.id1 AND LEFT.id2>RIGHT.min_id2,
			TRANSFORM(RECORDOF(LEFT),SELF.id1:=IF(RIGHT.id1=0,LEFT.id1,LEFT.id2),SELF.id2:=IF(RIGHT.id1=0,LEFT.id2,RIGHT.min_id2)),
			LEFT OUTER,KEEP(1),HASH);
		RETURN ds_reduce;
	END;
	EXPORT reduce_high(DATASET(PatchRec) ds) := FUNCTION
		RETURN LOOP(ds, reduce_high_needed(ROWS(LEFT)), reduce_high_once(ROWS(LEFT),COUNTER));
	END;
	
	EXPORT reduce(DATASET(PatchRec) ds) := FUNCTION
		RETURN reduce_chain(reduce_high(ds));
	END;
END;
// ds_in := DATASET([{4,3},{3,2},{2,1},{44,11},{44,22},{44,33}], SALT311.PatchReduce.PatchRec);
// SALT311.PatchReduce.reduce(ds_in);
