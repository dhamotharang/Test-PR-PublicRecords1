#OPTION('multiplePersistInstances',FALSE);
import Business_HeaderV2;

export EBR_As_Business_Contact := 
	fEBR_As_Business_Contact(Business_HeaderV2.Source_Files.ebr_header_base.BusinessHeader, Business_HeaderV2.Source_Files.ebr_demo_base.BusinessHeader)
	: PERSIST(EBR_Thor + 'persist::' + dataset_name + '::EBR_as_Business_Contact');
