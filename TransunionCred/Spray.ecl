import versionControl,_Control;

export Spray(string ver) := module

export Load := DATASET([
 	{_Control.IPAddress.bctlpedata11
 	,'/data/hds_180/nb_temp/data/' + ver   //Location to be determined by operations
 	//,'MFG*'                           
	,'PART*'
 	,'401'                                                             
 	,'~thor_data400::in::TransunionCred_load_' + ver
 	,[{'~thor_data400::in::TransunionCred_load'}]    
 	,'thor400_44'
	,ver
 	}
], versionControl.Layout_Sprays.Info);

export Updates := DATASET([
 	{_Control.IPAddress.bctlpedata11
 	,'/data/hds_180/nb_temp/data/' + ver   //Location to be determined by operations                
 	,'PART*'                           
 	,'401'                                                             
 	,'~thor_data400::in::TransunionCred_updates_' + ver
 	,[{'~thor_data400::in::TransunionCred_updates'}]    
 	,'thor400_44'
	,ver
 	}
], versionControl.Layout_Sprays.Info);

export Deletes := DATASET([
 	{_Control.IPAddress.bctlpedata11
 	,'/data/hds_180/nb_temp/data/' + ver   //Location to be determined by operations                
 	,'DPART*'                           
 	,'401'                                                             
 	,'~thor_data400::in::TransunionCred_deletes_' + ver
 	,[{'~thor_data400::in::TransunionCred_deletes'}]    
 	,'thor400_44'
	,ver
 	}
], versionControl.Layout_Sprays.Info);

end;