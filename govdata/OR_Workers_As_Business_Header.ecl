#OPTION('multiplePersistInstances',FALSE);
import business_headerv2;

export OR_Workers_As_Business_Header := fOR_Workers_As_Business_Header(Business_HeaderV2.Source_Files.or_workers.BusinessHeader) 
	: persist(persistnames.AsBusinessHeader.OR_Workers);
