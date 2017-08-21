IMPORT Data_Services, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
base := PRTE2_Business_Header.File_Prep_Business_Contacts_Plus;
#ELSE
base := File_Prep_Business_Contacts_Plus;
#END;

export Key_Prep_Business_Contacts_State_City_Name := INDEX(
	base,
	{lname, state, city, fname, mname, __filepos},
	'~thor_data400::key::business_contacts.state.city.name' + thorlib.wuid());