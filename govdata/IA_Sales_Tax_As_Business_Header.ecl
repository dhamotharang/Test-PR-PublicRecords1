#OPTION('multiplePersistInstances',FALSE);
import business_headerV2;

export IA_Sales_Tax_As_Business_Header := fIA_Sales_Tax_As_Business_Header(Business_HeaderV2.Source_Files.ia_sales_tax.BusinessHeader)
	: PERSIST(persistnames.AsBusinessHeader.IA_Sales_Tax);