IMPORT Infogroup, VersionControl;

EXPORT fSpray(STRING	pVersion      = '',
							BOOLEAN	pUseProd			= FALSE,
							STRING	pServerIP			= Infogroup._Dataset().IPAddress,
							STRING	pDirectory		= '/data/data_build_5_2/prolic/Infogroup/data/' + pVersion,
							STRING	pDataFilename	= 'Lexi*'
) :=
  DATASET([
					 {pServerIP
					 ,pDirectory
					 ,pDataFilename
					 ,549
					 ,Infogroup.Filenames(pVersion).Data_lInputTemplate
					 ,[{Infogroup.Filenames().Data_lInputTemplate}]
					 ,Infogroup._Dataset().groupname
					 ,pVersion
					 ,''
					 ,'FIXED'
					 ,''
					 ,Infogroup._Dataset().max_record_size
					 ,
					 }
	        ], VersionControl.Layout_Sprays.Info);