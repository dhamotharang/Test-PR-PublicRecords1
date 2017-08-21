#OPTION('multiplePersistInstances',FALSE);
import business_headerV2;

export MS_Workers_As_Business_Header := fMS_Workers_As_Business_Header(Business_HeaderV2.Source_Files.ms_workers_comp.BusinessHeader)
	: persist(persistnames.AsBusinessHeader.MS_Workers);