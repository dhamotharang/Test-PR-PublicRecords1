IMPORT corp2, tools;

EXPORT Build_Bases_Tables(
	STRING																					pfiledate,
	STRING																					pversion,
	BOOLEAN																					puseprod,
	DATASET(Corp2_Raw_VA.Layouts.TablesLayoutIn)		pInTables   	= Corp2_Raw_VA.Files(pfiledate,puseprod).Input.Tables.Logical,
	DATASET(Corp2_Raw_VA.Layouts.TablesLayoutBase)	pBaseTables 	= IF(Corp2_Raw_VA._Flags.Base.Tables, Corp2_Raw_VA.Files(,pUseOtherEnvironment := FALSE).Base.Tables.qa, 	DATASET([], Corp2_Raw_VA.Layouts.TablesLayoutBase))
) := MODULE

	Corp2_Raw_VA.Layouts.TablesLayoutBase standardize_input(Corp2_Raw_VA.Layouts.TablesLayoutIn L) := TRANSFORM
		SELF.action_flag				:= 'U';
		SELF.dt_first_received	:= (INTEGER)pversion;
		SELF.dt_last_received		:= (INTEGER)pversion;
		SELF                    := L;
		SELF                    := [];
	END;

	// Take the VA Tables update file, add received dates, and PROJECT it into the base layout.
	workingUpdate := PROJECT(pInTables, standardize_input(LEFT));

	// Combine base and update career to determine what's new.
	combined 			:= workingUpdate + pBaseTables;
	combined_dist := DISTRIBUTE(combined, HASH(table_id,table_column_value));
	combined_sort := SORT(combined_dist, table_id,table_column_value, RECORD, EXCEPT dt_first_received, dt_last_received, LOCAL);

	Corp2_Raw_VA.Layouts.TablesLayoutBase rollupBase(Corp2_Raw_VA.Layouts.TablesLayoutBase L,
																							     Corp2_Raw_VA.Layouts.TablesLayoutBase R) := TRANSFORM
    SELF.dt_first_received	:= corp2.EarliestDate(L.dt_first_received, R.dt_first_received);
    SELF.dt_last_received 	:= corp2.LatestDate(L.dt_last_received, 	R.dt_last_received);
	  SELF                    := L;
	END;
	
	baseTables	 := ROLLUP(	combined_sort,
													rollupBase(LEFT, RIGHT),
													RECORD,
													EXCEPT dt_first_received, dt_last_received,
													LOCAL);

	// Return
	tools.mac_WriteFile(Corp2_Raw_VA.Filenames(pversion).Base.Tables.New, baseTables, Build_Tables_Base);

	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
											Build_Tables_Base,
											OUTPUT('No Valid version parameter passed, skipping Corp2_Raw_VA.Build_Bases_Tables attribute')
									 );

END;
