EXPORT Files2 := MODULE

	export dsContactRecords := DATASET(Superfile_List.sfContactRecords, Layouts2.rStateContactEx, THOR, OPT);
	export dsExceptionRecords := DATASET(Superfile_List.sfExceptionRecords, Layouts2.rExceptionRecord, THOR, OPT);	
	export dsClientRecords := DATASET(Superfile_List.sfClientRecords, Layouts2.rClientEx, THOR, opt);	
	export dsAddressRecords := DATASET(Superfile_List.sfAddressRecords, Layouts2.rAddressEx, THOR, opt);	
	export dsCaseRecords := DATASET(Superfile_List.sfCaseRecords, Layouts2.rCaseEx, THOR, opt);	
	
	export dsNCF2 := DATASET(Superfile_List.sfNCF2, Layouts2.rNac2, THOR, opt);
	export dsNCF2Base := DATASET(Superfile_List.sfNCF2Base, $.Layout_Base2, THOR, opt);
	
	export dsReady := DATASET($.Superfile_list.sfReady, $.Layout_Base2, thor, opt);	
	export dsProcessing := DATASET($.Superfile_list.sfProcessing, $.Layout_Base2, thor, opt);
	export dsProcessed := DATASET($.Superfile_list.sfProcessed, $.Layout_Base2, thor, opt);
	export dsOnboarding := DATASET($.Superfile_list.sfOnboarding, $.Layout_Base2, thor, opt); // test data

END;