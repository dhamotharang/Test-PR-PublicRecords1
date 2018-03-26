// BWR_Build_Master_HuntFish := 'todo';
IMPORT PRTE, PRTE2_Common, ut, PRTE2_Hunting_Fishing;
#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'PRCT HuntFish Build');

string filedate := ut.GetDate+''; 
DoInternalDOPS := FALSE;

AfterBuildActions := PRTE2_Hunting_Fishing.post_processing_actions(filedate);

// First tests.
// BuildStep := PRTE.Proc_Build_Hunting_Fishing_Keys (filedate);
// BuildStep := PRTE.Proc_Build_Emerges_Keys (filedate);

BuildStep := PRTE2_Hunting_Fishing.Proc_Build_Hunting_Fishing_Keys_new (filedate, DoInternalDOPS);
// BuildStep := PRTE.Proc_Build_Hunting_Fishing_Keys_new (filedate, DoInternalDOPS);
// BuildStep := PRTE.Proc_Build_Hunting_Fishing_Keys (filedate, DoInternalDOPS);

// SEQUENTIAL (BuildStep,AfterBuildActions);
SEQUENTIAL (BuildStep);

/*
researching keys built to audit record counts
prte*key*hunt*20141212*
But that will not find the doxie key
prte*key*20141212*hunt*doxie*
*/


