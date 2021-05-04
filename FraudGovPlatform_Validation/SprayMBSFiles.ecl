import tools, _control,lib_thorlib, FraudGovPlatform, Scrubs_MBS, ut, STD;

export SprayMBSFiles(
	string pversion,
	boolean	pUseOtherEnvironment = false
) :=
function

	pMBSServerIP := IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata10, _control.IPAddress.bctlpedata10);
	pMBSFraudGovDirectory := IF (_control.ThisEnvironment.Name <> 'Prod_Thor', FraudGovPlatform_Validation.Constants.MBSLandingZonePathBase_dev, FraudGovPlatform_Validation.Constants.MBSLandingZonePathBase_prod);
	pMBSFDNServerIP := IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata10, _control.IPAddress.bctlpedata10);
	pMBSFDNDirectory := IF (_control.ThisEnvironment.Name <> 'Prod_Thor', Constants.FDNMBSLandingZonePathBase_dev, Constants.FDNMBSLandingZonePathBase_prod);
	pFilenamembs := '*file_info.txt';
	pFilenameMbsFdnMasterIDIndTypeInclusion := '*ind_gc_inclusion.txt';
	pFilenameMbsNewGcIdExclusion := '*file_gc_exclusion.txt';
	pFilenameMbsIndTypeExclusion := '*ind_type_exclusion.txt';
	pFilenameMbsProductInclude := '*file_product_include.txt';
	pFilenameMBSSourceGcExclusion := '*source_gc_exclusion_comp.txt';
	pFilenameMBSmarketAppend := '*fdn_market*txt';
	pFilenameMBSFdnIndType := '*ind_type.txt';
	pFilenameMBSTableCol := '*table_column.txt';
	pFilenameMBSColValDesc := '*column_value_desc.txt';
	yesterday_date := (unsigned) ut.date_math(pVersion[1..8], -1);
	pFilenameMBSFdnCCID := 'mbsi_fdn_accounts_' + (string)yesterday_date + '*';
	pFilenameMBSFdnHHID := '*hhid_fdn_accounts.txt';
	pGroupName := thorlib.group();
	pIsTesting := false;
	pOverwrite :=  true;
	pReplicate :=	true;
	pNameOutput := 'FraudGov Spray Info';
	pSprayMultipleFilesAs1 := true;

	MAC_FilesToSprayCSVPipe(pRemoteFilename,pLocalFilename,outAttr) := macro
	
		outAttr := dataset([

			{pMBSServerIP
			,pMBSFraudGovDirectory + '/' + pversion
			,pRemoteFilename
			,0
			,pLocalFilename.Template
			,[ {pLocalFilename.Sprayed	}	]
			,pGroupName
			,pversion
			,''
			,'VARIABLE'
			,''
			,FraudGovPlatform._Dataset(pUseOtherEnvironment).max_record_size
			,'|\t|' 
      ,'|\n'
			}
		], tools.Layout_Sprays.Info);
		
	endmacro;

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
			,FraudGovPlatform._Dataset(pUseOtherEnvironment).max_record_size
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
			,FraudGovPlatform._Dataset(pUseOtherEnvironment).max_record_size
			,'\\,'
			}
		], tools.Layout_Sprays.Info);
		
	endmacro;
	
	MAC_FilesToSprayCCID(pRemoteFilename,pLocalFilename,outAttr) := macro
	
		outAttr := DATASET([

			{pMBSFDNServerIP
			,pMBSFDNDirectory + '/mbs/prod'
			,pRemoteFilename
			,0
			,pLocalFilename.Template
			,[ {pLocalFilename.Sprayed	}	]
			,pGroupName
			,pversion
			,''
			,'VARIABLE'
			,''
			,FraudGovPlatform._Dataset(pUseOtherEnvironment).max_record_size
			,'\\,'
			}
		], tools.Layout_Sprays.Info);
		
	endmacro;

	MAC_FilesToSprayCSVPipe(pFilenamembs                				,FraudGovPlatform.Filenames(pversion).Input.mbs ,FilesToSprayMBS );
	MAC_FilesToSprayCSVPipe(pFilenameMbsFdnMasterIDIndTypeInclusion 	,FraudGovPlatform.Filenames(pversion).Input.MbsFdnMasterIDIndTypeInclusion ,FilesToSprayMbsFdnMasterIDIndTypeInclusion ); 
	MAC_FilesToSprayCSVPipe(pFilenameMbsNewGcIdExclusion    			,FraudGovPlatform.Filenames(pversion).Input.MbsNewGcIdExclusion ,FilesToSprayMbsNewGcIdExclusion );
	MAC_FilesToSprayCSVPipe(pFilenameMbsIndTypeExclusion    			,FraudGovPlatform.Filenames(pversion).Input.MbsIndTypeExclusion ,FilesToSprayMbsIndTypeExclusion );
	MAC_FilesToSprayCSVPipe(pFilenameMbsProductInclude      			,FraudGovPlatform.Filenames(pversion).Input.MbsProductInclude ,FilesToSprayMbsProductInclude );
	MAC_FilesToSprayCSVPipe(pFilenameMBSSourceGcExclusion   			,FraudGovPlatform.Filenames(pversion).Input.MBSSourceGcExclusion ,FilesToSprayMBSSourceGcExclusion );
	MAC_FilesToSprayCSVPipe(pFilenameMBSFdnIndType          			,FraudGovPlatform.Filenames(pversion).Input.MBSFdnIndType ,FilesToSprayMBSFdnIndType );
	MAC_FilesToSprayCSVPipe(pFilenameMBSTableCol         				,FraudGovPlatform.Filenames(pversion).Input.MBSTableCol ,FilesToSprayMBSTableCol );
	MAC_FilesToSprayCSVPipe(pFilenameMBSColValDesc         				,FraudGovPlatform.Filenames(pversion).Input.MBSColValDesc ,FilesToSprayMBSColValDesc );
	
	MAC_FilesToSprayMA(pFilenameMBSmarketAppend 						,FraudGovPlatform.Filenames(pversion).Input.MBSmarketAppend , FilesToSprayMBSmarketAppend );
	MAC_FilesToSprayCCID(pFilenameMBSFdnCCID 							,FraudGovPlatform.Filenames(pversion).Input.MBSFdnCCID , FilesToSprayMBSFdnCCID );
	MAC_FilesToSprayHHID(pFilenameMBSFdnHHID 							,FraudGovPlatform.Filenames(pversion).Input.MBSFdnHHID , FilesToSprayMBSFdnHHID );
 
	SprayTheFile(dataset(tools.Layout_Sprays.Info) FilesToSpray) :=
		tools.fun_Spray(FilesToSpray,,,pOverwrite,pReplicate,true,pIsTesting,,FraudGovPlatform._Dataset(pUseOtherEnvironment).Name + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1);

	return sequential(
		  FraudGovPlatform.Promote().MBSInputfiles.Sprayed2Using
		 ,FraudGovPlatform.Promote(pdelete := true).MBSInputfiles.Using2Used				
		 ,if(not FraudGovPlatform._Flags.FileExists.Input.MBS                          	or pOverwrite,SprayTheFile(FilesToSprayMBS ))
		 ,if(not FraudGovPlatform._Flags.FileExists.Input.MbsNewGcIdExclusion          	or pOverwrite,SprayTheFile(FilesToSprayMbsNewGcIdExclusion ))
		 ,if(not FraudGovPlatform._Flags.FileExists.Input.MbsIndTypeExclusion          	or pOverwrite,SprayTheFile(FilesToSprayMbsIndTypeExclusion ))
		 ,if(not FraudGovPlatform._Flags.FileExists.Input.MbsProductInclude            	or pOverwrite,SprayTheFile(FilesToSprayMbsProductInclude ))
		 ,if(not FraudGovPlatform._Flags.FileExists.Input.MBSSourceGcExclusion         	or pOverwrite,SprayTheFile(FilesToSprayMBSSourceGcExclusion ))
		 ,if(not FraudGovPlatform._Flags.FileExists.Input.MBSmarketAppend 				or pOverwrite,SprayTheFile(FilesToSprayMBSmarketAppend ))
		 ,if(not FraudGovPlatform._Flags.FileExists.Input.MBSFdnIndType                	or pOverwrite,SprayTheFile(FilesToSprayMBSFdnIndType ))
		 ,if(not FraudGovPlatform._Flags.FileExists.Input.MBSTableCol                  	or pOverwrite,SprayTheFile(FilesToSprayMBSTableCol ))
		 ,if(not FraudGovPlatform._Flags.FileExists.Input.MBSColValDesc                	or pOverwrite,SprayTheFile(FilesToSprayMBSColValDesc ))
		 ,if(not FraudGovPlatform._Flags.FileExists.Input.MbsFdnMasterIDIndTypeInclusion or pOverwrite,SprayTheFile(FilesToSprayMbsFdnMasterIDIndTypeInclusion ))
		, if(not FraudGovPlatform._Flags.FileExists.Input.MBSFdnCCID 					or pOverwrite,SprayTheFile(FilesToSprayMBSFdnCCID ))
		, if(not FraudGovPlatform._Flags.FileExists.Input.MBSFdnHHID 					or pOverwrite,SprayTheFile(FilesToSprayMBSFdnHHID ))
		, If(FraudGovPlatform._Flags.UseDemoData,FraudGovPlatform.Append_MBSDemoData(pversion).MbsIncl)
		, if(~STD.File.FileExists(FraudGovPlatform.Filenames(pversion).Input.MBSFdnHHID.new(pversion)),STD.File.SwapSuperFile(FraudGovPlatform.filenames().input.MBSFdnHHID.used,FraudGovPlatform.filenames().input.MBSFdnHHID.sprayed))
		, if(~STD.File.FileExists(FraudGovPlatform.Filenames(pversion).Input.MBSmarketAppend.new(pversion)),STD.File.SwapSuperFile(FraudGovPlatform.filenames().input.MBSmarketAppend.used,FraudGovPlatform.filenames().input.MBSmarketAppend.sprayed))

		);

end;