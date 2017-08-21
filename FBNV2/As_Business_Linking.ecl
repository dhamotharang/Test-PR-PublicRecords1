#OPTION('multiplePersistInstances',FALSE);
import business_header,Business_HeaderV2;
EXPORT As_Business_Linking := FBNV2.fFBNV2_As_Business_Linking(FBNV2.File_FBN_Contact_Base_AId (tmsid[1..3] not in ['ACU']),FBNV2.File_FBN_Business_Base_AID (tmsid[1..3] not in ['ACU']))
   	: PERSIST(business_header.Bus_Thor() + 'persist::FBNV2::FBN_As_Business_Header_Linking');
		
