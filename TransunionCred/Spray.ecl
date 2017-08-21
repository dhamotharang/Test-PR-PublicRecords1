import VersionControl,_Control;

export Spray := module

export Load := DATASET([
 	{_Control.IPAddress.bctlpedata11
 	,'/data/hds_180/nb_temp/data/' + version   //Location to be determined by operations
 	//,'MFG*'                           
	,'PART*'
 	,'401'                                                             
 	,'~thor_data400::in::TransunionCred_load_@version@'    
 	,[{'~thor_data400::in::TransunionCred_load'}]    
 	,'thor400_44'
	,version
 	}
], VersionControl.Layout_Sprays.Info);

export Updates := DATASET([
 	{_Control.IPAddress.bctlpedata11
 	,'/data/hds_180/nb_temp/data/' + version   //Location to be determined by operations                
 	,'PART*'                           
 	,'401'                                                             
 	,'~thor_data400::in::TransunionCred_updates_@version@'    
 	,[{'~thor_data400::in::TransunionCred_updates'}]    
 	,'thor400_44'
	,version
 	}
], VersionControl.Layout_Sprays.Info);

export Deletes := DATASET([
 	{_Control.IPAddress.bctlpedata11
 	,'/data/hds_180/nb_temp/data/' + version   //Location to be determined by operations                
 	,'DPART*'                           
 	,'401'                                                             
 	,'~thor_data400::in::TransunionCred_deletes_@version@'    
 	,[{'~thor_data400::in::TransunionCred_deletes'}]    
 	,'thor400_44'
	,version
 	}
], VersionControl.Layout_Sprays.Info);

end;