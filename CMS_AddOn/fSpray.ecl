IMPORT _Control, CMS_AddOn, VersionControl;

EXPORT fSpray(STRING pVersion       = '',
							STRING pServerIP			= _Control.IPAddress.bctlpedata11,
							STRING pAddOnFilename	= '*Add*.csv',
							STRING pDirectory			= '/data/data_build_4/CMS_AddOn/data/' + pVersion
) :=
  DATASET([
					 {pServerIP
					 ,pDirectory
					 ,pAddOnFilename
					 ,0
					 ,CMS_AddOn.Filenames(pVersion).lInputTemplate
					 ,[{CMS_AddOn.Filenames().lInputTemplate}]
					 ,CMS_AddOn._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'VARIABLE'
					 ,''
					 ,CMS_AddOn._Dataset().max_record_size
					 }
	        ], VersionControl.Layout_Sprays.Info);