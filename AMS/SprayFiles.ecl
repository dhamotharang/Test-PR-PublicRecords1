import tools, _control;

export SprayFiles(

	 string		pServerIP		= _control.IPAddress.bctlpedata11
	,string		pDirectory	= '/data/data_build_4/AMS/data'
	,string		pFilenameXref                 = '*provider_xref*txt'
	,string		pFilenameStateLicense         = '*provider_state_license*txt'
	,string		pFilenameSpecialty            = '*provider_specialties*txt'
	,string		pFilenameMerges               = '*provider_merge*txt'
	,string		pFilenameSplits               = '*provider_split*txt'
	,string		pFilenameProviderDemographics = '*provider_demographics*txt'
	,string		pFilenameDegree               = '*provider_degrees*txt'
	,string		pFilenameCredential           = '*provider_credentials*txt'
	,string		pFilenameProviderAddress      = '*provider_address*txt'
	,string		pFilenameCode                 = '*code*txt'
	,string		pFilenameAffiliation          = '*affiliations*txt'
	,string		pFilenameAccountDemographics  = '*account_demographics*txt'
	,string		pFilenameAccountAddress       = '*account_address*txt'
	,string		pFilenameAccountMerges        = '*account_merge*txt'
	,string		pFilenameAccountSplits        = '*account_split*txt'
	,string		pversion
	,string		pGroupName	= _dataset().groupname																		
	,boolean	pIsTesting	= false
	,boolean	pOverwrite	= false
	,boolean	pReplicate	=	true
	,string		pNameOutput	= 'AMS Spray Info'	
	,boolean	pSprayMultipleFilesAs1	= true

) :=
function

	MAC_FilesToSpray(pRemoteFilename,pLocalFilename,outAttr) := macro
	
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
			,'|'
			}
		], tools.Layout_Sprays.Info);
		
	endmacro;
	
	MAC_FilesToSpray(pFilenameXref                ,Filenames(pversion).Input.Xref                ,FilesToSprayXref                );
	MAC_FilesToSpray(pFilenameStateLicense        ,Filenames(pversion).Input.StateLicense        ,FilesToSprayStateLicense        );
	MAC_FilesToSpray(pFilenameSpecialty           ,Filenames(pversion).Input.Specialty           ,FilesToSpraySpecialty           );
	MAC_FilesToSpray(pFilenameMerges              ,Filenames(pversion).Input.Merges              ,FilesToSprayMerges              );
	MAC_FilesToSpray(pFilenameSplits              ,Filenames(pversion).Input.Splits              ,FilesToSpraySplits              );
	MAC_FilesToSpray(pFilenameProviderDemographics,Filenames(pversion).Input.ProviderDemographics,FilesToSprayProviderDemographics);
	MAC_FilesToSpray(pFilenameDegree              ,Filenames(pversion).Input.Degree              ,FilesToSprayDegree              );
	MAC_FilesToSpray(pFilenameCredential          ,Filenames(pversion).Input.Credential          ,FilesToSprayCredential          );
	MAC_FilesToSpray(pFilenameProviderAddress     ,Filenames(pversion).Input.ProviderAddress     ,FilesToSprayProviderAddress     );
	MAC_FilesToSpray(pFilenameCode                ,Filenames(pversion).Input.Code                ,FilesToSprayCode                );
	MAC_FilesToSpray(pFilenameAffiliation         ,Filenames(pversion).Input.Affiliation         ,FilesToSprayAffiliation         );
	MAC_FilesToSpray(pFilenameAccountDemographics ,Filenames(pversion).Input.AccountDemographics ,FilesToSprayAccountDemographics );
	MAC_FilesToSpray(pFilenameAccountAddress      ,Filenames(pversion).Input.AccountAddress      ,FilesToSprayAccountAddress      );
	MAC_FilesToSpray(pFilenameAccountMerges       ,Filenames(pversion).Input.AccountMerges       ,FilesToSprayAccountMerges       );
	MAC_FilesToSpray(pFilenameAccountSplits       ,Filenames(pversion).Input.AccountSplits       ,FilesToSprayAccountSplits       );
	
	SprayTheFile(dataset(tools.Layout_Sprays.Info) FilesToSpray) :=
		tools.fun_Spray(FilesToSpray,,,pOverwrite,pReplicate,true,pIsTesting,,_Dataset().Name + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1);

	return parallel(
		 if(not _Flags.FileExists.Input.Xref                 or pOverwrite,SprayTheFile(FilesToSprayXref                ))
		,if(not _Flags.FileExists.Input.StateLicense         or pOverwrite,SprayTheFile(FilesToSprayStateLicense        ))
		,if(not _Flags.FileExists.Input.Specialty            or pOverwrite,SprayTheFile(FilesToSpraySpecialty           ))
		,if(not _Flags.FileExists.Input.Merges               or pOverwrite,SprayTheFile(FilesToSprayMerges              ))
		,if(not _Flags.FileExists.Input.Splits               or pOverwrite,SprayTheFile(FilesToSpraySplits              ))
		,if(not _Flags.FileExists.Input.ProviderDemographics or pOverwrite,SprayTheFile(FilesToSprayProviderDemographics))
		,if(not _Flags.FileExists.Input.Degree               or pOverwrite,SprayTheFile(FilesToSprayDegree              ))
		,if(not _Flags.FileExists.Input.Credential           or pOverwrite,SprayTheFile(FilesToSprayCredential          ))
		,if(not _Flags.FileExists.Input.ProviderAddress      or pOverwrite,SprayTheFile(FilesToSprayProviderAddress     ))
		,if(not _Flags.FileExists.Input.Code                 or pOverwrite,SprayTheFile(FilesToSprayCode                ))
		,if(not _Flags.FileExists.Input.Affiliation          or pOverwrite,SprayTheFile(FilesToSprayAffiliation         ))
		,if(not _Flags.FileExists.Input.AccountDemographics  or pOverwrite,SprayTheFile(FilesToSprayAccountDemographics ))
		,if(not _Flags.FileExists.Input.AccountAddress       or pOverwrite,SprayTheFile(FilesToSprayAccountAddress      ))
		,if(not _Flags.FileExists.Input.AccountMerges        or pOverwrite,SprayTheFile(FilesToSprayAccountMerges       ))
		,if(not _Flags.FileExists.Input.AccountSplits        or pOverwrite,SprayTheFile(FilesToSprayAccountSplits       ))
	);

end;
