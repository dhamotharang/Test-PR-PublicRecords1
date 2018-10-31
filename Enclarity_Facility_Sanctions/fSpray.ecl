IMPORT VersionControl,_Control, ut, lib_fileservices,enclarity_facility_sanctions, tools;

EXPORT fSpray(
	STRING		pVersion              				= '',
	BOOLEAN   pUseProd              				= false,
	STRING		pServerIP											= '10.121.149.192',
	STRING		pFacilitySanctionsFileName		= '*facility_sanctions_' + pVersion[..8] + '.txt',
	STRING		pDirectory										= '/data/run_enclarity/facility_sanctions/input/'+ pVersion[..8],
	STRING		pGroupName										= IF((tools._Constants.IsDataland),'thor400_dev01','thor400_44'),
	BOOLEAN		pIsTesting										= false,
	BOOLEAN		pOverwrite										= true,
	STRING		pNameOutput										= 'Enclarity Facility Sanctions Spray Report'

) :=
  DATASET([
		{	 
		 pServerIP												
		,pDirectory                             
		,pFacilitySanctionsFilename                                          
		,0                                                             
		,'~thor_data400::in::enclarity_sanctions::facility_sanctions::' + pVersion   
		,[{'~thor_data400::in::enclarity_sanctions::facility_sanctions'}]    
		,pGroupName                                                
		,pVersion                                                   
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		}	

	], VersionControl.Layout_Sprays.Info);