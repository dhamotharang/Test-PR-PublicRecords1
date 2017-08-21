#OPTION('multiplePersistInstances',FALSE);
import business_headerV2;

export FL_FBN_As_Business_Header := fFL_FBN_As_Business_Header(Business_HeaderV2.Source_Files.fl_fbn.BusinessHeader,Business_HeaderV2.Source_Files.fl_fbn_events.BusinessHeader)
	: PERSIST(persistnames.AsBusinessHeader.FL_FBN);