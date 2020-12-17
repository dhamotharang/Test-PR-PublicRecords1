IMPORT MemberPoint, Phones, progressive_phone;

	EXPORT ConnectedPhones := MODULE
		// Return/filter connected phones for PhoneFinder (PhoneFinderOutPhone)
		EXPORT MemberPoint.Layouts.PhoneFinderOutPhone getConnectedPhoneFinder(DATASET(MemberPoint.Layouts.PhoneFinderOutPhone) recsIn, MemberPoint.IParam.BatchParams optsIn):= FUNCTION
			connectedRecs:= recsIn(phonestatus<> Phones.Constants.PhoneStatus.Inactive);
      RETURN connectedRecs;
		END;	
		// Return/filter connected phones for Waterfall phones (layout_progressive_phone_common)
		EXPORT progressive_phone.layout_progressive_phone_common getConnectedWaterfall(DATASET(progressive_phone.layout_progressive_phone_common)recsIn, MemberPoint.IParam.BatchParams optsIn):= FUNCTION
			connectedRecs:= recsIn(Meta_Phone_Status <>Phones.Constants.PhoneStatus.Inactive);
			RETURN connectedRecs;
			END;
		
	END;