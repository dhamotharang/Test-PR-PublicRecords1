import	ut;

// Pull the OFAC data from the GWL base file since we want to keep the adhoc process as is
dGWLOFACBase	:=	GlobalWatchLists.File_GlobalWatchLists(GlobalWatchLists.Functions.strClean2Upper(source)	=	'OFFICE OF FOREIGN ASSET CONTROL');
	
Layout_denorm	tOFAC(dGWLOFACBase	pInput)	:=
transform
	self.pname_clean	:=	map(	pInput.title	<>	''	and	pInput.fname	<>	''	and	pInput.mname	<>	''	and	pInput.lname	<>	''	=>	pInput.title	+	' '	+	pInput.fname	+	' '	+	pInput.mname	+	' '	+	pInput.lname	+	' '	+	pInput.a_score,
															pInput.title	<>	''	and	pInput.fname	<>	''	and	pInput.lname	<>	''														=>	pInput.title	+	' '	+	pInput.fname	+	' '	+	pInput.lname	+	' '	+	pInput.a_score,
															pInput.fname	<>	''	and	pInput.mname	<>	''	and	pInput.lname	<>	''														=>	pInput.fname	+	' '	+	pInput.mname	+	' '	+	pInput.lname	+	' '	+	pInput.a_score,
															pInput.fname	<>	''	and	pInput.lname	<>	''																											=>	pInput.fname	+	' '	+	pInput.lname	+	' '	+	pInput.a_score,
															pInput.lname	<>	''																																								=>	pInput.lname	+	' '	+	pInput.a_score,
															''
														);
	self							:=	pInput;
	self							:=	[];
end;

export	Mapping_GlobalWatchLists_OFAC	:=	project(dGWLOFACBase,tOFAC(left));