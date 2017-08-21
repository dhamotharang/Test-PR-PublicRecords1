import business_header,Business_HeaderV2;

export Credit_Unions_As_Business_Contact := fCredit_Unions_As_Business_Contact(Business_HeaderV2.Source_Files.credit_unions.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::Busdata::Credit_Unions_As_Business_Contact');