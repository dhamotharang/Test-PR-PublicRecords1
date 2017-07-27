export mac_map_state(infile, infield, outfield, outfile) := macro
	
	#uniquename(get_state)
	typeof(infile) %get_state%(infile L) := transform
		self.outfield := codes.GENERAL.STATE_LONG(stringlib.stringtouppercase(l.infield));
		self := L;
	end;
	
	outfile := project(infile, %get_state%(left));
	
	endmacro;
	