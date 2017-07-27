export Mac_Replace_Records(fulldataset,updates,fieldstojoin,replaceds) := macro

	// The purpose of this macro is to delete any record(s) from historical dataset (fulldataset)
	// that matches the fieldstojoin value in new file (updates) and add the new file to the slimmed 
	// dataset. In precise, replace the record with new one if it already exists.

	// fulldataset - the superfile contains all historical updates
	// updates - the superfile contains the most recent update
	// fieldstojoin - 
	#uniquename(replacerecs)
	#uniquename(distfull)
	#uniquename(distupdates)
	%distfull% := distribute(fulldataset,hash(fieldstojoin));
	%distupdates% := distribute(updates,hash(fieldstojoin));
	typeof(fulldataset) %replacerecs%(fulldataset l,updates r) := transform
		self := l;
	end;

	#uniquename(slimds)

	%slimds% := join(%distfull%,%distupdates%,left.fieldstojoin = right.fieldstojoin,
															%replacerecs%(left,right),
															left only,
															local);
	
		
	replaceds := %slimds% + updates;
	
endmacro;