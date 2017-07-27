EXPORT getAbilityIndex(grouped dataset(riskview.layouts.attributes_internal_layout) ds_in ) := function

// mydebug := record
	// real subScore0; real subscore1; real subscore2; real subscore3; real subscore4; real subscore5; real subscore6; real subscore7; real subScore8;
	// riskview.layouts.attributes_internal_layout;
// end;

	
riskview.layouts.attributes_internal_layout add_ability(ds_in le) := transform
// mydebug add_ability(ds_in le) := transform

	NULL := -999999999;

	SubjectRecordTimeOldest := (integer)le.SubjectRecordTimeOldest;
	SubjectDeceased := (integer)le.SubjectDeceased;
	ConfirmationSubjectFound := (integer)le.ConfirmationSubjectFound;
	EducationEvidence := (integer)le.EducationEvidence;
	EducationInstitutionRating := (integer)le.EducationInstitutionRating;
	assetprop := (integer)le.assetprop;
	AssetPropCurrentCount := (integer)le.AssetPropCurrentCount;
	AssetPropCurrentTaxTotal := (integer)le.AssetPropCurrentTaxTotal;
	AssetPersonalCount := (integer)le.AssetPersonalCount;
	PurchaseActivityCount := (integer)le.PurchaseActivityCount;
	PurchaseActivityDollarTotal := (integer)le.PurchaseActivityDollarTotal;
	LienJudgmentTaxCount := (integer)le.LienJudgmentTaxCount;
	BankruptcyChapter := (integer)le.BankruptcyChapter;
	BankruptcyStatus := (integer)le.BankruptcyStatus;
	SSNDeceased := (integer)le.SSNDeceased;
	AddrCurrentOwnershipIndex := (integer)le.AddrCurrentOwnershipIndex;
	AddrCurrentAVMValue := (integer)le.AddrCurrentAVMValue;


	/* SubjectRecordTimeOldest */
		subScore0 := map( SubjectRecordTimeOldest < 1 => 0.000000,
											SubjectRecordTimeOldest < 181 => -0.033509,
											0.019642 );
															
		RCValueC10 := 0.019642 - subScore0;				

	/* AssetProp */
		subScore1 := map( AssetProp < 0 => 0.000000,
											AssetProp < 1 => -0.175275,
											0.136419 );
		RCValueA41 :=  0.136419 - subScore1;	
			 

	/* AssetPersonalCount */
	subScore2 := map(AssetPersonalCount < 0 => 0.000000, 
									 AssetPersonalCount < 1 => -0.010293,
									 0.344544);

		
	/*Reason Code */                      
	RCValueA40 := 0.344544 - subScore2 ;				


	/* LienJudgmentTaxCount */
	subScore3 := map(LienJudgmentTaxCount < 0 => 0.000000,
									 LienJudgmentTaxCount < 1 => 0.033789,
									 LienJudgmentTaxCount < 3 => -0.768811,
									 -0.876094);
			 
	/*Reason Code */
	RCValueD34 :=  0.033789 - subScore3 ;				


	/* bankruptcy_index */
	bankruptcy_index := map(BankruptcyStatus = -1 => -1,
													BankruptcyStatus = 2 and BankruptcyChapter = 2 => 4,
													BankruptcyChapter = 2 or BankruptcyStatus = 2 => 3,
													BankruptcyChapter = 1 or BankruptcyStatus > 0 => 2,
													BankruptcyStatus = 0 => 1,
													10);

	subScore4 := map(bankruptcy_index < 1 => 0.000000,
									 bankruptcy_index < 2 => 0.025638,
									 bankruptcy_index < 3 => -0.319370,
									 bankruptcy_index < 4 => -0.573378,
									 -1.222279);
					
	/*Reason Code */
	RCValueD31 := 0.025638 - subScore4 ;				


	/* average_purchase */
	// average_purchase := if(PurchaseActivityCount = - 1, -1,
													// PurchaseActivityDollarTotal/PurchaseActivityCount);	
	average_purchase := -1;  // reason code edit for iBehavior removal
	
	 __rounded1 := round ( average_purchase, 3 );

	subScore5 := map( __rounded1 < 0 => 0.000000,
										__rounded1 < 6.62 => -0.469775,
										__rounded1 < 13.83 => -0.292343,
										__rounded1 < 17.33 => -0.113369,
										__rounded1 < 22.17 => -0.085692,
										__rounded1 < 45.06 => 0.026380,
										0.045692);

					
	/*Reason Code */
	// RCValueA50 := if(average_purchase=null, 0.045692 - subScore5, 0) ;				
	RCValueA50 := 0 ;				

	/* asset_prop_own_amount */
	asset_prop_own_amount := if(AssetPropCurrentCount <= 0, 0,
															AssetPropCurrentTaxTotal/AssetPropCurrentCount);

	__rounded2 := round ( asset_prop_own_amount, 1 );
	subScore6 := map(	__rounded2 < 1 => -0.043126,
										__rounded2 < 56174.5 => -0.027759,
										__rounded2 < 159994 => 0.033449,
										__rounded2 < 179218 => 0.076599,
										__rounded2 < 246855 => 0.109353,
										0.245817);
					
	/*Reason Code */
	RCValueA46 := 0.245817 - subScore6 ;				

	/* education_index */
	education_index := map(EducationEvidence = -1 => -1,
												 EducationEvidence = 0 => 0,
												 EducationInstitutionRating + 1);

	subScore7 := map(education_index < 0 => -0.000000,
									education_index < 1 => -0.049094,
									education_index < 2 => 0.270354,
									education_index < 6 => 0.513622,
									education_index < 7 => -0.212665,
									-0.368279);

	/*Reason Code */
	RCValueAE55 := if(EducationEvidence <= 0, 0.513622 - subScore7, 0);

	RCValueAE56 := if(EducationEvidence = 1, 0.513622 - subScore7, 0);	

	/* current_addr_avm_owner */
	current_addr_avm_owner := map(AddrCurrentOwnershipIndex >= 3 => AddrCurrentAVMValue,
																AddrCurrentOwnershipIndex = -1 => -1,
																0);
																
	subScore8 := map(current_addr_avm_owner < 0 => 0.000000,
									current_addr_avm_owner < 1087 => -0.094834,
									current_addr_avm_owner < 114616 => -0.174665,
									current_addr_avm_owner < 166577 => 0.066445,
									current_addr_avm_owner < 200458 => 0.180578,
									current_addr_avm_owner < 218010 => 0.185000,
									current_addr_avm_owner < 237388 => 0.291988,
									current_addr_avm_owner < 259200 => 0.392479,
									0.505901);

					
	/*Reason Code */
	RCValueA42 := if(AddrCurrentOwnershipIndex < 3, 0.505901 - subScore8, 0);				
	RCValueA51 := if(AddrCurrentAVMValue = 0, 0.505901 - subScore8, 0);
	RCValueA47 := if(AddrCurrentOwnershipIndex >= 3, 0.505901 - subScore8, 0);				


	/* ********************************************************/
	/* Note: summing sub-scores and scaling                  */
	/* ********************************************************/
	rawScore    := subScore0 + subscore1 + subscore2 + subscore3 + subscore4 + subscore5 + subscore6 + subscore7 + subScore8 ;
	lnOddsScore := ( rawScore * 1.000000 ) + 3.605878;
	scaledScore := ( rawScore * 1.000000 ) + 3.605878;
	probScore   := exp(lnOddsScore) / (1 + exp(lnOddsScore));

	score2 := round(40*(log(probScore/(1-probScore)) - log(20))/log(2) + 700);
					
	SubjectAbilityIndex1 := if(ConfirmationSubjectFound = 0 or SSNDeceased = 1 or SubjectDeceased = 1, 
															222,
															min(900,max(501, score2 )) 
														);

	SubjectAbilityIndex := map(SubjectAbilityIndex1 = 222 => -1, 
														SubjectAbilityIndex1 <= 715 => 1,
														SubjectAbilityIndex1 <= 720 => 2,
														SubjectAbilityIndex1 <= 734 => 3,
														SubjectAbilityIndex1 <= 739 => 4,
														SubjectAbilityIndex1 <= 745 => 5,
														SubjectAbilityIndex1 <= 753 => 6,
														SubjectAbilityIndex1 <= 763 => 7,
														SubjectAbilityIndex1 <= 778 => 8,
														9);

	ds_layout := {STRING rc, REAL value1};

	rc_dataset := DATASET([
			{'C10' , RCValueC10},
			{'A41' , RCValueA41},
			{'A40' , RCValueA40},
			{'D34' , RCValueD34},
			{'D31' , RCValueD31},
			{'A50' , RCValueA50},
			{'A46' , RCValueA46},
			{'E56', RCValueAE56},  	// dropped the leading A to make it 3 characters
			{'E55', RCValueAE55}, 	// dropped the leading A to make it 3 characters
			{'A42' , RCValueA42},
			{'A51' , RCValueA51},
			{'A47' , RCValueA47}
			], ds_layout);

	// IMPORTANT NOTE:  Select the primary factor ONLY if its value is > 0. 
	sorted_factors := sort(rc_dataset(value1 > 0), -value1);
	SubjectAbilityPrimaryFactor := sorted_factors[1].rc;

	self.SubjectAbilityIndex	:= (string)subjectabilityindex;

	self.SubjectAbilityPrimaryFactor := map(SubjectAbilityIndex = -1 => '-1',
																					SubjectAbilityPrimaryFactor='' => '0', 
																					SubjectAbilityPrimaryFactor)	;
	
	// self.subscore0 := subscore0;
	// self.subscore1 := subscore1;
	// self.subscore2 := subscore2;
	// self.subscore3 := subscore3;
	// self.subscore4 := subscore4;
	// self.subscore5 := subscore5;
	// self.subscore6 := subscore6;
	// self.subscore7 := subscore7;
	// self.subscore8 := subscore8;
	
	self := le;

end;

with_ability := project(ds_in, add_ability(left));

return with_ability;

end;
