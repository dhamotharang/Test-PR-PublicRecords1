//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BizLinkFull.BWR_Specificities - Specificities - SALT V4.4.1');
IMPORT BizLinkFull,SALT44;
SpecMod := BizLinkFull.Specificities(BizLinkFull.File_BizHead);
// Use the build command to actually build the specificity indexes
// This MUST be run before SpecMod.Specificities or SpecMod.SpcShift below to ensure the
//   indexes exist!!!
// SpecMod.Build;
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
// OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
// OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
 
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
 
// The following macro OUTPUTs your SPC file patched with the latest POPULATION count and
// specificity/switch values.  See comments in the macro for more options!
// IMPORT SALTTOOLS4;
// SpcPatch := SALTTOOLS4.mac_Patch_spcString(SpecMod.Specificities,BizLinkFull.File_BizHead,BizLinkFull.GenerationMod.spcString);
// OUTPUT(SpcPatch,NAMED('SpcPatch'));
 
