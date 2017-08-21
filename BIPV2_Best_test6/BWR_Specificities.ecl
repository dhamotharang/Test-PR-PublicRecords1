//This is the code to execute in a builder window
#workunit('name','BIPV2_Best_test6.BWR_Specificities - Specificities - SALT V2.7 Beta 1');
IMPORT BIPV2_Best_test6,SALT27;
IMPORT SALTTOOLS22;
SpecMod := BIPV2_Best_test6.specificities(BIPV2_Best_test6.In_Base);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
// Uncommenting (and filling in) the following will patch your SPC attribute with the latest values
// See comments in the macro for more options!
// SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_Best_test6.<your_spc_attribute>',BIPV2_Best_test6.In_Base);
