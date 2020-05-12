import STD,DOPS;
EXPORT mdRoxiePackage(
											string pScopeName = 'uspr'
											,string pProductName = 'ramps'
											,string pProcessName = 'packageupdate'
											,boolean isRefresh = false
											) := module
	////// LOCAL VARIABLES ///////
	// roxie variables
	shared vProdESP := '10.173.10.159'; // change to true prod when live
	shared vCertESP := '10.173.10.157';
	shared vProdTargetCluster := 'roxie';
	shared vCertTargetCluster := 'roxie';
	shared vProdProcess := 'roxie1';
	shared vCertProcess := 'roxie1';
	shared vSourceDali := '10.173.10.157';
	shared vDefaultPackageMapName := 'roxie::hipie';
	
	shared rRoxie := record
		string clustername := '';
		string envname := '';
		string esp := '';
		string vip := '';
		string roxiecluster := '';
	end;
	
	shared dRoxieEnvs := dataset([{'nonfcra','prod'}]
															,{rRoxie - [esp,vip,roxiecluster]});
	
	// thor variables
	shared vNoOfFileBackups := 10;
	shared vFilePrefix := '~'+pScopeName+'::'+pProductName+'::base::'+pProcessName;
	
	// process and common variables
	shared vPort := '8010';
	shared vDateTime := (string)STD.Date.Today() + (string)STD.Date.CurrentTime() : independent;
	
	////// END LOCAL VARIABLES ///////
	
	export fPopulateESPsVIPs() := function

		rStringField := record
			string stringfield := '';
		end;
		
		rRoxieAdded := record
			rRoxie;
			dataset(rStringField) esps;
		end;
		
		rRoxieAdded xGetESPsVIPs(dRoxieEnvs l) := transform
			self.vip := dops.constants.vRoxieVIP(l.clustername,l.envname);
			self.esps := dataset(dops.constants.vESPSet(l.clustername,l.envname),rStringField);
			self := l;
		end;
		
		dGetESPsVIPs := project(dRoxieEnvs, xGetESPsVIPs(left));
		
		rRoxie xNormESPs(dGetESPsVIPs l, rStringField r) := transform
			self.esp := r.stringfield;
			self.roxiecluster := dops.GetClusterInfo(r.stringfield,clustertype := 'RoxieCluster').LiveCluster(l.vip);
			self := l;
		end;
		
		dNormESPs := dedup(normalize(dGetESPsVIPs,left.esps,xNormESPs(left,right))(roxiecluster <> ''),clustername,envname,keep(1));
		
		return dNormESPs;
	end;
	
	// Function: fSuperFileTransaction
	// ParentModule: mdRoxiePackage
	// Parameters:
	//			pfilename - base file name used to perform transactions
	//			pdatetime - defaults to vDateTime (inhouse)
	//			pholdbackups - whether to hold backups or not
	// Purpose: 
	//			Creates pfilename, pfilename_delete/hold supers if it doesn't exist	
	//			Move files into super mention and hold backupis if pholdbackups is true
	shared fSuperFileTransaction(
														string pfilename
														,string pdatetime = vDateTime
														,boolean pholdbackups = false
														) := function
		
		return sequential
							(
								if (~STD.File.SuperFileExists(pfilename)
									,STD.File.CreateSuperFile(pfilename))
								,if (~STD.File.SuperFileExists(pfilename+'_delete')
									,STD.File.CreateSuperFile(pfilename+'_delete'))
								,if (~STD.File.SuperFileExists(pfilename+'_hold') and pholdbackups
									,STD.File.CreateSuperFile(pfilename+'_hold'))
								,if (STD.File.FindSuperFileSubname(pfilename,pfilename+'_'+pdatetime) = 0
									 ,sequential
											(
												if (pholdbackups
													,STD.File.AddSuperFile(pfilename+'_hold',pfilename,,true)
													,STD.File.AddSuperFile(pfilename+'_delete',pfilename,,true)
												)
												,STD.File.ClearSuperFile(pfilename)
												,STD.File.AddSuperFile(pfilename,pfilename+'_'+pdatetime)
												,if (pholdbackups
													,if ( STD.File.GetSuperFileSubCount(pfilename+'_hold') > vNoOfFileBackups
																,sequential
																(
																	STD.File.AddSuperFile(pfilename+'_delete','~'+STD.File.GetSuperFileSubName(pfilename+'_hold',1))
																	,STD.File.RemoveSuperFile(pfilename+'_hold','~'+STD.File.GetSuperFileSubName(pfilename+'_hold',1))
																)
															)
														)
												,STD.File.RemoveOwnedSubFiles(pfilename+'_delete',true)
													
											)
									)
							);
		
	end;
	
	
	// ModuleName: mdBackupPackageMaps
	// Parameters: Roxie ESP, Roxie Port, Roxie PackageMap Name, No of backups to hold (defauls to vNoOfFileBackups := 10)
	// Functions and variables: 
	//		vGetBackupFileName - get filename associated to the function
	//		fBackup() - Backups up the current active package file on thor
	export mdBackupPackageMaps(
															string pRoxieESP = vProdESP
															,string pRoxiePort = vPort
															,string pRoxieProcess = vProdProcess
															,string pRoxieCluster = vProdTargetCluster
															,string pRoxiePackageMapName = vDefaultPackageMapName
															,integer noofbackups = vNoOfFileBackups
															) := module
				
		// local variable to get file name associated to module_function
		shared vGetBackupFileName := vFilePrefix + '::mdBackupPackageMaps_fBackup';

		// Function: fBackupPackageFile
		// ParentModule: mdBackupPackageMaps
		// Parameters: <derived from module parameteres>
		// Purpose: Backup PackageMaps
		//					Get the current active packagemap
		//					Stores in file as dataset/record
		// Uses: dops.GetRoxiePackage().fGetXMLPackageAsString(), fSuperFileTransaction()
		export fBackup() := function
			dGetPackageAsXMLString := dops.GetRoxiePackage(pRoxieESP
																										,pRoxiePort
																										,pRoxieCluster
																										,pRoxieProcess).fGetXMLPackageAsString(pPackageMapName := vDefaultPackageMapName);
																										
			return sequential
										(
											output(dGetPackageAsXMLString,,vGetBackupFileName+'_'+vDateTime,overwrite,named('backup_current_active_package'))
											,fSuperFileTransaction(vGetBackupFileName,pholdbackups := true)
										);
		end;
		
		// Dataset Definition
		// Get the content of last backed up package file
		export dGetBackedUpPackageMapContent := 
							dataset(
												vGetBackupFileName
												,dops.GetRoxiePackage('','','').rPackageFile
												,thor
												,opt
											);
	end;
	
	// ModuleName: mdDatasets
	// Parameters: NA
	// Functions and variables: 
	//		vDOPSDatasetNames - holds list/set of all datasets from DOPS system (Public Records)
	//		dDOPSDatasetNames - dataset of the above set
	//		vGetConvetDSToPipeFileName - File name that holds the datasets in a field that is pipe delimited
	//		fConvertDSToPipeDelString() - Convert multiple records with dataset name in each record to
	//																	one record with a field that holds all dataset names delimited by pipe
	//		sGetDSAsPipeDelString - string that holds PR datasets needed for update in pipe-delimited format
	export mdDatasets() := module
		// Variable: vDOPSDatasetNames
		// Type: set
		// contains list of all dataset names used in PR
		// Used in: dDOPSDatasetNames
		export vDOPSDatasetNames := [
																	'FraudGovKeys'
																];
		
		// Variable: dDOPSDatasetNames
		// Type: dataset
		// dataset of all dataset names used in PR
		// Used in: fConvertDSToPipeDelString()
		shared dDOPSDatasetNames := dataset(vDOPSDatasetNames,{string dnames});

		// Variable: vGetConvetDSToPipeFileName
		// Type: string
		// filename to hold the responses from fConvertDSToPipeDelString()
		// Used in: sGetDSAsPipeDelString
		shared vGetConvetDSToPipeFileName := vFilePrefix + '::mdDatasets_fConvertDSToPipeDelString';
		
		// Variable: rPipeDelimited
		// Type: record set
		// record set for vGetConvetDSToPipeFileName
		// Used in: fConvertDSToPipeDelString(), sGetDSAsPipeDelString
		shared rPipeDelimited := record
			string dField := '1';
			string dName := '';
		end;

		// Function: fConvertDSToPipeDelString
		// ParentModule: mdDatasets
		// Parameters: NA
		// Purpose: roll up all rows into 1 and makes the dName field pipe delimited
		//					hold 1 version of the file that holds the above data
		// Uses: fSuperFileTransaction()
		// Used in: RunDeploy (action)
		export fConvertDSToPipeDelString() := function

			rPipeDelimited xConvertDS(dDOPSDatasetNames l) := transform
				self.dName := regexreplace('keys$',l.dnames,'',nocase);
				self := l;
			end;

			dConvertSetToDS := project(dDOPSDatasetNames,xConvertDS(left));

			rPipeDelimited xRollup(dConvertSetToDS l, dConvertSetToDS  r) := transform
				self.dName := l.DName + '|' + r.DName;
				self := l;
			end;

			dRollup := rollup(dConvertSetToDS
									,dField
										,xRollup(left,right));
										
			return sequential
										(
											output(dRollup,,vGetConvetDSToPipeFileName+'_'+vDateTime,overwrite,named('list_of_pr_datasets'))
											,fSuperFileTransaction(vGetConvetDSToPipeFileName)
										);
		end;
		
		// Variable: sGetDSAsPipeDelString
		// Type: string
		// contains the list of dataset names that are pipe delimited so it can be easily used in 
		// regex pattern matching
		// Used in: mdPackageUpdates().fGetPRChanges()
		export sGetDSAsPipeDelString := 
							dataset(
												vGetConvetDSToPipeFileName
												,rPipeDelimited
												,thor
												,opt
											)[1].dName;
		
	end;
	
	
	// ModuleName: mdPRChanges
	// Parameters: Roxie ESP, Roxie Port, Roxie PackageMap Name, No of backups to hold (defauls to vNoOfFileBackups := 10)
	// Functions and variables: 
	//		vGetBackupFileName - get filename associated to the function
	//		fBackup() - Backups up the current active package file on thor
	export mdPRChanges() := module
				
		// local variable to get file name associated to module_function
		shared vGetPRChangesFileName := vFilePrefix + '::mdPRChanges_fCapturePRChanges';
		
		shared rPRChanges := record
			rRoxie;
			string packageid := '';
			string superfile := '';
			string subfile := '';
			boolean ischanged := false;
		end;
		
		export dGetLocalKeys := if (isRefresh
																	,dataset([],rPRChanges)
																	,dataset(
																				vGetPRChangesFileName
																				,rPRChanges
																				,thor
																				,opt
																				)
																);
		
		export fCapturePRChanges() := function
			dPackageVIPs := fPopulateESPsVIPs();
			
			rPRChangesAdded := record
				rPRChanges;
				dataset(dops.GetRoxiePackage('','','').rPackageKeyInfo) keysfromroxie;
			end;
			
			rPRChangesAdded xGetKeysFromRoxie(dPackageVIPs l) := transform
				self.keysfromroxie := dops.GetRoxiePackage(l.esp
																										,vPort
																										,l.roxiecluster).Keys()(packageid in (mdDatasets().vDOPSDatasetNames));
				self := l;
			end;
			
			dGetKeysFromRoxie := project(dPackageVIPs,xGetKeysFromRoxie(left));
			
			rPRChanges xNormKeys(dGetKeysFromRoxie l, dops.GetRoxiePackage('','','').rPackageKeyInfo r) := transform
				self.packageid := r.packageid;
				self.superfile := r.superfile;
				self.subfile := r.subfile;
				self := l;
				
			end;
			
			dNormKeys  := sort(normalize(dGetKeysFromRoxie, left.keysfromroxie,xNormKeys(left,right)),clustername,envname,packageid,superfile,subfile);
			
			rPRChanges xGetIsChanged(dNormKeys l, dGetLocalKeys r) := transform
				self.isChanged := if (l.subfile <> r.subfile, true, false);
				self := l;
			end;
			
			dGetIsChanged := join(dNormKeys
														,sort(dGetLocalKeys,clustername,envname,packageid,superfile,subfile)
														,left.packageid = right.packageid
															and left.superfile = right.superfile
														,xGetIsChanged(left,right)
														,left outer
													);
													
			return dGetIsChanged;
		end;
		
		export bIsChanged := count(fCapturePRChanges()(ischanged)) > 0;
		
		export fStorePRChanges() := function
			return sequential
										(
											if (isRefresh
												,if (STD.File.SuperFileExists(vGetPRChangesFileName)
														,STD.File.RemoveOwnedSubFiles(vGetPRChangesFileName,true)
														)
												)
											,output(fCapturePRChanges(),,vGetPRChangesFileName+'_'+vDateTime,overwrite,named('pr_changes'))
											,fSuperFileTransaction(vGetPRChangesFileName)
										);
			
		end;
		
	end;
	
	// ModuleName: mdPackageUpdates
	// Parameters: NA
	// Functions and variables: 
	//		vUpdatePackageFileName - file name for fUpdatePackageForPRDatasets function output
	//		vValidatePackageFileName - file name for fValidatePackageFile function output
	//		dGetPackageChanges - dataset that shows the changes
	//		fGetPRChanges() - function to get list of all indexes that changed that are associated to 
	//											mdDatasets().sGetDSAsPipeDelString
	//		fUpdatePackageForPRDatasets(): Update the package content 
	export mdPackageUpdates(string pESPToUpdate = vProdESP
															,string pPortToUpdate = vPort
															,string pTargetToUpdate = vProdTargetCluster
															,string pProcessToUpdate = vProdProcess
															,string pESPToCompare = vCertESP
															,string pPortToCompare = vPort
															,string pTargetToCompare = vCertTargetCluster
															,string pProcessToCompare = vCertProcess
															,string pSourceDali = vSourceDali) := module
		// Variable: vGetPRChanges
		// Type: string
		// Used in: fGetPRChanges()
		shared vGetPRChanges := vFilePrefix + '::mdPackageUpdates_fGetPRChanges';
		// Variable: vUpdatePackageFileName
		// Type: string
		// Used in: fUpdatePackageForPRDatasets()
		shared vUpdatePackageFileName := vFilePrefix + '::mdPackageUpdates_fUpdatePackageForPRDatasets';
		// Variable: vUpdatePackageFileName
		// Type: string
		// Used in: fValidatePackageFile()
		shared vValidatePackageFileName := vFilePrefix + '::mdPackageUpdates_fValidatePackageFile';
		// Variable: vDeployPackageFileName
		// Type: string
		// Used in: fDeployPackage()
		shared vDeployPackageFileName := vFilePrefix + '::mdPackageUpdates_fDeployPackage';
		// Variable: dGetPackageChanges
		// Type: dataset
		// Used in: fGetPRChanges()
		// Uses: dops.mdComparePackages().fCaptureChanges()
		// Purpose: capture all changes from vCertESP by comparing the package file content from vProdESP
		export dGetPackageChanges := dops.mdComparePackages(pCompareESP := pESPToCompare
											,pCompareTarget := pTargetToCompare
											,pCompareProcess := pProcessToCompare
											,pUpdateESP := pESPToUpdate
											,pUpdateTarget := pTargetToUpdate
											,pUpdateProcess := pProcessToUpdate).fCaptureChanges();
		
		// Variable: dGetPRChanges
		// Type: dataset
		// Used in: fUpdatePackageForPRDatasets()
		// Uses: dops.mdComparePackages().rCaptureChanges
		// Purpose: in dGetPackageChanges isChanged flag is set to true for all changes
		//						, BUT dGetPRChanges isChanged flag is set to ONLY for PR related datasets/keys
		export dGetRampsPRChanges := 
							dataset(
												vGetPRChanges
												,dops.mdComparePackages(pCompareESP := ''
																					,pCompareTarget := ''
																					,pUpdateESP := ''
																					,pUpdateTarget := '').rCaptureChanges
												,thor
												,opt
											);
		
		// Function: fGetPRChanges
		// ParentModule: mdPackageUpdates
		// Parameters: NA
		// Purpose: Use dGetPackageChanges and mark isChanged = true ONLY for datasets/Keys related to PR mentioned
		// 					in mdDatasets().sGetDSAsPipeDelString and store the information in vGetPRChanges superfile
		// Uses: fSuperFileTransaction(), dGetPackageChanges, mdDatasets().sGetDSAsPipeDelString
		// Used in: RunDeploy (action)
		export fGetRampsPRChanges() := function
			typeof(dGetPackageChanges) xUpdatePackageForPR(dGetPackageChanges l) := transform
				self.isChanged := if (l.isChanged and regexfind('('+mdDatasets().sGetDSAsPipeDelString+')',l.subfile,nocase)
																,true
																,false);
				self := l;
			end;

			dUpdatePackageForPR := project(dGetPackageChanges,xUpdatePackageForPR(left));
			
			return dUpdatePackageForPR;
		end;
		
		export bIsRampsChanged := count(fGetRampsPRChanges()(ischanged)) > 0;
		
		export fStoreRampsPRChanges() := function
			
			return sequential
										(
											output(fGetRampsPRChanges(),,vGetPRChanges+'_'+vDateTime,overwrite,named('ramps_index_changes'))
											,fSuperFileTransaction(vGetPRChanges)
										);
								
			
		end;
		
		// Function: fUpdatePackageForPRDatasets
		// ParentModule: mdPackageUpdates
		// Parameters: NA
		// Purpose: Apply the changes to package in vCertESP determined in dGetPRChanges and 
		//					output the new dataset with changes to vUpdatePackageFileName
		// Uses: fSuperFileTransaction(), dops.mdComparePackages().fGetUpdatedPackageAsDataset, dGetPRChanges
		// Used in: RunDeploy (action)
		export fUpdatePackageForPRDatasets() := function
			
			return sequential
										(
											output(dops.mdComparePackages(pCompareESP := pESPToCompare
																									,pCompareTarget := pTargetToCompare
																									,pCompareProcess := pProcessToCompare
																									,pUpdateESP := pESPToUpdate
																									,pUpdateTarget := pTargetToUpdate
																									,pUpdateProcess := pProcessToUpdate).fGetUpdatedPackageAsDataset(dGetRampsPRChanges)
																	,,vUpdatePackageFileName+'_'+vDateTime,overwrite,named('updated_ramps_package_as_dataset'))
											,fSuperFileTransaction(vUpdatePackageFileName)
										);
			
		end;
		
		// Variable: dGetUpdatedPackage
		// Type: dataset
		// Used in: sPackageXML
		// Uses: dops.GetRoxiePackage().fGetXMLPackageAsString
		// Purpose: hold package updates
		export dGetUpdatedPackage := 
							dataset(
												vUpdatePackageFileName
												,dops.GetRoxiePackage('','','').rPackageKeyInfoWithQueries
												,thor
												,opt
											);
											
		// Variable: dGetUpdatedPackage
		// Type: string
		// Used in: fValidatePackageFile(), fDeployPackage()
		// Uses: dops.GetRoxiePackage().fGetXMLPackageAsString
		// Purpose: hold package updates
		export sPackageXML := '<RoxiePackages>' + dops.GetRoxiePackage('','','').fGetXMLPackageAsString
																														(dGetUpdatedPackage
																														,pPackageMapName := vDefaultPackageMapName)[1].packagexmlasstring
																					+ '</RoxiePackages>';

		// Function: fValidatePackageFile
		// ParentModule: mdPackageUpdates
		// Parameters: NA
		// Purpose: Validate the new updated packagemap in vProdESP (soapcall to esp service validatepackage) and store the  
		//					output the in vValidatePackageFileName
		// Uses: fSuperFileTransaction(), dops.PackageFile().ValidatePackage(), sPackageXML
		// Used in: RunDeploy (action)
		export fValidatePackageFile() := function
			dGetValidateResponse := dops.PackageFile(pESPToUpdate,pPortToUpdate).ValidatePackage(vDefaultPackageMapName
											,sPackageXML
											,vProdTargetCluster);
			return sequential
										(
											output(dGetValidateResponse
																	,,vValidatePackageFileName+'_'+vDateTime,overwrite,named('validate_package_response'))
											,fSuperFileTransaction(vValidatePackageFileName)
										);
		end;
		
		// Variable: dGetValidatePackage
		// Type: dataset
		// Used in: RunDeploy (action)
		// Uses: dops.PackageResponseLayouts.rValidatePackageResponse
		// Purpose: holds the response from fValidatePackageFile() soapcall
		export dGetValidatePackage := 
							dataset(
												vValidatePackageFileName
												,dops.PackageResponseLayouts.rValidatePackageResponse
												,thor
												,opt
											);

		export bisValidationErrors := count(dGetValidatePackage(count(errors) > 0 or count(exceptions) > 0)) > 0;

		// Function: fDeployPackage
		// ParentModule: mdPackageUpdates
		// Parameters: NA
		// Purpose: Deploy/Add the new packagemap to vProdESP and store the response in vDeployPackage
		// Uses: fSuperFileTransaction(), dops.PackageFile().AddPackage(), sPackageXML
		// Used in: RunDeploy (action)
		export fDeployPackage() := function
		
			dDeployPackage := dops.PackageFile(pESPToUpdate,pPortToUpdate).AddPackage
																				(
																					packagemap := vDefaultPackageMapName
																					,roxietarget := pTargetToUpdate
																					,daliip := pSourceDali
																					,xmlcontent := sPackageXML
																					,replacepackagemap := '1'
																					,activate := '1'
																				);
			return sequential
										(
											output(dDeployPackage
																	,,vDeployPackageFileName+'_'+vDateTime,overwrite,named('deploy_package_response'))
											,fSuperFileTransaction(vDeployPackageFileName)
										);
		end;
		
		// Variable: dGetAddPackage
		// Type: dataset
		// Used in: RunDeploy (action)
		// Uses: dops.PackageResponseLayouts.rAddPackageResponse
		// Purpose: holds the response from fDeployPackage() soapcall
		export dGetAddPackage := 
							dataset(
												vDeployPackageFileName
												,dops.PackageResponseLayouts.rAddPackageResponse
												,thor
												,opt
											);
		
	end;
	
	// Action: RunDeploy
	// ParentModule: mdRoxiePackage
	// Parameters: NA
	// Purpose: 
	//				1. Checks to see if the PR is updated for PR datasets listed in mdDatasets().vDOPSDatasetname
	//				2. if there is an update
	//							a. backup the current packagemap in vProdESP
	//							b. Convert the set of PR datasets into dataset
	//							c. Get PR changes
	//							d. Update PR changes and store in dataset
	//							e. Validate new package with update
	//							f. if errors in validation, stop and send email
	//							g. if no errors in validation, deploy package
	//							h. if no errors in deployment, send email upon successful deployment
	//							i. if errors in deployment, rollback to previous package and redeploy and send email
	export RunDeploy := if (mdPRChanges().bIsChanged
														,sequential
															(
																mdPRChanges().fStorePRChanges()
																,mdBackupPackageMaps().fBackup()
																,mdDatasets().fConvertDSToPipeDelString()
																,if (mdPackageUpdates().bIsRampsChanged
																		,sequential
																		(
																			mdPackageUpdates().fStoreRampsPRChanges()
																			,mdPackageUpdates().fUpdatePackageForPRDatasets()
																			,mdPackageUpdates().fValidatePackageFile()
																			,if (mdPackageUpdates().bisValidationErrors
																					,output(mdPackageUpdates().dGetValidatePackage,named('Validation_errors'))
																					,output('No errors')
																					//,mdPackageUpdates().fDeployPackage()
																					)
																		)
																		,output('No changes in ramps hipie indexes')
																)
														)
													,output('No changes in PR prod')
												);
												
	
end;