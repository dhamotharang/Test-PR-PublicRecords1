//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','InsuranceHeader_Property_Transactions_DeedsMortgages.BWR_Specificities - Specificities - SALT V3.4.1');
IMPORT InsuranceHeader_Property_Transactions_DeedsMortgages,SALT34;
IMPORT SALTTOOLS30;
SpecMod := InsuranceHeader_Property_Transactions_DeedsMortgages.specificities(InsuranceHeader_Property_Transactions_DeedsMortgages.In_PROPERTY_TRANSACTION);
// Use the build command to actually build the specificity indexes
//SpecMod.Build;
// Display the specificities and the specificity shifts
// NOTE:This is done by automatically by BWR_Iterate for people doing a full internal build
OUTPUT(SpecMod.Specificities,NAMED('Specificities'));
OUTPUT(SpecMod.SpcShift,NAMED('SpcShift'));
// Uncommenting the line below gives a detailed profile of the specificities of each field
// OUTPUT(SpecMod.AllProfiles,NAMED('SpcProfiles'));
// On repository-based HPCC platforms, the following macro will patch your SPC attribute with the
// latest POPULATION count and specificity/switch values.  See comments in the macro for more options!
// SALTTOOLS30.mac_Patch_SPC(SpecMod.Specificities,'InsuranceHeader_Property_Transactions_DeedsMortgages.<your_spc_attribute>',InsuranceHeader_Property_Transactions_DeedsMortgages.In_PROPERTY_TRANSACTION);
