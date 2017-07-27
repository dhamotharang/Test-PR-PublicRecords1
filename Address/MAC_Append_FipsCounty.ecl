export MAC_Append_FipsCounty(pInputfile		// Input File
							,pZipfield		// Zip5 field in input file
							,pIsZipInteger
							,pCountyField	// Fips county field in input file(to fix)
							,pOutputFile	// Output file with fixed county code
							) :=
macro

	// join the input file to the zip to fips code file, pulling the fips code
	// should blank out every fips code, or populate it with what matched
	// 
	
	#uniquename(tGetFipsCounty)
	#uniquename(jointogetfips)
	#uniquename(fZip2Fips)
	
	%fZip2Fips% := Address.File_Zip_city_fips_latlong;
	
	pInputfile %tGetFipsCounty%(pInputfile l, %fZip2Fips% r) :=
	transform
	
		self.pCountyField	:= map(r.fips_county <> '' => r.fips_county,
									regexfind('[^[:digit:]]', l.pCountyField ) => '', l.pCountyField );
		self				:= l;
	
	end;
	
	%jointogetfips% := join(pInputfile, %fZip2Fips%,
	#if(pIsZipInteger = true)
						left.pZipfield = (unsigned)right.zip,
	#else
						left.pZipfield = right.zip,
	#end
						%tGetFipsCounty%(left,right),
						left outer,
						lookup);
	
	pOutputFile := %jointogetfips%; 

endmacro;