import STD,ut;
EXPORT fGetKeysByQueryFromRoxie(
														string soapesp
														,string queryname
														,string targetcluster
														) := function
		
	rWUQueryDetailsRequest  := record
		string QueryId{xpath('QueryId')} := STD.Str.ToLowerCase(queryname);
		string QuerySet{xpath('QuerySet')} := targetcluster;
		string IncludeStateOnClusters{xpath('IncludeStateOnClusters')} := '1';
		string IncludeSuperFiles{xpath('IncludeSuperFiles')} := '1';
		string IncludeWsEclAddresses{xpath('IncludeSuperFiles')} := '1';
		string CheckAllNodes{xpath('IncludeSuperFiles')} := '1';
	end;
	
	dWUQueryDetailsResponse := SOAPCALL('http://'+soapesp+':8010/WsWorkunits?ver_=1.75'
											,'WUQueryDetails'
											,rWUQueryDetailsRequest
											,dataset(dops.PackageResponseLayouts.rWUQueryDetailsResponse)
											,xpath('WUQueryDetailsResponse')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );

	rGetQueryKeys := record
		string queryname := '';
		string queryid := '';
		string queryset := '';
		string superfile := '';
		string subfile := '';
		boolean suspended := false;
		dataset(dops.PackageResponseLayouts.rNames) names;
		dataset(dops.PackageResponseLayouts.rSupers) superfiles;
		dataset(dops.PackageResponseLayouts.rSubFiles) subfiles;
	end;
	
	rGetQueryKeys xTorGetQueryKeys(dWUQueryDetailsResponse l) := transform
		self.subfiles := [];
		self.names := [];
		self := l;
	end;
	
	dGetQueryKeys := project(dWUQueryDetailsResponse,xTorGetQueryKeys(left));

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
	
	rGetQueryKeyAssociation xGetSuperWithNoSubfiles(dNormSupers l) := transform
		self := l;
	end;
	
	dGetSuperWithNoSubfiles := project(dNormSupers, xGetSuperWithNoSubfiles(left));
	
	return dNormSubFileNames + dGetSuperWithNoSubfiles;
		
end;