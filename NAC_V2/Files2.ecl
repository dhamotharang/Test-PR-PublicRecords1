EXPORT Files2 := MODULE

	export dsContactRecords := DATASET(Superfile_List.sfContactRecords, Layouts2.rStateContactEx, THOR, OPT);
	export dsExceptionRecords := DATASET(Superfile_List.sfExceptionRecords, Layouts2.rExceptionRecord, THOR, OPT);	
	export dsClientRecords := DATASET(Superfile_List.sfClientRecords, Layouts2.rClientEx, THOR, opt);	
	export dsAddressRecords := DATASET(Superfile_List.sfAddressRecords, Layouts2.rAddressEx, THOR, opt);	
	export dsCaseRecords := DATASET(Superfile_List.sfCaseRecords, Layouts2.rCaseEx, THOR, opt);	
	
	export dsNCF2 := DATASET(Superfile_List.sfNCF2, $.Layouts2.rRawFile, CSV, opt);
	export dsNCF2Base := DATASET(Superfile_List.sfNCF2Base, $.Layout_Base2, THOR, opt);
	export dsNCF2PrevBase := DATASET(Superfile_List.sfNCF2Base+'::father', $.Layout_Base2, THOR, opt);
	
	export dsArchive := DATASET($.Superfile_List.sfArchive, $.Layouts2.rRawFile, THOR, opt);
	
	export dsReady := DATASET($.Superfile_list.sfReady, $.Layouts2.rNac2Ex, thor, opt);	
	export dsProcessing := DATASET($.Superfile_list.sfProcessing, $.Layouts2.rNac2Ex, thor, opt);
	export dsProcessed := DATASET($.Superfile_list.sfProcessed, $.Layouts2.rNac2Ex, thor, opt);
	export dsOnboarding := DATASET($.Superfile_list.sfOnboarding, $.Layouts2.rNac2Ex, thor, opt); // test data
	
	export PrevCollisions2  := DATASET(Superfile_List.sfCollisions+'::father', Layout_Collisions2.Layout_Collisions, THOR,opt);


END;
