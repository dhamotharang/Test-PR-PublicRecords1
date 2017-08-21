//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','HealthCareFacilityHeader_Best.BWR_Specificities - Specificities - SALT V3.0 Gold');
IMPORT HealthCareFacilityHeader_Best,SALT30;
IMPORT SALTTOOLS30;
SpecMod := HealthCareFacilityHeader_Best.specificities(HealthCareFacilityHeader_Best.In_HealthFacility);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
// Uncommenting (and filling in) the following will patch your SPC attribute with the latest values
// See comments in the macro for more options!
// SALTTOOLS30.mac_Patch_SPC(SpecMod.Specificities,'HealthCareFacilityHeader_Best.<your_spc_attribute>',HealthCareFacilityHeader_Best.In_HealthFacility);
