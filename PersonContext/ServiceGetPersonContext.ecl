IMPORT PersonContext;

EXPORT ServiceGetPersonContext() := FUNCTION
// Query: ServiceGetPersonContext
// Purpose: To supply PersonContext data to systems calling from outside of the Roxie.

	PCRequestIn := DATASET([], PersonContext.Layouts.Layout_PCRequest) : STORED('PersonContextRequest'); 
	PCRequest  	:= PCRequestIn[1];
	PCResponse	:= PersonContext.GetPersonContext(PCRequest, FALSE);
	RETURN OUTPUT(PCResponse, NAMED('PersonContextResponse'));

END;
