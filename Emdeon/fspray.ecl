import lib_fileservices,_control,lib_stringlib,Versioncontrol,emdeon, ut, tools;

EXPORT fSpray(
	STRING		pVersion              = '',
	BOOLEAN   pUseProd              = false,
	STRING		pServerIP							= _control.IPAddress.bctlpedata10,
	STRING		pRawfile							= '*Claims_US_CF_D_deid.dat',
	STRING		pDirectory						= '/data/enclarity/claims/',// + pVersion,
	STRING		pGroupName						= IF((tools._Constants.IsDataland),'thor40_241','thor400_44'),//was thor400_30
	BOOLEAN		pIsTesting						= false,
	BOOLEAN		pOverwrite						= true,
	STRING		pNameOutput						= 'Emdeon Claims Source Files Info Spray Report'

) :=
  DATASET([
		{	 
		 pServerIP												
		,pDirectory                             
		,pRawfile                                          
		,0                                                               
		,_Dataset(pUseProd).thor_cluster_Files+ 'in::emdeon_claims::raw_orig_file::@version@'       //Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
		,[{_Dataset(pUseProd).thor_cluster_Files+'in::emdeon_claims::raw_orig_file'}]            //dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
		
		,pGroupName                                                
		,pVersion                                                    
		,''                                                            
		,'VARIABLE'                                                         
		,''                                                     
		}
], VersionControl.Layout_Sprays.Info);