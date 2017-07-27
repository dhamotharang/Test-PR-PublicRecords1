//EXPORT _BWR_Build_Relationship_Base := 'todo';
IMPORT Org_Mast;

Affl_pversion := '20160328';		// Affiliate Base file version to use
Org_Mst_pversion := '20160328';	// Org Master Base file version to use
pversion := '20160328';					// Relationship Base version 
pUseProd := false;
     
#workunit('name', 'Relationship Base Build ' + pversion);
sequential(
			Org_Mast.Build_Relationship_Base(Affl_pversion, Org_Mst_pversion, pversion).Relationship_all
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).Relationship_lBaseTemplate_qa, true)
			,FileServices.RemoveOwnedSubFiles(Org_Mast.Filenames(pversion,pUseProd).Relationship_lBaseTemplate_built, true)
			
			,parallel(
					Org_mast.Build_Keys.Build_Keys_Facilities(pversion,pUseProd).FacilitiesKey,
					Org_mast.Build_Keys.Build_Keys_Relationship_Key1(pversion,pUseProd).Relationship_Key1,
					Org_mast.Build_Keys.Build_Keys_Relationship_Key2(pversion,pUseProd).Relationship_Key2
			)		
			,Org_Mast.Promote.Promote_FacilitiesKey(pversion,pUseProd).buildfiles.Built2QA
			,Org_Mast.Promote.Promote_Key1(pversion,pUseProd).buildfiles.Built2QA		
			,Org_Mast.Promote.Promote_Key2(pversion,pUseProd).buildfiles.Built2QA			
);