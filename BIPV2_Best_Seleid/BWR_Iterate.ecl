//This is the code to execute in a builder window
#workunit('name','BIPV2_Best_Seleid.BWR_Iterate - Internal Linking - SALT V2.8 Gold SR1');
IMPORT BIPV2_Best_Seleid,SALT28;
//Proc_Iterate also supports a dataset parameter to allow an arbitrary file as starting point.
//Proc_Iterate also supports a threshold parameter to override the default threshold.
// If the debugging parameter is set to off the build will go a little quicker but the debug services (such as the compare service) will not be available.
P := BIPV2_Best_Seleid.Proc_Iterate('1'); // Change '1' for later iterations
P.DoAll; // Change '1' for subsequent iterations
// P.DoAllAgain; // Use this version to re-run an iteration
// If IdConsistency0 has problems then you should run THIS to see if the input was valid
// P.InputValidityStats;
