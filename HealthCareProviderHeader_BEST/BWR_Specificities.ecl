//This is the code to execute in a builder window
#workunit('name','HealthCareProviderHeader_BEST.BWR_Specificities - Specificities - SALT V2.9 Beta 3');
IMPORT HealthCareProviderHeader_BEST,SALT29;
IMPORT SALTTOOLS22;
SpecMod := HealthCareProviderHeader_BEST.specificities(HealthCareProviderHeader_BEST.In_HealthProvider);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
// Uncommenting (and filling in) the following will patch your SPC attribute with the latest values
// See comments in the macro for more options!
// SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'HealthCareProviderHeader_BEST.<your_spc_attribute>',HealthCareProviderHeader_BEST.In_HealthProvider);
