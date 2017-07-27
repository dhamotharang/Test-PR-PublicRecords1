//This is the code to execute in a builder window
#workunit('name','BIPV2_Relative.BWR_Specificities - Specificities - SALT V2.5 Gold');
IMPORT BIPV2_Relative,SALT25;
IMPORT SALTTOOLS22;
SpecMod := BIPV2_Relative.specificities(BIPV2_Relative.In_DOT_Base);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
// Uncommenting (and filling in) the following will patch your SPC attribute with the latest values
// See comments in the macro for more options!
// SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_Relative.<your_spc_attribute>',BIPV2_Relative.In_DOT_Base);
