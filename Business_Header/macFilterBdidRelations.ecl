//*** Macro to filter the BDID relations from the relative and relative group files.
export macFilterBdidRelations(
	 pDataset
	,pFilterDataset
	,pOutput
	,pbdid1Field		= 'bdid1'
	,pbdid2Field		= 'bdid2'
	,pFilterOut			= 'true'
) :=
macro

	#uniquename(add_reverse)
	#uniquename(dFilteredBDIDRels)
	#uniquename(dleftonlyjoin)
	#uniquename(dinnerjoin)

	//*** reverse the BDID combo for filter.
	recordof(pFilterDataset) %add_reverse%(pFilterDataset L) := transform
  	self.bdid1 := (unsigned6)L.bdid2;
  	self.bdid2 := (unsigned6)L.bdid1;    
  end;

  %dFilteredBDIDRels% := dedup(pFilterDataset + project(pFilterDataset, %add_reverse%(left)),record,all); 
	
	%dleftonlyjoin% := join(
		 pDataset
		,%dFilteredBDIDRels%
		,			left.pbdid1Field = right.bdid1
		 and	left.pbdid2Field = right.bdid2
    ,transform(recordof(pDataset), self := left)
		,left only
		,lookup
	);	

	%dinnerjoin% := join(
		 pDataset
		,%dFilteredBDIDRels%
		,			left.pbdid1Field = right.bdid1
		 and	left.pbdid2Field = right.bdid2
    ,transform(recordof(pDataset), self := left)
		,lookup
	);	
	
	pOutput := if(pFilterOut = true, %dleftonlyjoin%,%dinnerjoin%);

endmacro;