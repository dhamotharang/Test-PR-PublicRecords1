IMPORT ut, Business_Header, Domains,Business_HeaderV2;


EXPORT Whois_As_Business_Contact := Domains.fWhois_As_Business_Contact(Business_HeaderV2.Source_Files.whois.BusinessHeader)  
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::Domains::Whois_As_Business_Contact');