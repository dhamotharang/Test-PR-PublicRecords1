IMPORT PublicRecords_KEL;

//NOTE these are INTERNAL MAS LAYOUTS ONLY!

EXPORT Layout_Business_NonFCRA := RECORD
		STRING65 B_InpAcct;
		INTEGER G_ProcBusUID;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBIIInternal - B_InpAcct;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessSeleIDInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutBusinessproxIDInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutBuildDatesInternal;
END;
