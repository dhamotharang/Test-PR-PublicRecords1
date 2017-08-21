#OPTION('multiplePersistInstances',FALSE);
import Business_HeaderV2;

export SEC_Broker_Dealer_As_Business_Header := fSEC_Broker_Dealer_As_Business_Header(Business_HeaderV2.Source_Files.SEC2.BusinessHeader)
	: persist(persistnames.AsBusinessHeader.SEC_Broker_Dealer);