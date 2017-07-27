#OPTION('multiplePersistInstances',FALSE);
IMPORT ut, Business_Header, SDA_SDAA,business_headerv2;

EXPORT SDA_SDAA_As_Business_contact:= project(Business_HeaderV2.Source_Files.sda.BusinessHeader((INTEGER)name_score<3 and company_title<>'')
																							+ Business_HeaderV2.Source_Files.sdaa.BusinessHeader((INTEGER)name_score<3 and company_title<>''), transform(business_header.Layout_Business_Contact_Full_New, self.from_hdr := 'N',self := left))
	                               : persist(business_header._dataset().thor_cluster_Persists + 'persist::SDA_SDAA_As_Business_Contact');
	