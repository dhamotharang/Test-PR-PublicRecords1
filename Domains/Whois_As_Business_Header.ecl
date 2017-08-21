IMPORT Business_Header, Domains,Business_HeaderV2;

EXPORT Whois_As_Business_Header := Domains.fWhois_As_Business_Header(Business_HeaderV2.Source_Files.whois.BusinessHeader(registrant_name<>''))
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::Domains::Whois_As_Business_Header');