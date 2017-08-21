#OPTION('multiplePersistInstances',FALSE);
import business_header,business_headerv2;

export Watercraft_as_Business_Header(

	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) := 
function

	asbh := fWatercraft_As_Business_Header(
		if(pUsingInBusinessHeader	,project(Business_HeaderV2.Source_Files.Watercraft.BusinessHeader,Watercraft.Layout_Watercraft_Search_Base),File_Base_Search_Prod)
	) 
 :	persist(business_header._dataset().thor_cluster_Persists + 'persist::Watercraft::Watercraft_as_Business_Header')
 ;

	return asbh;

end;