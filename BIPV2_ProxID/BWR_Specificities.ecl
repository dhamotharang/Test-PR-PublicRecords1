//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_ProxID.BWR_Specificities - Specificities - SALT V3.7.0');
IMPORT BIPV2_ProxID,SALT37;
SpecMod := BIPV2_ProxID.specificities(BIPV2_ProxID.In_DOT_Base);
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
 
// The following macro OUTPUTs your SPC file patched with the latest POPULATION count and
// specificity/switch values.  See comments in the macro for more options!
// IMPORT SALTTOOLS30;
// SpcPatch := SALTTOOLS30.mac_Patch_spcString(SpecMod.Specificities,BIPV2_ProxID.In_DOT_Base,BIPV2_ProxID.GenerationMod.spcString);
// OUTPUT(SpcPatch,NAMED('SpcPatch'));
 
