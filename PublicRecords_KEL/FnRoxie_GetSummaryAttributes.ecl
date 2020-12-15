IMPORT KEL13 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetSummaryAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) InputData,
																		PublicRecords_KEL.Interface_Options Options,
																		DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset) := FUNCTION
            
	NSumAttributes := PublicRecords_KEL.FnRoxie_NSumAttributes(InputData, Options, FDCDataset);
	SSNSumAttributes := PublicRecords_KEL.FnRoxie_GetSSNSumInputPIIAttributes(InputData, Options, FDCDataset);
	PhoneSumAttributes := PublicRecords_KEL.FnRoxie_PhoneSumAttributes(InputData, Options, FDCDataset);
	AddressSummaryAttributes := PublicRecords_KEL.FnRoxie_AddrSummaryAttributes(InputData, Options, FDCDataset);
	
	withNSumAttributes := JOIN(InputData, NSumAttributes, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutALLSumAttributes,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));	
		
	withSSNSumAttributes := JOIN(withNSumAttributes, SSNSumAttributes, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutALLSumAttributes,
			SELF := RIGHT,
			SELF := LEFT),
		LEFT OUTER, KEEP(1), ATMOST(100));	
		
	withPhoneSumAttributes := JOIN(withSSNSumAttributes, PhoneSumAttributes, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutALLSumAttributes,
			SELF := RIGHT,
			SELF := LEFT),
		LEFT OUTER, KEEP(1), ATMOST(100));			
		
	withAddrSummaryAttributes := JOIN(withPhoneSumAttributes, AddressSummaryAttributes, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutALLSumAttributes,
			SELF := RIGHT,
			SELF := LEFT),
		LEFT OUTER, KEEP(1), ATMOST(100));
					
	RETURN SORT(withAddrSummaryAttributes, G_ProcUID);
END;
		