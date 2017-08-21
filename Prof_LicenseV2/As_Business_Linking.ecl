#OPTION('multiplePersistInstances',FALSE);
import business_header;
EXPORT As_Business_Linking :=Prof_LicenseV2.fProf_License_As_Business_Linking()
   	: PERSIST(business_header.Bus_Thor() + 'persist::Prof_License::Prof_licenses_as_business_header_linking');