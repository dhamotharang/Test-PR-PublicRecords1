IMPORT ProfileBooster, ProfileBooster.ProfileBoosterV2_KEL, STD;

EXPORT FnThor_Prep_InputPII(DATASET(ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Input_Layout) Input,
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
  OUTPUT(CHOOSEN(InputEcho,100),named('fnThorPrep_InputEcho'));
	cleanInput := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_CleanInput_THOR( InputEcho );	
  OUTPUT(CHOOSEN(cleanInput,100),named('fnThorPrep_cleanInput'));

	cleanInput_withUID := 
    PROJECT(
      cleanInput,
      TRANSFORM( ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutInputPII,
        SELF.G_ProcUID := COUNTER,
        SELF := LEFT,
				SELF := [] )) : INDEPENDENT;

  OUTPUT(CHOOSEN(cleanInput_withUID,100),named('fnThorPrep_cleanInput_withUID'));


	// Append LexID
	withLexID := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Fn_AppendLexid_THOR( cleanInput_withUID, Options );				
	OUTPUT(CHOOSEN(withLexID,100),named('fnThorPrep_withLexID'));

	//only run if phone is on input, nonFCRA only
	//this key is set up like this because we are not able to return PII from this key, we can only use it for phone verification
	// CheckBureauPhone := IF(~Options.isFCRA, ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.FnThor_Get_Bureau_Phones(withLexID), withLexID);
	
	//only run if phone is on input, FCRA & nonFCRA 
	// CheckTPMPhone := ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.FnThor_Get_TPM_Phones.Consumer(CheckBureauPhone, Options);


 RETURN withLexID;


 END;				