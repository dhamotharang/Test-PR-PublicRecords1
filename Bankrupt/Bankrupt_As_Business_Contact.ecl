IMPORT Business_Header;

export Bankrupt_As_Business_Contact := fBankrupt_As_Business_Contact(File_BK_Search, File_BK_Main)
	: persist(business_header.Bus_Thor + 'persist::Bankrupt::Bankrupt_As_Business_Contact');