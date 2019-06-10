IMPORT iesp;

EXPORT PhonePickList_Records( DATASET(PhoneFinder_Services.Layouts.BatchInAppendDID) dIn,
															PhoneFinder_Services.iParam.SearchParams               inMod) :=
FUNCTION	
	// Inhouse phone records
	dPhonesAll := PhoneFinder_Services.GetPhones(dIn,inMod);
	
	// Sort by penalty and dedup phones
	dPhonesDedup := DEDUP(SORT(dPhonesAll,phone,penalt),phone);
	
	// Format to iesp layout
	iesp.phonepicklist.t_PhonePickListRecord tPhoneCarrierInfo(dPhonesDedup pInput) :=
	TRANSFORM
		SELF.PhoneNumber   := pInput.phone;
		SELF._Type         := pInput.coc_description;
		SELF.Carrier       := pInput.carrier_name;
		SELF.CarrierCity   := pInput.phone_region_city;
		SELF.CarrierState  := pInput.phone_region_st;
	END;
	
	dPhonePickList := PROJECT(dPhonesDedup,tPhoneCarrierInfo(LEFT));
	
	// Debug
	#IF(PhoneFinder_Services.Constants.Debug.Main)
		OUTPUT(dPhonesAll,NAMED('dPhonesAll'));
		OUTPUT(dPhonesDedup,NAMED('dPhonesDedup'));
	#END
	
	RETURN dPhonePickList;
END;