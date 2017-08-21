IMPORT VersionControl,_Control, ut, lib_fileservices,misc, tools;
	
EXPORT fSpray_ProfLic_lookup(
	 
	STRING		pDirectory						= '/hds_180/prolic_type/' + Prof_LicenseV2.ProfLic_Lookup_version,
	STRING		pServerIP							= _control.IPAddress.edata12,
	STRING		pFilename							= 'license_type_load*.csv',
	STRING		pGroupName						= IF((tools._Constants.IsDataland),'thor40_241','thor400_44'),
	BOOLEAN		pIsTesting						= false,
	BOOLEAN		pOverwrite						= true,
	STRING		pNameOutput						= 'ProfLic Type Lookup Info Spray Report'

) :=
FUNCTION
	
	FilesToSpray := DATASET([

		{	 
		 pServerIP												
		,pDirectory                             
		,pFilename                                          
		,0                                                             
		,'~thor_data400::in::prolicv2::professional_license_type_lookup_' + (STRING)Prof_LicenseV2.ProfLic_lookup_version   
		,[{'~thor_data400::in::prolicv2::professional_license_type_lookup_load'}]    
		,pGroupName                                                
		,Prof_LicenseV2.ProfLic_Lookup_version                                                    
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		}
				
	], VersionControl.Layout_Sprays.Info);

	RETURN VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,,pIsTesting,,'ProfLic_Type_Lookup_Info_' + Prof_LicenseV2.ProfLic_Lookup_version,pNameOutput);

END;