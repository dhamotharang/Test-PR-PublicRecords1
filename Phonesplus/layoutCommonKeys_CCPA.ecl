EXPORT layoutCommonKeys_CCPA := RECORD
	Phonesplus.layoutCommonKeys;
	//CCPA-5 Add CCPA fields
	unsigned4 global_sid;
	unsigned8 record_sid;	
END;