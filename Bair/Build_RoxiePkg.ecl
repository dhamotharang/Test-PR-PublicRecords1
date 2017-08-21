import pkgfile, _Control;

EXPORT Build_RoxiePkg(
			 string clustername = ''
			,string env				= 'qa'
			,string	version		= ''
			,string pMode			= ''
			,DATASET(pkgfile.layouts.flat_layouts.FileRecord) KeyDS
			) := module
			
			EXPORT isFull 					:= if (stringlib.StringToUpperCase(pMode) in ['WEEKLY'], true, false);
			EXPORT isNonBooleanPkg	:= if(count(KeyDS((packageid in ['BairPublicSafetyKeys', 'BairCompositeDeltaKeys', 'BairCompositeFullKeys']))) > 1, true, false);
			
			EXPORT pkgfiles_mod := pkgfile.files('flat', clustername);
			
			ReplacePkgVersion(DATASET(pkgfile.layouts.flat_layouts.packageid) ds_in, string oldVer, string newVer) := FUNCTION
				return project(ds_in, 
					transform(pkgfile.layouts.flat_layouts.packageid
						, self.subfilevalue := if(regexfind('bair::geohash', left.subfilevalue), left.subfilevalue, regexreplace(oldVer, left.subfilevalue, newVer))
						, self := left;));
			END;
					
			BooleanFullVers		:= dataset(bair.Superfile_List().BooleanFullBuilt, {string Ver}, flat, opt);
			NonBooleanFullVers	:= dataset(bair.Superfile_List().NonBooleanFullBuilt, {string Ver}, flat, opt);
			
			BooleanKeys			:= pkgfiles_mod.getflatpackage(id in ['BairBooleanKeys', 'BairDeltaKeys', 'BairNightlyWeeklyKeys', 'BairWeeklyKeys']);
			NonBooleanKeys	:= pkgfiles_mod.getflatpackage(id not in ['BairBooleanKeys', 'BairDeltaKeys', 'BairNightlyWeeklyKeys', 'BairWeeklyKeys']);
			

			isLastFullPkgBoolean := dataset(bair.Superfile_List().LastFullPkgType, bair.layouts.rLastFullPkgType, flat)[1].BooleanPkg;
			
			flatpkg 	:= if(isLastFullPkgBoolean, BooleanKeys, NonBooleanKeys);			
			fullVers 	:= if(isLastFullPkgBoolean, BooleanFullVers, NonBooleanFullVers);
			
			EXPORT InitPkg := if(not isFull									
														,if (count(fileservices.RemoteDirectory(Bair.PackageFileConstants(env, true).packageip, Bair.PackageFileConstants(env, true).fulldeploylocation)) = 0 
														and count(fileservices.RemoteDirectory(Bair.PackageFileConstants(env, true).packageip, Bair.PackageFileConstants(env, true).switchfulllocation)) = 0
																//no full is running
																,if (count(flatpkg(regexfind(fullVers[1].Ver, subfilevalue) = true)) = 0
																		,sequential(
																			 output('no full pkg is deploying currently')
																			,output(ReplacePkgVersion(flatpkg, fullVers[2].Ver, fullVers[1].Ver) + if(isLastFullPkgBoolean, NonBooleanKeys, BooleanKeys),,pkgfiles_mod.pfile + version + if(isLastFullPkgBoolean,'_Boolean_NFR', '_NonBoolean_NFR'), overwrite)
																			,pkgfile.Promote(clustername).backup('flat')
																			,fileservices.addsuperfile(pkgfiles_mod.pfile, pkgfiles_mod.pfile + version + if(isLastFullPkgBoolean,'_Boolean_NFR', '_NonBoolean_NFR'))
																			)
																	)
																,if (count(flatpkg(regexfind(fullVers[2].Ver, subfilevalue) = true)) = 0
																		,sequential(
																			 output(if(isLastFullPkgBoolean, 'Boolean', 'Non Boolean') + ' full pkg is deploying currently')
																			,output(ReplacePkgVersion(flatpkg, fullVers[1].Ver, fullVers[2].Ver) + if(isLastFullPkgBoolean, NonBooleanKeys, BooleanKeys),,pkgfiles_mod.pfile + version + if(isLastFullPkgBoolean,'_Boolean_FR', '_NonBoolean_FR'), overwrite)
																			,pkgfile.Promote(clustername).backup('flat')
																			,fileservices.addsuperfile(pkgfiles_mod.pfile, pkgfiles_mod.pfile + version + if(isLastFullPkgBoolean,'_Boolean_FR', '_NonBoolean_FR'))
																			)
																	)
															)
															,if(isNonBooleanPkg and count(pkgfiles_mod.getflatpackage(regexfind(BooleanFullVers[1].Ver, subfilevalue) = true)) = 0
																,sequential(
																	 output(ReplacePkgVersion(pkgfiles_mod.getflatpackage(), BooleanFullVers[2].Ver, BooleanFullVers[1].Ver),,pkgfiles_mod.pfile + version + '_Boolean_CurrentVersion', overwrite)
																	,pkgfile.Promote(clustername).backup('flat')
																	,fileservices.addsuperfile(pkgfiles_mod.pfile, pkgfiles_mod.pfile + version + '_Boolean_CurrentVersion')
																	)
															)
													);
			
			EXPORT PackageDS := KeyDS;
			
			EXPORT pkgVersion := version + if(isNonBooleanPkg, '_NonBoolean', '_Boolean') + if(isFull, '_f', '_d');
			
			KeyCount := count(KeyDS);
			FS:=fileservices;

			t:=table(KeyDS
				,{packageid
				,missing_keys:=subfile
				,does_key_exist:=FS.FileExists('~'+subfile)
				,superfile
				,last_key_added_in_superfile:=FS.SuperFileContents('~'+superfile)(regexfind('qa',name))[1].name
			});

			t1:=nothor(t);			

			EXPORT VerifyKeys := map(
							count(t1(does_key_exist=true))<>KeyCount =>
								if(Stringlib.StringToUpperCase(pMode) = 'NIGHTLY'
									,fail('ERROR: SOME KEYS ARE MISSING IN NIGHTLY PACKAGE - NIGHTLY_MissingKeys')
									,fail('ERROR: SOME KEYS ARE MISSING IN WEEKLY PACKAGE - WEEKLY_MissingKeys')
									)
							);
							
			export _AddKeys 		 := Bair.RoxiePackageModule(pkgVersion,clustername).AddKeys(PackageDS);
			export GetFlatFileDS := pkgfiles_mod.getflatpackage;
			
			export pkg_all := sequential(
								InitPkg,
								VerifyKeys,
								_AddKeys,
								Bair.RoxiePackageModule(pkgVersion,clustername).PrepPackage,
								Bair.RoxiePackageModule(pkgVersion,clustername).GetPackageToDeployLocation(Bair.PackageFileConstants(env).packageip,Bair.PackageFileConstants(env, isFull).switchlocation) // use this ONLY when you are ready for package deployment);
								);

			Filter:=[
							'BairServices.IncidentIDSearchService'
							];//add to this set to filter queries that are to be added to QA onl
							// remove from this set queries that are to be added to prod

			QueryDS_ := dataset([
								{'BairServices.CFSSearchService','1','true',''},
								{'BairServices.CFSReportService','1','true',''},
								{'BairServices.CrashReportService','1','true',''},
								{'BairServices.CrashSearchService','1','true',''},
								{'BairServices.EventReportService','1','true',''},
								{'BairServices.EventSearchService','1','true',''},
								{'BairServices.IntelReportService','1','true',''},
								{'BairServices.IntelSearchService','1','true',''},
								{'BairServices.ImageService','1','true',''},
								{'BairServices.MapIncidentSearchService','1','true',''},
								{'BairServices.OffenderSearchService','1','true',''},
								{'BairServices.ShotSpotterSearchService','1','true',''},
								{'BairServices.LPRSearchService','1','true',''},
								{'BairServices.ClassificationService','1','true',''},
								{'BairServices.EventSlimSearchService','1','true',''},
								{'bairservices.echoservice','1','true',''},
								{'BairServices.PersonSearchService','1','true',''},
								{'BairServices.PersonReportService','1','true',''},
								{'BairServices.VehicleSearchService','1','true',''},
								{'BairServices.PhoneSearchService','1','true',''},
								{'BairServices.IncidentIDSearchService','1','true',''},								
								{'BairServices.MapIncidentSearchService','1','true',''},
								{'BairServices.LayerGroupSearchService','1','true',''},
								{'BairServices.LayerTextService','1','true',''}
								],pkgfile.layouts.flat_layouts.queries);
								
			QueryDS_CertOnly := dataset([
								{'bair_externallinkkeys.ps_header_service','1','true',''},
								{'Bair_ExternalLinkKeys_V2.PS_Header_Service','1','true',''}
								],pkgfile.layouts.flat_layouts.queries);

			
			QueryDS := if(clustername = 'bair-qa', QueryDS_ + QueryDS_CertOnly, QueryDS_);
			
			export pkg_AddQueries := Bair.RoxiePackageModule(pkgVersion,clustername).AddQueries(QueryDS);// -- run this separately in a builder window DO NOT run this as a part of build process

	end;