IMPORT TopBusiness_BIPV2, AMS, CNLD_Facilities; //, XXX, YYY, etc. add license source modules here

// initially we have no license sources
// remove my 
//empty_license_ds := dataset([], TopBusiness_BIPV2.Layouts.rec_license_combined_layout);

export License_sources := 
		//	empty_license_ds;//remove this once we have real sources
			AMS.AMS_As_License()
		+	CNLD_Facilities.CNLD_Facilities_As_License()
	 ;
		
// As of 04/22(?)/2013, other sources identified that contain "license" related data and 
// are to be included in the new BIP2 combined "License" data key.
/* 
AMS (Advantage Medical Services)
CNLD_Facilities (CNLD=Choicepoint National License Database)
CNLD_Practitioner (CNDL=Choicepoint National License Database) 
*/
