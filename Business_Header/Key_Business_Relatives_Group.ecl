Import Data_Services, business_header_ss,ut, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
f_brg := PRTE2_Business_Header.Files().Base.Business_Relatives_Group.built;
#ELSE
f_brg := Business_Header.Files().Base.Business_Relatives_Group.built;
#END;


EXPORT Key_Business_Relatives_Group := INDEX(f_brg,
	{f_brg.group_id}, {f_brg},
	'~thor_data400::key::business_header.Business_Relatives_Group_' + business_header_ss.key_version);