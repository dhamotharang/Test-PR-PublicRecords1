import tools, _control,lib_thorlib, FraudShared;

export SprayMBSFiles(
	 string		pServerIP		                   						= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10)
	,string		pDirectory	                   						= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', '/data/super_credit/fdn/in/mbs/dev', '/data/super_credit/fdn/in/mbs/prod')	
	,string   pFilenameMBSmarketAppend       						= '*fdn_market*txt'
	,string   pFilenameMBSFdnCCID            						= 'mbsi_fdn_accounts*'
	,string   pFilenameMBSFdnHHID            						= 'hhid_fdn_accounts*'
	,string		pversion
	,string		pGroupName	                   = thorlib.group()																		
	,boolean	pIsTesting	                   = false
	,boolean	pOverwrite	                   =  true
	,boolean	pReplicate	                   =	true
	,string		pNameOutput	                   = 'FraudGov Spray Info'	
	,boolean	pSprayMultipleFilesAs1	       = true

) :=
function

	MAC_FilesToSprayMA(pRemoteFilename,pLocalFilename,outAttr) := macro
	
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
			,FraudShared.Platform.max_record_size()
			,'|\t|' 
      ,'|\n'
			}
		], tools.Layout_Sprays.Info);
		
	endmacro;

	MAC_FilesToSprayHHID(pRemoteFilename,pLocalFilename,outAttr) := macro
	
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
			,FraudShared.Platform.max_record_size()
			,'\\,'
			}
		], tools.Layout_Sprays.Info);
		
	endmacro;
	
	MAC_FilesToSprayCCID(pRemoteFilename,pLocalFilename,outAttr) := macro
	
		outAttr := DATASET([

			{pServerIP
			,pDirectory
			,pRemoteFilename
			,0
			,pLocalFilename.Template
			,[ {pLocalFilename.Sprayed	}	]
			,pGroupName
			,pversion
			,''
			,'VARIABLE'
			,''
			,FraudShared.Platform.max_record_size()
			,'\\,'
			}
		], tools.Layout_Sprays.Info);
		
	endmacro;

	
  MAC_FilesToSprayMA(pFilenameMBSmarketAppend	,FraudShared.Filenames(pversion).Input.MBSmarketAppend 									,FilesToSprayMBSmarketAppend 									);
  MAC_FilesToSprayCCID(pFilenameMBSFdnCCID			,FraudShared.Filenames(pversion).Input.MBSFdnCCID 											,FilesToSprayMBSFdnCCID												);
  MAC_FilesToSprayHHID(pFilenameMBSFdnHHID      ,FraudShared.Filenames(pversion).Input.MBSFdnHHID 											,FilesToSprayMBSFdnHHID 											);

	SprayTheFile(dataset(tools.Layout_Sprays.Info) FilesToSpray) :=
		tools.fun_Spray(FilesToSpray,,,pOverwrite,pReplicate,true,pIsTesting,,FraudShared.Platform.Name() + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1);

	return parallel(
		  if(not FraudShared._Flags.FileExists.Input.MBSmarketAppend              	or pOverwrite,SprayTheFile(FilesToSprayMBSmarketAppend       						))
		 ,if(not FraudShared._Flags.FileExists.Input.MBSFdnCCID                   	or pOverwrite,SprayTheFile(FilesToSprayMBSFdnCCID      									))
		 ,if(not FraudShared._Flags.FileExists.Input.MBSFdnHHID                   	or pOverwrite,SprayTheFile(FilesToSprayMBSFdnHHID       								))
		);

end;