﻿EXPORT Files2 := MODULE

	export dsContactRecords := DATASET(Superfile_List.sfContactRecords, Layouts2.rStateContactEx, THOR, OPT);
	export dsExceptionRecords := DATASET(Superfile_List.sfExceptionRecords, Layouts2.rExceptionRecord, THOR, OPT);	
	export dsClientRecords := DATASET(Superfile_List.sfClientRecords, Layouts2.rClientEx, THOR);	
	export dsAddressRecords := DATASET(Superfile_List.sfAddressRecords, Layouts2.rAddressEx, THOR);	
	export dsCaseRecords := DATASET(Superfile_List.sfCaseRecords, Layouts2.rCaseEx, THOR);	
	
	export dsNCF2 := DATASET(Superfile_List.sfNCF2, Layouts2.rNac2, THOR);
	
	export dsProcessing := DATASET($.Superfile_list.sfProcessing, $.Layout_Base2, thor);

END;