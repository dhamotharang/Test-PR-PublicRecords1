IMPORT KEL011 AS KEL;
IMPORT PublicRecords_KEL;

EXPORT FnRoxie_GetAttrs(DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) InputData,
                INTEGER Score_threshold = 80) := FUNCTION

  // Clean input
  cleanInput := PublicRecords_KEL.ECL_Functions.Fn_CleanInput_Roxie( InputData );
  
  // Append LexID
  withLexID := PublicRecords_KEL.ECL_Functions.Fn_AppendLexid_Roxie( cleanInput, Score_threshold );

  //Put in format for Attributes
  InputAttrs := PROJECT(withLexID, TRANSFORM(PublicRecords_KEL.ECL_Functions.AttrWithDate_Layout,
    SELF := LEFT,
    SELF := []));
    
  // Get Attributes - cleans the attributes after KEL is done 
  InputPII := KEL.Clean(PublicRecords_KEL.Q_Input_Attributes_V1(InputAttrs, (INTEGER) InputAttrs.ArchiveDate[1..8]).res0, TRUE, TRUE, TRUE);
	//Cast Attributes back to their string values
  InputPII_Attrs := project(InputPII, transform(PublicRecords_KEL.ECL_Functions.Attr_Layout, 
		SELF.inputCleanDOB := (STRING) LEFT.inputCleanDOB;
		SELF := LEFT)); 
  InputPII_srtd := SORT( InputPII_Attrs, InputID ); 
	
  RETURN InputPII_srtd;
 END;

 