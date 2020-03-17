﻿IMPORT ProfileBooster,ProfileBooster.ProfileBoosterV2_KEL, STD;

EXPORT Fn_Prep_InputPII(DATASET(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Input_Layout) Input,
                ProfileBooster.ProfileBoosterV2_KEL.Interface_Options OptionsRaw,
									ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile KEL_Settings = ProfileBooster.ProfileBoosterV2_KEL.CFG_Compile) := FUNCTION
				
// WARNING: This function assumes you have distributed your InputData dataset 
	// appropriately on Thor already.
	
	// Append the KEL Permissions Required for Viewing the Data

	Options := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_Set_Interface_Options(OptionsRaw, KEL_Settings);
	
  ds_input_slim := 
    PROJECT(
      Input,
      TRANSFORM( ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Input_Layout_Slim,
        SELF.G_ProcUID := 0,
        SELF := LEFT ));
				
	InputEcho := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_InputEcho_THOR( ds_input_slim );	
	output(InputEcho, named('InputEcho'));
	cleanInput := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_CleanInput_THOR( InputEcho );	
	output(cleanInput, named('cleanInput'));
	cleanInput_withUID := 
    PROJECT(
      cleanInput,
      TRANSFORM( ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII,
        SELF.G_ProcUID := COUNTER,
        SELF := LEFT,
				SELF := [] )) : INDEPENDENT;
	output(cleanInput_withUID, named('cleanInput_withUID'));
	// Append LexID
	// withLexID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_AppendLexid_THOR( cleanInput_withUID, Options );				
	// output(withLexID, named('withLexID'));
	//only run if phone is on input, nonFCRA only
	//this key is set up like this because we are not able to return PII from this key, we can only use it for phone verification
	// CheckBureauPhone := IF(~Options.isFCRA, ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_get_bureau_phones(withLexID), withLexID);
	
	//only run if phone is on input, FCRA & nonFCRA 
	// CheckTPMPhone := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_get_tpm_phones.Consumer(CheckBureauPhone, Options);


 RETURN cleanInput_withUID;
 // RETURN withLexID;


 END;				