IMPORT AutoStandardI,doxie_crs, Gateway;

EXPORT iParam :=
MODULE

  // EXPORT SourceServiceParams :=
  // INTERFACE(AutoStandardI.DataRestrictionI.params)
    // EXPORT BOOLEAN   AllowAll              := FALSE;
    // EXPORT BOOLEAN   AllowGLB              := FALSE;
    // EXPORT BOOLEAN   AllowDPPA             := FALSE;
    // EXPORT UNSIGNED1 GLBPurpose            := 0;
    // EXPORT UNSIGNED1 DPPAPurpose           := 0;
    // EXPORT BOOLEAN   IncludeMinors         := FALSE;
		// EXPORT STRING    DataRestrictionMask   := '00000000000000000000';
		// EXPORT BOOLEAN   ignoreFares           := FALSE;
		// EXPORT BOOLEAN   ignoreFidelity        := FALSE;
    // EXPORT BOOLEAN   LnBranded             := FALSE;
		// EXPORT STRING6   SSNMask               := '';
		// EXPORT UNSIGNED1 DLMask                := 0;
		// EXPORT STRING5   IndustryClass         := '';
		// EXPORT STRING32  ApplicationType       := '';
    // EXPORT BOOLEAN   isCRS                 := FALSE;
    // EXPORT BOOLEAN   ProbationOverride     := FALSE;
    // EXPORT STRING8   RecordByDate          := '';
    // EXPORT UNSIGNED1 BankruptcyVersion     := 0;
    // EXPORT UNSIGNED1 CriminalRecordVersion := 0;
    // EXPORT UNSIGNED1 DeaVersion            := 0;
    // EXPORT UNSIGNED1 DlVersion             := 0;
    // EXPORT UNSIGNED1 JudgmentLienVersion   := 0;
    // EXPORT UNSIGNED1 VehicleVersion        := 0;
    // EXPORT UNSIGNED1 VoterVersion          := 0;
    // EXPORT UNSIGNED1 UccVersion            := 0;
    // EXPORT STRING1   DebtorType            := doxie_crs.str_typeDebtor;
  // END;

	EXPORT ProgressivePhoneParams := INTERFACE
		EXPORT DATASET(Gateway.Layouts.Config) Gateways_In := DATASET([], Gateway.Layouts.Config);
		EXPORT BOOLEAN 	 IncludePhonesFeedback			:= FALSE;
    EXPORT BOOLEAN 	 type_a_with_did 						:= FALSE;
    EXPORT BOOLEAN 	 useNeustar 								:= FALSE;
    EXPORT BOOLEAN 	 default_sx_match_limit 		:= FALSE;
    EXPORT BOOLEAN 	 callMetronet 							:= FALSE;
    EXPORT BOOLEAN 	 isPFR 											:= FALSE;
    EXPORT INTEGER 	 metronetLimit 							:= 0;
    EXPORT STRING    ScoreModel             		:= '';
    EXPORT UNSIGNED1 MaxNumAssociate            := 0;
		EXPORT UNSIGNED1 MaxNumAssociateOther       := 0;
		EXPORT UNSIGNED1 MaxNumFamilyOther          := 0;
		EXPORT UNSIGNED1 MaxNumFamilyClose          := 0;
		EXPORT UNSIGNED1 MaxNumParent            		:= 0;
		EXPORT UNSIGNED1 MaxNumSpouse            		:= 0;
		EXPORT UNSIGNED1 MaxNumSubject            	:= 0;
		EXPORT UNSIGNED1 MaxNumNeighbor            	:= 0;
		EXPORT BOOLEAN	 ReturnPhoneScore						:= FALSE;
		EXPORT BOOLEAN 	 Confirmation_GoToGateway 	:= FALSE;
		EXPORT BOOLEAN 	 UsePremiumSource_A 				:= FALSE;
		EXPORT INTEGER 	 PremiumSource_A_limit 			:= 0; 
		EXPORT BOOLEAN 	 RunRelocation 							:= FALSE;
  END;
	
	// Function to initalize the params
	EXPORT getProgressivePhoneParams() :=	FUNCTION
			
			inMod := MODULE(ProgressivePhoneParams)
				EXPORT IncludePhonesFeedback   := FALSE : STORED('IncludePhonesFeedback');
				EXPORT ScoreModel              := ''		: STORED('ScoreModel');
				EXPORT MaxNumAssociate         := 0			: STORED('MaxNumAssociate');
				EXPORT MaxNumAssociateOther    := 0			: STORED('MaxNumAssociateOther');
				EXPORT MaxNumFamilyOther       := 0			: STORED('MaxNumFamilyOther');
				EXPORT MaxNumFamilyClose       := 0			: STORED('MaxNumFamilyClose');
				EXPORT MaxNumParent            := 0			: STORED('MaxNumParent');
				EXPORT MaxNumSpouse            := 0			: STORED('MaxNumSpouse');
				EXPORT MaxNumSubject           := 0			: STORED('MaxNumSubject');
				EXPORT MaxNumNeighbor          := 0			: STORED('MaxNumNeighbor');
				EXPORT ReturnPhoneScore				 := FALSE : STORED('ReturnPhoneScore');
			END;
			
			RETURN inMod;
	END;
	
END;