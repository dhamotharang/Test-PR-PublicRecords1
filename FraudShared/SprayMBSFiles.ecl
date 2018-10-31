import tools, _control,lib_thorlib;

export SprayMBSFiles(
	 string		pServerIP		                   						= IF (_control.ThisEnvironment.Name <> 'Prod_Thor', _control.IPAddress.bctlpedata12, _control.IPAddress.bctlpedata10)
	,string		pDirectory	                   						= '/data/super_credit/fdn/in'	
	,string		pFilenamembs                   						= '*file_info.txt'	 											
	,string 	pFilenameMbsFdnMasterIDIndTypeInclusion		= '*ind_gc_inclusion.txt'
	,string		pFilenameMbsNewGcIdExclusion   						= '*file_gc_exclusion.txt'
	,string		pFilenameMbsIndTypeExclusion   						= '*ind_type_exclusion.txt'
	,string		pFilenameMbsProductInclude     						= '*file_product_include.txt'
	,string		pFilenameMBSSourceGcExclusion  						= '*source_gc_exclusion_comp.txt'
	,string   pFilenameMBSmarketAppend       						= '*fdn_market*txt'
	,string   pFilenameMBSFdnIndType         						= '*ind_type.txt'
	,string   pFilenameMBSFdnCCID            						= 'mbsi_fdn_accounts*'
	,string   pFilenameMBSFdnHHID            						= 'hhid_fdn_accounts*'
	,string   pFilenameMBSTableCol           						= 'table_column.txt'
	,string   pFilenameMBSColValDesc         						= 'column_value_desc.txt'
	,string 	pFilenameMbsVelocityRules									= '*velocity_rules.txt'
	,string		pversion
	,string		pGroupName	                   = thorlib.group()																		
	,boolean	pIsTesting	                   = false
	,boolean	pOverwrite	                   =  true
	,boolean	pReplicate	                   =	true
	,string		pNameOutput	                   = 'FraudGov Spray Info'	
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
			,Platform.max_record_size()
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
			,Platform.max_record_size()
			,'\\,'
			}
		], tools.Layout_Sprays.Info);
		
	endmacro;
	
	
	MAC_FilesToSprayCSVPipe(pFilenamembs                							,Filenames(pversion).Input.mbs                	 						,FilesToSprayMBS                							);
	MAC_FilesToSprayCSVPipe(pFilenameMbsFdnMasterIDIndTypeInclusion   ,Filenames(pversion).Input.MbsFdnMasterIDIndTypeInclusion   ,FilesToSprayMbsFdnMasterIDIndTypeInclusion   );
	MAC_FilesToSprayCSVPipe(pFilenameMbsNewGcIdExclusion    					,Filenames(pversion).Input.MbsNewGcIdExclusion   						,FilesToSprayMbsNewGcIdExclusion  						);
	MAC_FilesToSprayCSVPipe(pFilenameMbsIndTypeExclusion    					,Filenames(pversion).Input.MbsIndTypeExclusion 	 						,FilesToSprayMbsIndTypeExclusion 							);
  MAC_FilesToSprayCSVPipe(pFilenameMbsProductInclude      					,Filenames(pversion).Input.MbsProductInclude								,FilesToSprayMbsProductInclude 								);
  MAC_FilesToSprayCSVPipe(pFilenameMBSSourceGcExclusion   					,Filenames(pversion).Input.MBSSourceGcExclusion 						,FilesToSprayMBSSourceGcExclusion							);
  MAC_FilesToSprayCSVPipe(pFilenameMBSmarketAppend        					,Filenames(pversion).Input.MBSmarketAppend 									,FilesToSprayMBSmarketAppend 									);
  MAC_FilesToSprayCSVPipe(pFilenameMBSFdnIndType          					,Filenames(pversion).Input.MBSFdnIndType 										,FilesToSprayMBSFdnIndType 										);
  MAC_FilesToSprayCSV(pFilenameMBSFdnCCID         									,Filenames(pversion).Input.MBSFdnCCID 											,FilesToSprayMBSFdnCCID												);
  MAC_FilesToSprayCSV(pFilenameMBSFdnHHID         									,Filenames(pversion).Input.MBSFdnHHID 											,FilesToSprayMBSFdnHHID 											);
  MAC_FilesToSprayCSVPipe(pFilenameMBSTableCol         							,Filenames(pversion).Input.MBSTableCol 											,FilesToSprayMBSTableCol 											);
  MAC_FilesToSprayCSVPipe(pFilenameMBSColValDesc         						,Filenames(pversion).Input.MBSColValDesc 										,FilesToSprayMBSColValDesc 										);
	MAC_FilesToSprayCSVPipe(pFilenameMbsVelocityRules      						,Filenames(pversion).Input.MbsVelocityRules									,FilesToSprayMbsVelocityRules									);

	SprayTheFile(dataset(tools.Layout_Sprays.Info) FilesToSpray) :=
		tools.fun_Spray(FilesToSpray,,,pOverwrite,pReplicate,true,pIsTesting,,Platform.Name() + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1);

	return parallel(
		  if(not _Flags.FileExists.Input.MBS                          	or pOverwrite,SprayTheFile(FilesToSprayMBS               								))
		 ,if(not _Flags.FileExists.Input.MbsNewGcIdExclusion          	or pOverwrite,SprayTheFile(FilesToSprayMbsNewGcIdExclusion    					))
		 ,if(not _Flags.FileExists.Input.MbsIndTypeExclusion          	or pOverwrite,SprayTheFile(FilesToSprayMbsIndTypeExclusion    					))
		 ,if(not _Flags.FileExists.Input.MbsProductInclude            	or pOverwrite,SprayTheFile(FilesToSprayMbsProductInclude      					))
		 ,if(not _Flags.FileExists.Input.MBSSourceGcExclusion         	or pOverwrite,SprayTheFile(FilesToSprayMBSSourceGcExclusion  						))
		 ,if(not _Flags.FileExists.Input.MBSmarketAppend              	or pOverwrite,SprayTheFile(FilesToSprayMBSmarketAppend       						))
		 ,if(not _Flags.FileExists.Input.MBSFdnIndType                	or pOverwrite,SprayTheFile(FilesToSprayMBSFdnIndType       							))
		 ,if(not _Flags.FileExists.Input.MBSFdnCCID                   	or pOverwrite,SprayTheFile(FilesToSprayMBSFdnCCID      									))
		 ,if(not _Flags.FileExists.Input.MBSFdnHHID                   	or pOverwrite,SprayTheFile(FilesToSprayMBSFdnHHID       								))
		 ,if(not _Flags.FileExists.Input.MBSTableCol                  	or pOverwrite,SprayTheFile(FilesToSprayMBSTableCol       								))
		 ,if(not _Flags.FileExists.Input.MBSColValDesc                	or pOverwrite,SprayTheFile(FilesToSprayMBSColValDesc       							))
		 ,if(not _Flags.FileExists.Input.MbsFdnMasterIDIndTypeInclusion or pOverwrite,SprayTheFile(FilesToSprayMbsFdnMasterIDIndTypeInclusion		))
		 ,if(Platform.Source = 'FraudGov' and
				(not _Flags.FileExists.Input.MbsVelocityRules 							or pOverwrite),SprayTheFile(FilesToSprayMbsVelocityRules								))
		);

end;