import ut;
EXPORT Mac_Crim_OffenderKey_Mapping(inds,mappingfield,retval) := macro
	#uniquename(lookuplayout)
	
	%lookuplayout% := record
		string oldoffkey;
		string newoffkey;
		string ssn;
		string did;
	end;
	
	#uniquename(lookupds)
	%lookupds% := dataset(ut.foreign_prod+'thor_data400::base::crim::override::offenderkeychangeslookup',%lookuplayout%,csv(heading(1))); 
	
	#uniquename(mapoffkey)
	typeof(inds) %mapoffkey%(inds l,%lookupds% r) := transform
		self.mappingfield := if (r.newoffkey <> '',r.newoffkey,l.mappingfield);
		self := l;
	end;

	
	retval := join(inds,%lookupds%,left.mappingfield = right.oldoffkey,
									%mapoffkey%(left,right),
									left outer,
									lookup);
	
	
endmacro;