IMPORT KEL11 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetAttrs(DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) InputData,
								PublicRecords_KEL.Interface_Options Options) := FUNCTION
								
	ds_input_slim := 
    PROJECT(InputData,
      TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_Layout_Slim,
        SELF.G_ProcUID := COUNTER,
        SELF := LEFT ));														
								
	Prep_inputPII := PublicRecords_KEL.ECL_Functions.FnRoxie_Prep_InputPII(InputData, Options);
		
	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( Prep_inputPII, Options );

  // Get Attributes - cleans the attributes after KEL is done 
  InputPIIAttributes := KEL.Clean(PublicRecords_KEL.Q_Input_Attributes_V1(Prep_inputPII, (STRING) Prep_inputPII[1].P_InpClnArchDt[1..8], Options.KEL_Permissions_Mask).res0, TRUE, TRUE, TRUE);
	
	PersonAttributes := PublicRecords_KEL.FnRoxie_GetPersonAttributes(Prep_inputPII, FDCDataset, Options); 

	withPersonAttributes := JOIN(InputPIIAttributes, PersonAttributes, LEFT.G_ProcUID = RIGHT.G_ProcUID,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));

	MasterResults := SORT(withPersonAttributes, G_ProcUID);
	
	IF(Options.OutputMasterResults, OUTPUT(MasterResults, NAMED('MasterResults')));
  RETURN MasterResults;
 END;

 