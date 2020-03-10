import ut;
EXPORT fValidatePackage(
										string packagemapname
										,string xmlcontent
										,string roxieesp
										,string roxietarget
										,string roxieport = '8010'
										,boolean isactive = false
										,boolean checkdfs = true
										,boolean globalscope = true
										) := function
	
	
	rValidatePackageRequest := record
		string Info{xpath('Info')} := xmlcontent;
		string PMID{xpath('PMID')} := packagemapname;
		string Target{xpath('Target')} := roxietarget;
		boolean Activate{xpath('Activate')} := isactive;
		boolean CheckDFS{xpath('CheckDFS')} := checkdfs;
		boolean GlobalScope{xpath('GlobalScope')} := globalscope;
	end;
			
	dValidatePackageResponse := SOAPCALL('http://'+roxieesp+':'+roxieport+'/WsPackageProcess?ver_=1.03'
										,'ValidatePackage'
										,rValidatePackageRequest
										,dataset(dops.PackageResponseLayouts.rValidatePackageResponse)
										,xpath('ValidatePackageResponse')
										,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
									 );
	
	rValidatePackageFull := record
		dops.PackageResponseLayouts.rValidatePackageResponse;
		string unmatchedfiles := '';
		string queryname := '';
		string filesnotfoundindfs := '';
		
	end;

	rValidatePackageFull xQueries(dValidatePackageResponse l, dops.PackageResponseLayouts.rWarnings r) := transform
		self.queryname := r.Item;
		self := l;
	end;
	
	dQueries := normalize(dValidatePackageResponse
													,left.queries
													,xQueries(left,right)
													);
	
	
	rValidatePackageFull xUnmatchedFiles(dQueries l, dops.PackageResponseLayouts.rWarnings r) := transform
		self.unmatchedfiles := r.Item;
		self := l;
	end;
	
	dUnmatchedFiles := normalize(dQueries
													,left.filesunmatched
													,xUnmatchedFiles(left,right)
													);
	
	rValidatePackageFull xNotinDFS(dQueries l, dops.PackageResponseLayouts.rFilesNotFound r) := transform
		self.filesnotfoundindfs := r.File;
		self := l;
	end;
	
	dNotInDFS := normalize(dQueries
													,left.filesnotindfs
													,xNotinDFS(left,right)
													);
	
	rValidatePackage := record
		rValidatePackageFull - [queries, filesunmatched, filesnotindfs, packages]
	end;
	
	rValidatePackage xValidatePackage(dUnmatchedFiles l) := transform
		self := l;
	end;
	
	dValidatePackage := project(dUnmatchedFiles + dNotInDFS,xValidatePackage(left));
	
	return dValidatePackage;
	
end;