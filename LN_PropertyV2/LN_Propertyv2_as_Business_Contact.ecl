#OPTION('multiplePersistInstances',FALSE);
import Business_Header,ut,Business_HeaderV2;

export LN_Propertyv2_as_Business_Contact(
	
	boolean pUsingInBusinessHeader = true	//if true, use using_in_business_header superfiles

) :=
function

	asbc := fLN_Propertyv2_as_Business_Contact(

 	 if(pUsingInBusinessHeader	,Business_HeaderV2.Source_Files.propSearch.BusinessHeader			    	,File_Search_DID			)
	,if(pUsingInBusinessHeader	,Business_HeaderV2.Source_Files.propDeed.BusinessHeader			     		,Files.base.DeedMortgage			      )
	,if(pUsingInBusinessHeader	,Business_HeaderV2.Source_Files.propAssessment.BusinessHeader			  ,Files.base.Assessment			)
	,if(pUsingInBusinessHeader	,Business_HeaderV2.Source_Files.propaddl_fares_deed.BusinessHeader	,File_addl_fares_deed	)
	,if(pUsingInBusinessHeader	,Business_HeaderV2.Source_Files.propaddl_Fares_tax.BusinessHeader		,File_addl_Fares_tax	)
   
 )
	: persist(business_header._dataset().thor_cluster_Persists 
						+ 'persist::LN_Propertyv2::LN_Propertyv2_as_Business_Contact')
	;

	return asbc;

end;