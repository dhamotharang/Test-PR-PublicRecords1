#OPTION('multiplePersistInstances',FALSE);
import Business_Header, ut,Business_HeaderV2;

export Prof_License_As_Business_Contact(

   boolean pUseInBusinessHeader = true

) :=
function

	shared persistroot := business_header._dataset().thor_cluster_Persists;

	shared basefile := if(pUseInBusinessHeader = true   
											,Business_HeaderV2.Source_Files.professional_licenses.BusinessHeader
											,Prof_License.File_prof_license_base_AID
											);

	dReturnMe := fProf_License_As_Business_Contact(basefile)
	: persist(persistroot + 'persist::Prof_License::Prof_License_As_Business_Contact')
	;
	
	return dReturnMe;
	
end;
