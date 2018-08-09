IMPORT VersionControl,_Control, ut, lib_fileservices,misc, tools;

EXPORT fSpray_VendorSrc_Files(
	STRING		pVersion,
	STRING		pDirectory						= '/data/hds_180/vendor_source/data',// + Misc.VendorSrc_version,
	STRING		pServerIP							= _control.IPAddress.bctlpedata10,
	STRING		pFile1Name						= 'Court*BK*.csv',
	STRING		pFile2Name						= 'Court*SLJ*.csv',
	STRING		pFile3Name						= 'RiskView*.csv',
	STRING		pFile4Name						= 'Vendor*Source*.csv',
	STRING    pFile5Name    = 'CollegeLocator*.txt',
	STRING		pGroupName						= IF((tools._Constants.IsDataland),'thor40_241','thor400_44'),
	BOOLEAN		pIsTesting						= false,
	BOOLEAN		pOverwrite						= true,
	STRING		pNameOutput						= 'Vendor Source Info Spray Report'

) :=
FUNCTION
	
	FilesToSpray := DATASET([
		
		{	 
		 pServerIP												
		,pDirectory                             
		,pFile1Name                                          
		,0                                                             
		,'~thor_data400::in::vendor_src::court_bank_' + pVersion   
		,[{'~thor_data400::in::vendor_src_info_load'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},
		
		{	 
		 pServerIP												
		,pDirectory                             
		,pFile2Name                                          
		,0                                                             
		,'~thor_data400::in::vendor_src::court_lien_' + pVersion   
		,[{'~thor_data400::in::vendor_src_info_load'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},   // Deleted comma because of removing the following two groupings
		
		{	 
		 pServerIP												
		,pDirectory                             
		,pFile5Name                                          
		,0                                                             
		,'~thor_data400::in::vendor_src::college_locator_' + pVersion   
		,[{'~thor::in::vendor_src::collegelocator'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		}   
// Deleted comma because of removing the following two groupings
/*	
        // Removing spray of Riskview FFD since that is now being pulled directly from Orbit 3	
		{	 
		 pServerIP												
		,pDirectory                             
		,pFile3Name                                          
		,0                                                             
		,'~thor_data400::in::vendor_src::riskview_ffd_' + pVersion   
		,[{'~thor_data400::in::vendor_src_info_load'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		},

        // Removing spray of Old Vendor Src as deprecated	
		{	 
		 pServerIP												
		,pDirectory                             
		,pFile4Name                                          
		,0                                                             
		,'~thor_data400::in::vendor_src::old_vendor_src_base_' + pVersion   
		,[{'~thor_data400::in::vendor_src_info_load'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		}

*/

	], VersionControl.Layout_Sprays.Info);

	RETURN VersionControl.fSprayInputFiles(FilesToSpray,,,pOverwrite,,,pIsTesting,,'VendorSourceInfo_' + pVersion,pNameOutput);

END;