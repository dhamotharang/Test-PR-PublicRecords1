import tools, _control,lib_thorlib;

export SprayMBSFiles(

	 string		pServerIP		                   						= _control.IPAddress.bair_batchlz01
	,string		pDirectory	                   						= '/data/otto/in/'
	,string		pFilenamembs                   						= 'fdn_file_info.txt'	
	,string		pFilenameMbsGcIdExclusion      						= '*prev_fdn_file_gc*txt'
	,string 	pFilenameMbsFdnMasterIDIndTypeInclusion		= 'fdn_file_ind_type_gc_id_inclusion*txt'
	,string		pFilenameMbsNewGcIdExclusion   						= '*fdn_file_gc*txt'	// NewMBS excl file
	,string		pFilenameMbsIndTypeExclusion   						= '*fdn_file_ind_type_ex*txt'	
	,string		pFilenameMbsProductInclude     						= '*fdn_file_product*txt'	
	,string		pFilenameMBSSourceGcExclusion  						= '*fdn_source_gc_exclusion*txt'
	,string   pFilenameMBSmarketAppend       						= '*fdn_market*txt'
	,string   pFilenameMBSFdnIndType         						= 'fdn_ind_type.txt' 
	,string   pFilenameMBSFdnCCID            						= 'mbsi_fdn_accounts*' //CCID mbs accounts
	,string   pFilenameMBSFdnHHID            						= 'hhid_fdn_accounts*' //HHID accounts
	,string   pFilenameMBSTableCol           						= 'table_column.txt' 
	,string   pFilenameMBSColValDesc         						= 'column_value_desc.txt' 
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
			,if(_Control.ThisEnvironment.Name='Dataland','thor50_dev','thor400_30') //destinationgroup
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
			,if(_Control.ThisEnvironment.Name='Dataland','thor50_dev','thor400_30') //destinationgroup
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
	MAC_FilesToSprayCSVPipe(pFilenameMbsGcIdExclusion       					,Filenames(pversion).Input.MbsGcIdExclusion   	 						,FilesToSprayMbsGcIdExclusion     						);
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

	SprayTheFile(dataset(tools.Layout_Sprays.Info) FilesToSpray) :=
		tools.fun_Spray(FilesToSpray,,,pOverwrite,pReplicate,true,pIsTesting,,Platform.Name() + ' ' + pversion,pNameOutput,pShouldSprayMultipleFilesAs1 := pSprayMultipleFilesAs1);

	return parallel(
		  if(not _Flags.FileExists.Input.MBS                          	or pOverwrite,SprayTheFile(FilesToSprayMBS               								))
		 ,if(not _Flags.FileExists.Input.MbsGcIdExclusion             	or pOverwrite,SprayTheFile(FilesToSprayMbsGcIdExclusion       					))
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

		 ,if(Platform.Source = 'FRAUDGOV' and
				(not _Flags.FileExists.Input.MbsFdnMasterIDIndTypeInclusion	or pOverwrite),SprayTheFile(FilesToSprayMbsFdnMasterIDIndTypeInclusion))
		);

end;