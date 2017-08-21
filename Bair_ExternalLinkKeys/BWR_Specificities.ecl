//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Bair_ExternalLinkKeys.BWR_Specificities - Specificities - SALT V3.3.0');
IMPORT Bair_ExternalLinkKeys,SALT33;
IMPORT SALTTOOLS30;
SpecMod := Bair_ExternalLinkKeys.specificities(Bair_ExternalLinkKeys.File_Classify_PS);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
 
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
 
// On repository-based HPCC platforms, the following macro will patch your SPC attribute with the
// latest POPULATION count and specificity/switch values.  See comments in the macro for more options!
// SALTTOOLS30.mac_Patch_SPC(SpecMod.Specificities,'Bair_ExternalLinkKeys.<your_spc_attribute>',Bair_ExternalLinkKeys.File_Classify_PS);
 
