IMPORT KEL12 AS KEL;
IMPORT ProfileBooster, Business_Risk_BIP, ProfileBooster.ProfileBoosterV2_KEL, STD;

EXPORT FnThor_GetAttrsV11(DATASET(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Input_Layout) InputData,
        ProfileBooster.ProfileBoosterV2_KEL.Interface_Options OptionsRaw,
				ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile KEL_Settings_PB = ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile) := FUNCTION

// WARNING: This function assumes you have distributed your InputData dataset 
// appropriately on Thor already.

	mod_transforms := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Transforms;
	
	InputDataPrep := PROJECT(InputData, mod_transforms.xfm_InputDataPrep(LEFT),LOCAL);

	PB11Attributes := ProfileBooster.ProfileBoosterV2_KEL.FnTHOR_GetPB11Attributes(InputDataPrep, OptionsRaw, KEL_Settings_PB);

	//DEBUGGING
  // OUTPUT(CHOOSEN(InputDataPrep,100), named('InputDataPrep_100'));
  // OUTPUT(CHOOSEN(Prep_inputPII,100), named('Prep_inputPII_100'));
  // OUTPUT(CHOOSEN(PB11Attributes,100), named('PB11Attributes_100'));
	
	RETURN PB11Attributes;
  
 END;