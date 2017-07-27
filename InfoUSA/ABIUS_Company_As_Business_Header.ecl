IMPORT Business_Header, ut;

EXPORT ABIUS_Company_As_Business_Header 
	:= fABIUS_Company_As_Business_Header(InfoUSA.update_ABIUS)
	: PERSIST(business_header.Bus_Thor + 'persist::InfoUSA::ABIUS_Company_As_Business_Header')
	;