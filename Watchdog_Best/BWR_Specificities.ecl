//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Watchdog_best.BWR_Specificities - Specificities - SALT V3.11.7');
IMPORT Watchdog_best,SALT311;
SpecMod := Watchdog_best.Specificities(Watchdog_best.In_Hdr);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));

// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));

// The following macro OUTPUTs your SPC file patched with the latest POPULATION count and
// specificity/switch values.  See comments in the macro for more options!
// IMPORT SALTTOOLS30;
// SpcPatch := SALTTOOLS30.mac_Patch_spcString(SpecMod.Specificities,Watchdog_best.In_Hdr,Watchdog_best.GenerationMod.spcString);
// OUTPUT(SpcPatch,NAMED('SpcPatch'));

