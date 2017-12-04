import Versioncontrol, _Control, fbn_new,lib_thorlib , ut, std, tools;

pDate 			:= (string8)std.date.today():INDEPENDENT;
file_types 	:= ['bridger','riskwise','banko_batch','banko','batch','custom','InquiryTracking','delta_shell','deconfliction','transaction','accounting_log','accurint'];

rFileDef := record
	string 	LogicalFile;	
	string5 Separate;
	DATASET(FsLogicalFileNameRecord) SuperFiles;
end;

GetFileDetails(string pFileType, string pPrefix) := function
	rgxName 	:= '[0-9-]{4,}';
	pVersion 	:= stringlib.stringfilterout(regexfind(rgxName, pFileType, 0), '-');
	version 	:= if(pVersion = '', pDate, pVersion);
	
	LogicalFile := map(
									regexfind(file_types[1],pFileType) 	=> pPrefix + '::in::'+version+'::bridger_acclog',
									regexfind(file_types[2],pFileType)	=> pPrefix + '::in::'+version+'::riskwise_acclog',
									regexfind(file_types[3],pFileType) 	=> pPrefix + '::in::'+version+'::banko_batch_acclog',
									regexfind(file_types[4],pFileType) 	=> pPrefix + '::in::'+version+'::banko_acclog',
									regexfind(file_types[5],pFileType) 	=> pPrefix + '::in::'+version+'::batch_acclog',
									regexfind(file_types[6],pFileType) 	=> pPrefix + '::in::'+version+'::custom_acclog',
									regexfind(file_types[7],pFileType) 	=> pPrefix + '::in::'+version+'::idm_bls_acclog',									
									regexfind(file_types[8],pFileType) 	=> pPrefix + '::in::'+version+'::sba_acclogs',
									regexfind(file_types[9],pFileType)  => pPrefix + '::in::mbs::'+version+'::deconfliction',
									regexfind(file_types[10],pFileType) => pPrefix + '::in::mbs::'+version+'::transaction_desc',
									regexfind(file_types[11],pFileType) => pPrefix + '::in::'+version+'::accurint_acclogs',
									regexfind(file_types[12],pFileType) => pPrefix + '::in::'+version+'::accurint_acclog',
									'');
	
	Superfile := map(
									regexfind(file_types[1],pFileType) 	=> pPrefix + '::in::bridger_acclogs_preprocess',
									regexfind(file_types[2],pFileType) 	=> pPrefix + '::in::riskwise_acclogs_preprocess',
									regexfind(file_types[3],pFileType) 	=> pPrefix + '::in::banko_batch_acclogs_preprocess',
									regexfind(file_types[4],pFileType) 	=> pPrefix + '::in::banko_acclogs_preprocess',									
									regexfind(file_types[5],pFileType) 	=> pPrefix + '::in::batch_acclogs_preprocess',
									regexfind(file_types[6],pFileType) 	=> pPrefix + '::in::custom_acclogs_preprocess',
									regexfind(file_types[7],pFileType) 	=> pPrefix + '::in::idm_bls_acclogs_preprocess',
									regexfind(file_types[8],pFileType) 	=> pPrefix + '::in::sba_acclogs_preprocess', 
									regexfind(file_types[9],pFileType)  => pPrefix + '::in::mbs::deconfliction',
									regexfind(file_types[10],pFileType) => pPrefix + '::in::transaction_desc',									
									regexfind(file_types[11],pFileType) => pPrefix + '::in::accurint_acclogs_preprocess',
									regexfind(file_types[12],pFileType) => pPrefix + '::in::accurint_acclogs_preprocess',
									'');
	Separate := map(
									regexfind(file_types[1],pFileType) 	=> '\t',
									regexfind(file_types[2],pFileType) 	=> '~~',
									regexfind(file_types[3],pFileType) 	=> '|',
									regexfind(file_types[4],pFileType) 	=> '~~',									
									regexfind(file_types[5],pFileType) 	=> '|',
									regexfind(file_types[6],pFileType) 	=> '~~',
									regexfind(file_types[7],pFileType) 	=> ',',
									regexfind(file_types[8],pFileType) 	=> '~~',
									regexfind(file_types[9],pFileType)  => '~~',
									regexfind(file_types[10],pFileType) => '~~',
									regexfind(file_types[11],pFileType) => '~~',
									regexfind(file_types[12],pFileType) => '~~',
									'');
	
	sf_accurint_cc 	:= pPrefix + '::in::accurint_acclogs_cc';
	sf_accurint_sl 	:= pPrefix + '::in::accurint_acclogs_sl';
	sf_accurint_fdn	:= '~thor_data400::in::fdn::sprayed::glb5';	
	sf_riskwise_sl 	:= pPrefix + '::in::riskwise_acclogs_sl';
	sf_custom_sl 		:= pPrefix + '::in::custom_acclogs_sl';
													
	SuperFiles := if(regexfind(file_types[12],pFileType)
									,dataset([{sf_accurint_cc}, {sf_accurint_sl}, {sf_accurint_fdn}], FsLogicalFileNameRecord)
									,if(regexfind(file_types[2],pFileType)
										,dataset([{sf_riskwise_sl}], FsLogicalFileNameRecord)
										,if(regexfind(file_types[6],pFileType)
											,dataset([{sf_custom_sl}], FsLogicalFileNameRecord)
											)
										)
									)
									+
									dataset([{Superfile}], FsLogicalFileNameRecord);
										
	ds := dataset([{LogicalFile, Separate, SuperFiles}], rFileDef);
	return ds;	
end;

export fSprayInputFiles(dataset({FsFilenameRecord}) filelist, boolean fcra = false) := function
	
	pServerIP		:= _control.IPAddress.bctlpedata10;
	pGroupName	:= if(fcra, 'thor20_52', 'thor120_50_a'); //ThorLib.Group();
	pPrefix			:= if(fcra, '~thor10_231', '~thor100_21');
	directory 	:= '/data/inquiry_data_01/spraying';	
	
	tools.Layout_Sprays.Info xForm(filelist L) := transform
			self:=row(
								{	 
								 pServerIP												
								,directory                             
								,L.name                                          
								,0  
								,GetFileDetails(L.name, pPrefix)[1].LogicalFile
								,GetFileDetails(L.name, pPrefix)[1].Superfiles//[{GetFileDetails(L.name, pPrefix)[1].Superfile}]
								,pGroupName                                                
								,''                                                    
								,''                                                            
								,'VARIABLE'                                                         
								,''
								,''
								,GetFileDetails(L.name, pPrefix)[1].Separate
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