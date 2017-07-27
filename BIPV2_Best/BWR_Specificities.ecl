//This is the code to execute in a builder window
#workunit('name','BIPV2_Best.BWR_Specificities - Specificities - SALT V2.4 Gold');
IMPORT BIPV2_Best,SALT24;
IMPORT SALTTOOLS22;
SpecMod := BIPV2_Best.specificities(BIPV2_Best.In_Base);
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
// Uncommenting (and filling in) the following will patch your SPC attribute with the latest values
// See comments in the macro for more options!
// SALTTOOLS22.mac_Patch_SPC(SpecMod.Specificities,'BIPV2_Best.<your_spc_attribute>',BIPV2_Best.In_Base);
