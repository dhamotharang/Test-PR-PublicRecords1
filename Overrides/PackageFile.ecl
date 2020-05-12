import dops, pkgfile;

EXPORT PackageFile(string queryname
														,string targetcluster
														,string roxieesp
														,string buildversion // override build version
														,string packagecluster = 'overrideoneway'
														,string roxieport = '8010') := module
		
		export NonOverrideKeys := 'NonOverrideKeys';
		export ThorDali := '10.241.12.201';//'10.173.44.105';
		export CertRoxieDali := '10.239.196.104';//'10.173.235.23';
		export OverrideKeys := 'FCRA_OverrideKeys';
		export certroxieesp := '10.239.196.101';//'10.173.235.22';
		export certroxietargetcluster := 'roxie_196_dataland';
				
		///////////////// BUILDING PACKAGE FILE ///////////////////
		///////////////// BUILDING PACKAGE FILE ///////////////////
		///////////////// BUILDING PACKAGE FILE ///////////////////
		export dQueriesForPackage := 
					dataset([
								{queryname,'1','true',''}],pkgfile.layouts.flat_layouts.queries);
					
		export ConvertToPkglayout() := function
			dFromRoxie := dops.PackageFile(certroxieesp,roxieport).GetKeysByQueryFromRoxie(queryname
																									,certroxietargetcluster);
				
			dKeysFromDOPS := dops.GetRoxieKeys(OverrideKeys
																					,'B'
																					,'F'
																					,
																					,
																					,'prod'
																				);
			
			pkgfile.layouts.flat_layouts.FileRecord xConvertToPkgLayout(dFromRoxie l, dKeysFromDOPS r) := transform
				self.packageid := NonOverrideKeys;
				self.superfile := l.superfile;
				self.subfile :=  l.subfile;
				self.isfullreplace := false;
				self.isdeltareplace := false;
				self.daliip := CertRoxieDali;
			end;
			
			dConvertToPkgLayout := join(sort(dFromRoxie,superfile)
																	,sort(dKeysFromDOPS,superkey)
																	,left.superfile = right.superkey
																	,xConvertToPkgLayout(left, right)
																	,left only
																	,lookup
																	);
			
			pkgfile.layouts.flat_layouts.FileRecord xConvertDOPSToPkgLayout(dKeysFromDOPS l) := transform
				self.packageid := OverrideKeys;
				self.superfile := l.superkey;
				self.subfile := regexreplace(OverrideKeys + '_DATE',l.logicalkey,buildversion);
				self.isfullreplace := true;
				self.isdeltareplace := false;
				self.daliip := ThorDali;
			end;
			
			dConvertDOPSToPkgLayout := projecT(dKeysFromDOPS,xConvertDOPSToPkgLayout(left));
			
			return dConvertToPkgLayout + dConvertDOPSToPkgLayout;
			
		end;
		
		export DeletePackage := Pkgfile.delete(packagecluster).packageid([NonOverrideKeys,OverrideKeys]);
		
		export AddKeysToPackage := pkgfile.add(packagecluster).Sfiles(ConvertToPkglayout(),buildversion+'keys');
		
		export AddQueriesToPackage := pkgfile.add(packagecluster).Queries(dQueriesForPackage,buildversion+'queries');
		
		export AddEVariablesToPackage := sequential
																				(
																					pkgfile.add(packagecluster).Environment(,'NewAddressCleaningServer','sap_troxieinterlb.br.seisint.com',buildversion+'env1')
																					,pkgfile.add(packagecluster).Environment(,'NewIAddressCleaningPort','21100',buildversion+'env2')
																					);
		
		export BuildPackage() := function
			
				return sequential
												(
														DeletePackage
														,AddEVariablesToPackage
														,AddQueriesToPackage
														,AddKeysToPackage
														,Pkgfile.RoxiePackage(packagecluster).BuildPromotePackage() 
													);
			
		end;
		
		///////////////// END PACKAGE FILE BUILD ///////////////////
		///////////////// END PACKAGE FILE BUILD ///////////////////
		///////////////// END PACKAGE FILE BUILD ///////////////////
		
		
		///////////////// PACKAGE DEPLOYMENT PROCESS ///////////////
		///////////////// PACKAGE DEPLOYMENT PROCESS ///////////////
		///////////////// PACKAGE DEPLOYMENT PROCESS ///////////////
		
		export GetPackageContent() := function
			rPkgContent := record, maxlength(30000)
				string xmlline;
			end;
	
			dPkgFile := dataset(Pkgfile.files('xml',packagecluster).pfile,rPkgContent,CSV(Separator('|')));
				rRollupRecord := record
				integer dummy := 1;
				string xmlline;
			end;
				rRollupRecord xProject(dPkgFile l) := transform
				self := l;
			end;

			dProject := project(dPkgFile,xProject(left));
				rRollupRecord xRollupRecord(dProject l, dProject r) := transform
				self.xmlline := l.xmlline + r.xmlline;
				self := l;
			end;

			dRollupRecord := rollup(dProject,dummy,xRollupRecord(left,right));
			
			return trim(regexreplace('<RoxiePackages></RoxiePackages>',dRollupRecord[1].xmlline,''));
		end;
	
		
	
		///////////////// END PACKAGE DEPLOYMENT PROCESS ///////////////
		///////////////// END PACKAGE DEPLOYMENT PROCESS ///////////////
		///////////////// END PACKAGE DEPLOYMENT PROCESS ///////////////
	
end;