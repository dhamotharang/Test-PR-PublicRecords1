IMPORT Business_Header, ut,address;

EXPORT IDEXEC_as_Business_Header
	:= fIDEXEC_as_Business_Header(InfoUSA.update_IDEXEC)
	: persist(business_header.Bus_Thor + 'persist::InfoUSA::IDEXEC_As_Business_Header')
	;