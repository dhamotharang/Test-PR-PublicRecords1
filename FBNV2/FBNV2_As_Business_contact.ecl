#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_HeaderV2, Business_Header;

export FBNV2_As_Business_contact :=
fFBNV2_As_Business_contact(Business_HeaderV2.Source_Files.fbnv2_Contact.BusinessHeader
						  (tmsid[1..3] not in ['ACU']),
						   Business_HeaderV2.Source_Files.fbnv2_Business.BusinessHeader(tmsid[1..3] not in ['ACU']))
						  : persist(business_header.Bus_Thor() + 'persist::FBNV2::FBNV2_As_Business_Contact');
						  