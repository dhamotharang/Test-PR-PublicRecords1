IMPORT ut, Business_Header, uccd;

EXPORT UCC_Party_As_Business_Contact 
	:= fUCC_Party_As_Business_Contact(uccd.UCC_Parties_Wdates)
	: persist(business_header.Bus_Thor + 'persist::UCC::UCC_Party_As_Business_Contact')
	;
