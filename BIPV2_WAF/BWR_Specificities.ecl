//This is the code to execute in a builder window
#workunit('name','BIPV2_WAF.BWR_Specificities - Specificities - SALT V2.9 Beta 3');
IMPORT BIPV2_WAF,SALT29;
IMPORT SALTTOOLS22;
SpecMod := BIPV2_WAF.specificities(BIPV2_WAF.File_BizHead);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
// Uncommenting (and filling in) the following will patch your SPC attribute with the latest values
// See comments in the macro for more options!
// SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_WAF.<your_spc_attribute>',BIPV2_WAF.File_BizHead);
