import business_header, infousa, ut, address;

export IDEXEC_as_Business_Contact 
	:= fIDEXEC_as_Business_Contact(infousa.update_IDEXEC)
	: persist(business_header.Bus_Thor + 'persist::InfoUSA::IDEXEC_As_Business_Contact')
	;
