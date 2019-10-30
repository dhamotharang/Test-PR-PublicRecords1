//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_DOTID_PLATFORM.BWR_Specificities - Specificities - SALT V3.2.0');
IMPORT BIPV2_DOTID_PLATFORM,SALT32;
IMPORT SALTTOOLS30;
SpecMod := BIPV2_DOTID_PLATFORM.specificities(BIPV2_DOTID_PLATFORM.In_DOT);
// Use the build command to actually build the specificity indexes
//SpecMod.Build;
// This gives statistics on records counts per partition
  OUTPUT(SpecMod.PartitionCounts,NAMED('Partitions'));
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
 
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
 
// On repository-based HPCC platforms, the following macro will patch your SPC attribute with the
// latest POPULATION count and specificity/switch values.  See comments in the macro for more options!
// SALTTOOLS30.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_DOTID_PLATFORM.<your_spc_attribute>',BIPV2_DOTID_PLATFORM.In_DOT);
 
