IMPORT MemberPoint, PhoneFinder_Services;

	EXPORT MemberPoint.Layouts.PhoneFinderOutPhone concatenatePrimaryData(DATASET(MemberPoint.Layouts.PhoneFinderOutPhone) otherPhones, 
																																				PhoneFinder_Services.Layouts.PhoneFinder.BatchOut inRow):= FUNCTION
		primaryData:= PROJECT(inRow, TRANSFORM(MemberPoint.Layouts.PhoneFinderOutPhone,
													SELF.acctno:= '0',
													SELF.PhoneNumber:= LEFT.Number,
													SELF.PhoneType:= LEFT._Type,
													SELF.DateFirstSeen:= LEFT.Identity1_FirstSeenWithPrimaryPhone,
													SELF.DateLastSeen:= LEFT.Identity1_LastSeenWithPrimaryPhone,
													SELF.ListingName:= LEFT.Identity1_Full,
													SELF:= LEFT));
		RETURN primaryData + otherPhones;
	END;