//This is the code to execute in a builder window
#workunit('name','HealthCareProviderHeader_BEST.BWR_Best - BEST - SALT V2.9 Beta 3');
IMPORT HealthCareProviderHeader_BEST,SALT29;
//Best is generated automatically by proc_iterate - this file can perform best production independently//If you just want to test best - it is easier to build the keys and then use the best service
// HealthCareProviderHeader_BEST.Keys(HealthCareProviderHeader_BEST.In_HealthProvider).BuildData;
// The statistics for the best (also builds all the persists)
HealthCareProviderHeader_BEST.Best(HealthCareProviderHeader_BEST.In_HealthProvider).Stats;
/* The following can be used to output the actual best results for some purpose
// As defined below they will simply go to the WU - obviously named files can be added
// Note: for TESTING purpose the BestService gives rather more (and better) results
// To enable this section - comment out or delete the first and last lines of the comment
b := HealthCareProviderHeader_BEST.Best(HealthCareProviderHeader_BEST.In_HealthProvider); // Instantiate Best module
// These are the 'absolute best' results for each field
OUTPUT(b.BestBy_LNPID__DOB_best);
OUTPUT(b.BestBy_LNPID__ADDRESS_ID_best);
OUTPUT(b.BestBy_LNPID_best);
OUTPUT(b.BestBy_LNPID__CNSMR_DOB_best);
OUTPUT(b.BestBy_LNPID__LIC_STATE_best);
OUTPUT(b.BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_best);
OUTPUT(b.BestBy_LNPID_ZIP_best);
// These are the best results for each best_type for each field
OUTPUT(b.BestBy_LNPID__DOB_child); // Uses child datasets
OUTPUT(b.BestBy_LNPID__DOB); // Wide file - blanks where needed
OUTPUT(b.BestBy_LNPID__ADDRESS_ID_child); // Uses child datasets
OUTPUT(b.BestBy_LNPID__ADDRESS_ID); // Wide file - blanks where needed
OUTPUT(b.BestBy_LNPID_child); // Uses child datasets
OUTPUT(b.BestBy_LNPID); // Wide file - blanks where needed
OUTPUT(b.BestBy_LNPID__CNSMR_DOB_child); // Uses child datasets
OUTPUT(b.BestBy_LNPID__CNSMR_DOB); // Wide file - blanks where needed
OUTPUT(b.BestBy_LNPID__LIC_STATE_child); // Uses child datasets
OUTPUT(b.BestBy_LNPID__LIC_STATE); // Wide file - blanks where needed
OUTPUT(b.BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP_child); // Uses child datasets
OUTPUT(b.BestBy_LNPID_PRIM_RANGE_PRIM_NAME_ZIP); // Wide file - blanks where needed
OUTPUT(b.BestBy_LNPID_ZIP_child); // Uses child datasets
OUTPUT(b.BestBy_LNPID_ZIP); // Wide file - blanks where needed
*/
