export macFix_Contact_DIDs(

	 pDataset
	,pDidField
	,pLastNameField
	,pHasDidScoreField	= 'false'
	,pDidScoreField			= 'did_score'
	,pHasSsnField				= 'false'
	,pIsSsnFieldString	= 'false'
	,pSsnField					= 'ssn'
	,pOutputDataset
	,pHeaderFile				= 'header.File_Headers'

) :=
macro

	#uniquename(pDataset_withDID)
	#uniquename(pDataset_withoutDID)
	#uniquename(header_orig)
	#uniquename(lname_set)
	#uniquename(header_table)
	#uniquename(tRollupHeaders)
	#uniquename(slimheader)
	#uniquename(lay2did)
	#uniquename(tBlankDid)
	#uniquename(jpDataset2header)

	%pDataset_withDID%		:= pDataset(pDidField != 0);
	%pDataset_withoutDID%	:= pDataset(pDidField  = 0);

	%header_orig%	:= distribute(pHeaderFile, did);

	////////////////////////////////////////////////////////////
	// -- rollup headers on did, adding new last names to a set
	// -- so have a set of last names per did
	////////////////////////////////////////////////////////////
	%lname_set% :=
	record, maxlength(320000)
		%header_orig%.did;
		%header_orig%.lname;
		set of string setlnames;
	end;

	%header_table% := sort(project(%header_orig%, transform(%lname_set%, self := left; self.setlnames := [left.lname];)), did, local);

	%lname_set% %tRollupHeaders%(%header_table% l, %header_table% r) :=
	transform

		self.did				:= l.did	;
		self.lname			:= l.lname;
		self.setlnames	:= if(r.lname not in l.setlnames	,l.setlnames + [r.lname]
																											,l.setlnames
												);
	end;

	%slimheader% := rollup(
							 %header_table%
							,%tRollupHeaders%(left,right)
							,did
							,local
					);

	//join to headers, compare last names
	//if same, keep did
	//if different, blank out did

	%lay2did% :=
	record
//		unsigned6 orig_did;
		recordof(pDataset);
	end;

	%lay2did% %tBlankDid%(%pDataset_withDID% l, %slimheader% r) := 
	transform
//		self.orig_did		:= l.pDidField;
		self.pDidField	:= if(l.pLastNameField not in r.setlnames,0, l.pDidField);
#if(pHasDidScoreField = true)
		self.pDidScoreField := if(self.pDidField = 0, 0, l.pDidScoreField);
#end
#if(pHasSsnField = true)
#if(pIsSsnFieldString = true)
		self.pSsnField			:= if(self.pDidField = 0, '', l.pSsnField);
#else
		self.pSsnField			:= if(self.pDidField = 0, 0, l.pSsnField);
#end
#end
		self := l;

	end;

	%jpDataset2header% := join(
								 distribute(%pDataset_withDID%, did)
								,%slimheader%
								,left.pDidField = right.did
								,%tBlankDid%(left,right)
								,local
								,left outer
							);
	
	pOutputDataset := %jpDataset2header% + %pDataset_withoutDID%;

endmacro;