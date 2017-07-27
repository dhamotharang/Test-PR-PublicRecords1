//This is the code to execute in a builder window
#workunit('name','BIPV2_Best.BWR_Best - BEST - SALT V2.4 Gold');
IMPORT BIPV2_Best,SALT24;
//Best is generated automatically by proc_iterate - this file can perform best production independently//If you just want to test best - it is easier to build the keys and then use the best service
// BIPV2_Best.Keys(BIPV2_Best.In_Base).BuildData;
// The statistics for the best (also builds all the persists)
BIPV2_Best.Best(BIPV2_Best.In_Base).Stats;
/* The following can be used to output the actual best results for some purpose
// As defined below they will simply go to the WU - obviously named files can be added
// Note: for TESTING purpose the BestService gives rather more (and better) results
// To enable this section - comment out or delete the first and last lines of the comment
b := BIPV2_Best.Best(BIPV2_Best.In_Base); // Instantiate Best module
// These are the 'absolute best' results for each field
OUTPUT(b.BestBy_Proxid_best);
// These are the best results for each best_type for each field
OUTPUT(b.BestBy_Proxid_child); // Uses child datasets
OUTPUT(b.BestBy_Proxid); // Wide file - blanks where needed
*/
