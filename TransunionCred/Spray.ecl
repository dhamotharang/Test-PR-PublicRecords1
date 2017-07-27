import VersionControl,_Control;

export Spray := module

export Load := DATASET([
 	{_Control.IPAddress.edata12
 	,'/hds_180/nb_temp/' + version   //Location to be determined by operations                
 	,'MFG*'                           
 	,'400'                                                             
 	,'~thor_data400::in::TransunionCred_load_@version@'    
 	,[{'~thor_data400::in::TransunionCred_load'}]    
 	,'thor400_92'
	,version
 	}
], VersionControl.Layout_Sprays.Info);

export Updates := DATASET([
 	{_Control.IPAddress.edata12
 	,'/hds_180/nb_temp/' + version   //Location to be determined by operations                
 	,'PART*'                           
 	,'400'                                                             
 	,'~thor_data400::in::TransunionCred_updates_@version@'    
 	,[{'~thor_data400::in::TransunionCred_updates'}]    
 	,'thor400_92'
	,version
 	}
], VersionControl.Layout_Sprays.Info);

end;