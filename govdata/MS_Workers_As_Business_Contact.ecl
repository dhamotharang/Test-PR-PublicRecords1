#OPTION('multiplePersistInstances',FALSE);
import Business_HeaderV2;
export MS_Workers_As_Business_Contact := fMS_Workers_As_Business_Contact(Business_HeaderV2.Source_Files.ms_workers_comp.BusinessHeader)
	: persist(persistnames.AsBusinessContact.MS_Workers);