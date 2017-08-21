#OPTION('multiplePersistInstances',FALSE);
import Business_Header, ut,Business_HeaderV2;


export CNLD_Facilities_As_Business_Header(

   boolean pUseInBusinessHeader = true

				) :=
function

	shared persistroot := business_header._dataset().thor_cluster_Persists;

	shared basefile := if(pUseInBusinessHeader = true   
											// ,Business_HeaderV2.Source_Files.professional_licenses.BusinessHeader
											,CNLD_Facilities.file_Facilities_AID
											);

	dReturnMe := fCNLD_Facilities_As_Business_Header(basefile)
	: persist(persistroot + 'persist::cnldfacilities::CNLD_Facilities_As_Business_Header')
	;
	
	return dReturnMe;
	
end;