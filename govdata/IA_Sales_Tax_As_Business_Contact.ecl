#OPTION('multiplePersistInstances',FALSE);
import Business_HeaderV2;
export IA_Sales_Tax_As_Business_Contact := fIA_Sales_Tax_As_Business_Contact(Business_HeaderV2.Source_Files.ia_sales_tax.BusinessHeader)
	: persist(persistnames.AsBusinessContact.IA_Sales_Tax);