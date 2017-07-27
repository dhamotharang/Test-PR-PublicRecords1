import MDR,tools;

export KeyPrep_URLs_ID(
	dataset(Layout_URLs.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	searchpattern := '^([0-9]+)[.]([0-9]+)[.]([0-9]+)[.]([0-9]+)$';
		
	projected := project(base,
		transform(KeyLayouts.URLs,
			self.source_docid_1 := map(
				MDR.SourceTools.SourceIsProperty(left.source) => left.source_docid[1],
				''),
       badUrl := (regexfind(searchpattern,trim(left.cleanurl,left,right)));      				
			self.cleanUrl := if (badUrl, '', left.cleanurl);
			self := left))(cleanurl <> '');
	
	deduped := dedup(projected,record,all);
	
	tools.mac_FilesIndex('deduped,{bid},{deduped}',keynames(version,pUseOtherEnvironment).URLs,idx);
	
	return idx;

end;
