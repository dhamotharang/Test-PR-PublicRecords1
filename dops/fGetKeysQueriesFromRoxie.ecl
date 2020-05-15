EXPORT fGetKeysQueriesFromRoxie(
														string soapesp //ip
														,string targetcluster
														) := function
		
	dGetQueries := dops.fGetQueriesFromRoxie(soapesp, targetcluster);
	
	rKeysQueries := record
		string roxiecluster;
		dops.PackageResponseLayouts.rGetQueryKeyAssociation;
		dataset(dops.PackageResponseLayouts.rGetQueryKeyAssociation) keyquery;
	end;
	
	rKeysQueries xGetKeysbyQuery(dGetQueries l) := transform
		self.roxiecluster := targetcluster;
		self.keyquery := dops.fGetKeysByQueryFromRoxie(soapesp, l.name, targetcluster);
		self := l;
	end;
	
	dGetKeysbyQuery := project(dGetQueries,xGetKeysbyQuery(left));
	
	rKeysQueries - [keyquery] xKeysQueries(dGetKeysbyQuery l,dops.PackageResponseLayouts.rGetQueryKeyAssociation r) := transform
		self := r;
		self := l;
	end;
	
	dKeysQueries := normalize(dGetKeysbyQuery,left.keyquery,xKeysQueries(left,right));
	
	return dKeysQueries;
	
	
end;