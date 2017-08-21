#OPTION('multiplePersistInstances',FALSE);
import business_headerV2;

EXPORT Gov_Phones_As_Business_Header := fGov_Phones_As_Business_Header(Business_HeaderV2.Source_Files.gov_phones.BusinessHeader)
	: PERSIST(persistnames.AsBusinessHeader.Gov_Phones);