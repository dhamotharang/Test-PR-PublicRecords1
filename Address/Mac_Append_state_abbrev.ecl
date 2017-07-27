export Mac_Append_state_abbrev(pInputfile		// Input File
							,pZipfield		// Zip5 field in input file
							,pIsZipInteger
							,pStateField	// Fips county field in input file(to fix)
							,pOutputFile	// Output file with fixed county code
							) :=
macro

	// join the input file to the zip to fips code file, pulling the fips code
	// should blank out every fips code, or populate it with what matched
	// 
	
	#uniquename(tGetState)
	#uniquename(jointogetState)
	#uniquename(fZip2State)
	
	%fZip2State% := Address.File_Zip_city_fips_latlong;
	
	pInputfile %tGetState%(pInputfile l, %fZip2State% r) :=
	transform
	
		self.pStateField	:= if(l.pStatefield = '', r.state, l.pStateField);
		self				:= l;
	
	end;
	
	%jointogetState% := join(pInputfile, %fZip2State%,
	#if(pIsZipInteger = true)
						left.pZipfield = (unsigned)right.zip,
	#else
						left.pZipfield = right.zip,
	#end
						%tGetState%(left,right),
						left outer,
						lookup);
	
	pOutputFile := %jointogetState%; 

endmacro;