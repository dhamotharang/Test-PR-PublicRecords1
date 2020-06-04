//This is the code to execute in a builder window
#workunit('name','BIPV2_DOTID_PLATFORM.BWR_Best - BEST - SALT V2.4 Beta 2');
IMPORT BIPV2_DOTID_PLATFORM,SALT24;
//Best is generated automatically by proc_iterate - this file can perform best production independently//If you just want to test best - it is easier to build the keys and then use the best service
// BIPV2_DOTID_PLATFORM.Keys(BIPV2_DOTID_PLATFORM.In_DOT).BuildData;

// The statistics for the best (also builds all the persists)
BIPV2_DOTID_PLATFORM.Best(BIPV2_DOTID_PLATFORM.In_DOT).Stats;

/* The following can be used to output the actual best results for some purpose
// As defined below they will simply go to the WU - obviously named files can be added
// Note: for TESTING purpose the BestService gives rather more (and better) results

// To enable this section - comment out or delete the first and last lines of the comment
b := BIPV2_DOTID_PLATFORM.Best(BIPV2_DOTID_PLATFORM.In_DOT); // Instantiate Best module

// These are the 'absolute best' results for each field
OUTPUT(b.BestBy_DOTid_best);

// These are the best results for each best_type for each field
OUTPUT(b.BestBy_DOTid_child); // Uses child datasets
OUTPUT(b.BestBy_DOTid); // Wide file - blanks where needed
*/
