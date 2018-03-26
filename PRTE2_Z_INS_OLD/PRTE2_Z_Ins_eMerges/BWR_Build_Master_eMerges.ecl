IMPORT PRTE, PRTE2_Common, ut, PRTE2_eMerges;
#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'PRCT Ccw Build');

string filedate := ut.GetDate+''; 
DoInternalDOPS := FALSE;

AfterBuildActions := PRTE2_eMerges.post_processing_actions(filedate);

// First tests.
// BuildStep := PRTE.Proc_Build_ccw_Keys (filedate);
// BuildStep := PRTE.Proc_Build_Emerges_Keys (filedate);

BuildStep := PRTE2_eMerges.proc_build_ccw_keys_new(filedate, DoInternalDOPS);
// BuildStep := PRTE.Proc_Build_ccw_Keys_new (filedate, DoInternalDOPS);
// BuildStep := PRTE.Proc_Build_ccw_Keys (filedate, DoInternalDOPS);

// SEQUENTIAL (BuildStep,AfterBuildActions);
SEQUENTIAL (BuildStep);

/*
researching keys built to audit record counts
prte*key*ccw*20141212*
But that will not find the doxie key
prte*key*20141212*ccw*doxie*
*/


