//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_ProxID.BWR_Best - BEST - SALT V3.11.3');
IMPORT BIPV2_ProxID,SALT311;
//Best is generated automatically by proc_iterate - this file can perform best production independently
//If you just want to test best - it is easier to build the keys and then use the best service
// BIPV2_ProxID.Keys(BIPV2_ProxID.In_DOT_Base).BuildData;
 
// The statistics for the best (also builds all the persists)
BIPV2_ProxID.MAC_CreateBest(BIPV2_ProxID.In_DOT_Base, , ).Stats;
 
/* The following can be used to output the actual best results for some purpose
// As defined below they will simply go to the WU - obviously named files can be added
// Note: for TESTING purpose the BestService gives rather more (and better) results
 
// To enable this section - comment out or delete the first and last lines of the comment
b := BIPV2_ProxID.MAC_CreateBest(BIPV2_ProxID.In_DOT_Base, , ); // Instantiate Best module
 
// These are the 'absolute best' results for each field
OUTPUT(b.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_best);
 
// These are the best results for each best_type for each field
OUTPUT(b.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip_child); // Uses child datasets
OUTPUT(b.BestBy_cnp_name_prim_name_derived_v_city_name_st_zip); // Wide file - blanks where needed
*/
