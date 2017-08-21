#OPTION('multiplePersistInstances',FALSE);
import Business_Header, Business_HeaderV2;

export FBNV2_As_Business_Header := 
	fFBNV2_As_Business_Header(Business_HeaderV2.Source_Files.fbnv2_Business.BusinessHeader(tmsid[1..3] not in ['ACU'])) 
	: persist(business_header.Bus_Thor() + 'persist::FBNV2::FBNV2_As_Business_Header');