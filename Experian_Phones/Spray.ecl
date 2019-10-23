import versioncontrol, _control;
EXPORT Spray(string version) := module

export Input := DATASET([
 	{_control.IPAddress.bctlpedata10										
 	,'/data/hds_180/experian_index_phone/data/'+version   //Location to be determined                  
 	,'*.txt'                           
 	,'82'                                                             
 	,'~thor_data400::in::experian_phone::@version@'    
 	,[{'~thor_data400::in::experian_phones'}]    
 	,'thor400_44'
	,version
                      
 	}

], VersionControl.Layout_Sprays.Info);

end;