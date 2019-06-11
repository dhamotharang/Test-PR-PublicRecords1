import tools, _control,lib_thorlib, FraudShared, FraudGovPlatform, Scrubs_MBS, ut;

export SprayMBSFiles(
	 string pversion
) :=
function

	pMBSServerIP := IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10);
	pMBSFraudGovDirectory := IF (_control.ThisEnvironment.Name <> 'Prod_Thor', FraudGovPlatform_Validation.Constants.MBSLandingZonePathBase_dev, FraudGovPlatform_Validation.Constants.MBSLandingZonePathBase_prod);
	pMBSFDNServerIP := IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10);
	pMBSFDNDirectory := IF (_control.ThisEnvironment.Name <> 'Prod_Thor', Constants.FDNMBSLandingZonePathBase_dev, Constants.FDNMBSLandingZonePathBase_prod);
	pFilenameMBSmarketAppend := '*fdn_market*txt';
	yesterday_date := (unsigned) ut.date_math(pVersion[1..8], -1);
	pFilenameMBSFdnCCID := 'mbsi_fdn_accounts_' + (string)yesterday_date + '*';
	pFilenameMBSFdnHHID := '*hhid_fdn_accounts.csv';
	pGroupName := thorlib.group();
	pIsTesting := false;
	pOverwrite :=  true;
	pReplicate :=	true;
	pNameOutput := 'FraudGov Spray Info';
	pSprayMultipleFilesAs1 := true;

	MAC_FilesToSprayMA(pRemoteFilename,pLocalFilename,outAttr) := macro
	
		outAttr := DATASET([

			{pMBSFDNServerIP
			,pMBSFDNDirectory + '/' + pversion
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

			{pMBSFDNServerIP
			,pMBSFDNDirectory + '/' + pversion
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

			{pMBSFDNServerIP
			,pMBSFDNDirectory
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

	
  MAC_FilesToSprayMA(pFilenameMBSmarketAppend , FraudShared.Filenames(pversion).Input.MBSmarketAppend , FilesToSprayMBSmarketAppend );
  MAC_FilesToSprayCCID(pFilenameMBSFdnCCID , FraudShared.Filenames(pversion).Input.MBSFdnCCID , FilesToSprayMBSFdnCCID );
  MAC_FilesToSprayHHID(pFilenameMBSFdnHHID , FraudShared.Filenames(pversion).Input.MBSFdnHHID , FilesToSprayMBSFdnHHID );
 
	SprayTheFile(dataset(tools.Layout_Sprays.Info) FilesToSpray) :=
		tools.fun_Spray(FilesToSpray,,,pOverwrite,pReplicate,true,pIsTesting,,FraudShared.Platform.Name() + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1);

	return sequential(
		  FraudShared.Promote().Inputfiles.Sprayed2Using
		, FraudShared.Promote().Inputfiles.Using2Used				
		, FraudShared.SprayMBSFiles(pversion := pVersion[1..8], pServerIP := pMBSServerIP,pDirectory := pMBSFraudGovDirectory)
		, if(not FraudShared._Flags.FileExists.Input.MBSmarketAppend or pOverwrite , SprayTheFile(FilesToSprayMBSmarketAppend ))
		, if(not FraudShared._Flags.FileExists.Input.MBSFdnCCID or pOverwrite , SprayTheFile(FilesToSprayMBSFdnCCID ))
		, if(not FraudShared._Flags.FileExists.Input.MBSFdnHHID or pOverwrite , SprayTheFile(FilesToSprayMBSFdnHHID ))
		, If(FraudGovPlatform._Flags.UseDemoData,FraudGovPlatform.Append_MBSDemoData(pversion).MbsIncl)
		);

end;