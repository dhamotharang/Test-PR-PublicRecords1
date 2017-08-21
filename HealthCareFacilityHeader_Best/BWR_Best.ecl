//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareFacilityHeader_Best.BWR_Best - BEST - SALT V3.0 Gold');
IMPORT HealthCareFacilityHeader_Best,SALT30;
//Best is generated automatically by proc_iterate - this file can perform best production independently//If you just want to test best - it is easier to build the keys and then use the best service
// HealthCareFacilityHeader_Best.Keys(HealthCareFacilityHeader_Best.In_HealthFacility).BuildData;
// The statistics for the best (also builds all the persists)
HealthCareFacilityHeader_Best.Best(HealthCareFacilityHeader_Best.In_HealthFacility).Stats;
/* The following can be used to output the actual best results for some purpose
// As defined below they will simply go to the WU - obviously named files can be added
// Note: for TESTING purpose the BestService gives rather more (and better) results
// To enable this section - comment out or delete the first and last lines of the comment
b := HealthCareFacilityHeader_Best.Best(HealthCareFacilityHeader_Best.In_HealthFacility); // Instantiate Best module
// These are the 'absolute best' results for each field
OUTPUT(b.BestBy_LNPID_best);
OUTPUT(b.BestBy_LNPID__LIC_STATE_best);
// These are the best results for each best_type for each field
OUTPUT(b.BestBy_LNPID_child); // Uses child datasets
OUTPUT(b.BestBy_LNPID); // Wide file - blanks where needed
OUTPUT(b.BestBy_LNPID__LIC_STATE_child); // Uses child datasets
OUTPUT(b.BestBy_LNPID__LIC_STATE); // Wide file - blanks where needed
*/
