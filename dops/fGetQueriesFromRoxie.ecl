import ut;
EXPORT fGetQueriesFromRoxie(
														string soapesp //ip
														,string targetcluster
														) := function
	
	
	
	rWUQuerySetDetailsRequest := record
		string QuerySetName {xpath('QuerySetName')} := targetcluster;
		string CheckAllNodes {xpath('CheckAllNodes')} := '1';
		string FilterType {xpath('FilterType')} := 'All';
	end;
	
	dWUQuerySetDetailsResponse := SOAPCALL('http://'+soapesp+':8010/WsWorkunits'
											,'WUQuerysetDetails'
											,rWUQuerySetDetailsRequest
											,dataset(dops.PackageResponseLayouts.rWUQuerySetDetailsResponse)
											,xpath('WUQuerySetDetailsResponse')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );
	
	rFlatLayout := record
		string name := '';
		string dll := '';
		string islibrary := '';
		boolean suspended := false;
		string roxiecluster := '';
		dataset(dops.PackageResponseLayouts.rQuerysetQueries) queriesinfo;
		
	end;
	
	rFlatLayout - [queriesinfo] xNormQset(dWUQuerySetDetailsResponse l,dops.PackageResponseLayouts.rQuerysetQueries r) := transform
		self.name := r.Name;
		self.dll := r.Dll;
		self.islibrary := r.isLibrary;
		self.suspended := r.Suspended;
		self.roxiecluster := targetcluster;
		self := l;
	end;
	
	dNormQset := normalize(dWUQuerySetDetailsResponse,left.QuerysetQueries,xNormQset(left,right));
	
	return dNormQset;
		
end;
