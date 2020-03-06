import RoxieKeybuild,Std,PromoteSupers;

Export Proc_Build_Alpha (string filedate) := function 

		AlphaIn := File_KeybuildV2.alpha ; 
		
		PromoteSupers.Mac_SF_BuildProcess(BuildIncidentsExtract,'~thor_data400::base::ecrash_Incidents',buildIncidents_Extract,,,true);
	 PromoteSupers.Mac_SF_BuildProcess(AlphaIn,'~thor_data400::base::accidents_alpha',buildBase,,,true);
		
		//Validate CRU Base file count -- DF-27413
		vCount := FLAccidents_Ecrash.fn_Validate_cru(filedate) ; 
	 
	 
	 
		return sequential(buildIncidents_Extract,buildBase, vCount); 

end; 

