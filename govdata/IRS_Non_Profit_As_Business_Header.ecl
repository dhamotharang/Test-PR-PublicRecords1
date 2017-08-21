#OPTION('multiplePersistInstances',FALSE);
import business_headerV2;

export IRS_Non_Profit_As_Business_Header := fIRS_Non_Profit_As_Business_Header(Business_HeaderV2.Source_Files.irs_non_profit.BusinessHeader)
	: persist(persistnames.AsBusinessHeader.IRS_Non_Profit);