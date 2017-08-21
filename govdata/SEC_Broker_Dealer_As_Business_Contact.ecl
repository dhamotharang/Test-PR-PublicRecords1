#OPTION('multiplePersistInstances',FALSE);
import Business_HeaderV2;
export SEC_Broker_Dealer_As_Business_Contact := fSEC_Broker_Dealer_As_Business_Contact(Business_HeaderV2.Source_Files.SEC.BusinessHeader)
	: persist(persistnames.AsBusinessContact.SEC_Broker_Dealer);