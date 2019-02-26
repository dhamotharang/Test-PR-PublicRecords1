import ut;
EXPORT GetSubFiles(string superfilename, string esp) := function


	rSuperfileListRequest := record
		string superfile{xpath('superfile')} := superfilename;
	end;
	
	rSubFiles := record
		string subfile{xpath('')};
	end;
	
	rSuperfileListResponse  := record
		string superfile{xpath('superfile')};
		dataset(rSubFiles) subfiles{xpath('subfiles/Item')};
	end;
	
	results := SOAPCALL('http://'+esp+':8010/WsDfu'
											,'SuperfileList'
											,rSuperfileListRequest
											,dataset(rSuperfileListResponse)
											,xpath('SuperfileListResponse')
											,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues())
										 );
	
	rNormRecs := record
		string superfile;
		string subfile;
	end;
	
	rNormRecs xNormRecs(results l, rSubFiles r) := transform
		self.subfile := r.subfile;
		self := l;
	end;
	
	dNormRecs := normalize(results
													,left.subfiles
													,xNormRecs(left,right)
													);
	
	return dNormRecs;

end;