EXPORT fBldPkgWithMissingQueries(
																	string roxieesp // local roxie
																	,string roxietarget // target cluster associated to roxieesp passed in module
																	,string roxieport = '8010'
																	
																	) := function
	
	rPackageLayout := record
		dops.GetRoxiePackage('', '', '').rPackageKeyInfoWithQueries;
	end;
	
	
		dKeysQueries := sort(dops.fGetKeysQueriesFromRoxie(roxieesp, roxietarget),queryname, superfile) : independent;
			
		rPackageLayout xQueries(dKeysQueries l) := transform
			
			self.packageid := l.queryname;
			
			self.baseid := l.superfile;
			//self := l;
		end;
		
		dQueries := dedup(sort(project(dKeysQueries,xQueries(left)),packageid,baseid),packageid,baseid);
		
		rPackageLayout xDatasetKeys(dKeysQueries l) := transform
			
			self.packageid := l.superfile;
			self.superfile := l.superfile;
			self.subfile := l.subfile;
			//self := l;
		end;
		
		dDatasetKeys := dedup(sort(project(dKeysQueries,xDatasetKeys(left)),packageid,superfile, subfile),packageid,superfile, subfile);
		
		 
	
		dQueriesFromRoxie := dQueries + dDatasetKeys : independent;
	
	dPackage := if( count(dops.fListAllPackages(roxieesp, roxietarget,roxieport)(isactive = '1')) > 0
										,dops.GetRoxiePackage(roxieesp, roxieport, roxietarget).fXMLPackageAsDataset()
										,dataset([],rPackageLayout)) : independent;
																																
	
	
		
		rPackageLayout xGetMissing(dQueriesFromRoxie l,dPackage r) := transform
			self := l;
			
		end;
		
		dGetMissingQueries := join(dQueriesFromRoxie(baseid <> '')
																,dPackage(baseid <> '')
																,left.packageid = right.packageid
																	and left.baseid = right.baseid
																,xGetMissing(left,right)
																,left only);
		
		dGetMissingKeys := join(dQueriesFromRoxie(baseid = '')
																,dPackage(baseid = '')
																,left.packageid = right.packageid
																	and left.superfile = right.superfile
																	and left.subfile = right.subfile
																,xGetMissing(left,right)
																,left only);
		
		// get all queries as they will have a respective superkey
		// get only superfiles that have subfiles
		// get the package content
		return dGetMissingQueries + dGetMissingKeys + dPackage;
		
	
			
end;