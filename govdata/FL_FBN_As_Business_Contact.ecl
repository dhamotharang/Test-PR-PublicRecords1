#OPTION('multiplePersistInstances',FALSE);
import Business_HeaderV2;
export FL_FBN_As_Business_Contact := fFL_FBN_As_Business_Contact(Business_HeaderV2.Source_Files.fl_fbn.BusinessHeader,Business_HeaderV2.Source_Files.fl_fbn_events.BusinessHeader)
	: persist(persistnames.AsBusinessContact.FL_FBN);