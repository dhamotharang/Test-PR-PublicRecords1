export mac_map_race(infile,infield,outfield,outfile) := macro
	
	#uniquename(into)
	typeof(infile) %into%(infile L) := transform
		self.outfield := MAP(stringlib.stringtouppercase(L.infield)[1] = 'W' => 'White',
						 stringlib.stringtouppercase(L.infield)[1] = 'B' => 'African American',
						 stringlib.stringtouppercase(L.infield)[1] = 'H' => 'Hispanic',
						 stringlib.stringtouppercase(L.infield)[1] = 'I' => 'Native American',
						 stringlib.stringtouppercase(l.infield)[1] = 'C' => 'White', // Caucasian
						 stringlib.stringtouppercase(L.infield)[1] = 'O' => 'Other', 
						 stringlib.stringtouppercase(L.infield)[1] = 'A' and length(trim(L.infield)) = 1 => 'Asian', 
						 stringlib.stringtouppercase(l.infield)[1] = 'P' => 'Pacific Islander',
						 length(l.infield) > 1 and stringlib.stringtouppercase(L.infield)[1..2] = 'AS' => 'Asian',
						 length(l.infield) > 1 and stringlib.stringtouppercase(L.infield)[1..2] = 'AM' => 'Native American',
						 length(l.infield) > 1 and stringlib.stringtouppercase(L.infield)[1..2] = 'AF' => 'African American',
						 length(l.infield) > 1 and stringlib.stringtouppercase(L.infield)[1..2] = 'AL' => 'Alaskan Native',
						 'Unknown');
		self := L;
	end;
	
	outfile := project(infile,%into%(LEFT));
	
endmacro;
