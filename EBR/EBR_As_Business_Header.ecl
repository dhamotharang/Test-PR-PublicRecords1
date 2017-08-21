#OPTION('multiplePersistInstances',FALSE);
import business_headerV2;
EXPORT EBR_As_Business_Header := fEBR_As_Business_Header(Business_HeaderV2.Source_Files.ebr_header_base.BusinessHeader)
	: PERSIST(EBR_Thor + 'persist::' + dataset_name + '::EBR_as_Business_Header');