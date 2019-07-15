//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Watchdog_best.BWR_Best - BEST - SALT V3.11.7');
IMPORT Watchdog_best,SALT311;
//Best is generated automatically by proc_iterate - this file can perform best production independently
//If you just want to test best - it is easier to build the keys and then use the best service
// Watchdog_best.Keys(Watchdog_best.In_Hdr).BuildData;

// The statistics for the best (also builds all the persists)
Watchdog_best.MAC_CreateBest(Watchdog_best.In_Hdr, , ).Stats;

/* The following can be used to output the actual best results for some purpose
// As defined below they will simply go to the WU - obviously named files can be added
// Note: for TESTING purpose the BestService gives rather more (and better) results

// To enable this section - comment out or delete the first and last lines of the comment
b := Watchdog_best.MAC_CreateBest(Watchdog_best.In_Hdr, , ); // Instantiate Best module

// These are the 'absolute best' results for each field
OUTPUT(b.BestBy_did_best);

// These are the best results for each best_type for each field
OUTPUT(b.BestBy_did_child); // Uses child datasets
OUTPUT(b.BestBy_did); // Wide file - blanks where needed
*/
