IMPORT PRTE, PRTE2_Common, ut;

#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'PRCT FAA Build');

string filedate := ut.GetDate+''; 
DoDOPS := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;
// DoDOPS := PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;

BuildStep := PRTE.Proc_Build_FAA_Keys (filedate, DoDOPS);
SEQUENTIAL (BuildStep);
/*
NOTES:	The opening of the Proc_Build_FAA_Keys will need to then be:
export	Proc_Build_FAA_Keys (string filedate, boolean doDOPS=TRUE)	:=

that will default it to TRUE so that it behavies the same for the Boca people.
that way it will work even if a boca person does this the old way.
	PRTE.Proc_Build_Phonesplusv2_Keys (filedate);
*/