EXPORT layoutCommonOut_CCPA := RECORD
	Phonesplus.layoutCommonOut;
	//CCPA-5 Add CCPA fields
	unsigned4 global_sid;
	unsigned8 record_sid;
END;