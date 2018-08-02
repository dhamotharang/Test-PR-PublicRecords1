import VersionControl,_Control;

export Spray(string ver) := module

// export Load := DATASET([
 	// {_Control.IPAddress.bctlpedata11
 	// ,'/data/data_lib_2_hus2/Experian/FCRA/in/' + version   //Location to be determined by operations                
 	// ,'D*LEXNEX*FCRA.dat'                           
 	// ,'3775'                                                             
 	// ,'~thor_data400::in::FCRA::ExperianCred_load_@version@'    
 	// ,[{'~thor_data400::in::FCRA::ExperianCred_load'}]    
 	// ,'thor400_30'
	// ,version
 	// }
// ], VersionControl.Layout_Sprays.Info);

export ip 		:= _Control.IPAddress.bctlpedata11;
export path 	:= '/data/data_lib_2_hus2/Experian/FCRA/in/' + version;

export load := DATASET([
 	{_Control.IPAddress.bctlpedata11
 	,path   //Location to be determined by operations                
 	,'D*LEXNEX*EXP*FCRA.dat'                           
 	,'3775'                                                             
 	,'~thor_data400::in::FCRA::ExperianCred_load_@version@'    
 	,[{'~thor_data400::in::FCRA::ExperianCred_load'}]    
 	,'thor400_66'
	,ver
	,'S[0-9]{3}'
 	}
], VersionControl.Layout_Sprays.Info);

export Updates := DATASET([
 	{ip
 	,path   //Location to be determined by operations                
 	,'D*LEXNEX*FCRA.dat'                           
 	,'3775'                                                             
 	,'~thor_data400::in::FCRA::ExperianCred_updates_@version@'    
 	,[{'~thor_data400::in::FCRA::ExperianCred_updates'}]    
 	,'thor400_66'
	,ver
	,'S[0-9]{3}'
 	}
], VersionControl.Layout_Sprays.Info);

export Deletes := DATASET([
 	{ip
 	,path   //Location to be determined by operations                
 	,'DPINS'                           
 	,'101'                                                             
 	,'~thor_data400::in::FCRA::ExperianCred_deletes_@version@'    
 	,[{'~thor_data400::in::FCRA::ExperianCred_deletes'}]    
 	,'thor400_66'
	,ver
 	}
], VersionControl.Layout_Sprays.Info);

export Deceased := DATASET([
 	{ip
 	,path
 	,'DEC'                           
 	,'101'                                                             
 	,'~thor_data400::in::FCRA::ExperianCred_deceased_@version@'    
 	,[{'~thor_data400::in::FCRA::ExperianCred_deceased'}]    
 	,'thor400_66'
	,ver
 	}
], VersionControl.Layout_Sprays.Info);

end;