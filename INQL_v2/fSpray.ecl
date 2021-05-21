import Versioncontrol, _Control, fbn_new,lib_thorlib , ut, std, tools,INQL_V2;

    pDate := (string8)std.date.today():INDEPENDENT;
	rFileDef := record
		string 	LogicalFile;	
		string5 Separate;
		DATASET(FsLogicalFileNameRecord) SuperFiles;
	end;

	GetFileDetails(string fversion,string pFileType,string pPrefix, boolean fcra = false) := function
        rgxName 	:= '[0-9-]{4,}';
        pVersion 	:= stringlib.stringfilterout(regexfind(rgxName, fversion, 0), '-');
		version 	:= if(pVersion = '', pDate, pVersion);
		

    LogicalFile := IF(pFileType='transaction',pPrefix + '::in::mbs::'+version+'::transaction_desc',
				   INQL_V2.Filenames(version,fcra,,pFileType).InputTemplate);
	
	Superfile  :=  IF(pFileType='transaction',pPrefix + '::in::transaction_desc',
				   INQL_V2.Filenames(version,fcra,,pFileType).Input);
	
	Separate   := IF(pFileType='bridger','\t', 
	              IF(pFileType='batch','|',
				  IF(pFileType='idm',',','~~'))); 

	
	sf_accurint_cc 	:= pPrefix + '::in::accurint_acclogs_cc';
	sf_accurint_sl 	:= pPrefix + '::in::accurint_acclogs_sl';
	sf_accurint_fdn	:= '~thor_data400::in::fdn::sprayed::glb5';	
	sf_riskwise_sl 	:= pPrefix + '::in::riskwise_acclogs_sl';
	sf_custom_sl 	:= pPrefix + '::in::custom_acclogs_sl';
													
	SuperFiles := if(pFileType='accurint' and fcra=false,dataset([{sf_accurint_cc}, {sf_accurint_sl}, {sf_accurint_fdn}], FsLogicalFileNameRecord),
				  if(pFileType='riskwise',dataset([{sf_riskwise_sl}], FsLogicalFileNameRecord),
				  if(pFileType='custom',dataset([{sf_custom_sl}], FsLogicalFileNameRecord)
											)
										)
									)
									+
									dataset([{Superfile}], FsLogicalFileNameRecord);
										
	ds := dataset([{LogicalFile, Separate, SuperFiles}], rFileDef);
	return ds;	
end;

export fSpray(dataset({FsFilenameRecord,string source}) filelist, boolean fcra = false) := function
	
	pGroupName	:= INQL_v2._Constants.GROUPNAME;
	pPrefix		:= if(fcra, '~thor10_231', '~thor100_21');
	
	tools.Layout_Sprays.Info xForm(filelist L) := transform
			self:=row(
								{	 
								 INQL_v2._Constants.LZ	
								,INQL_v2._Constants.sprayingDir                           
								,L.name                                      
								,0
								,GetFileDetails(L.name,L.source, pPrefix, fcra)[1].LogicalFile
								,GetFileDetails(L.name,L.source, pPrefix, fcra)[1].Superfiles
								,pGroupName                                                
								,''                                                    
								,''                                                            
								,'VARIABLE'                                                         
								,''
								,''
								,GetFileDetails(L.name,L.source, pPrefix, fcra)[1].Separate
								,''               //'\\n,\\r\\n'
								,','                     //''
								,true
								}
								,tools.Layout_Sprays.Info);
																
	end;
	
	FilesToSpray:=project(filelist, xForm(left));
	spray := sequential(
						VersionControl.fSprayInputFiles(FilesToSpray(regexfind('transaction_desc', thor_filename_template))
																												,pShouldClearSuperfileFirst:= true
																												,pSplitEmails:=false
																												,pShouldSprayZeroByteFiles:=false
																												,pShouldSprayMultipleFilesAs1:=false
																												,pVersion:='')
					 ,VersionControl.fSprayInputFiles(FilesToSpray(~regexfind('transaction', thor_filename_template)))
						);
	
	return spray;
	
end;