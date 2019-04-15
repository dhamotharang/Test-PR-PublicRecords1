﻿IMPORT BatchShare, MemberPoint, Phones, progressive_phone;

	EXPORT ConnectedPhones := MODULE
	
		// Internal: Return/filter set of disconnected phones (member point)
		SHARED SET OF STRING10 getDisconnectedPhones(DATASET(Phones.Layouts.PhoneAttributes.BatchIn)recsIn, MemberPoint.IParam.BatchParams optsIn):= FUNCTION

      mod_batch := BatchShare.IParam.ConvertToLegacy(optsIn);
			opts := MODULE(PROJECT(mod_batch, Phones.IParam.PhoneAttributes.BatchParams, OPT))
				EXPORT BOOLEAN return_current:= TRUE;
				EXPORT BOOLEAN include_temp_susp_reactivate:= FALSE;
			END;
			phonesStatus:= Phones.PhoneAttributes_BatchRecords(recsIn, opts);
			filteredPhones:= phonesStatus(event_type = 'D' AND disconnect_date <> 0);
			connectedSet:= SET(filteredPhones, phoneno);
			RETURN connectedSet;
		END;
	
		// Return/filter connected phones for PhoneFinder (PhoneFinderOutPhone)
		EXPORT MemberPoint.Layouts.PhoneFinderOutPhone getConnectedPhoneFinder(DATASET(MemberPoint.Layouts.PhoneFinderOutPhone) recsIn, MemberPoint.IParam.BatchParams optsIn):= FUNCTION
			Phones.Layouts.PhoneAttributes.BatchIn buildFilterIn(MemberPoint.Layouts.PhoneFinderOutPhone lft):= TRANSFORM
				SELF.acctno:= lft.acctno;
				SELF.phoneno:= lft.PhoneNumber;
			END;
			filterIn:= PROJECT(recsIn, buildFilterIn(LEFT));
			disconnectedPhones:= getDisconnectedPhones(filterIn, optsIn);
			connectedRecs:= recsIn(PhoneNumber NOT IN disconnectedPhones);
			RETURN connectedRecs;
		END;
		
		// Return/filter connected phones for Waterfall phones (layout_progressive_phone_common)
		EXPORT progressive_phone.layout_progressive_phone_common getConnectedWaterfall(DATASET(progressive_phone.layout_progressive_phone_common)recsIn, MemberPoint.IParam.BatchParams optsIn):= FUNCTION
			Phones.Layouts.PhoneAttributes.BatchIn buildFilterIn(progressive_phone.layout_progressive_phone_common lft, INTEGER indx):= TRANSFORM
				SELF.acctno:= (STRING20)indx;
				SELF.phoneno:= lft.subj_phone10;
			END;
			filterIn:= PROJECT(recsIn, buildFilterIn(LEFT, COUNTER));
			disconnectedPhones:= getDisconnectedPhones(filterIn, optsIn);
			connectedRecs:= recsIn(subj_phone10 NOT IN disconnectedPhones);
			RETURN connectedRecs;
		END;
		
	END;