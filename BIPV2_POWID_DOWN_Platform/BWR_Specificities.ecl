//This is the code to execute in a builder window
#workunit('name','BIPV2_POWID_DOWN_Platform.BWR_Specificities - Specificities - SALT V2.7 Gold');
IMPORT BIPV2_POWID_DOWN_Platform,SALT27;
IMPORT SALTTOOLS22;
SpecMod := BIPV2_POWID_DOWN_Platform.specificities(BIPV2_POWID_DOWN_Platform.In_POWID_Down);
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
// Uncommenting (and filling in) the following will patch your SPC attribute with the latest values
// See comments in the macro for more options!
// SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_POWID_DOWN_Platform.<your_spc_attribute>',BIPV2_POWID_DOWN_Platform.In_POWID_Down);
