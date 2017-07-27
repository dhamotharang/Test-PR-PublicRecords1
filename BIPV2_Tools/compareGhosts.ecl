// This layout is what we recieve from a "Copy as ECL" of the 8th output of a runIngest WU
copy_Record :=
  record
    varstring type;
    unsigned integer4 cnt;
    varstring source;
  end;

IMPORT MDR;

EXPORT compareGhosts(dataset(copy_Record) in_before, dataset(copy_Record) in_after) := FUNCTION
	l_compare := RECORD
		STRING2 source;
		STRING50 sourceName;
		INTEGER  diff_Old;
		DECIMAL13_2 before_pct_ghost;
		DECIMAL13_2 after_pct_ghost;
		UNSIGNED before_Total;
		UNSIGNED after_Total;
		UNSIGNED before_Old;
		UNSIGNED after_Old;
		UNSIGNED before_New;
		UNSIGNED after_New;
		UNSIGNED before_Unchanged;
		UNSIGNED after_Unchanged;
		UNSIGNED before_Updated;
		UNSIGNED after_Updated;
	END;
	
	l_compare toBefore(copy_Record L) := TRANSFORM
		SELF.source						:= L.source;
		SELF.before_Old				:= IF(L.type='Old', L.cnt, 0);
		SELF.before_New				:= IF(L.type='New', L.cnt, 0);
		SELF.before_Unchanged	:= IF(L.type='Unchanged', L.cnt, 0);
		SELF.before_Updated		:= IF(L.type='Updated', L.cnt, 0);
		SELF := [];
	END;
	
	l_compare toAfter(copy_Record L) := TRANSFORM
		SELF.source						:= L.source;
		SELF.after_Old				:= IF(L.type='Old', L.cnt, 0);
		SELF.after_New				:= IF(L.type='New', L.cnt, 0);
		SELF.after_Unchanged	:= IF(L.type='Unchanged', L.cnt, 0);
		SELF.after_Updated		:= IF(L.type='Updated', L.cnt, 0);
		SELF := [];
	END;
	
	l_compare toRoll(l_compare L, l_compare R) := TRANSFORM
		SELF.source						:= IF(L.source<>'', L.source, R.source);
		SELF.sourceName				:= IF(L.sourceName<>'', L.sourceName, MDR.sourceTools.TranslateSource(SELF.source));
		
		SELF.before_Old				:= L.before_Old + R.before_Old;
		SELF.before_New				:= L.before_New + R.before_New;
		SELF.before_Unchanged	:= L.before_Unchanged + R.before_Unchanged;
		SELF.before_Updated		:= L.before_Updated + R.before_Updated;
		SELF.after_Old				:= L.after_Old + R.after_Old;
		SELF.after_New				:= L.after_New + R.after_New;
		SELF.after_Unchanged	:= L.after_Unchanged + R.after_Unchanged;
		SELF.after_Updated		:= L.after_Updated + R.after_Updated;
		
		SELF.diff_Old					:= SELF.after_Old - SELF.before_Old;
		SELF.before_Total			:= SELF.before_old + SELF.before_New + SELF.before_Unchanged + SELF.before_Updated;
		SELF.after_Total			:= SELF.after_old + SELF.after_New + SELF.after_Unchanged + SELF.after_Updated;
		SELF.before_pct_ghost	:= 100.0 * SELF.before_old / SELF.before_Total;
		SELF.after_pct_ghost	:= 100.0 * SELF.after_old / SELF.after_Total;
	END;
	
	ds_flat := PROJECT(in_before, toBefore(LEFT)) + PROJECT(in_after, toAfter(LEFT));
	ds_roll := ROLLUP(SORT(ds_flat,source), toRoll(LEFT,RIGHT), source);
	ds_sort := SORT(ds_roll, -diff_Old, RECORD);
	
	RETURN ds_sort;
END;