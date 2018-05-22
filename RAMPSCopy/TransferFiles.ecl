import did_add, dops, lib_fileservices, STD, lib_stringlib;
EXPORT TransferFiles(string destenv = '',integer noofgens = 2, boolean useeclcccluster = true) := module

	export clustertorun := if (useeclcccluster, STD.system.Job.Target(),'hthor');

	export RoxiePackage(string esp, string port, string target, boolean iscopy = false) := function
		dPackageKeys := dedup(sort(dops.GetRoxiePackage(esp
																	,port		
																	,target).Keys(),superfile),superfile, subfile);
	
		dFilesToMove := if (iscopy
												,sort(rampscopy.constants(destenv).filestocopyds,superfile)
												,sort(rampscopy.constants(destenv).rampsfileds,superfile)
												);

		rdFilesToMove := record
			dFilesToMove;
		end;
		
		rdFilesToMove xFilesReadyForLive(dFilesToMove l, dPackageKeys r) := transform
			self.subfile := r.subfile;
			self.cnt := 0;
			self := l;
		end;
		
		dFilesReadyForLive := dedup(sort(join(dFilesToMove
																,dPackageKeys
																,left.superfile = right.superfile
																,xFilesReadyForLive(left,right)
																),superfile, subfile), superfile, subfile);

		/*rtFilesToMove := record
			dFilesReadyForLive.superfile;
			integer scnt := count(group);
		end;

		dtFilesToMove := table(dFilesReadyForLive,rtFilesToMove,superfile, few);*/

		rdFilesToMove pGroupSubFiles(dFilesReadyForLive l, dFilesReadyForLive r) := transform
			
			self.cnt := if(l.superfile = r.superfile, l.cnt + 1, 1);
			self := r;
			
		end;
		
		dGroupSubFiles := iterate(dFilesReadyForLive
															,pGroupSubFiles(left,right));
		
		
		return dGroupSubFiles;
		
	end;
	
	// export getprodroxieversion() := function
		// roxienvlist := dedup(sort(rampscopy.constants(destenv).filestocopyds,roxieenvvariable),roxieenvvariable);
		
		// rampscopy.layouts.filestocopy populateversion(roxienvlist l) := transform
			// self.roxieversion := 'NA';//did_add.get_EnvVariable(l.roxieenvvariable,inroxieip);
			// self := l;
		// end;
		
		// getversion := project(roxienvlist,populateversion(left));
		
		// return getversion;
	// end;
	
	export getsubfiles(boolean iscopy = false) := function
		
		// subfileds := record
			// rampscopy.layouts.filestocopy;
			// dataset(lib_fileservices.FsLogicalFileNameRecord) l_subfiles;
		// end;
		
		// versionds := getprodroxieversion();
		
		// subfileds subfiles(rampscopy.constants(destenv).filestocopyds l, versionds r) := transform
			// self.l_subfiles := fileservices.SuperFileContents('~'+l.superfile);
			// self.roxieversion := r.roxieversion;
			// self := l;
		// end;

		// dswithsubfiles := join(rampscopy.constants(destenv).filestocopyds
														// ,versionds
														// ,left.roxieenvvariable = right.roxieenvvariable
														// ,subfiles(left,right));
		
		// rampscopy.layouts.filestocopy norm_recs(dswithsubfiles l, lib_fileservices.FsLogicalFileNameRecord r) := transform
			// self.subfile := r.name;
			// self := l;
		// end;

		// normedrecs := normalize(dswithsubfiles,left.l_subfiles
																	// ,norm_recs(left,right));
		
		dFilesReadyFromCert := RoxiePackage(rampscopy.constants(destenv).boca.nonfcra.roxiecertesp
																	,rampscopy.constants(destenv).boca.port		
																	,rampscopy.constants(destenv).boca.nonfcra.roxiecerttarget
																	,iscopy);
		
		return dFilesReadyFromCert;
		
	end;
	
	export filelistcmd := 'server=http://'+ trim(rampscopy.constants(destenv).ramps.dstesp,left,right) + ':8010 ' 
									+ 'overwrite=1 ' 
									+ 'replicate=1 ' 
									+ 'action=copy ' 
									+ 'dstcluster=' + rampscopy.constants(destenv).ramps.dstcluster +' ' 
									+ 'dstname=~'+rampscopy.constants(destenv).rampsfile
									+ ' srcname=~'+rampscopy.constants(destenv).rampsfile 
									+ ' nosplit=1 '
									+ 'wrap=1 '
									+ 'transferbuffersize=1000000 '
									+ 'srcdali=' + rampscopy.constants(destenv).boca.srcdali + ' ';
	
	
	export copy() := function
	
		sFiles := getsubfiles(true) : independent;
	
		dops.Layout_filelist convertodopsxform(sFiles l) := transform
			self.name := l.subfile;
			self.cmd := '';
			
		end;
	
		convertodops := project(sFiles(subfile <> ''),convertodopsxform(left));
	
	
		return if (count(convertodops) > 0,
									sequential(
												output(sFiles,,'~'+rampscopy.constants(destenv).rampsfile,overwrite)
												,STD.File.DfuPlusExec(filelistcmd)
												,dops.CopyFiles(
														rampscopy.constants(destenv).boca.srcesp
														,trim(rampscopy.constants(destenv).ramps.dstesp,left,right)
														,rampscopy.constants(destenv).boca.srcdali
														,rampscopy.constants(destenv).ramps.dstdali
														,rampscopy.constants(destenv).ramps.dstcluster
														,rampscopy.constants(destenv).boca.srcclusters
														,
														,convertodops
														,
														,'rampscopy'+destenv
													).Run
											),
										sequential(
												output('No filelist to copy: ' + rampscopy.constants(destenv).rampsfile + ' is empty or unable to retreive package from ' + rampscopy.constants(destenv).boca.nonfcra.roxiecertesp + '; target:' + rampscopy.constants(destenv).boca.nonfcra.roxiecerttarget)
												,fileservices.sendemail(
																				RAMPSCopy.constants(destenv).rToEmail
																				,if (destenv <> '',stringlib.StringToUpperCase(destenv),'PROD')+':RAMPS Copy Failed but restarting'
																				,'No filelist to copy: ' + rampscopy.constants(destenv).rampsfile + ' is empty or unable to retreive package from ' + rampscopy.constants(destenv).boca.nonfcra.roxiecertesp + '; target:' + rampscopy.constants(destenv).boca.nonfcra.roxiecerttarget
																				,
																				,
																				,RAMPSCopy.constants(destenv).rFromEmail
																			)
													,fail('Unable to get list, see output section')
												)
									);
	end;
	
	export MoveCopiedToStaging() := function
		
		dFilesReadyForStaging := RoxiePackage(rampscopy.constants(destenv).boca.nonfcra.roxiecertesp
																	,rampscopy.constants(destenv).boca.port		
																	,rampscopy.constants(destenv).boca.nonfcra.roxiecerttarget) : independent;
	
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
									,fileservices.deletelogicalfile('~'+rampscopy.constants(destenv).rampsfile+'_cert')
									)
								;
	end;
	
	export cleanup() := function
				
		dFilesReadyForLive := sort(RoxiePackage(rampscopy.constants(destenv).boca.nonfcra.roxieprodesp
																	,rampscopy.constants(destenv).boca.port		
																	,rampscopy.constants(destenv).boca.nonfcra.roxieprodtarget),superfile,subfile) : independent;
																	
		return 
										nothor(apply(
											global(dFilesReadyForLive,few),
												
																				
																						sequential(
																								if (cnt  = 1
																									,sequential
																										(
																											if (fileservices.findsuperfilesubname('~'+superfile+'_delete', '~'+subfile) > 0
																											,fileservices.removesuperfile('~'+superfile+'_delete','~'+subfile)),
																											fileservices.addsuperfile('~'+superfile+'_delete','~'+superfile+'_father',,true),
																											fileservices.clearsuperfile('~'+superfile+'_father'),
																											fileservices.addsuperfile('~'+superfile+'_father','~'+superfile,,true),
																											fileservices.clearsuperfile('~'+superfile),
																											fileservices.removesuperfile('~'+superfile+'_delete','~'+subfile),
																											fileservices.removesuperfile('~'+superfile+'_father','~'+subfile),
																										)
																									),
																								fileservices.addsuperfile('~'+superfile,'~'+subfile),
																								fileservices.removeownedsubfiles('~'+superfile+'_delete',true)
																							)
																						)
																					);
																			
										
									
	
	end;
	
	export MoveStagingToLive() := function
		
		dFilesReadyForLive := sort(RoxiePackage(rampscopy.constants(destenv).boca.nonfcra.roxieprodesp
																	,rampscopy.constants(destenv).boca.port		
																	,rampscopy.constants(destenv).boca.nonfcra.roxieprodtarget),superfile,subfile) : independent;
																	
		return if (noofgens in [1,2],
							if (~fileservices.fileexists('~'+rampscopy.constants(destenv).rampsfile+'_cert')
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
																					if (noofgens = 2,
																						sequential
																							(fileservices.addsuperfile('~'+superfile+'_delete','~'+superfile+'_father',,true)
																								,fileservices.clearsuperfile('~'+superfile+'_father')
																								,fileservices.addsuperfile('~'+superfile+'_father','~'+superfile,,true)
																								,fileservices.clearsuperfile('~'+superfile)
																							),
																							sequential
																							(fileservices.addsuperfile('~'+superfile+'_delete','~'+superfile,,true)
																								,fileservices.clearsuperfile('~'+superfile)
																							)
																						)
																					)
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
										
									,output('RAMPS move to staging in progress')
								),
								fail('noofgens value should be [1,2]')
							);
									
		
	end;
	
	
	export SubmitWUonRampsThor(string jobtype) := function
	
		return map(
															jobtype = 'stage' => output(RAMPSCopy.WorkUnitModule(trim(RAMPSCopy.constants(destenv).ramps.dstesp,left,right),RAMPSCopy.constants(destenv).ramps.port).fSubmitNewWorkunit(
																	'#workunit(\'name\',\'Move Boca Indexes to Staging\');\r\n'+
																	'sequential(\r\noutput(rampscopy.constants(\''+destenv+'\').rampsfileds,,\'~\'+rampscopy.constants(\''+destenv+'\').rampsfile+\'_cert\',overwrite)\r\n,RAMPSCopy.TransferFiles(\''+destenv+'\','+(string)noofgens+','+if(useeclcccluster,'true','false')+').MoveCopiedToStaging()) : failure(fileservices.deletelogicalfile(\'~\'+rampscopy.constants(\''+destenv+'\').rampsfile+\'_cert\'));',clustertorun)),
															jobtype = 'live' => output(RAMPSCopy.WorkUnitModule(trim(RAMPSCopy.constants(destenv).ramps.dstesp,left,right),RAMPSCopy.constants(destenv).ramps.port).fSubmitNewWorkunit(
																	'#workunit(\'name\',\'Move Staging Indexes to Live\');\r\n'+
																	'RAMPSCopy.TransferFiles(\''+destenv+'\','+(string)noofgens+','+if(useeclcccluster,'true','false')+').MoveStagingToLive() : failure(\r\n' +
																						'fileservices.sendemail(\r\n' +
																								'RAMPSCopy.constants(\''+destenv+'\').rToEmail\r\n' +
																								',\'RAMPS Stage to Live Move Failed\'\r\n' +
																								',failmessage\r\n' +
																								',\r\n' +
																								',\r\n' +
																								',RAMPSCopy.constants(\''+destenv+'\').rFromEmail\r\n' +
																								')\r\n' +
																						');',clustertorun)),
															output('NA')
														);
	
		
	end;
	
	export BeginCopy := if (~fileservices.fileexists('~'+rampscopy.constants(destenv).rampsfile+'_copyinprogress')
									,sequential
									(
										output(rampscopy.constants(destenv).rampsfileds,,'~'+rampscopy.constants(destenv).rampsfile+'_copyinprogress',overwrite)
										,copy()
										,fileservices.deletelogicalfile('~'+rampscopy.constants(destenv).rampsfile+'_copyinprogress')
										,SubmitWUonRampsThor('stage')
										
									)
									,output('File copy in progress')
									) : failure(
												sequential
														(
															fileservices.deletelogicalfile('~'+rampscopy.constants(destenv).rampsfile+'_copyinprogress'),
															fileservices.sendemail(
																				RAMPSCopy.constants(destenv).rToEmail
																				,if (destenv <> '',stringlib.StringToUpperCase(destenv),'PROD')+':RAMPS Copy Failed but restarting'
																				,failmessage
																				,
																				,
																				,RAMPSCopy.constants(destenv).rFromEmail
																			),
																output(RAMPSCopy.WorkUnitModule(RAMPSCopy.constants(destenv).boca.srcesp,RAMPSCopy.constants(destenv).boca.port).fSubmitNewWorkunit(
																	'#workunit(\'name\',\'Copy Files to RAMPS '+ stringlib.StringToUpperCase(destenv) +' thor\')\r\n'+
																	'Rampscopy.TransferFiles(\''+destenv+'\','+(string)noofgens+','+if(useeclcccluster,'true','false')+').begincopy : WHEN(CRON(\'0 17,21 * * *\'));',clustertorun))
																)
														);
		
	
	
end;