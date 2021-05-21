IMPORT PublicRecords_KEL;

//NOTE these are INTERNAL MAS LAYOUTS ONLY!

EXPORT Layout_Person_NonFCRA := RECORD
		INTEGER G_ProcUID;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPIIInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutPersonInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutNSumInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutSSNSumInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutPhoneSumInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutAddrSummaryInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutHighRiskAddressInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutBuildDatesInternal;


END;