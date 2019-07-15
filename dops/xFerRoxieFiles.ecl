////////////// README //////////////////////////

// xFerRoxieFiles is used to 

// Copy Files and move copied files to cert and staging super: xFerRoxieFiles().begincopy

// 1. transfer/copy files from source THOR to destination THOR, based on the availability 
		// of the file on CERT Roxie
// 2. Move the copied file into _cert super, the process will suffix "_cert" to the superfiles 
		// mentioned in filescopyds dataset (passed as parameter) and create one if it doesn't exist
// 3. Move the copied file into _stating super, the process will suffix "_staging" to the superfiles 
		// mentioned in filescopyds dataset (passed as parameter) and create one if it doesn't exist
// 4. The function will create a new WU on dest thor for move

// Move files from Staging to Live: xFerRoxieFiles('dev').SubmitWUonRampsThor('live')

// 1. If suffixSuperName is blank then Live super name will be the same as supernames mentioned in filecopyds
		// else the supernames will be suffixed with "_suffixSuperName" the suffixed supername 
		// will be considered Live
// 2. Check if the file is available on Prod roxie, if the file is on prod roxie the move the file from
		// staging to live super
// 3. The function will create a new WU on dest thor for move

////////////////////////////////////////////////

import did_add, dops, lib_fileservices, STD, lib_stringlib, _Control;

EXPORT xFerRoxieFiles(
											dataset(dops.layouts.filestocopy) filescopyds = dataset([],dops.layouts.filestocopy)
											,string dstthoresp = ''
											,string dstthordali = '' 
											,string dstthorcluster = ''
											,string dstthorespport = ''
											,string destenv = ''// prod or dr or dev or some environment identity, this value will be used in dops.copyconstants.copyfile
											,string rToEmail = ''
											,string suffixSuperName = ''
											,boolean MoveToLive = false
											,boolean spawnWU = true
											,string roxieip = _Control.RoxieEnv.prod_batch_neutral
											,string srcthoresp = 'prod_esp.br.seisint.com'
											,string srcthordali = 'prod_dali.br.seisint.com'
											,string srcthorespport = '8010'
											,set of string srcthorclusters = ['thor400_20'
																											,'thor400_30'
																											,'thor400_31_store'
																											,'thor400_60'
																											,'thor400_44'
																											,'hthor__eclagent']
											,string roxieprodespport = '8010'
											,string roxieprodesp = '10.173.1.131'
											,string roxieprodtarget = 'roxie_134'
											,string roxiecertespport = '8010'
											,string roxiecertesp = '10.173.235.23'
											,string roxiecerttarget = 'roxie_130'
											,boolean useRoxieToGetSubFilenames = true
											,boolean isFullRefresh = false
											) := module
		
		export isAddSubFileSuffix := if (suffixSuperName <> ''
																			,true
																			,false);
		
		
		export GetSubFilesFromThor() := function
			rGetSubFiles := record
				string superfile;
				string subfile;
			end;
			
			rFiles := record
				dops.layouts.filestocopy;
				dataset(rGetSubFiles) fromGetSubFiles;
			end;
			
			rFiles xGetFiles(filescopyds l) := transform
				self.fromGetSubFiles := dops.GetSubFiles(l.superfile,srcthoresp);
				self := l;
			end;
			
			dFiles := project(filescopyds,xGetFiles(left));
			
			dops.layouts.filestocopy xConvertToCommonLayout(dFiles l, rGetSubFiles r) := transform
				self.subfile := r.subfile;
				self := l;
			end;
			
			dNormRecs := normalize(dFiles
															,left.fromGetSubFiles
															,xConvertToCommonLayout(left,right)
														);
			
			return dNormRecs;
			
		end;
		
		export RoxiePackage(string esp, string port, string target, boolean addSubFileSuffix = false, boolean useFile = false) := function
			dPackageKeys := sort(dops.GetRoxiePackage(esp
																		,port		
																	,target).Keys(),superfile);
	
			dFilesToMove := sort(if (~useFile,filescopyds,dops.copyconstants(destenv).copyfileds),superfile);

			rdFilesToMove := record
				dFilesToMove;
			end;
		
			rdFilesToMove xFilesReadyForLive(dFilesToMove l, dPackageKeys r) := transform
				self.subfile := r.subfile;
				self.cnt := 0;
				self := l;
			end;
		
			dFilesReadyForLive := if (useRoxieToGetSubFilenames
																,dedup(sort(join(dFilesToMove
																			,dPackageKeys
																			,stringlib.StringToLowerCase(regexreplace('_'+suffixSuperName
																													,regexreplace('::'+suffixSuperName+'::',left.superfile, '::qa::',nocase),
																														'_qa',nocase)) = stringlib.StringToLowerCase(right.superfile)
																																
																			,xFilesReadyForLive(left,right)
																		),superfile,subfile),record)
																,GetSubFilesFromThor()
																
																);

			rtFilesToMove := record
				dFilesReadyForLive.superfile;
				integer scnt := count(group);
			end;

			dtFilesToMove := table(dFilesReadyForLive,rtFilesToMove,superfile, few);

			rdFilesToMove pGroupSubFiles(dFilesReadyForLive l, dFilesReadyForLive r) := transform
				
				self.cnt := if(l.superfile = stringlib.StringToLowerCase(regexreplace('_qa'
																													,regexreplace('::qa::',r.superfile, '::'+suffixSuperName+'::'),
																														'_'+suffixSuperName
																																)), l.cnt + 1, 1);
				self.superfile := if (suffixSuperName <> '', stringlib.StringToLowerCase(regexreplace('_qa'
																													,regexreplace('::qa::',r.superfile, '::'+suffixSuperName+'::'),
																														'_'+suffixSuperName
																																)), stringlib.StringToLowerCase(r.superfile));
				self.subfile := if (~addSubFileSuffix
																,r.subfile
																,r.subfile + '_' + suffixSuperName);
				self := l;
			end;
		
			dGroupSubFiles := iterate(dFilesReadyForLive
															,pGroupSubFiles(left,right));
		
			return dGroupSubFiles;
		
		end;
	
		export getsubfiles() := function
			dFilesReadyFromCert := if (~MoveToLive
																			,RoxiePackage(roxiecertesp
																							,roxiecertespport
																							,roxiecerttarget)
																			,RoxiePackage(roxieprodesp
																							,roxieprodespport
																							,roxieprodtarget)
																				);
			return dFilesReadyFromCert;
		end;
	
		export filelistcmd := 'server=http://'+ dstthoresp + ':8010 ' 
									+ 'overwrite=1 ' 
									+ 'replicate=1 ' 
									+ 'action=copy ' 
									+ 'dstthorcluster=' + dstthorcluster +' ' 
									+ 'dstname=~'+dops.copyconstants(destenv).copyfile
									+ ' srcname=~'+dops.copyconstants(destenv).copyfile 
									+ ' nosplit=1 '
									+ 'wrap=1 '
									+ 'transferbuffersize=1000000 '
									+ 'srcthordali=' + srcthordali + ' ';
	
	
		export copy() := function
			sFiles := getsubfiles() : independent;
			dops.Layout_filelist convertodopsxform(sFiles l) := transform
				self.name := l.subfile;
				self.cmd := '';
			end;
			convertodops := project(sFiles(subfile <> ''),convertodopsxform(left));
			return sequential(
												output(sFiles,,'~'+dops.copyconstants(destenv).copyfile,overwrite)
												,if (~fileservices.fileexists('~foreign::'+dstthordali+'::'+dops.copyconstants(destenv).copyfile)
														,STD.File.DfuPlusExec(filelistcmd))
												,dops.CopyFiles(
														srcthoresp
														,dstthoresp
														,srcthordali
														,dstthordali
														,dstthorcluster
														,srcthorclusters
														,
														,convertodops
														,suffixSuperName
													).run
												,fileservices.deletelogicalfile('~'+dops.copyconstants(destenv).copyfile+'_copyinprogress')
											);
		end;
	
		export MoveCopiedToStaging() := function
			dFilesReadyForStaging := if (~MoveToLive
																			,RoxiePackage(roxiecertesp
																							,roxiecertespport
																							,roxiecerttarget
																							,isAddSubFileSuffix
																							,true)
																			,RoxiePackage(roxieprodesp
																							,roxieprodespport
																							,roxieprodtarget
																							,isAddSubFileSuffix
																							,true)
																				) : independent;
			// this code gets submitted on destination thor
			return 	sequential
									(
									// Move files to cert super
									// From cert move to staging super
									// From cert move to prelive super
									// Reason for cert and staging:
									// If a super has multiple subfiles and if there is a new subfile added to super
									// then holding all previous subfiles in staging will not delete from disk and it
									// allows to safely clear cert super without the risk of file deletion
									// Reason for prelive super:
									// Files are staged in this super until they are moved to live
									// when move prelive will be cleared/deleted
									
									nothor(apply(global(dFilesReadyForStaging,few),
										sequential
											(
													if ( ~fileservices.superfileexists('~'+superfile+'_cert')
															,fileservices.createsuperfile('~'+superfile+'_cert'))
													,fileservices.RemoveOwnedSubFiles('~'+superfile+'_cert',true)
													,fileservices.clearsuperfile('~'+superfile+'_cert')
												)
											))
									,nothor(apply(global(dFilesReadyForStaging,few),
										sequential
											(
												if ( ~fileservices.superfileexists('~'+superfile)
															,fileservices.createsuperfile('~'+superfile))
												,if (isFullRefresh,
																sequential
																						(fileservices.RemoveOwnedSubFiles('~'+superfile,true)
																							,fileservices.clearsuperfile('~'+superfile)
																						)
														)
											)
										))
									,if (~MoveToLive
											,nothor(apply(global(dFilesReadyForStaging,few),
												sequential
													(
														if ( ~fileservices.superfileexists('~'+superfile+'_cert')
																,fileservices.createsuperfile('~'+superfile+'_cert'))
														,if ( ~fileservices.superfileexists('~'+superfile+'_prelive')
																,fileservices.createsuperfile('~'+superfile+'_prelive'))
														,if (fileservices.fileexists('~'+subfile)
															,sequential
																	(if (fileservices.FindSuperFileSubname('~'+superfile+'_cert','~'+subfile) = 0
																		,fileservices.addsuperfile('~'+superfile+'_cert','~'+subfile))
																	,if (fileservices.FindSuperFileSubname('~'+superfile+'_prelive','~'+subfile) = 0
																		,fileservices.addsuperfile('~'+superfile+'_prelive','~'+subfile))
																	)
															)
													)
												))
											,nothor(apply(global(dFilesReadyForStaging,few)
													,if (fileservices.fileexists('~'+subfile)
															,sequential
																(
																	if ( ~fileservices.superfileexists('~'+superfile)
																			,fileservices.createsuperfile('~'+superfile))
																	,if (fileservices.FindSuperFileSubname('~'+superfile,'~'+subfile) = 0
																			,sequential
																			(
																				if (cnt = 1,
																					sequential
																						(fileservices.RemoveOwnedSubFiles('~'+superfile,true)
																							,fileservices.clearsuperfile('~'+superfile)
																						))
																				,if (cnt > 1,
																							if (fileservices.FindSuperFileSubname('~'+superfile,'~'+subfile) = 0
																										,fileservices.addsuperfile('~'+superfile,'~'+subfile))
																							,sequential
																									(
																										fileservices.clearsuperfile('~'+superfile)
																										,fileservices.addsuperfile('~'+superfile,'~'+subfile)
																										)
																								
																						)
																				)
																		
																		)
																	)
														,output('~'+subfile)
														)
													))
											)
									,fileservices.deletelogicalfile('~'+dops.copyconstants(destenv).copyfile+'_cert')
									)
								;
		end;
	
		export MoveStagingToLive() := function
			dFilesReadyForLive := sort(RoxiePackage(roxieprodesp
																	,roxieprodespport		
																	,roxieprodtarget
																	,isAddSubFileSuffix
																	,true),superfile,subfile) : independent;
																	
			return if (~fileservices.fileexists('~'+dops.copyconstants(destenv).copyfile+'_cert')
								,sequential
								(
									nothor(apply(
											global(dFilesReadyForLive,few)
											,sequential
												(
													if ( ~fileservices.superfileexists('~'+superfile+'_prelive')
															,fileservices.createsuperfile('~'+superfile+'_prelive'))
													,if ( ~fileservices.superfileexists('~'+superfile)
															,fileservices.createsuperfile('~'+superfile))
													,if ( ~fileservices.superfileexists('~'+superfile+'_father')
															,fileservices.createsuperfile('~'+superfile+'_father'))
													,if ( ~fileservices.superfileexists('~'+superfile+'_delete')
															,fileservices.createsuperfile('~'+superfile+'_delete'))
													,if(fileservices.findsuperfilesubname('~'+superfile+'_prelive','~'+subfile) = 0
															,output('~'+superfile+'_prelive doesnt have ~'+subfile+' to begin live move')
															,if (fileservices.findsuperfilesubname('~'+superfile,'~'+subfile) = 0
																	,sequential
																			(
																				if (cnt = 1,
																					sequential
																						(fileservices.addsuperfile('~'+superfile+'_delete','~'+superfile+'_father',,true)
																							,fileservices.clearsuperfile('~'+superfile+'_father')
																							,fileservices.addsuperfile('~'+superfile+'_father','~'+superfile,,true)
																							,fileservices.clearsuperfile('~'+superfile)
																						))
																				,if (cnt > 1,
																							if (fileservices.FindSuperFileSubname('~'+superfile,'~'+subfile) = 0
																										,fileservices.addsuperfile('~'+superfile,'~'+subfile))
																							,sequential
																									(
																										fileservices.clearsuperfile('~'+superfile)
																										,fileservices.addsuperfile('~'+superfile,'~'+subfile)
																										)
																								
																						)
																						// remove from prelive
																				,fileservices.removesuperfile('~'+superfile+'_prelive','~'+subfile)
																				,fileservices.RemoveOwnedSubFiles('~'+superfile+'_delete',true)
																				,fileservices.clearsuperfile('~'+superfile+'_delete') // have to clear to remove the reference if it is held by another super
																				)
																	,output('~'+superfile+' has '+'~'+subfile)
																)
														)
												)
											))
										// Clear out prelive after the data is live
										,nothor(apply(global(dFilesReadyForLive,few),
												sequential
														(
														if ( ~fileservices.superfileexists('~'+superfile+'_prelive')
																,fileservices.createsuperfile('~'+superfile+'_prelive'))
														,if (fileservices.findsuperfilesubname('~'+superfile,'~'+subfile) > 0
															,	// remove from prelive just in case remove didn't happen in previous clear
																		fileservices.removesuperfile('~'+superfile+'_prelive','~'+subfile))
														,fileservices.RemoveOwnedSubfiles('~'+superfile+'_prelive',true)
														// don't clear out prelive because after copy finishes an attempt is
														// made to clear _cert (delete files) and it is not held in _prelive then
														// the file will be deleted
																	)
															)
													)
											)
										
									,output('move to staging in progress')
								);
		end;
	
		export SubmitWUonThor(string jobtype) := function
			return map(
															jobtype = 'stage' => output(dops.WorkUnitModule(dstthoresp,dstthorespport).fSubmitNewWorkunit(
																	'#workunit(\'name\',\'Move Indexes to Staging\');\r\n'+
																	'sequential(\r\noutput(dops.copyconstants(\''+destenv+'\').copyfileds,,\'~\'+dops.copyconstants(\''+destenv+'\').copyfile+\'_cert\',overwrite)\r\n,dops.xFerRoxieFiles(,\''+dstthoresp+'\',\''+dstthordali+'\',\''+dstthorcluster+'\',\''+dstthorespport+'\',\''+destenv+'\',\''+rToEmail+'\',\''+suffixSuperName+'\',' + MoveToLive + ',' + spawnWU + ',\''+roxieip+'\',\''+srcthoresp+'\',\''+srcthordali+'\',\''+srcthorespport+'\',,\''+roxieprodespport+'\',\''+roxieprodesp+'\',\''+roxieprodtarget+'\',\''+roxiecertespport+'\',\''+roxieprodesp+'\',\''+roxieprodtarget+'\',\''+roxiecertespport+'\',\''+roxiecertesp+'\',\''+roxiecerttarget+'\').MoveCopiedToStaging()) : failure(fileservices.deletelogicalfile(\'~\'+dops.copyconstants(\''+destenv+'\').copyfile+\'_cert\'));','hthor')),
															jobtype = 'live' => output(dops.WorkUnitModule(dstthoresp,dstthorespport).fSubmitNewWorkunit(
																	'#workunit(\'name\',\'Move Staging Indexes to Live\');\r\n'+
																	'dops.xFerRoxieFiles(\''+destenv+'\').MoveStagingToLive() : failure(\r\n' +
																						'fileservices.sendemail(\r\n' +
																								rToEmail+'\r\n' +
																								',\'Stage to Live Move Failed\'\r\n' +
																								',failmessage\r\n' +
																								',\r\n' +
																								',\r\n' +
																								',dops.copyconstants(\''+destenv+'\').rFromEmail\r\n' +
																								')\r\n' +
																						');','hthor')),
															output('NA')
														);
		end;
	
		export BeginCopy := if (~fileservices.fileexists('~'+dops.copyconstants(destenv).copyfile+'_copyinprogress')
									,sequential
									(
										output(dops.copyconstants(destenv).copyfileds,,'~'+dops.copyconstants(destenv).copyfile+'_copyinprogress',overwrite)
										,copy()
										
										,if (spawnWU
													,SubmitWUonThor('stage')
													,MoveCopiedToStaging()
												)
										)
									,output('File copy in progress')
									) : failure(
												sequential
														(
															fileservices.deletelogicalfile('~'+dops.copyconstants(destenv).copyfile+'_copyinprogress'),
															fileservices.sendemail(
																				rToEmail
																				,stringlib.StringToUpperCase(destenv)+':Copy Failed'
																				,failmessage
																				,
																				,
																				,dops.copyconstants(destenv).rFromEmail
																			)
																)
														);
	
	
end;