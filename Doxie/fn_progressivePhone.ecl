IMPORT progressive_phone, addrBest, PhonesFeedback_Services, ut, PhonesFeedback, phone_shell, doxie;

// function that returns waterfall phone data

EXPORT fn_progressivePhone := MODULE
	
	EXPORT byDIDonly(DATASET(doxie.layout_references) inDids,
										doxie.iParam.ProgressivePhoneParams progphone_mod = module(doxie.iParam.ProgressivePhoneParams)end
									) := FUNCTION
	
			f_in_progressive_phone := PROJECT(inDids,TRANSFORM(progressive_phone.layout_progressive_batch_in,
																		SELF.Acctno := (STRING) LEFT.did, // Assign did to acctno to tie back to correct input records
																		SELF.did := LEFT.did,    
																		SELF := []));

			progPhoneLayout := progressive_phone.layout_progressive_online_out;

			ProgPhones := PROJECT(AddrBest.Progressive_phone_common(f_in_progressive_phone,,,
																											 progphone_mod.Gateways_In, 
																											 progphone_mod.type_a_with_did,
																											 progphone_mod.useNeustar,
																											 progphone_mod.default_sx_match_limit,
																											 progphone_mod.callMetronet,
																											 progphone_mod.isPFR,
																											 progphone_mod.metronetLimit,
																											 progphone_mod.ScoreModel,
																											 progphone_mod.MaxNumAssociate,
																											 progphone_mod.MaxNumAssociateOther,
																											 progphone_mod.MaxNumFamilyOther,
																											 progphone_mod.MaxNumFamilyClose,
																											 progphone_mod.MaxNumParent,
																											 progphone_mod.MaxNumSpouse,
																											 progphone_mod.MaxNumSubject,
																											 progphone_mod.MaxNumNeighbor,
																											 progphone_mod.Confirmation_GoToGateway,
																											 progphone_mod.UsePremiumSource_A,
																											 progphone_mod.PremiumSource_A_limit,
																											 progphone_mod.RunRelocation),progPhoneLayout);

		ProgPhoneFilter := UNGROUP(progressive_phone.HelperFunctions.FN_FilterPerScore(ProgPhones));

		PhonesFeedback_Services.Mac_Append_Feedback(ProgPhoneFilter,did,subj_phone10,ProgPhoneFilter_w_fb);
		ProgPhoneFeedback := if(progphone_mod.IncludePhonesFeedback,ProgPhoneFilter_w_fb,ProgPhoneFilter);
		ut.getTimeZone(ProgPhoneFeedback,subj_phone10,timeZone,ProgfinalOut);
		
		ProgPhoneGroup := GROUP(SORT(ProgfinalOut,acctno,-phone_score),acctno);

		phoneRollRec := RECORD
			UNSIGNED6 did;
			DATASET(progPhoneLayout) phoneInfo;
		END;

		phoneRollRec RollPhones(progPhoneLayout l, DATASET(progPhoneLayout) allRows) := TRANSFORM
			SELF.did := (INTEGER) l.acctno;
			SELF.phoneinfo := CHOOSEN(allRows[1..],doxie.rollup_limits.progressivePhone);
		END;

		// Rollup results by did since more than one did can be searched on via progessive phone lookup
		ProgPhoneRolled := ROLLUP(ProgPhoneGroup, GROUP, RollPhones(LEFT,ROWS(LEFT)));

		RETURN ProgPhoneRolled;
	END;
	
END;