import STD, DOPS, _Control;
EXPORT IngestModule(string p_superfilesuffix = 'vault'
										,string p_port = '8010'
										,string p_location = 'uspr'
										,string p_processname = 'ingest') := module

	////////////////////// FILES, RECORD SETS AND DATASETS //////////////////////

	export vLocalFilePrefix := '~'+p_location+'::'+p_superfilesuffix+'::'+p_processname;
	export vVaultFileList := vLocalFilePrefix + '_filelist';
	
	export rVaultFileList := record
		string superfile := '';
		string attributename := '';
		string l_cluster := '';
	end;
	
	export rVaultFileStatus := record
		string superfile := '';
		string attributename := '';
		string p_cluster := '';
		string roxiekey := '';
		string whenlastupdated := '';
		boolean existsonthor := false;
		boolean isupdate := false;
		integer cnt := 0;
		
	end;
	
	// dataset that holds superfile name, attribute name (to run on vault thor), environment (fcra or nonfcra)
	export dVaultFileList := dataset(vVaultFileList,rVaultFileList,thor);
	
	export dLogicalFileSuperSubList(string p_environment) := STD.File.LogicalFileSuperSubList()(regexfind(p_superfilesuffix+'_',supername)) : independent;

	export dGetMissingFromFile(string p_environment) := 
								dataset(vLocalFilePrefix+'_'+p_environment+'_missing'
														,rVaultFileStatus,thor,opt);

	////////////////////// FILES, RECORD SETS AND DATASETS //////////////////////

	///////////////////// FUNCTIONS AND CALLERS /////////////////////////////////
	
	export fESPAssociatedToCluster(string p_cluster
																,string p_environment
																,string p_port = '8010') := function
		dESPs := dataset(Vault.Constants().vESPSet(p_cluster,p_environment),{string esps});

		rMatchingESP := record
			string esp;
			string roxiecluster;
		end;

		rMatchingESP xMatchingESP(dESPs l) := transform
			l_roxiecluster := dops.GetRoxieClusterInfo(l.esps,p_port).LiveCluster(Vault.Constants().vRoxieVIP(p_cluster,p_environment));
			self.esp := if (l_roxiecluster <> '', l.esps, '');
			self.roxiecluster := l_roxiecluster;
		end;

		dMatchingESP := project(dESPs,xMatchingESP(left))(esp <> '');

		return dedup(dMatchingESP,roxiecluster,KEEP(1));
	end;
	
	export fGetFileListFromRoxie(
															string p_esp
															,string p_roxiecluster
															,string p_port = '8010'
															,string p_cluster
															) := function
															
		dSlimdVaultFileList := sort(dVaultFileList(l_cluster = p_cluster),superfile);
	
		dRoxieKeys := sort(dops.GetRoxiePackage(p_esp,p_port,p_roxiecluster).Keys(),superfile);
		
		rVaultFileStatus xGetKeys(dSlimdVaultFileList l,dRoxieKeys r) := transform
			self.roxiekey := r.subfile;
			self.p_cluster := l.l_cluster;
			self.existsonthor := if(STD.File.FileExists('~foreign::'+Vault.Constants().vSourceDali+'::'+r.subfile),true,false);
			self := l;
			//self := r;
		end;

		dGetKeys := sort(join(dSlimdVaultFileList
												,dRoxieKeys
												,left.superfile = right.superfile
												,xGetKeys(left,right)),superfile, roxiekey);
												


		rVaultFileStatus xGroupSubFiles(dGetKeys l, dGetKeys r) := transform
			self.cnt := if(l.superfile = r.superfile, l.cnt + 1, 1);
			self := r;
		end;
		
		dGroupSubFiles := iterate(dGetKeys
															,xGroupSubFiles(left,right));
		
		
		return if (p_esp <> '',dGroupSubFiles,dataset([],rVaultFileStatus));
		
	end;

	
	export fGetMatchingFilesFromRoxie(string p_cluster,string p_environment) := function
		vESP := fESPAssociatedToCluster(p_cluster,p_environment,p_port);
		
		dGetMatchingNameFromRoxie := if ( count(vESP) > 0
																				,sort(fGetFileListFromRoxie(vESP[1].esp,vESP[1].roxiecluster,p_port,p_cluster),superfile,roxiekey)
																				,dataset([],rVaultFileStatus)
																			);
		
		return dGetMatchingNameFromRoxie;
	end;
	
	export fGetMissingLogicals(
															string p_cluster
															,string p_environment
															) := function

		dGetLogicalNameFromRoxie := fGetMatchingFilesFromRoxie(p_cluster, p_environment);
		
		
		rVaultFileStatus xGetMissingLogicals(dGetLogicalNameFromRoxie l) := transform
			l_isupdate := if (p_environment = 'prod'
													,if (~STD.File.FileExists('~'+l.superfile+'_vaultflag') // if a job on vault thor is running for super
															, true, false)
														,if (~STD.File.FileExists('~'+l.roxiekey), true, false)
													);
			
			self.isupdate := l_isupdate;
			self := l;
		end;
		
		dGetMissingLogicals := sort(project(dGetLogicalNameFromRoxie
																	,xGetMissingLogicals(left))
																	,superfile,roxiekey,cnt);
		
		///////
		
		// confirm
		// if the file was ingested already
		// super cleared but the file exists on thor
		
		dGetFile := sort(dGetMissingFromFile(p_environment),superfile,roxiekey,cnt);
		
		rVaultFileStatus xisIngested(dGetMissingLogicals l, dGetFile r) := transform
			//self.isupdate := if ( r.superfile = '', l.isupdate, false );
			self.whenlastupdated := if (r.superfile = '' and l.isupdate,(string8)STD.Date.Today()+Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S'),l.whenlastupdated);
			self := l;
		end;
		
		disIngested := join(dGetMissingLogicals
												,dGetFile
												,left.superfile = right.superfile
														and left.roxiekey = right.roxiekey
														and left.cnt = right.cnt 
												,xisIngested(left,right)
												,left outer
												);
		
		return disIngested;
		
	end;
	
	// get missing logicals for each cluster within an environment
	// for example: cert has nonfcra, fcra, boolean and same with prod
	export fCreateLogicalsForMissing(string p_environment) := function
		dGetClustersFromFile :=  dedup(dVaultFileList,l_cluster);
		
		rClusters := record
			string clustername;
			dataset(rVaultFileStatus) cMissing;
		end;
		
		rClusters xGetClustersFromFile(dGetClustersFromFile l) := transform
			self.clustername := l.l_cluster;
			// fCreateLogicalsForMissing MUST be run prior to this call
			self.cMissing := fGetMissingLogicals(l.l_cluster,p_environment); 
		end;
		
		dClusters := project(dGetClustersFromFile,xGetClustersFromFile(left));
		
		rVaultFileStatus xNormClusters(dClusters l, rVaultFileStatus r) := transform
			self := r;
		end;
		
		dNormClusters := normalize(dClusters, left.cMissing, xNormClusters(left,right));
		
		return dNormClusters;//output(dNormClusters,,vLocalFilePrefix+'_'+p_environment+'_missing',overwrite);
	end;
	
	// Copy Files that are live in cert (from thor)
	export fCopyFiles() := function
		dFilesToCopy := dGetMissingFromFile('cert')(existsonthor and isupdate);
		
		dops.Layout_filelist xConvertToDOPSLayout(dFilesToCopy l) := transform
			self.name := l.roxiekey;
			self.cmd := '';
			
		end;
	
		dConvertToDOPSLayout := project(dFilesToCopy(roxiekey <> ''),xConvertToDOPSLayout(left));
	
	
		return if (Vault.Constants().vIsHthorCluster
								,if (count(dConvertToDOPSLayout) > 0
												,dops.CopyFiles(
														Vault.Constants().vSourceESP
														,Vault.Constants().vVaultESP
														,Vault.Constants().vSourceDali
														,Vault.Constants().vVaultDali
														,Vault.Constants().vVaultGroup
														,Vault.Constants().vSourceGroups
														,ds := dConvertToDOPSLayout
														,uniquearbitrarystring := p_superfilesuffix
													).Run
												,output('No new files to copy')
											)
								,fail('Run on *hthor* target cluster')		
							);
									
	end;
	
	export fMoveCopiedToCertPreLive() := function
		
		dFilesReadyForStaging := dGetMissingFromFile('cert') : independent;
	
		// this code gets submitted on destination thor
		return 	if (Vault.Constants().vIsHthorCluster and Vault.Constants().vIsCorrectDestination
								,if (count(dFilesReadyForStaging) > 0
									,sequential
									(
									output(dataset([{WORKUNIT}],{string wuid}),,vLocalFilePrefix+'_prelive_moveinprogress',overwrite)
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
									,nothor(apply(global(dFilesReadyForStaging,few),
										sequential
											(
													if ( ~STD.File.superfileexists('~'+superfile+'_'+p_superfilesuffix+'_cert')
															,STD.File.createsuperfile('~'+superfile+'_'+p_superfilesuffix+'_cert'))
													,STD.File.RemoveOwnedSubFiles('~'+superfile+'_'+p_superfilesuffix+'_cert',true)
													,STD.File.clearsuperfile('~'+superfile+'_'+p_superfilesuffix+'_cert')
												)
											))
										
									,nothor(apply(global(dFilesReadyForStaging,few),
										sequential
											(
													if ( ~STD.File.superfileexists('~'+superfile+'_'+p_superfilesuffix+'_cert')
															,STD.File.createsuperfile('~'+superfile+'_'+p_superfilesuffix+'_cert'))
													,if ( ~STD.File.superfileexists('~'+superfile+'_'+p_superfilesuffix+'_prelive')
															,STD.File.createsuperfile('~'+superfile+'_'+p_superfilesuffix+'_prelive'))
													,if (STD.File.fileexists('~'+roxiekey)
														,sequential
																(if (STD.File.FindSuperFileSubname('~'+superfile+'_'+p_superfilesuffix+'_cert','~'+roxiekey) = 0
																	,STD.File.addsuperfile('~'+superfile+'_'+p_superfilesuffix+'_cert','~'+roxiekey))
																,if (STD.File.FindSuperFileSubname('~'+superfile+'_'+p_superfilesuffix+'_prelive','~'+roxiekey) = 0
																	,STD.File.addsuperfile('~'+superfile+'_'+p_superfilesuffix+'_prelive','~'+roxiekey))
																)
														)
												)
											))
									// ,STD.File.DeleteLogicalfile('~'+vLocalFilePrefix+'_cert_missing')
									,STD.File.deletelogicalfile(vLocalFilePrefix+'_prelive_moveinprogress')
									)
									,output('Nothing to Move')
								)
								
							,fail('Run on *hthor* target cluster AND '+ Vault.Constants().vVaultESP)		
						);
								
	end;
	
	export fCopyAndUpdateCertPreLive() := 
				if (Vault.Constants().vIsHthorCluster and Vault.Constants().vIsCorrectDestination
					,if (~STD.File.FileExists(vLocalFilePrefix+'_cert_copyinprogress')
									,sequential
										(
											output(dataset([{WORKUNIT}],{string wuid}),,vLocalFilePrefix+'_cert_copyinprogress',overwrite)
											,output(fCreateLogicalsForMissing('cert'),,vLocalFilePrefix+'_cert_missing',overwrite)
											,fCopyFiles()
											,fMoveCopiedToCertPreLive()
											,STD.File.deletelogicalfile(vLocalFilePrefix+'_cert_copyinprogress')
										)
									,output('copy in progress, '+vLocalFilePrefix+'_cert_copyinprogress not deleted')
							)
					,fail('Run on *hthor* target cluster AND '+ Vault.Constants().vVaultESP)		
					) : failure (sequential(
																STD.File.DeleteLogicalFile(vLocalFilePrefix+'_cert_copyinprogress')
																,STD.File.DeleteLogicalFile(vLocalFilePrefix+'_prelive_moveinprogress')
																,STD.System.Email.SendEmail
																	(
																		Vault.Constants().vReceiveEmail
																		,'[VAULT INGEST FAILURE]: COPY PROCESS'
																		,'ESP:' + Vault.Constants().vSourceESP + '; Workunit: ' + WORKUNIT + '; \r\n' + failmessage
																		,
																		,
																		,Vault.Constants().vSenderEmail
																	)
																));
		
		
	export fMovePreLiveToLive(integer noofgens = 1) := function
		
		dGetFile := dGetMissingFromFile('prod');
		
		rVaultFileStatus xFixIsUpdate(dGetFile l) := transform
			self.isupdate := if ( STD.File.SuperFileExists('~'+l.superfile)
													,if (STD.File.findsuperfilesubname('~'+l.superfile,'~'+l.roxiekey) = 0, true, false)
													,true);
			self := l;
		end;
		
		dFixIsUpdate := project(dGetFile,xFixIsUpdate(left))(isupdate);
		
		dFilesReadyForLive := dGetMissingFromFile('prod');
																	
		return if (Vault.Constants().vIsHthorCluster and Vault.Constants().vIsCorrectDestination
							,if (noofgens in [1,2],
								if (~STD.File.fileexists('~'+vLocalFilePrefix+'_prelive_moveinprogress')
									,sequential
									(
										output(dFixIsUpdate,,vLocalFilePrefix+'_prod_missing_temp',overwrite)
										,STD.File.DeleteLogicalFile(vLocalFilePrefix+'_prod_missing')
										,STD.File.RenameLogicalFile(vLocalFilePrefix+'_prod_missing_temp',vLocalFilePrefix+'_prod_missing')
										,nothor(apply(
											global(dFilesReadyForLive,few) // by this time _prod_missing file will be updated
											,sequential
												(
													if ( ~STD.File.superfileexists('~'+superfile+'_'+p_superfilesuffix+'_prelive')
															,STD.File.createsuperfile('~'+superfile+'_'+p_superfilesuffix+'_prelive'))
													,if ( ~STD.File.superfileexists('~'+superfile)
															,STD.File.createsuperfile('~'+superfile))
													,if ( ~STD.File.superfileexists('~'+superfile+'_'+p_superfilesuffix+'_father')
															,STD.File.createsuperfile('~'+superfile+'_'+p_superfilesuffix+'_father'))
													,if ( ~STD.File.superfileexists('~'+superfile+'_'+p_superfilesuffix+'_delete')
															,STD.File.createsuperfile('~'+superfile+'_'+p_superfilesuffix+'_delete'))
													,if(STD.File.findsuperfilesubname('~'+superfile+'_'+p_superfilesuffix+'_prelive','~'+roxiekey) = 0
															,output('~'+superfile+'_'+p_superfilesuffix+'_prelive doesnt have ~'+roxiekey+' to begin live move')
															,if (STD.File.findsuperfilesubname('~'+superfile,'~'+roxiekey) = 0
																	,sequential
																			(
																				if (cnt = 1,
																					if (noofgens = 2,
																						sequential
																							(STD.File.addsuperfile('~'+superfile+'_'+p_superfilesuffix+'_delete','~'+superfile+'_'+p_superfilesuffix+'_father',,true)
																								,STD.File.clearsuperfile('~'+superfile+'_'+p_superfilesuffix+'_father')
																								,STD.File.addsuperfile('~'+superfile+'_'+p_superfilesuffix+'_father','~'+superfile,,true)
																								,STD.File.clearsuperfile('~'+superfile)
																							),
																							sequential
																							(STD.File.addsuperfile('~'+superfile+'_'+p_superfilesuffix+'_delete','~'+superfile,,true)
																								,STD.File.clearsuperfile('~'+superfile)
																							)
																						)
																					)
																				,if (cnt > 1,
																							if (STD.File.FindSuperFileSubname('~'+superfile,'~'+roxiekey) = 0
																										,STD.File.addsuperfile('~'+superfile,'~'+roxiekey))
																							,sequential
																									(
																										STD.File.clearsuperfile('~'+superfile)
																										,STD.File.addsuperfile('~'+superfile,'~'+roxiekey)
																										)
																								
																						)
																						// remove from prelive
																				,STD.File.removesuperfile('~'+superfile+'_'+p_superfilesuffix+'_prelive','~'+roxiekey)
																				,STD.File.RemoveOwnedSubFiles('~'+superfile+'_'+p_superfilesuffix+'_delete',true)
																				,STD.File.clearsuperfile('~'+superfile+'_'+p_superfilesuffix+'_delete') // have to clear to remove the reference if it is held by another super
																				)
																	,output('~'+superfile+' has '+'~'+roxiekey)
																)
														)
												)
											))
										// attemp to clean/delete files in prelive
										,nothor(apply(global(dFilesReadyForLive,few),
												sequential
														(
														if ( ~STD.File.superfileexists('~'+superfile+'_'+p_superfilesuffix+'_prelive')
																,STD.File.createsuperfile('~'+superfile+'_'+p_superfilesuffix+'_prelive'))
														,if (STD.File.findsuperfilesubname('~'+superfile,'~'+roxiekey) > 0
															,	// remove from prelive just in case remove didn't happen in previous clear
																		STD.File.removesuperfile('~'+superfile+'_'+p_superfilesuffix+'_prelive','~'+roxiekey))
														,STD.File.RemoveOwnedSubfiles('~'+superfile+'_'+p_superfilesuffix+'_prelive',true)
														// don't clear out prelive because after copy finishes an attempt is
														// made to clear _cert (delete files) and it is not held in _prelive then
														// the file will be deleted
																	)
															)
													)
											)
										
									,output('Move to cert/prelive in progress, '+vLocalFilePrefix+'_prelive_moveinprogress is not cleared.')
								),
								fail('noofgens value should be [1,2]')
							)
							
						,fail('Run on *hthor* target cluster AND '+ Vault.Constants().vVaultESP)		
					);
									
		
	end;
	
	export fExecuteVaultAttributes() := function
			return if( Vault.Constants().vIsCorrectDestination
							,apply(
									dedup(sort(dGetMissingFromFile('prod')(isupdate),attributename),attributename)
									,output(dops.WorkUnitModule(Vault.Constants().vVaultESP,p_port).fSubmitNewWorkunit(
																	'#workunit(\'name\',\'[VAULT INGEST]: '+ attributename +'\');\r\n'+
																	'if (~STD.File.FileExists(\'~'+superfile+'_vaultflag\'),sequential\r\n'+
																				'(\r\n'+
																					'output(dataset([],{string field1}),,\'~'+superfile+'_vaultflag\',overwrite)\r\n'+
																						',output('+attributename+')\r\n'+
																						',STD.File.DeleteLogicalFile(\'~'+superfile+'_vaultflag\')\r\n'+
																						// ',' + fGetStringToSpawnWU(superfile,attributename,'delete',Vault.Constants().vVaultHthorCluster) + '\r\n'+
																						'))\r\n' + 
																						' : failure(\r\n' +
												'sequential \r\n'+
														'(\r\n'+
															'STD.File.DeleteLogicalFile(\'~'+superfile+'_vaultflag\'),\r\n'
															+'STD.System.Email.SendEmail(\r\n'
															+					'\''+Vault.Constants().vSenderEmail+ '\'\r\n'
																+				',\'[VAULT INGEST FAILURE]:' + attributename + '\'\r\n'
																	+			',\' ESP:' + Vault.Constants().vVaultESP + '; Workunit: \'' + ' + WORKUNIT +' + '\';\'' + '+ failmessage\r\n'
																		+		',\r\n'
																			+	',\r\n'
																			+	',\'' + Vault.Constants().vReceiveEmail + '\'\r\n'
																			+')));',Vault.Constants().vVaultTargetCluster)))
								,fail('Submit the job on ' + Vault.Constants().vVaultESP)
							);
								
	end;
	//////////////////////////////////////////////////////////
	
	// Spawns job to execute
	// fMovePreLiveToLive()
	// fExecuteVaultAttributes()
	export fUpdateProdAndExecuteAttributes() := 
								if (Vault.Constants().vIsHthorCluster and Vault.Constants().vIsCorrectDestination
											,sequential(
													output(fCreateLogicalsForMissing('prod'),,vLocalFilePrefix+'_prod_missing',overwrite)
													,fMovePreLiveToLive()
													,fExecuteVaultAttributes()
												)
											,fail('Run on *hthor* target cluster AND '+ Vault.Constants().vVaultESP)		
										);
	
	
	///////////////////// FUNCTIONS AND CALLERS /////////////////////////////////
	
end;