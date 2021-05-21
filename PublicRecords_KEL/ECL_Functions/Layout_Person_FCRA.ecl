IMPORT PublicRecords_KEL;

//NOTE these are INTERNAL MAS LAYOUTS ONLY!

EXPORT Layout_Person_FCRA := RECORD
		INTEGER G_ProcUID;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPIIInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutPersonInternal;
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutInferredAttributesInternal;
		// PublicRecords_KEL.ECL_Functions.Layouts.LayoutHighRiskAddressInternal;//one day
		PublicRecords_KEL.ECL_Functions.Layouts.LayoutBuildDatesInternal;

END;