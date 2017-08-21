IMPORT Business_Header, UT, uccd;

EXPORT UCC_Party_As_Business_Header 
	:= fUCC_Party_As_Business_Header(uccd.UCC_Parties_Wdates)
	: persist(business_header.Bus_Thor + 'persist::UCC::UCC_Party_As_Business_Header')
	;
