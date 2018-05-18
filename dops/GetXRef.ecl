EXPORT GetXRef(string esp) := module

	// Files that have info on dali but missing 1 or more file parts
	// Pre-requisite, xref must be generated before calling this function
	// to get the latest list
	export LostFiles(string l_cluster) := function
		
		rDFUXRefLostFilesRequest := record
			string Cluster{xpath('Cluster')} := l_cluster;
		end;
	
		rPart := record
			string Node{xpath('Node')};
			string Num{xpath('Num')};
			string Replicate{xpath('Replicate')};
		end;
	
		rFiles := record
			string Name{xpath('Name')};
			string Partslost{xpath('Partslost')};
			string Numparts{xpath('Numparts')};
			dataset(rPart) partsinfo{xpath('Part')};
		end;
	
		rDFUXRefLostFilesResponse := record,maxlength(30000)
			dataset(rFiles) Files{xpath('File')};
			//string contenttype{xpath('FileDetail/ContentType')};
		end;
	
		dDFUXRefLostFilesResponse := SOAPCALL('http://' + esp + ':8010/WsDFUXRef'
												,'DFUXRefLostFilesQuery'
												,rDFUXRefLostFilesRequest
												,dataset(rDFUXRefLostFilesResponse)											
												,xpath('DFUXRefLostFilesQueryResponse/DFUXRefLostFilesQueryResult/Lost')
										 );


		rFileNames := record
			string r_cluster;
			string Name := '';
			string Partslost := '';
			string Numparts := '';
			string Node := '';
			string Num := '';
			string Replicate := '';
			dataset(rPart) partsinfo;
			dataset(rFiles) Files;
		end;
	
		rFileNames xNormNames(dDFUXRefLostFilesResponse l, rFiles r) := transform
			self.r_cluster := l_cluster;
			self := r;
			self := l;
		end;
		
		dFileNames := normalize(dDFUXRefLostFilesResponse,left.Files,xNormNames(left,right));
	
		rFileNames xNormParts(dFileNames l, rPart r) := transform
			self := r;
			self := l;
		end;
		
		dParts := normalize(dFileNames,left.partsinfo,xNormParts(left,right));
	
		rFinal := record
			string r_cluster;
			string Name := '';
			string Partslost := '';
			string Numparts := '';
			string Node := '';
			string Num := '';
			string Replicate := '';
		end;
	
		rFinal xFinal(dParts l) := transform
			self := l;
		end;
		
		dFinal := project(dParts,xFinal(left));
			
		return dFinal;
		
	end;
end;