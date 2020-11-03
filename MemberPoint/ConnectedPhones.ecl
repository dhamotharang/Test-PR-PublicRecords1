IMPORT MemberPoint, Phones, progressive_phone,BatchShare;

	EXPORT ConnectedPhones := MODULE
		// Internal: Return/filter set of disconnected phones (member point)
		SHARED SET OF STRING10 getDisconnectedPhones(DATASET(Phones.Layouts.PhoneAttributes.BatchIn)recsIn, MemberPoint.IParam.BatchParams optsIn):= FUNCTION
			opts := MODULE(PROJECT(optsIn, Phones.IParam.BatchParams, OPT))
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
			connectedRecs:= recsIn(Meta_Phone_Status <>Phones.Constants.PhoneStatus.Inactive);
			RETURN connectedRecs;
		END;
		
	END;