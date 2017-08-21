//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_GA_Main.BWR_Specificities - Specificities - SALT V3.4.3');
IMPORT Scrubs_Corp2_Mapping_GA_Main,SALT34;
IMPORT SALTTOOLS30;
SpecMod := Scrubs_Corp2_Mapping_GA_Main.specificities(Scrubs_Corp2_Mapping_GA_Main.In_in_file);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
 
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
 
// On repository-based HPCC platforms, the following macro will patch your SPC attribute with the
// latest POPULATION count and specificity/switch values.  See comments in the macro for more options!
// SALTTOOLS30.mac_Patch_SPC(SpecMod.Specificities,'Scrubs_Corp2_Mapping_GA_Main.<your_spc_attribute>',Scrubs_Corp2_Mapping_GA_Main.In_in_file);
 
