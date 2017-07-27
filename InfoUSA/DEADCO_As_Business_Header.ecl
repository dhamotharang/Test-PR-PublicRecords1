import business_header, infousa, ut, address;

EXPORT DEADCO_as_Business_Header
	:= fDEADCO_as_Business_Header(infousa.update_DEADCO)
	: PERSIST(business_header.Bus_Thor + 'persist::InfoUSA::DEADCO_as_Business_Header')
	;
