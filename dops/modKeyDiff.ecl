// Module: modKeyDiff
// Purpose: Functions, variables, record sets to run keydiff
// Parameters: ESP (thor esp, MUST be local esp)

import _Control, DOPS, STD, WsWorkunits;
export modKeyDiff(string p_esp = 'prod_esp.br.seisint.com'
									,string p_location = dops.constants.location
									,string p_environment = '' // H, HC, HU, N, F, ..
									) := module
	
	export lFileScope := trim(dops.constants.vFileScope(p_location,p_environment));
	export vKeyDiffFileListPrefix := '~'+lFileScope+'::dops::keydiff::';
	export vKeyPatchFileListPrefix := '~'+lFileScope+'::dops::keypatch::';
	
	// Record Structure: rListToProcess
	// Purpose: record structure to hold all information needed for keydiff, keypatch
	// Used in: fGetFileStatus, fRunKDiff
	export rListToProcess := record
		string attributename;
		string superfile;
		string newlogicalfile;
		string previouslogicalfile;
		
	end;
	
	export rList := record
			rListToProcess;
			string originalsuper := '';
			string keydifffile := '';
			string keypatchfile := '';
			boolean iskeydiffexist := false;
			boolean iskeypatchexist := false;
			boolean iskeydiff := false;
			boolean iskeypatch := false;
			boolean newfile := false;
			boolean previousfile := false;
			boolean previousfileinsuper := true;
			dataset(STD.File.FsLogicalFileNameRecord) dSuperFileList;
		end;
	// Action: aCreateSupers
	// Purpose: create keydiff super, father, grandfather
	// Used in: fSuperFileTransaction
	export aCreateSupers(string superfile) := sequential
														(
															if (~STD.File.SuperFileExists(superfile+'_keydiff')
																,STD.File.CreateSuperFile(superfile+'_keydiff'))
															,if (~STD.File.SuperFileExists(superfile+'_keydiff_father')
																,STD.File.CreateSuperFile(superfile+'_keydiff_father'))
															,if (~STD.File.SuperFileExists(superfile+'_keydiff_gfather')
																,STD.File.CreateSuperFile(superfile+'_keydiff_gfather'))
															,if (~STD.File.SuperFileExists(superfile+'_keydiff_delete')
																,STD.File.CreateSuperFile(superfile+'_keydiff_delete'))
														);
	
	// Dataset: dLayoutMismatch
	// Purpose: dataset to hold layout details for a file
	// Used in: fGetFileStatus
	export dLayoutMismatch(string p_FileName) := 
																	dops.FileInfo(p_FileName
																				,p_esp).LayoutDetails();

	EXPORT fGetFileStatus(dataset(rListToProcess) dListToProcess) := function
	
		rListToProcess xListToProcess(dListToProcess l) := transform
			self.superfile := if (regexfind('~',l.superfile),l.superfile,'~'+l.superfile);
			self.newlogicalfile := if (regexfind('~',l.newlogicalfile),l.newlogicalfile,'~'+l.newlogicalfile);
			self.previouslogicalfile := if (regexfind('~',l.previouslogicalfile),l.previouslogicalfile,'~'+l.previouslogicalfile);
			self := l;
		end;
		
		dCheckforTild := project(dListToProcess,xListToProcess(left));
		
		rlist xGetFileStatus(dCheckforTild l) := transform
			isFileExists := STD.File.FileExists(l.newlogicalfile + '_keydiff');
			patchFilename := if (STD.File.FileExists(l.newlogicalfile)
																	,l.newlogicalfile + '_keypatch'
																	,l.newlogicalfile
																	);
			isKdiff := if (~isFileExists
																and (STD.File.FileExists(l.newlogicalfile)
																		and STD.File.FileExists(l.previouslogicalfile))
															,true
															,false);
			isPatchFileExists := STD.File.FileExists(patchFilename);
			isKPatch := if (~isPatchFileExists // patch file doesn't exist
														and isFileExists // keydiff file exists
														and STD.File.FileExists(l.previouslogicalfile) // previous file exists
													,true
													,false
											);
			self.originalsuper := l.superfile + '_forkeydiff';
			self.keydifffile := l.newlogicalfile + '_keydiff';
			self.keypatchfile := patchFilename;
			self.iskeydiff := isKdiff;
			self.iskeydiffexist := isFileExists;
			self.iskeypatch := isKPatch;
			self.iskeypatchexist := isPatchFileExists;
			self.newfile := STD.File.FileExists(l.newlogicalfile);
			self.previousfile := STD.File.FileExists(l.previouslogicalfile);
			self.dSuperFileList := if(STD.File.FileExists(l.previouslogicalfile)
																,STD.File.LogicalFileSuperOwners(l.previouslogicalfile)
																,dataset([],STD.File.FsLogicalFileNameRecord));
																	
			self := l;
		end;
		
		dGetFileStatus := nothor(project(global(dCheckforTild,few),xGetFileStatus(left)));
		
		rlist xIsKeyDiff(dGetFileStatus l) := transform
			self.iskeydiff := if (
															dLayoutMismatch(l.newlogicalfile)[1].fulllayout <> ''
															and dLayoutMismatch(l.newlogicalfile)[1].fulllayout <> 
																		dLayoutMismatch(l.previouslogicalfile)[1].fulllayout
																	,false
																	,l.iskeydiff
													);
			/*self.previousfileinsuper := if (l.previousfile 
																			// any superfile besides forkeydiff superfile
																		,if(count(l.dSuperFileList(~regexfind('forkeydiff',name))) > 0
																				,true
																				,false)
																		,false
																		);*/
			self := l;
									
		end;
		
		disKeyDiff := project(dGetFileStatus,xIsKeyDiff(left));
		
		return disKeyDiff;
		
	end;
	
	export fRemoveLogicalFromSuper(string p_file) := function
		return nothor(apply(STD.File.LogicalFileSuperOwners(p_file)
												,STD.File.RemoveSuperFile('~'+name,p_file)
											));
	end;
	
	export fSuperFileTransaction(string superfile
																,string p_newfile
																,string filetype) := function
		return if (STD.File.FileExists(p_newfile)
						,if (count(STD.File.LogicalFileSuperOwners(p_newfile)) = 0
								,sequential
								(
									aCreateSupers(superfile)
									,STD.File.PromoteSuperFileList([superfile+'_' + filetype
																								,superfile+'_' + filetype +'_father'
																								,superfile+'_' + filetype +'_gfather'
																								,superfile+'_' + filetype +'_delete'],p_newfile)
									,STD.File.RemoveOwnedSubFiles(superfile+'_' + filetype +'_delete',true)
								)
							,output(p_newfile + ' exists in super')
							)
						,output(p_newfile + ' doesnt exist')
					);
	end;
	
	export fHoldPreviousLogical(dataset(rListToProcess) dListToProcess) := function
		dStatus := fGetFileStatus(dListToProcess);
		return sequential
							(output(choosen(dStatus,1000))
									,nothor(apply(global(dStatus(iskeydiff),few)
														,sequential
															(
																IF (~STD.File.SuperFileExists(originalsuper)
																	,STD.File.CreateSuperFile(originalsuper))
																,IF (STD.File.FindSuperFileSubName(originalsuper,previouslogicalfile) = 0
																	,STD.File.AddSuperFile(originalsuper,previouslogicalfile)
																		
																	)
															)
														)
													)
											
									);
	end;
	
	export fKeyDiff(string iKeyAttribute
									,string superfile
									,string newlogicalfile
									,string previouslogicalfile
									,string keydifffile
									,string p_targetcluster = STD.System.Job.Target()) := function
		return output(WsWorkunits.soapcall_WUWaitComplete
																(WsWorkunits.Create_Wuid_Raw
																		(
																		'#workunit(\'name\',\'[KEYDIFF]: '+ superfile +'\');\r\n'
																		+ '#workunit(\'priority\',\'high\');\r\n'
																		+ 'KEYDIFF\r\n'
																				+'(\r\n'
																				+	'index('+iKeyAttribute+',\''+previouslogicalfile+'\')\r\n'
																				+	',index('+iKeyAttribute+',\''+newlogicalfile+'\')\r\n'
																				+	',\''+keydifffile+'\'\r\n'
																				+',overwrite)'
																			,p_targetcluster
																			,p_esp
																			,'8010'
																			)
																		,pReturnOnWait := true
																		,pesp := p_esp
																	));
	end;
	
	export fKeyPatch(string iKeyAttribute
									,string superfile
									,string previouslogicalfile
									,string keydifffile
									,string patchedfile
									,string p_targetcluster = STD.System.Job.Target()) := function
		return output(WsWorkunits.soapcall_WUWaitComplete
																(WsWorkunits.Create_Wuid_Raw
																		(
																		'#workunit(\'name\',\'[KEYPATCH]: '+ superfile +'\');\r\n'
																		+ '#workunit(\'priority\',\'high\');\r\n'
																		+ 'KEYPATCH\r\n'
																				+'(\r\n'
																				+	'index('+iKeyAttribute+',\''+previouslogicalfile+'\')\r\n'
																				+	',\''+keydifffile+'\'\r\n'
																				+	',\''+patchedfile+'\'\r\n'
																				+',overwrite)'
																			,p_targetcluster
																			,p_esp
																			,'8010'
																			)
																		,pReturnOnWait := true
																		,pesp := p_esp
																	));
	end;
	
	export fRunKDiff(dataset(rListToProcess) dListToProcess
														,boolean holdpreviousforkeydiff = true
														,string p_targetcluster = STD.System.Job.Target()) := function
		dStatus := fGetFileStatus(dListToProcess) : independent;
		
		return if (~regexfind('hthor', p_targetcluster)
						,sequential
								(
									// add to super to hold the previous key so it is not deleted
									fHoldPreviousLogical(dListToProcess)
									,apply(dStatus(iskeydiff)
										,fKeyDiff(attributename
															,superfile
															,newlogicalfile
															,previouslogicalfile
															,keydifffile
															,p_targetcluster
														)
											)
									,nothor(apply(global(dStatus,few)
											,sequential
													(
														if(STD.File.FileExists(keydifffile)
															,STD.File.SetFileDescription(keydifffile,previouslogicalfile+'|'+newlogicalfile))
														,fSuperFileTransaction(superfile,keydifffile,'keydiff')
														,IF (holdpreviousforkeydiff
																,IF (STD.File.SuperFileExists(originalsuper)
																				,	sequential 
																						(					
																								STD.File.RemoveOwnedSubFiles(originalsuper,true) // attempting to delete file
																								,STD.File.ClearSuperFile(originalsuper)
																							)
																			)
																		
																)
													)
												)
										)
								)
							,fail('**** RUN ON *THOR (NOT HTHOR)* CLUSTER *****')
						);
	end;
	
	export fRunKPatch(dataset(rListToProcess) dListToProcess
											,boolean holdpatchedinsuper = true
											,string p_targetcluster = STD.System.Job.Target()) := function
		dStatus := fGetFileStatus(dListToProcess) : independent;
		
		return if (~regexfind('hthor', p_targetcluster)
						,sequential
								(
									output(choosen(dStatus,1000))
									,apply(dStatus(iskeypatch)
										,fKeyPatch(attributename
															,superfile
															,previouslogicalfile
															,keydifffile
															,keypatchfile
															,p_targetcluster
														)
											)
									,if (holdpatchedinsuper
											,nothor(apply(global(dStatus,few)
													,fSuperFileTransaction(superfile,keypatchfile,'keypatch')
													)
												)
											)
								)
						,fail('**** RUN ON *THOR (NOT HTHOR)* CLUSTER *****')
						);
	end;
	
	export fSpawnKeyDiffWrapper(dataset(rListToProcess) p_dListToProcess
															,string p_dopsdatasetname = STD.System.Job.User()
															,boolean holdpreviousforkeydiff = true
															,string p_targetcluster = STD.System.Job.Target()) := function
															
		return if (~regexfind('hthor', p_targetcluster)
						,sequential
							(
								output(p_dListToProcess,,vKeyDiffFileListPrefix+p_dopsdatasetname,overwrite)
								,fHoldPreviousLogical(p_dListToProcess)
								,output(WsWorkunits.soapcall_WUWaitComplete
																(WsWorkunits.Create_Wuid_Raw
																		(
																		'#workunit(\'name\',\'[KEYDIFF]: '+ p_dopsdatasetname +'\');\r\n'
																		+ '#workunit(\'priority\',\'high\');\r\n'
																		+ 'ds := dataset(\''+vKeyDiffFileListPrefix+p_dopsdatasetname+'\',dops.modKeydiff().rListToProcess,thor);\r\n'
																			+ 'dops.modKeydiff(\''+p_esp+'\',\''+p_location+'\',\''+p_environment+'\').fRunKDiff(ds,'+if (holdpreviousforkeydiff,'true','false')+')'
																			,p_targetcluster
																			,p_esp
																			,'8010'
																			)
																		,pWait := 180
																		,pReturnOnWait := true
																		,pesp := p_esp
																	))
							)
						,fail('**** RUN ON *THOR (NOT HTHOR)* CLUSTER *****')
						);
	end;
	
	export fSpawnKeyPatchWrapper(dataset(rListToProcess) p_dListToProcess
															,string p_dopsdatasetname = STD.System.Job.User()
															,boolean holdpatchedinsuper = true
															,string p_targetcluster = STD.System.Job.Target()) := function
															
		return if (~regexfind('hthor', p_targetcluster)
						,sequential
							(
								output(p_dListToProcess,,vKeyPatchFileListPrefix+p_dopsdatasetname,overwrite)
								,output(WsWorkunits.soapcall_WUWaitComplete
																(WsWorkunits.Create_Wuid_Raw
																		(
																		'#workunit(\'name\',\'[KEYPATCH]: '+ p_dopsdatasetname +'\');\r\n'
																		+ '#workunit(\'priority\',\'high\');\r\n'
																		+ 'ds := dataset(\''+vKeyPatchFileListPrefix+p_dopsdatasetname+'\',dops.modKeydiff().rListToProcess,thor);\r\n'
																			+ 'dops.modKeydiff(\''+p_esp+'\',\''+p_location+'\',\''+p_environment+'\').fRunKPatch(ds,'+if (holdpatchedinsuper,'true','false')+')'
																			,p_targetcluster
																			,p_esp
																			,'8010'
																			)
																		,pWait := 180
																		,pReturnOnWait := true
																		,pesp := p_esp
																	))
							)
						,fail('**** RUN ON *THOR (NOT HTHOR)* CLUSTER *****')
						);
	end;
	
end;