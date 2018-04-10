import STD;
EXPORT fGetKeysByQueryFromRoxie(
														string soapurl
														,string queryname
														,string targetcluster
														) := function
		
	rGetQueryFileMappingRequest  := record
		string Target{xpath('Target')} := targetcluster;
		string QueryName{xpath('QueryName')} := STD.Str.ToLowerCase(queryname)
	end;
	
	dGetQueryFileMappingResponse := SOAPCALL(soapurl
											,'GetQueryFileMapping'
											,rGetQueryFileMappingRequest
											,dataset(dops.PackageResponseLayouts.rGetQueryFileMappingResponse)
											,xpath('GetQueryFileMappingResponse/SuperFiles')
										 );

	rGetQueryKeys := record
		string queryname := '';
		string superfile := '';
		string subfile := '';
		dataset(dops.PackageResponseLayouts.rNames) names;
		dataset(dops.PackageResponseLayouts.rSupers) superfiles;
		dataset(dops.PackageResponseLayouts.rSubFiles) subfiles;
	end;
	
	rGetQueryKeys xTorGetQueryKeys(dGetQueryFileMappingResponse l) := transform
		self.queryname := queryname;
		self.subfiles := [];
		self.names := [];
		self := l;
	end;
	
	dGetQueryKeys := project(dGetQueryFileMappingResponse,xTorGetQueryKeys(left));

	rGetQueryKeys xNormSupers(dGetQueryKeys l, dops.PackageResponseLayouts.rSupers r) := transform
		self.subfiles := r.subfiles;
		self.superfile := r.Name;
		self := l;
	end;
	
	dNormSupers := normalize(dGetQueryKeys
													,left.superfiles
													,xNormSupers(left,right)
													);
	
	rGetQueryKeys xNormSubFiles(dNormSupers l, dops.PackageResponseLayouts.rSubFiles r) := transform
		self.names := r.files;
		self := l;
	end;
	
	dNormSubFiles := normalize(dNormSupers
													,left.subfiles
													,xNormSubFiles(left,right)
													);
	
	rGetQueryKeyAssociation := record
		rGetQueryKeys - [superfiles, subfiles, names];
	end;
	
	rGetQueryKeyAssociation xNormSubFileNames(dNormSubFiles l, dops.PackageResponseLayouts.rNames r) := transform
		self.subfile := r.Name;
		self := l;
	end;
	
	dNormSubFileNames := normalize(dNormSubFiles
													,left.names
													,xNormSubFileNames(left,right)
													);
	
	
	return dNormSubFileNames;
		
end;