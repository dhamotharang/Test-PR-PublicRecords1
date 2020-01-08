IMPORT KEL11 AS KEL;
IMPORT ProfileBooster, Business_Risk_BIP, ProfileBooster.ProfileBoosterV2_KEL, STD;

EXPORT FnThor_GetAttrsV11(DATASET(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Input_Layout) InputData,
        ProfileBooster.ProfileBoosterV2_KEL.Interface_Options OptionsRaw,
				ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile KEL_Settings = ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile,
				ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile KEL_Settings_PB = ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile) := FUNCTION

// WARNING: This function assumes you have distributed your InputData dataset 
// appropriately on Thor already.

	// Append the KEL Permissions Required for Viewing the Data
	Options := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Set_Interface_Options(OptionsRaw, KEL_Settings);
	
	//clean input pii and append lexids 
	// Prep_inputPII := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.FnThor_Prep_InputPII(InputData,Options, KEL_Settings);
  // OUTPUT(CHOOSEN(Prep_inputPII,100), named('Prep_inputPII'));

	InputDataPrep := PROJECT(InputData, 
													TRANSFORM(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII, 
															SELF.p_inplexid := (INTEGER)LEFT.LexID;
															SELF.p_lexid := (INTEGER)LEFT.LexID;
															SELF.P_InpAcct := LEFT.Account;
															SELF := LEFT; 
															SELF := [];));

	PB11Attributes := ProfileBooster.ProfileBoosterV2_KEL.FnTHOR_GetPB11Attributes(InputDataPrep, Options, KEL_Settings_PB);
	// PB11Attributes := Prep_inputPII;
  // OUTPUT(CHOOSEN(PB11Attributes,100), named('PB11Attributes_100'));

	RETURN PB11Attributes;
  
 END;