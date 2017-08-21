
/*
	Superfiles for USAA:
	  cluster+'base::USAA::marketing_prospects'
		cluster+'base::USAA::direct_marketing'	

*/

IMPORT USAA, ut;

EXPORT BWR_create_superfiles() := 
	FUNCTION	
		csf0  := FileServices.CreateSuperFile (USAA.cluster+'base::USAA::marketing_prospects');	
		csf1  := FileServices.CreateSuperFile (USAA.cluster+'base::USAA::marketing_prospects_delete');
		csf2  := FileServices.CreateSuperFile (USAA.cluster+'base::USAA::marketing_prospects_father');
		csf3  := FileServices.CreateSuperFile (USAA.cluster+'base::USAA::marketing_prospects_grandfather');
		
		csf8  := FileServices.CreateSuperFile (USAA.cluster+'base::USAA::direct_marketing');
		csf9  := FileServices.CreateSuperFile (USAA.cluster+'base::USAA::direct_marketing_delete');
		csf10 := FileServices.CreateSuperFile (USAA.cluster+'base::USAA::direct_marketing_father');
		csf11 := FileServices.CreateSuperFile (USAA.cluster+'base::USAA::direct_marketing_grandfather');
		
		SEQUENTIAL(csf0, csf1, csf2, csf3,  
		           csf8, csf9, csf10,csf11);

		RETURN 1;
	END;

/*  	If you have to delete any already-existing superfiles, do so in a BW, e.g...:

	FileServices.DeleteSuperFile (USAA.cluster+'base::USAA::marketing_prospects_father');

*/