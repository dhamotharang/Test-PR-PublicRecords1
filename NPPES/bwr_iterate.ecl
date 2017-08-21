//This is the code to execute in a builder window
#workunit('name','NPPES. - Internal Linking - SALT V1.9 Gold')
//Will auto-ingest if possible. Use second parameter of FALSE to prevent
NPPES.Proc_Iterate('1').DoAll; // Change '1' for subsequent iterations
//NPPES.Proc_Iterate('1').DoAllAgain; // Use this version to re-run an iteration
