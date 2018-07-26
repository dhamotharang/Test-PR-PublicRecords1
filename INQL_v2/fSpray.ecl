import Versioncontrol, _Control, fbn_new,lib_thorlib , ut, std, tools;

	pDate := (string8)std.date.today():INDEPENDENT;

	rFileDef := record
		string 	LogicalFile;	
		string5 Separate;
		DATASET(FsLogicalFileNameRecord) SuperFiles;
	end;

	GetFileDetails(string pFileType, boolean fcra = false) := function
		rgxName 	:= '[0-9-]{4,}';
		pVersion 	:= stringlib.stringfilterout(regexfind(rgxName, pFileType, 0), '-');
		version 	:= if(pVersion = '', pDate, pVersion);
		
		LogicalFile := map(
										regexfind(INQL_v2._Constants.FILE_TYPES[1],pFileType) 	=> INQL_v2.LogicalFile_List(fcra, version).bridger,
										regexfind(INQL_v2._Constants.FILE_TYPES[2],pFileType)		=> INQL_v2.LogicalFile_List(fcra, version).riskwise,
										regexfind(INQL_v2._Constants.FILE_TYPES[3],pFileType) 	=> INQL_v2.LogicalFile_List(fcra, version).banko,
										regexfind(INQL_v2._Constants.FILE_TYPES[4],pFileType) 	=> INQL_v2.LogicalFile_List(fcra, version).batch,
										regexfind(INQL_v2._Constants.FILE_TYPES[5],pFileType) 	=> INQL_v2.LogicalFile_List(fcra, version).custom,
										regexfind(INQL_v2._Constants.FILE_TYPES[6],pFileType) 	=> INQL_v2.LogicalFile_List(fcra, version).idm,									
										regexfind(INQL_v2._Constants.FILE_TYPES[7],pFileType) 	=> INQL_v2.LogicalFile_List(fcra, version).sba,
										regexfind(INQL_v2._Constants.FILE_TYPES[8],pFileType)  	=> INQL_v2.LogicalFile_List(fcra, version).deconfliction,
										regexfind(INQL_v2._Constants.FILE_TYPES[9],pFileType) 	=> INQL_v2.LogicalFile_List(fcra, version).transaction,
										regexfind(INQL_v2._Constants.FILE_TYPES[10],pFileType) 	=> INQL_v2.LogicalFile_List(fcra, version).accurint,
										regexfind(INQL_v2._Constants.FILE_TYPES[11],pFileType) 	=> INQL_v2.LogicalFile_List(fcra, version).accurint,
										'');
		
		Superfile := map(
										regexfind(INQL_v2._Constants.FILE_TYPES[1],pFileType) 	=> INQL_v2.Superfile_List(fcra).bridger,
										regexfind(INQL_v2._Constants.FILE_TYPES[2],pFileType) 	=> INQL_v2.Superfile_List(fcra).riskwise,
										regexfind(INQL_v2._Constants.FILE_TYPES[3],pFileType) 	=> INQL_v2.Superfile_List(fcra).banko,
										regexfind(INQL_v2._Constants.FILE_TYPES[4],pFileType) 	=> INQL_v2.Superfile_List(fcra).batch,
										regexfind(INQL_v2._Constants.FILE_TYPES[5],pFileType) 	=> INQL_v2.Superfile_List(fcra).custom,
										regexfind(INQL_v2._Constants.FILE_TYPES[6],pFileType) 	=> INQL_v2.Superfile_List(fcra).idm,
										regexfind(INQL_v2._Constants.FILE_TYPES[7],pFileType) 	=> INQL_v2.Superfile_List(fcra).sba,
										regexfind(INQL_v2._Constants.FILE_TYPES[8],pFileType)  	=> INQL_v2.Superfile_List(fcra).deconfliction,
										regexfind(INQL_v2._Constants.FILE_TYPES[9],pFileType) 	=> INQL_v2.Superfile_List(fcra).transaction,
										regexfind(INQL_v2._Constants.FILE_TYPES[10],pFileType) 	=> INQL_v2.Superfile_List(fcra).accurint,
										regexfind(INQL_v2._Constants.FILE_TYPES[11],pFileType) 	=> INQL_v2.Superfile_List(fcra).accurint,
										'');
		Separate := map(
										regexfind(INQL_v2._Constants.FILE_TYPES[1],pFileType) 	=> '\t',
										regexfind(INQL_v2._Constants.FILE_TYPES[2],pFileType) 	=> '~~',
										regexfind(INQL_v2._Constants.FILE_TYPES[3],pFileType) 	=> '~~',									
										regexfind(INQL_v2._Constants.FILE_TYPES[4],pFileType) 	=> '|',
										regexfind(INQL_v2._Constants.FILE_TYPES[5],pFileType) 	=> '~~',
										regexfind(INQL_v2._Constants.FILE_TYPES[6],pFileType) 	=> ',',
										regexfind(INQL_v2._Constants.FILE_TYPES[7],pFileType) 	=> '~~',
										regexfind(INQL_v2._Constants.FILE_TYPES[8],pFileType)  	=> '~~',
										regexfind(INQL_v2._Constants.FILE_TYPES[9],pFileType) 	=> '~~',
										regexfind(INQL_v2._Constants.FILE_TYPES[10],pFileType) 	=> '~~',
										regexfind(INQL_v2._Constants.FILE_TYPES[11],pFileType) 	=> '~~',
										'');
		
		sf_accurint_cc 	:= INQL_v2.Superfile_List(fcra).accurint_cc;
		sf_accurint_sl 	:= INQL_v2.Superfile_List(fcra).accurint_sl;
		sf_accurint_fdn	:= INQL_v2.Superfile_List(fcra).accurint_fdn;
		sf_riskwise_sl 	:= INQL_v2.Superfile_List(fcra).riskwise_sl;
		sf_custom_sl 		:= INQL_v2.Superfile_List(fcra).custom_sl;
														
		SuperFiles := map(
										regexfind(INQL_v2._Constants.FILE_TYPES[11],pFileType) => dataset([{sf_accurint_cc}, {sf_accurint_sl}, {sf_accurint_fdn}], FsLogicalFileNameRecord)
									 ,regexfind(INQL_v2._Constants.FILE_TYPES[2],pFileType)  => dataset([{sf_riskwise_sl}], FsLogicalFileNameRecord)
									 ,regexfind(INQL_v2._Constants.FILE_TYPES[5],pFileType)  => dataset([{sf_custom_sl}], FsLogicalFileNameRecord)
									 ,dataset([], FsLogicalFileNameRecord)
									 )
										+
									dataset([{Superfile}], FsLogicalFileNameRecord);
											
		ds := dataset([{LogicalFile, Separate, SuperFiles}], rFileDef);
		return ds;	
	end;

export fSpray(dataset({FsFilenameRecord}) filelist, boolean fcra = false) := function
	
	pGroupName	:= INQL_v2._Constants.GROUPNAME;
	
	tools.Layout_Sprays.Info xForm(filelist L) := transform
			self:=row(
								{	 
								 INQL_v2._Constants.LZ						
								,INQL_v2._Constants.sprayingDir                           
								,L.name                                      
								,0
								,GetFileDetails(L.name, fcra)[1].LogicalFile
								,GetFileDetails(L.name, fcra)[1].Superfiles
								,pGroupName                                                
								,''                                                    
								,''                                                            
								,'VARIABLE'                                                         
								,''
								,''
								,GetFileDetails(L.name, fcra)[1].Separate
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