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
  withLexID := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanInput, Options );

  //Put in format for Attributes
  InputAttrs := PROJECT(withLexID, TRANSFORM(PublicRecords_KEL.ECL_Functions.Attr_Layout,
    SELF := LEFT,
    SELF := []));
		
	FDCDataset := PublicRecords_KEL.Fn_MAS_FCRA_FDC( InputAttrs, Options );

  // Get Attributes - cleans the attributes after KEL is done 
  InputPII := KEL.Clean(PublicRecords_KEL.Q_Input_Attributes_V1(InputAttrs, (STRING) InputAttrs[1].InputArchiveDateClean[1..8]).res0, TRUE, TRUE, TRUE);
	// Cast Attributes back to their string values
  InputPII_Attrs := project(InputPII, transform(PublicRecords_KEL.ECL_Functions.Attr_Layout, 
		SELF := LEFT)); 
  InputPII_srtd := SORT( InputPII_Attrs, InputUIDAppend ); 
	
  RETURN InputPII_srtd;

 END;

 