import business_header, infousa, ut;

export DEADCO_as_Business_Contact
	:= fDEADCO_as_Business_Contact(infousa.update_DEADCO)
	: PERSIST(business_header.Bus_Thor + 'persist::InfoUSA::DEADCO_as_Business_Contact')
	;