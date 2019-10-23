import tools, _control;

export SprayFiles(

	 string		pServerIP		                   = IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10)
	,string		pDirectory	                   = '/data/super_credit/fdn/in'
	,string		pFilenameSuspectIP             = '*suspicious_ip*'
  ,string		pFilenameTiger                 = '*Tiger*txt'
	,string		pFilenameCFNA                  = '*CFNA*txt'
	,string		pFilenameErie                  = 'FDN_ERIE_CF*txt'
	,string		pFilenameErieWatchList         = 'FDN_ERIE_WL*txt'
	,string		pversion
	,string		pGroupName	                   = _dataset().groupname																		
	,boolean	pIsTesting	                   = false
	,boolean	pOverwrite	                   = false
	,boolean	pReplicate	                   =	true
	,string		pNameOutput	                   = 'FDN Spray Info'	
	,boolean	pSprayMultipleFilesAs1	       = true

) :=
function


		MAC_FilesToSprayCSV(pRemoteFilename,pLocalFilename,outAttr) := macro
	
		outAttr := DATASET([

			{pServerIP
			,pDirectory + '/' + pversion
			,pRemoteFilename
			,0
			,pLocalFilename.Template
			,[ {pLocalFilename.Sprayed	}	]
			,pGroupName
			,pversion
			,''
			,'VARIABLE'
			,''
			,_Dataset().max_record_size
			,'\\,'
			}
		], tools.Layout_Sprays.Info);
		
	endmacro;
	

  MAC_FilesToSprayCSV(pFilenameSuspectIP          ,Filenames(pversion).Input.SuspectIP              ,FilesToSpraySuspectIP		);
  MAC_FilesToSprayCSV(pFilenameTiger              ,Filenames(pversion).Input.Tiger                  ,FilesToSprayTiger        );
	MAC_FilesToSprayCSV(pFilenameCFNA               ,Filenames(pversion).Input.CFNA                   ,FilesToSprayCFNA         );
	MAC_FilesToSprayCSV(pFilenameErie               ,Filenames(pversion).Input.Erie                   ,FilesToSprayErie         );
	MAC_FilesToSprayCSV(pFilenameErieWatchList      ,Filenames(pversion).Input.ErieWatchList          ,FilesToSprayErieWatchList );

	SprayTheFile(dataset(tools.Layout_Sprays.Info) FilesToSpray) :=
		tools.fun_Spray(FilesToSpray,,,pOverwrite,pReplicate,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1);

	return parallel(
		  if(not _Flags.FileExists.Input.SuspectIP                    or pOverwrite,SprayTheFile(FilesToSpraySuspectIP         ))
		 ,if(not _Flags.FileExists.Input.Tiger                        or pOverwrite,SprayTheFile(FilesToSprayTiger             ))
		 ,if(not _Flags.FileExists.Input.CFNA                         or pOverwrite,SprayTheFile(FilesToSprayCFNA              ))
		 ,if(not _Flags.FileExists.Input.Erie                         or pOverwrite,SprayTheFile(FilesToSprayErie              ))
		 ,if(not _Flags.FileExists.Input.ErieWatchList                or pOverwrite,SprayTheFile(FilesToSprayErieWatchList     ))

		);

end;