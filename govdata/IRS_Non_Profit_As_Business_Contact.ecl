#OPTION('multiplePersistInstances',FALSE);
import Business_HeaderV2;
export IRS_Non_Profit_As_Business_Contact := fIRS_Non_Profit_As_Business_Contact(Business_HeaderV2.Source_Files.irs_non_profit.BusinessHeader)
	: persist(persistnames.AsBusinessContact.IRS_Non_Profit);