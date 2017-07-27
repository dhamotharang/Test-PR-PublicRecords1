import tools, _control;

export SprayFiles(

	 string		pServerIP		                   = IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10)
	,string		pDirectory	                   = '/data/super_credit/fdn/in'
	,string		pFilenameSuspectIP             = '*suspicious_ip*'
  ,string		pFilenameTiger                 = '*Tiger*txt'
	,string		pFilenameCFNA                  = '*CFNA*txt'
	,string		pFilenamembs                   = 'fdn_file_info.txt'	
	,string		pFilenameMbsGcIdExclusion      = '*prev_fdn_file_gc*txt'	
	,string		pFilenameMbsNewGcIdExclusion   = '*fdn_file_gc*txt'	// NewMBS excl file
	,string		pFilenameMbsIndTypeExclusion   = '*fdn_file_ind_type_ex*txt'	
	,string		pFilenameMbsProductInclude     = '*fdn_file_product*txt'	
	,string		pFilenameMBSSourceGcExclusion  = '*fdn_source_gc_exclusion*txt'
	,string   pFilenameMBSmarketAppend       = '*fdn_market*txt'
	,string   pFilenameMBSFdnIndType         = 'fdn_ind_type.txt' 
	,string   pFilenameMBSFdnCCID            = 'mbsi_fdn_accounts*' //CCID mbs accounts
	,string   pFilenameMBSFdnHHID            = 'hhid_fdn_accounts*' //HHID accounts
	,string   pFilenameMBSTableCol           = 'table_column.txt' 
	,string   pFilenameMBSColValDesc         = 'column_value_desc.txt' 
	,string		pversion
	,string		pGroupName	                   = _dataset().groupname																		
	,boolean	pIsTesting	                   = false
	,boolean	pOverwrite	                   = false
	,boolean	pReplicate	                   =	true
	,string		pNameOutput	                   = 'FDN Spray Info'	
	,boolean	pSprayMultipleFilesAs1	       = true

) :=
function

	MAC_FilesToSprayCSVPipe(pRemoteFilename,pLocalFilename,outAttr) := macro
	
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
			,'|\t|' 
      ,'|\n'
			}
		], tools.Layout_Sprays.Info);
		
	endmacro;
	
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
	
	MAC_FilesToSprayCSVPipe(pFilenamembs                ,Filenames(pversion).Input.mbs                ,FilesToSprayMBS                );
	MAC_FilesToSprayCSVPipe(pFilenameMbsGcIdExclusion            ,Filenames(pversion).Input.MbsGcIdExclusion   ,FilesToSprayMbsGcIdExclusion            );
	MAC_FilesToSprayCSVPipe(pFilenameMbsNewGcIdExclusion            ,Filenames(pversion).Input.MbsNewGcIdExclusion   ,FilesToSprayMbsNewGcIdExclusion   );
	MAC_FilesToSprayCSVPipe(pFilenameMbsIndTypeExclusion         ,Filenames(pversion).Input.MbsIndTypeExclusion ,FilesToSprayMbsIndTypeExclusion );
  MAC_FilesToSprayCSVPipe(pFilenameMbsProductInclude         ,Filenames(pversion).Input.MbsProductInclude ,FilesToSprayMbsProductInclude );
  MAC_FilesToSprayCSVPipe(pFilenameMBSSourceGcExclusion         ,Filenames(pversion).Input.MBSSourceGcExclusion ,FilesToSprayMBSSourceGcExclusion );
  MAC_FilesToSprayCSVPipe(pFilenameMBSmarketAppend         ,Filenames(pversion).Input.MBSmarketAppend ,FilesToSprayMBSmarketAppend );
  MAC_FilesToSprayCSVPipe(pFilenameMBSFdnIndType         ,Filenames(pversion).Input.MBSFdnIndType ,FilesToSprayMBSFdnIndType );
  MAC_FilesToSprayCSV(pFilenameMBSFdnCCID         ,Filenames(pversion).Input.MBSFdnCCID ,FilesToSprayMBSFdnCCID );
  MAC_FilesToSprayCSV(pFilenameMBSFdnHHID         ,Filenames(pversion).Input.MBSFdnHHID ,FilesToSprayMBSFdnHHID );
  MAC_FilesToSprayCSVPipe(pFilenameMBSTableCol         ,Filenames(pversion).Input.MBSTableCol ,FilesToSprayMBSTableCol );
  MAC_FilesToSprayCSVPipe(pFilenameMBSColValDesc         ,Filenames(pversion).Input.MBSColValDesc ,FilesToSprayMBSColValDesc );

  MAC_FilesToSprayCSV(pFilenameSuspectIP              ,Filenames(pversion).Input.SuspectIP                  ,FilesToSpraySuspectIP);
  MAC_FilesToSprayCSV(pFilenameTiger              ,Filenames(pversion).Input.Tiger                  ,FilesToSprayTiger         );
	MAC_FilesToSprayCSV(pFilenameCFNA               ,Filenames(pversion).Input.CFNA                   ,FilesToSprayCFNA         );

	SprayTheFile(dataset(tools.Layout_Sprays.Info) FilesToSpray) :=
		tools.fun_Spray(FilesToSpray,,,pOverwrite,pReplicate,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1);

	return parallel(
		  if(not _Flags.FileExists.Input.MBS                          or pOverwrite,SprayTheFile(FilesToSprayMBS               ))
		  ,if(not _Flags.FileExists.Input.MbsGcIdExclusion             or pOverwrite,SprayTheFile(FilesToSprayMbsGcIdExclusion          ))
		 ,if(not _Flags.FileExists.Input.MbsNewGcIdExclusion          or pOverwrite,SprayTheFile(FilesToSprayMbsNewGcIdExclusion          ))
		 ,if(not _Flags.FileExists.Input.MbsIndTypeExclusion          or pOverwrite,SprayTheFile(FilesToSprayMbsIndTypeExclusion      ))
		 ,if(not _Flags.FileExists.Input.MbsProductInclude            or pOverwrite,SprayTheFile(FilesToSprayMbsProductInclude       ))
		 ,if(not _Flags.FileExists.Input.MBSSourceGcExclusion         or pOverwrite,SprayTheFile(FilesToSprayMBSSourceGcExclusion       ))
		 ,if(not _Flags.FileExists.Input.MBSmarketAppend              or pOverwrite,SprayTheFile(FilesToSprayMBSmarketAppend       ))
		 ,if(not _Flags.FileExists.Input.MBSFdnIndType                or pOverwrite,SprayTheFile(FilesToSprayMBSFdnIndType       ))
		 ,if(not _Flags.FileExists.Input.MBSFdnCCID                   or pOverwrite,SprayTheFile(FilesToSprayMBSFdnCCID       ))
		 ,if(not _Flags.FileExists.Input.MBSFdnHHID                   or pOverwrite,SprayTheFile(FilesToSprayMBSFdnHHID       ))
		 ,if(not _Flags.FileExists.Input.MBSTableCol                  or pOverwrite,SprayTheFile(FilesToSprayMBSTableCol       ))
		 ,if(not _Flags.FileExists.Input.MBSColValDesc                or pOverwrite,SprayTheFile(FilesToSprayMBSColValDesc       ))
		 ,if(not _Flags.FileExists.Input.SuspectIP                    or pOverwrite,SprayTheFile(FilesToSpraySuspectIP             ))
		 ,if(not _Flags.FileExists.Input.Tiger                        or pOverwrite,SprayTheFile(FilesToSprayTiger             ))
		 ,if(not _Flags.FileExists.Input.CFNA                         or pOverwrite,SprayTheFile(FilesToSprayCFNA              ))

		);

end;