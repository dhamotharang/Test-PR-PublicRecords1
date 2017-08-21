#OPTION('multiplePersistInstances',FALSE);
import Business_HeaderV2;
EXPORT Gov_Phones_As_Business_Contact := fGov_Phones_As_Business_Contact(Business_HeaderV2.Source_Files.gov_phones.BusinessHeader) 
	: PERSIST(persistnames.AsBusinessContact.Gov_Phones);