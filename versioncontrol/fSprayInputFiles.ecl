import ut, lib_fileservices, _control;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- fSprayInputFiles() function:
// -- 	Generic spray function used to spray multiple input files according to the fields in the passed dataset
// --	It also adds them to the appropriate superfile(s).  The files may be fixed, xml, or variable.
// -- 	Parameters:
// --		Dataset(Layout_Sprays.Info)	pSprayInformation		-- 
// -- 		string						pSprayRecordSuperfile	-- 
// -- 		boolean						pIsTesting				-- Testing flag, ex. true = no spray, just output dataset.
// --		
// --		The dataset parameter pSprayInformation consists of the following fields:
// --		string						SourceIP				-- Remote Server's IP address
// --		string						SourceDirectory			-- Absolute path of directory on Remote Server where files are located
// --		string						directory_filter		-- Regular expression filter for files to be sprayed, default = '*'
// --		unsigned4					record_size				-- record length of files to be sprayed(for fixed length files only)
// --		string						Thor_filename_template	-- template filename for files to be sprayed, ex. '~thor_data400::in::corp2::@version@::cont'
// --		dataset(Layout_Names)		dSuperfilenames			-- dataset of superfiles to add the sprayed files to.
// --		string						GroupName				-- Thor Group name, ex. 'thor_data400' = dataland400, 'thor_dell400' = prod400(default)
// --		string						FileDate				-- version of all of the sprayed files(overrides the next field, dateregex). Default = ''
// --		string						date_regex				-- regular expression to get the date from the remote filenames.  Default = '[0-9]{8}'
// --		string						file_type				-- Type of file format.  Possible types are 'FIXED', 'VARIABLE', OR 'XML'.  Default = 'FIXED'
// --		string						sourceRowTagXML			-- XML Row tag.  Only used when file_type = 'XML'.  Default = ''
// --		integer4 					sourceMaxRecordSize		-- Maximum record size for Variable or XML files.  Default = 8192;
// --		string 						sourceCsvSeparate		-- Field separator for variable length records only. Default = '\\,' (comma)
// -- 	string						sourceCsvTerminate		-- Record separator for variable length records only.  Default = '\\n,\\r\\n'  (line feed or carriage return, line feed)
// --		string						sourceCsvQuote			-- Quoted Field delimiter for variable length records only.  Default = '"';	 (quote)
// --		boolean						compress				-- true = Compress, false = Don't compress.  Default = true.
// --
// -- Please run on hthor for maximum speed
// -- 
// -- Example spray using this function(to dataland400):
// --	FilesToSpray := DATASET([
// --
// --	 	{'192.168.0.39'
// --	 	,'/thor_back5/temp/'
// --	 	,'corporate_direct_*_event.d00'
// --	 	,sizeof(Corp.Layout_Corporate_Direct_Event_In)
// --	 	,'~thor_data400::temp::lbentley::corp::@version@::event::OK'
// --	 	,[{'~thor_data400::temp::lbentley::corp::using::event::OK'}]
// --	 	,'thor_data400'
// --	 	},
// --	 
// --	 	{'192.168.0.39'												
// --	 	,'/thor_back5/bbb/build/20060626/'                             
// --	 	,'nonmember*.xml.out'                                          
// --	 	,0                                                             
// --	 	,'~thor_data400::temp::lbentley::bbb::@version@::nonmember'    
// --	 	,[{'~thor_data400::temp::lbentley::bbb::using::nonmember'}]    
// --	 	,'thor_data400'                                                
// --	 	,'20060626'                                                    
// --	 	,''                                                            
// --	 	,'XML'                                                         
// --	 	,'listing'                                                     
// --	 	},
// --	 	
// --		{
// --	 	 '192.168.0.39'												
// --	 	,'/export/home/lbentley/'                             
// --	 	,'D3765.F001.BOCA.csv'                                          
// --	 	,0                                                             
// --	 	,'~thor_data400::temp::lbentley::wither::@version@::update'    
// --	 	,[{'~thor_data400::temp::lbentley::wither::sprayed::update'}]    
// --	 	,'thor_data400'                                                
// --	 	,'20050314'                                                    
// --	 	,''                                                            
// --	 	,'VARIABLE'                                                         
// --	 	}	                                                            
// --	 		                                                            
// --
// --	], VersionControl.Layout_Sprays.Info);
// --
// -- 	VersionControl.fSprayInputFiles(FilesToSpray);
// --
// --	This sprays some fixed length files,  xml , and csv files in the same call
// -- 
// -- Future improvements/comments:
// -- 	Looks like if you want to use the default value of a field, but have to specify fields after that one, you will have 
// --		to put the default value in that field(i.e. when you are spraying xml or csv files you put zero in the record_size field even though
// --		zero is the default).  I'm not sure why this is, but it will give you an error if you don't do it.  It will accept the 
// --		default values if you don't have to specify any fields after the defaults.
// --	have it create a string or file with records of strings that describes exactly what it did(spray, add to superfile, etc)
// --	so you have a log of what it did, and what it didn't do.
// --	Also, would be nice to have another optional regex so you could call it once, and use it for multiple
// -- states(or any other distinguishing information and dates.
// -- need to fix the bug of when there are no files to spray, say that in the email
// -- also maybe try to name the output dataset uniquely--there is a way to do this
//////////////////////////////////////////////////////////////////////////////////////////////
#option('maxLength', 131072); // have to increase for the remote directory child datasets

export fSprayInputFiles(	 
							 Dataset(Layout_Sprays.Info)	pSprayInformation
							,string												pSprayInfoSuperfile			= ''
							,string												pSprayInfoLogicalfile		= ''
							,boolean											pOverwrite							= false
							,boolean											pReplicate							= true
							,boolean											pAddCounter							= true
							,boolean											pIsTesting							= false
							,string												pEmailNotificationList	= _control.MyInfo.EmailAddressNotify
							,string												pEmailSubjectDataset		= ''			// such as 'Corp' or 'UCCS', etc
						) :=
function

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- Get directory listings using the passed filter for all records in passed dataset
	////////////////////////////////////////////////////////////////////////////////////////////////////
	layout_directory_listings :=
	record, maxlength(100000)
		pSprayInformation;
		DATASET(lib_fileservices.FsFileNameRecord)	dDirectoryListing;
		unsigned4	remotefilescount;
	end;
	
	layout_directory_listings tGetDirs(Layout_Sprays.Info l) :=
	transform
		self.SourceIP := IPAddresses.fGetIPAddressFromServerName(l.SourceIP);
		self.dDirectoryListing	:= FileServices.remotedirectory(self.SourceIP, l.SourceDirectory, l.directory_filter);
		self.remotefilescount	:= count(self.dDirectoryListing);
		self := l;
	end;
	
	directory_listings := project(pSprayInformation, tGetDirs(left));

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- fSetLogicalFilenames function
	////////////////////////////////////////////////////////////////////////////////////////////////////
	fSetLogicalFilenames(
						 dataset(lib_fileservices.FsFileNameRecord) pRemotefilenames
						,string 																		pTemplatefilename
						,string 																		pDate
						,string1																		pFlag
						,unsigned4 																	pRemotefilesCount
						,boolean																		pShouldOverwrite
						,string																			pFile_type
						,unsigned4																	pRecord_Size
						) :=
	function
		
		Layout_Sprays.ChildNames tSetLogicalFilenames(pRemotefilenames l, unsigned4 pCounter) :=
		transform
			// first check to see if filedate is set
			// if not, then use regex if not blank
			// if not, use current date
			filenameversion := map(	pFlag = 'F' and pDate != '' 							=> 	pDate,
									pFlag = 'R' and pDate != '' and regexfind(pDate,l.name) => 	regexfind(pDate,l.name, 0),
																								workunit[2..9]
								);
			LogicalFilenameTemp := regexreplace( '@version@'
											,pTemplatefilename
											,filenameversion
											);
			LogicalFilename		:= if(pRemotefilesCount = 1 or pAddCounter = false,  LogicalFilenameTemp, LogicalFilenameTemp + '_' + (string) pCounter);
									
			self.RemoteFilename			:= l.name;
			self.ThorLogicalFilename	:= LogicalFilename;
			self.fileexists							:= fileservices.FileExists(self.ThorLogicalFilename) 
																		or 	fileservices.SuperFileExists(self.ThorLogicalFilename);
			self.ismemberofsuperfiles		:= fileservices.FileExists(self.ThorLogicalFilename) and 
																			 count(fileservices.LogicalFileSuperOwners(self.ThorLogicalFilename)) > 0;
			self.willspray							:= (pOverwrite or pShouldoverwrite or not(self.fileexists) or FileServices.GetFileDescription(self.ThorLogicalFilename) = workunit) and l.size != 0 and ((pFile_type != 'FIXED') or
																																																 (pFile_type = 'FIXED' and l.size % pRecord_Size = 0));



			self.remotesize							:= l.size;
			self.record_length					:= if(pFile_type != 'FIXED',0, pRecord_Size); 
			self.issizemultipleofrecordlength	:= if(pFile_type != 'FIXED',true, l.size % pRecord_Size = 0);

//			self.willaddtosuperfile			:= FileServices.FindSuperFileSubName(pSuperfilename, self.ThorLogicalFilename) = 0;
			     
		end;
		
		doproject := project(pRemotefilenames, tSetLogicalFilenames(left,counter));
		
		return doproject;
		
	end;

	fSetSuperFilenames(dataset(Layout_Names) pSupers
						) :=
	function
		
		Layout_Sprays.ChildSuperNames tSetSuperFilenames(pSupers l) :=
		transform
			self.name := l.name;
			self.dSuperfilecontents := if(fileservices.superfileexists(l.name),
																		fileservices.superfilecontents(l.name),dataset([],lib_fileservices.FsLogicalFileNameRecord));
		end;
		
		doproject := project(pSupers, tSetSuperFilenames(left));
		
		return doproject;
		
	end;

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// -- finalize dataset before spray
	////////////////////////////////////////////////////////////////////////////////////////////////////	
	Layout_Sprays.InfoOut tGetReadyToSpray(layout_directory_listings l) := 
	transform
		lDate := map(	l.FileDate		!= '' => l.Filedate,
						l.date_regex	!= '' => l.date_regex,
						'');
		lFlag := map(	l.FileDate		!= '' => 'F',
						l.date_regex	!= '' => 'R',
						'');
					
		self.dFilesToSpray	:= fSetLogicalFilenames(l.dDirectoryListing, l.Thor_filename_template,  lDate, lFlag, l.remotefilescount, l.shouldoverwrite, l.file_type, l.record_size);
		self.dSuperfilenames := fSetSuperFilenames(l.dSuperfilenames);
		self.superfilescount := count(self.dSuperfilenames);
		SELF 				:= l;
	END;

	dReadyToSpray	:= project(directory_listings, tGetReadyToSpray(left));
	
	outputwork := if(pSprayInfoLogicalfile != ''
									,sequential(
										if(not(fileservices.FileExists(pSprayInfoLogicalfile) 
												or fileservices.SuperFileExists(pSprayInfoLogicalfile))
											,sequential(
												 output(dReadyToSpray, ,pSprayInfoLogicalfile,overwrite)
												,if(pSprayInfoSuperfile != ''
													,sequential(
														 mUtilities.createsuper(pSprayInfoSuperfile)
														,fileservices.StartSuperFileTransaction()
														,fileservices.addsuperfile(pSprayInfoSuperfile, pSprayInfoLogicalfile)
														,fileservices.finishSuperFileTransaction()
													)
												)
											)
										,nothor(output(dReadyToSpray))
										)
									)
									,nothor(output(dReadyToSpray))
									);



	//////////////////////////////////////////////////////////////////////////////////////////////
	// -- Spray Files
	//////////////////////////////////////////////////////////////////////////////////////////////

	SprayFixedFiles(string pSourceIP
			,string pSourcePath
			,dataset(versioncontrol.Layout_Sprays.childnames) pfilestospray
			,integer4 pRecordLength
			,string pGroupName
			,boolean pCompress
	) :=
			apply(pfilestospray, 
				sequential(
				if(FileExists,
					VersionControl.fClearLogicalFileSupers(dataset([{ThorLogicalFilename}], Layout_Names), false)),
				output('Spraying: ' + pSourcePath + '/' + RemoteFilename + ' -> ' + ThorLogicalFilename),
				FileServices.SprayFixed(
					 pSourceIP
					,pSourcePath + '/' + RemoteFilename
					,pRecordLength
					,pGroupName
					,ThorLogicalFilename 
					,
					,
					,
					,willspray
					,pReplicate
					,pCompress
				)));
	
	AddSuperfile(dataset(Layout_Sprays.childnames) plogicalnames, string pSuperfilename) :=
			sequential(
			 mUtilities.createsuper(pSuperfilename)
			,apply(plogicalnames(willspray), 
						FileServices.SetFileDescription(ThorLogicalFilename, workunit))
			,fileservices.StartSuperFileTransaction()
			,apply(plogicalnames, 
						fileservices.addsuperfile(pSuperfilename, ThorLogicalFilename))
			,fileservices.finishSuperFileTransaction()
				);

	AddToSuperfiles( dataset(Layout_Sprays.childnames)	plogicalnames
					,dataset(Layout_Sprays.childsupernames)				pSuperfilenames
	) :=
			apply(pSuperfilenames, AddSuperfile(plogicalnames, name));
					

	SprayVariableFiles(	 string		pSourceIP
						,string		pSourcePath
						,integer4	pMaxRecordSize
						,varstring	pSourceCsvSeparate
						,varstring	pSourceCsvTerminate
						,varstring	pSourceCsvQuote
						,dataset(versioncontrol.Layout_Sprays.childnames) pfilestospray
						,string		pGroupName
						,boolean	pCompress
				) :=
					apply(pfilestospray, 
				sequential(
				if(FileExists,
					VersionControl.fClearLogicalFileSupers(dataset([{ThorLogicalFilename}], Layout_Names), false)),
					output('Spraying: ' + pSourcePath + '/' + RemoteFilename + ' -> ' + ThorLogicalFilename),

						Fileservices.SprayVariable(	 
									 pSourceIP
									,pSourcePath + '/' + RemoteFilename
									,pMaxRecordSize
									,pSourceCsvSeparate
									,pSourceCsvTerminate
									,pSourceCsvQuote
									,pGroupName
									,ThorLogicalFilename
									,,,,willspray
									,pReplicate
									,pCompress
									)));

	SprayXMLFiles(	 string		pSourceIP
					,string		pSourcePath
					,integer4	pMaxRecordSize
					,varstring	psourceRowTag
					,dataset(versioncontrol.Layout_Sprays.childnames) pfilestospray
					,string		pGroupName
					,boolean	pCompress
				) :=
					apply(pfilestospray, 

				sequential(
				if(FileExists,
					VersionControl.fClearLogicalFileSupers(dataset([{ThorLogicalFilename}], Layout_Names), false)),
					output('Spraying: ' + pSourcePath + '/' + RemoteFilename + ' -> ' + ThorLogicalFilename),
							
						lib_fileservices.FileServices.SprayXml(	 
									 pSourceIP
									,pSourcePath + '/' + RemoteFilename
									,pMaxRecordSize
									,psourceRowTag
									,
									,pGroupName
									,ThorLogicalFilename
									,,,,willspray
									,pReplicate
									,pCompress
									)));
									

	spray_files		:= APPLY(dReadyToSpray(remotefilescount > 0),
								sequential(
									map(file_type = 'FIXED' => 	SprayFixedFiles( SourceIP
																				,SourceDirectory
																				,dFilesToSpray(willspray = true)
																				,record_size
																				,GroupName
																				,compress),
										file_type = 'VARIABLE' => 	SprayVariableFiles(	SourceIP
																						,SourceDirectory
																						,sourceMaxRecordSize
																						,sourceCsvSeparate
																						,sourceCsvTerminate
																						,sourceCsvQuote
																						,dFilesToSpray(willspray = true)
																						,GroupName
																						,compress
																					),
										file_type = 'XML' => 	SprayXMLFiles(SourceIP
																				,SourceDirectory
																				,sourceMaxRecordSize
																				,sourceRowTagXML
																				,dFilesToSpray(willspray = true)
																				,GroupName
																				,compress
																			),
										output('Bad File type: ' + file_type + ' on record')),
										AddToSuperfiles(dFilesToSpray, dSuperfilenames)));

	email_body			:= fPrepareSprayEmailBody(dReadyToSpray) : global;

	numFilesSprayed	:= email_body.numFilesSprayed;
	numFilesSkipped	:= email_body.numFilesSkipped;
	
	email_subject_header:= pEmailSubjectDataset + ' Spray to ' + _Control.ThisEnvironment.Name + ': ';
	
	email_subject :=	if(numFilesSprayed > 0	
											,'Sprayed ' + numFilesSprayed + ' file' + 
												if(numFilesSprayed > 1, 's', '') +
												if(numFilesSkipped > 0, ', '	,'')
											,if(numFilesSkipped > 0
												,'No Files Sprayed'
												,'No Files Found') + if(numFilesSkipped > 0, ', '	,'')) +
											
										if(numFilesSkipped > 0	,'Skipped ' + numFilesSkipped + ' file' + if(numFilesSkipped > 1, 's', ''), '')
										;
											
	
	send_email := if(pEmailNotificationList != '', fileservices.sendemail(	 pEmailNotificationList
									,email_subject_header + email_subject
									,email_body.emailine));
	
	fail_email := if(pEmailNotificationList != '', fileservices.sendemail(
									 pEmailNotificationList
									,email_subject_header + ' Failed'
									,workunit + '\n' + failmessage));
			
													
	return_code := if(pIsTesting = false,
				sequential(
					 outputwork
					,nothor(spray_files)
					,send_email
				),
				sequential(
					 outputwork
					,send_email
				)) : failure(fail_email);
//				)) : success(send_email), failure(fail_email);

	return return_code;

end;