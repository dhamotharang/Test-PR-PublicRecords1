// Module: modKeyDiff
// Purpose: Functions, variables, record sets to run keydiff
// Parameters: ESP (thor esp, MUST be local esp)

import _Control, DOPS, STD, WsWorkunits;
export modKeyDiff(string p_esp = _Control.Config.Localesp
									,string p_location = dops.constants.location
									,string p_environment = '' // H, HC, HU, N, F, ..
									) := module
	
	export lFileScope := dops.constants.vFileScope(p_location,p_environment);
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
	
	export fKeyDiff(string iKeyAttribute
									,string superfile
									,string newlogicalfile
									,string previouslogicalfile
									,string keydifffile) := function
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
																			,STD.System.Job.Target()
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
									,string patchedfile) := function
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
																			,STD.System.Job.Target()
																			,p_esp
																			,'8010'
																			)
																		,pReturnOnWait := true
																		,pesp := p_esp
																	));
	end;
	
	EXPORT fGetFileStatus(dataset(rListToProcess) dListToProcess) := function
		rList := record
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
		end;

		rlist xGetFileStatus(dListToProcess l) := transform
			isFileExists := STD.File.FileExists(l.newlogicalfile + '_keydiff');
			patchFilename := if (STD.File.FileExists(l.newlogicalfile)
																	,l.newlogicalfile + '_keypatch'
																	,l.newlogicalfile
																	);
			isKdiff := if (~isFileExists
																and (STD.File.FileExists(l.newlogicalfile)
																		and STD.File.FileExists(l.previouslogicalfile))
																and ~(STD.File.SuperFileExists(l.newlogicalfile)
																		and STD.File.SuperFileExists(l.previouslogicalfile))
															,true
															,false);
			isPatchFileExists := STD.File.FileExists(patchFilename);
			isKPatch := if (~isPatchFileExists
														and STD.File.FileExists(l.previouslogicalfile)
													,true
													,false
											);
			self.originalsuper := l.newlogicalfile + '_forkeydiff';
			self.keydifffile := l.newlogicalfile + '_keydiff';
			self.keypatchfile := patchFilename;
			self.iskeydiff := isKdiff;
			self.iskeydiffexist := isFileExists;
			self.iskeypatch := isKPatch;
			self.iskeypatchexist := isPatchFileExists;
			self.newfile := STD.File.FileExists(l.newlogicalfile) and ~STD.File.SuperFileExists(l.newlogicalfile);
			self.previousfile := STD.File.FileExists(l.previouslogicalfile) and ~STD.File.SuperFileExists(l.previouslogicalfile);
			self := l;
		end;
		
		dGetFileStatus := nothor(project(global(dListToProcess,few),xGetFileStatus(left)));
		
		rlist xIsKeyDiff(dGetFileStatus l) := transform
			self.iskeydiff := if (
															dLayoutMismatch(l.newlogicalfile)[1].fulllayout <> ''
															and dLayoutMismatch(l.newlogicalfile)[1].fulllayout <> 
																		dLayoutMismatch(l.previouslogicalfile)[1].fulllayout
																	,false
																	,l.iskeydiff
													);
			self := l;
									
		end;
		
		disKeyDiff := project(dGetFileStatus,xIsKeyDiff(left));
		
		return disKeyDiff;
		
	end;
	
	export fRunKDiff(dataset(rListToProcess) dListToProcess
														,boolean holdpreviousforkeydiff = true) := function
		dStatus := fGetFileStatus(dListToProcess) : independent;
		
		return if (~regexfind('hthor', STD.System.Job.Target())
						,sequential
								(
									// add to super to hold the previous key so it is not deleted
									output(choosen(dStatus,1000),named('keydiff_records'))
									,if (holdpreviousforkeydiff
											,nothor(apply(global(dStatus(iskeydiff),few)
														,sequential
															(
																IF (~STD.File.SuperFileExists(originalsuper)
																	,STD.File.CreateSuperFile(originalsuper))
																,STD.File.RemoveOwnedSubFiles(originalsuper,true)
																,STD.File.ClearSuperFile(originalsuper)
																,STD.File.AddSuperFile(originalsuper,previouslogicalfile)
															)
														)
													)
											)
									,apply(dStatus(iskeydiff)
										,fKeyDiff(attributename
															,superfile
															,newlogicalfile
															,previouslogicalfile
															,keydifffile
														)
											)
									,nothor(apply(global(dStatus,few)
											,sequential
													(
														fSuperFileTransaction(superfile,keydifffile,'keydiff')
														,IF (iskeydiff and holdpreviousforkeydiff
																,sequential
																		(
																			STD.File.RemoveOwnedSubFiles(originalsuper,true)
																			,STD.File.ClearSuperFile(originalsuper)
																		)
																)
													)
												)
										)
								)
							,fail('**** RUN ON NON-HTHOR CLUSTER *****')
						);
	end;
	
	export fRunKPatch(dataset(rListToProcess) dListToProcess
											,boolean holdpatchedinsuper = true) := function
		dStatus := fGetFileStatus(dListToProcess) : independent;
		
		return if (~regexfind('hthor', STD.System.Job.Target())
						,sequential
								(
									// add to super to hold the previous key so it is not deleted
									output(choosen(dStatus,1000),named('keypatch_records'))
									,apply(dStatus(iskeypatch)
										,fKeyPatch(attributename
															,superfile
															,previouslogicalfile
															,keydifffile
															,keypatchfile
														)
											)
									,if (holdpatchedinsuper
											,nothor(apply(global(dStatus,few)
													,fSuperFileTransaction(superfile,keypatchfile,'keypatch')
													)
												)
											)
								)
						,fail('**** RUN ON NON-HTHOR CLUSTER *****')
						);
	end;
	
	export fSpawnKeyDiffWrapper(dataset(rListToProcess) p_dListToProcess
															,string p_dopsdatasetname = STD.System.Job.User()
															,boolean holdpreviousforkeydiff = true) := function
															
		return if (~regexfind('hthor', STD.System.Job.Target())
						,sequential
							(
								output(p_dListToProcess,,vKeyDiffFileListPrefix+p_dopsdatasetname,overwrite)
								,output(WsWorkunits.soapcall_WUWaitComplete
																(WsWorkunits.Create_Wuid_Raw
																		(
																		'#workunit(\'name\',\'[KEYDIFF]: '+ p_dopsdatasetname +'\');\r\n'
																		+ '#workunit(\'priority\',\'high\');\r\n'
																		+ 'ds := dataset('+vKeyDiffFileListPrefix+p_dopsdatasetname+',dops.modKeydiff().rListToProcess,thor);\r\n'
																			+ 'fRunKDiff(ds,'+holdpreviousforkeydiff+')'
																			,STD.System.Job.Target()
																			,p_esp
																			,'8010'
																			)
																		,pReturnOnWait := true
																		,pesp := p_esp
																	))
							)
						,fail('**** RUN ON NON-HTHOR CLUSTER *****')
						);
	end;
	
end;