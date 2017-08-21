//This is the code to execute in a builder window
#workunit('name','aherzberg_property_salt.BWR_Specificities - Specificities - SALT V3.0 Alpha 1');
IMPORT aherzberg_property_salt,SALT30;
IMPORT SALTTOOLS22;
SpecMod := aherzberg_property_salt.specificities(aherzberg_property_salt.In_Property_deed);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
// Uncommenting (and filling in) the following will patch your SPC attribute with the latest values
// See comments in the macro for more options!
// SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'aherzberg_property_salt.<your_spc_attribute>',aherzberg_property_salt.In_Property_deed);
