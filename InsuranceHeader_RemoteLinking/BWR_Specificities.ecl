//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_RemoteLinking.BWR_Specificities - Specificities - SALT V3.7.2');
IMPORT InsuranceHeader_RemoteLinking,SALT37;
SpecMod := InsuranceHeader_RemoteLinking.specificities(InsuranceHeader_RemoteLinking.File_HEADER);
// Use the build command to actually build the specificity indexes
//SpecMod.Build;
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
 
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
 
// The following macro OUTPUTs your SPC file patched with the latest POPULATION count and
// specificity/switch values.  See comments in the macro for more options!
// IMPORT SALTTOOLS30;
// SpcPatch := SALTTOOLS30.mac_Patch_spcString(SpecMod.Specificities,InsuranceHeader_RemoteLinking.File_HEADER,InsuranceHeader_RemoteLinking.GenerationMod.spcString);
// OUTPUT(SpcPatch,NAMED('SpcPatch'));
 
