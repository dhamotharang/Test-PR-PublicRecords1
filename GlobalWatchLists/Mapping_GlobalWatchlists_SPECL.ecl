import	ut;

// This watchlists is in our base files but not in Bridger
dGWLFinCrimesBase	:=	GlobalWatchLists.File_GlobalWatchLists(GlobalWatchLists.Functions.strClean2Upper(source)	=	'FINANCIAL CRIMES ENFORCEMENT NETWORK SPECIAL ALERT LIST');

GlobalWatchLists.Layout_denorm	tFinCrimes(dGWLFinCrimesBase	pInput)	:=
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

export	Mapping_GlobalWatchlists_SPECL	:=	project(dGWLFinCrimesBase,tFinCrimes(left));