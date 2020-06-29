Import Data_Services, business_header_ss,ut,header_services, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
	f_br_1 := PRTE2_Business_Header.Files().Base.Business_Relatives.built;
#ELSE
	f_br_1 := Files().Base.Business_Relatives.built;
#END;


#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
	f_br := f_br_1;
#ELSE
	f_br := Business_Header.Prep_Build.applyBusinessRelativesInj(f_br_1);
#END;

EXPORT Key_Business_Relatives := INDEX(f_br,
	{f_br.bdid1}, {f_br}, 
	'~thor_data400::key::business_header.BusinessRelatives_' + business_header_ss.key_version);