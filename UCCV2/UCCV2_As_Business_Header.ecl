#OPTION('multiplePersistInstances',FALSE);
import Business_Header,Business_HeaderV2;

export uccV2_As_Business_Header(

	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) := 
function

	asbh := fuccV2_As_Business_Header(
		if(pUsingInBusinessHeader	,Business_HeaderV2.Source_Files.ucc_party.BusinessHeader,UCCV2.File_UCC_Party_Base_AID)
	) 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::uccV2::uccV2_As_Business_Header');

	return asbh;

end;