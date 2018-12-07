IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetAttrs(DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) InputData,
								PublicRecords_KEL.Interface_Options Options) := FUNCTION
								
	ds_input_slim := 
    PROJECT(InputData,
      TRANSFORM( PublicRecords_KEL.ECL_Functions.Input_Layout_Slim,
        SELF.InputUIDAppend := COUNTER,
        SELF := LEFT ));														
								
	// Echo input
	InputEcho := PublicRecords_KEL.ECL_Functions.Fn_InputEcho_Roxie( ds_input_slim );	

  // Clean input
  cleanInput := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( InputEcho );
  
  // Append LexID
  withLexID := IF(Options.isFCRA, 
		PublicRecords_KEL.ECL_Functions.Neutral_Lexid_Soapcall(cleanInput, Options), //FCRA uses soapcall
		PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanInput, Options ));
		
	FDCDataset := PublicRecords_KEL.Fn_MAS_FDC( withLexID, Options );

  // Get Attributes - cleans the attributes after KEL is done 
  InputPIIAttributes := KEL.Clean(PublicRecords_KEL.Q_Input_Attributes_V1(withLexID, (STRING) withLexID[1].InputArchiveDateClean[1..8]).res0, TRUE, TRUE, TRUE);
	
	PersonAttributes := PublicRecords_KEL.FnRoxie_GetPersonAttributes(withLexID, FDCDataset, Options); 

	withPersonAttributes := JOIN(InputPIIAttributes, PersonAttributes, LEFT.InputUIDAppend = RIGHT.InputUIDAppend,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutMaster,
			SELF := RIGHT,
			SELF := LEFT,
			SELF := []),
		LEFT OUTER, KEEP(1), ATMOST(100));

	MasterResults := SORT(withPersonAttributes, InputUIDAppend);
	
	IF(Options.OutputMasterResults, OUTPUT(MasterResults, NAMED('MasterResults')));

  RETURN MasterResults;
 END;

 