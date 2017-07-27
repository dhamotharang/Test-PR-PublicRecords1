IMPORT Business_Header, ut;

export ABIUS_Executive_As_Business_Contact
	:= fABIUS_Executive_As_Business_Contact(InfoUSA.update_ABIUS)
	: PERSIST(business_header.Bus_Thor + 'persist::InfoUSA::ABIUS_Executive_As_Business_Contact')
	;