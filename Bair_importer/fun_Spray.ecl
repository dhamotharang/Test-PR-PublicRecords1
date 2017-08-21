import ut, lib_fileservices, _control, tools;

#option('maxLength', 131072); 				// have to increase for the remote directory child datasets

export fun_Spray(	 
							 Dataset(tools.Layout_Sprays.Info)	pSprayInformation
							,string												pSprayInfoSuperfile					= ''
							,string												pSprayInfoLogicalfile				= ''
							,boolean											pOverwrite									= false
							,boolean											pReplicate									= true
							,boolean											pAddCounter									= true
							,boolean											pIsTesting									= false
							,string												pEmailNotificationList			= _control.MyInfo.EmailAddressNotify
							,string												pEmailSubjectDataset				= ''			// such as 'Corp' or 'UCCS', etc
							,string												pOutputName									= ''
							,boolean											pShouldClearSuperfileFirst	= false
							,boolean											pSplitEmails								= false
							,boolean											pShouldSprayZeroByteFiles			= false
							,boolean											pShouldSprayMultipleFilesAs1	= false
							,string 											pFileVersion								= ''
) :=
function
	////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Get directory listings using the passed filter for all records in passed dataset
	////////////////////////////////////////////////////////////////////////////////////////////////////
	layout_directory_listings :=
	record, maxlength(100000)
		pSprayInformation;
		DATASET(lib_fileservices.FsFileNameRecord)	dDirectoryListing;
		DATASET(lib_fileservices.FsFileNameRecord)	dDirectorySummation;
		unsigned4	remotefilescount;
		unsigned8	remotefilessize;
	end;
	
	layout_directory_listings tGetDirs(tools.Layout_Sprays.Info l) :=
	transform
		self.SourceIP := Tools.mod_IPAddresses.fGetIPAddressFromServerName(l.SourceIP);
		self.dDirectoryListing	:= FileServices.remotedirectory(self.SourceIP, l.SourceDirectory, l.directory_filter);
		self.remotefilescount	:= count(self.dDirectoryListing);
		self.ShouldSprayMultipleFilesAs1	:= pShouldSprayMultipleFilesAs1 = true or l.ShouldSprayMultipleFilesAs1 = true;
		self.remotefilessize	:= if(self.remotefilescount > 0 and self.ShouldSprayMultipleFilesAs1 = true
																,sum(self.dDirectoryListing,self.dDirectoryListing.size)
																,0
														);
		self.dDirectorySummation	:= if(self.ShouldSprayMultipleFilesAs1
																	,dataset([{l.directory_filter,self.remotefilessize,''}],lib_fileservices.FsFileNameRecord)
																	,dataset([],lib_fileservices.FsFileNameRecord)
																);
		self.dSuperfilenames := l.dSuperfilenames + if(count(l.dSuperfilenames) = 0, dataset([''], Tools.Layout_Names)
		, dataset([], Tools.Layout_Names));
		self := l;
	end;
	
	directory_listings := nothor(project(global(pSprayInformation,few), tGetDirs(left)));
	lblankfiles := dataset([{'', 0,''}],  lib_fileservices.FsFileNameRecord);
	////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- fSetLogicalFilenames function
	////////////////////////////////////////////////////////////////////////////////////////////////////
	fSetLogicalFilenames(
						 dataset(lib_fileservices.FsFileNameRecord) pRemotefilenames
						,string 																		pTemplatefilename
						,string 																		pDate
						,string1																		pFlag
						,unsigned4 																	pRemotefilesCount
						,unsigned8 																	pRemotefilesSize
						,boolean																		pShouldOverwrite
						,string																			pFile_type
						,unsigned4																	pRecord_Size
						,boolean																		pSprayZeroByteFiles		= false
						,boolean																		pSprayMultipleFilesAs1	= false
						) :=
	function
	
	
		lRemotefilenames := if(count(pRemotefilenames) = 0
													,lblankfiles
													,pRemotefilenames
												);
		
		Tools.Layout_Sprays.ChildNames tSetLogicalFilenames(lRemotefilenames l, unsigned4 pCounter) :=
		transform
			// first check to see if filedate is set
			// if not, then use regex if not blank
			// if not, use current date
			filenameversion := map(	
									 pFlag = 'F' and pDate != '' 														 => 	pDate
									,pFlag = 'R' and pDate != '' and regexfind(pDate,l.name) => 	regexfind(pDate,l.name, 0)
									,pFlag = 'R' and pDate != '' and pSprayMultipleFilesAs1  => 	pDate
									,pDate != '' 	                                           => 	pDate
									,																															workunit[2..9]
								);
			LogicalFilenameTemp := regexreplace( '@version@',pTemplatefilename,if(trim(filenameversion)[1..5] != '[0-9]'  ,filenameversion  ,workunit[2..9]));
			
			LogicalFilename		:= if(pRemotefilesCount = 1 or pAddCounter = false or pSprayMultipleFilesAs1 = true,  LogicalFilenameTemp, LogicalFilenameTemp + '_' + (string) pCounter);
									
			self.RemoteFilename			:= l.name;
			self.ThorLogicalFilename	:= LogicalFilename;
			self.fileexists							:= fileservices.FileExists(self.ThorLogicalFilename) 
																		or 	fileservices.SuperFileExists(self.ThorLogicalFilename);
			self.ismemberofsuperfiles		:= false;
			self.willspray							:= (
																						pOverwrite 
																				or	pShouldoverwrite 
																				or not(self.fileexists) 
																				or FileServices.GetFileDescription(self.ThorLogicalFilename) = workunit
																		 ) 
																		 and (l.size != 0 or pRemotefilesSize != 0 or pShouldSprayZeroByteFiles or pSprayZeroByteFiles) 
																		 and (
																								(pFile_type != 'FIXED' or (integer4)pRecord_Size = RECFMVB_RECSIZE) 
																						or	(
																											(			pFile_type 						= 'FIXED' 
																												and l.size % pRecord_Size = 0
																											)
																											or
																											(			pFile_type 											= 'FIXED' 
																												and pSprayMultipleFilesAs1					= true
																												and pRemotefilesSize % pRecord_Size = 0
																											)
																											
																								)
																				 );
      
			self.remotesize							:= l.size;
			self.record_length					:= if(pFile_type != 'FIXED',0, pRecord_Size); 
			self.issizemultipleofrecordlength	:= if(pFile_type != 'FIXED' or (integer4)pRecord_Size = RECFMVB_RECSIZE,true, l.size % pRecord_Size = 0 or (pSprayMultipleFilesAs1	= true and pRemotefilesSize % pRecord_Size = 0));
//			self.willaddtosuperfile			:= FileServices.FindSuperFileSubName(pSuperfilename, self.ThorLogicalFilename) = 0;
		end;
		
		doproject := project(lRemotefilenames, tSetLogicalFilenames(left,counter));
		
		return doproject;
		
	end;
	fSetSuperFilenames(dataset(Tools.Layout_Names) pSupers
						) :=
	function
		
		Tools.Layout_Sprays.ChildSuperNames tSetSuperFilenames(pSupers l) :=
		transform
			self.name := l.name;
			self.dSuperfilecontents := dataset([],lib_fileservices.FsLogicalFileNameRecord);
//			self.dSuperfilecontents := if(fileservices.superfileexists(l.name),
//																		fileservices.superfilecontents(l.name),dataset([],lib_fileservices.FsLogicalFileNameRecord));
		end;
		
		doproject := project(pSupers, tSetSuperFilenames(left));
		
		return doproject;
		
	end;
	////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- finalize dataset before spray
	////////////////////////////////////////////////////////////////////////////////////////////////////	
	Tools.Layout_Sprays.InfoOut tGetReadyToSpray(layout_directory_listings l, unsigned2 ptype) := 
	transform
		lDate := map(	 pFileVersion != '' =>  pFileVersion
                  ,l.FileDate		!= '' =>	l.Filedate
									,l.date_regex	!= '' =>	l.date_regex
									,												''
						);
		lFlag := map(	 l.FileDate		!= '' or pFileVersion != '' => 'F'
									,l.date_regex	!= '' => 'R'
									,''
						);
		lDateAs1 := map(	
									 lFlag = 'F' and lDate    != '' 																								=> 	lDate
									,lFlag = 'F' and pFileVersion != '' 																						=> 	pFileVersion
                  ,lFlag = 'R' and lDate != '' and regexfind(lDate,l.dDirectoryListing[1].name) 	=> 	regexfind(lDate,l.dDirectoryListing[1].name, 0)
									,																																										workunit[2..9]
								);
					
		self.dFilesToSpray				:= fSetLogicalFilenames(l.dDirectoryListing		, l.Thor_filename_template,  lDate		, lFlag, l.remotefilescount, l.remotefilessize,l.shouldoverwrite, l.file_type, l.record_size, l.ShouldSprayZeroByteFiles,l.ShouldSprayMultipleFilesAs1);
		self.dMultAs1FilesToSpray	:= fSetLogicalFilenames(l.dDirectorySummation	, l.Thor_filename_template,  lDateAs1	, lFlag, l.remotefilescount, l.remotefilessize,l.shouldoverwrite, l.file_type, l.record_size, l.ShouldSprayZeroByteFiles,l.ShouldSprayMultipleFilesAs1);
		
		self.dSuperfilenames 	:= if(ptype != 0
																, fSetSuperFilenames(l.dSuperfilenames)
																, fSetSuperFilenames(l.dSuperfilenames(name != ''))
														);
		self.superfilescount 	:= count(self.dSuperfilenames);
		self.spray_workunit		:= workunit;
		SELF 									:= l;
	END;
	
	dReadyToSprayout	:= nothor(project(global(directory_listings,few), tGetReadyToSpray(left, 0)));
	dReadyToSpray			:= nothor(project(global(directory_listings,few), tGetReadyToSpray(left, 1)));
	
	outputtoworkunit := nothor(output(dReadyToSprayout, all));
		
	outputwork := if(pSprayInfoLogicalfile != ''
									,sequential(
										if((  not(    fileservices.FileExists     (pSprayInfoLogicalfile) 
                              or  fileservices.SuperFileExists(pSprayInfoLogicalfile)
                             )
                          or pOverwrite
                       )
											and not pIsTesting
											,sequential(
												 if(fileservices.FileExists(pSprayInfoLogicalfile) ,nothor(Tools.fun_ClearfilesFromSupers(dataset([{pSprayInfoLogicalfile}], Tools.Layout_Names), false)))
												,output(dReadyToSprayout, ,pSprayInfoLogicalfile,overwrite)
												,if(pSprayInfoSuperfile != ''
													,sequential(
														 Tools.mod_Utilities.createsuper(pSprayInfoSuperfile)
														,fileservices.StartSuperFileTransaction()
														,fileservices.addsuperfile(pSprayInfoSuperfile, pSprayInfoLogicalfile)
														,fileservices.finishSuperFileTransaction()
													)
												)
											)
										,outputtoworkunit
										)
									)
									,outputtoworkunit
									);
	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Spray Files
	//////////////////////////////////////////////////////////////////////////////////////////////
	SprayFixedFiles(string pSourceIP
			,string pSourcePath
			,dataset(Tools.Layout_Sprays.childnames) pfilestospray
			,integer4 pRecordLength
			,string pfun_Groupname
			,boolean pCompress
	) :=
			apply(pfilestospray, 
				sequential(
				if(FileExists,
					Tools.fun_ClearfilesFromSupers(dataset([{ThorLogicalFilename}], Tools.Layout_Names), false)),
				//output('Spraying: ' + pSourcePath + '/' + RemoteFilename + ' -> ' + ThorLogicalFilename),
				FileServices.SprayFixed(
					 pSourceIP
					,pSourcePath + '/' + RemoteFilename
					,pRecordLength
					,pfun_Groupname
					,ThorLogicalFilename 
					,
					,
					,
					,willspray
					,pReplicate
					,pCompress
				)));
	
	AddSuperfile(dataset(Tools.Layout_Sprays.childnames) plogicalnames, string pSuperfilename) :=
			sequential(
			 Tools.mod_Utilities.createsuper(pSuperfilename)
			,apply(plogicalnames(willspray), 
						FileServices.SetFileDescription(ThorLogicalFilename, workunit))
			,fileservices.StartSuperFileTransaction()
			,if(pShouldClearSuperfileFirst, fileservices.clearsuperfile(pSuperfilename))
      ,fileservices.finishSuperFileTransaction()
			,apply(plogicalnames(willspray or fileexists), 
				sequential(
           fileservices.StartSuperFileTransaction()
					,fileservices.removesuperfile	(pSuperfilename, ThorLogicalFilename)
          ,fileservices.finishSuperFileTransaction()
          ,fileservices.StartSuperFileTransaction()
					,fileservices.addsuperfile		(pSuperfilename, ThorLogicalFilename)
          ,fileservices.finishSuperFileTransaction()
				)
			)
//			,fileservices.finishSuperFileTransaction()
				);
	AddToSuperfiles( dataset(Tools.Layout_Sprays.childnames)	plogicalnames
					,dataset(Tools.Layout_Sprays.childsupernames)				pSuperfilenames
	) :=
			apply(pSuperfilenames, if(name != '', AddSuperfile(plogicalnames, name)));
					
	SprayVariableFiles(	 string		pSourceIP
						,string		pSourcePath
						,integer4	pMaxRecordSize
						,varstring	pSourceCsvSeparate
						,varstring	pSourceCsvTerminate
						,varstring	pSourceCsvQuote
						,dataset(Tools.Layout_Sprays.childnames) pfilestospray
						,string		pfun_Groupname
						,boolean	pCompress
				) :=
					apply(pfilestospray, 
				sequential(
				if(FileExists,
					Tools.fun_ClearfilesFromSupers(dataset([{ThorLogicalFilename}], Tools.Layout_Names), false)),
					output('Spraying: ' + pSourcePath + '/' + RemoteFilename + ' -> ' + ThorLogicalFilename),
						Fileservices.SprayVariable(	 
									 pSourceIP
									,pSourcePath + '/' + RemoteFilename
									,pMaxRecordSize
									,pSourceCsvSeparate
									,pSourceCsvTerminate
									,pSourceCsvQuote
									,pfun_Groupname
									,ThorLogicalFilename
									,,,,willspray
									,pReplicate
									,pCompress
									)));
	SprayXMLFiles(	 string		pSourceIP
					,string		pSourcePath
					,integer4	pMaxRecordSize
					,varstring	psourceRowTag
					,dataset(Tools.Layout_Sprays.childnames) pfilestospray
					,string		pfun_Groupname
					,boolean	pCompress
				) :=
					apply(pfilestospray, 
				sequential(
				if(FileExists,
					Tools.fun_ClearfilesFromSupers(dataset([{ThorLogicalFilename}], Tools.Layout_Names), false)),
					output('Spraying: ' + pSourcePath + '/' + RemoteFilename + ' -> ' + ThorLogicalFilename),
							
						lib_fileservices.FileServices.SprayXml(	 
									 pSourceIP
									,pSourcePath + '/' + RemoteFilename
									,pMaxRecordSize
									,psourceRowTag
									,
									,pfun_Groupname
									,ThorLogicalFilename
									,,,,willspray
									,pReplicate
									,pCompress
									)));
									
	spray_files		:= APPLY(dReadyToSpray(remotefilescount > 0),
								sequential(
									map(file_type = 'FIXED' => 	SprayFixedFiles( SourceIP
																				,SourceDirectory
																				,if(ShouldSprayMultipleFilesAs1
																						,dMultAs1FilesToSpray	(willspray = true)
																						,dFilesToSpray				(willspray = true)
																				)
																				,record_size
																				,fun_Groupname
																				,compress),
										file_type = 'VARIABLE' => 	SprayVariableFiles(	SourceIP
																						,SourceDirectory
																						,sourceMaxRecordSize
																						,sourceCsvSeparate
																						,sourceCsvTerminate
																						,sourceCsvQuote
																						,if(ShouldSprayMultipleFilesAs1
																								,dMultAs1FilesToSpray	(willspray = true)
																								,dFilesToSpray				(willspray = true)
																						)
																						,fun_Groupname
																						,compress
																					),
										file_type = 'XML' => 	SprayXMLFiles(SourceIP
																				,SourceDirectory
																				,sourceMaxRecordSize
																				,sourceRowTagXML
																				,if(ShouldSprayMultipleFilesAs1
																						,dMultAs1FilesToSpray	(willspray = true)
																						,dFilesToSpray				(willspray = true)
																				)
																				,fun_Groupname
																				,compress
																			)
										//,output('Bad File type: ' + file_type + ' on record')
										),
										AddToSuperfiles(if(ShouldSprayMultipleFilesAs1
																						,dMultAs1FilesToSpray	
																						,dFilesToSpray				
																				), dSuperfilenames)));
	email_body			:= Tools.fun_SprayEmailBody(dReadyToSprayout) : global;
	numFilesSprayed	:= email_body[1].numFilesSprayed;
	numFilesSkipped	:= email_body[1].numFilesSkipped;
	
	email_subject_header:= pEmailSubjectDataset + ' Spray to ' + _Control.ThisEnvironment.Name + if(pIsTesting ,'(TESTING)','') + ': ';
	
	email_subject :=	if(numFilesSprayed > 0	
											,'Sprayed ' + numFilesSprayed + ' file' + 
												if(numFilesSprayed > 1, 's', '') +
												if(numFilesSkipped > 0, ', '	,'')
											,if(numFilesSkipped > 0
												,'No Files Sprayed'
												,'No Files Found') + if(numFilesSkipped > 0, ', '	,'')) +
											
										if(numFilesSkipped > 0	,'Skipped ' + numFilesSkipped + ' file' + if(numFilesSkipped > 1, 's', ''), '')
										;
											
	email_subject_sprayed :=	if(numFilesSprayed > 0	
											,'Sprayed ' + numFilesSprayed + ' file' + 
												if(numFilesSprayed > 1, 's', '')
											,'No Files Sprayed'
										);
	email_subject_skipped :=	if( numFilesSkipped > 0 and numFilesSprayed = 0	,'No Files Sprayed, '
																,if(numFilesSkipped = 0 and numFilesSprayed = 0	,'No Files Found','')
												) +
												if(numFilesSkipped > 0	,'Skipped ' + numFilesSkipped + ' file' + if(numFilesSkipped > 1, 's', ''), '')
										;
													
	return_code := if(pIsTesting = false,
				sequential(
					 outputwork
					,nothor(spray_files)
				),
				sequential(
					 outputwork
				)) ;
	return return_code;
end;
