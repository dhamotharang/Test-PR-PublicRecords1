EXPORT Files := module

	export infile := dataset(constants.IN_PREFIX_NAME, layouts.incoming, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')))(property_rid <> 0);
	
	export base := project(infile, transform(layouts.base, 
  self.global_sid := map(left.vendor_source='A' =>  28571,
										     left.vendor_source = 'B'  => 28581,
												 left.vendor_source = 'C'  => 28581,
												 left.vendor_source = 'D'  => 28591,
												 left.vendor_source = 'E'  => 27621,
												 left.vendor_source = 'F'  => 28601,
												 left.vendor_source = 'G'  => 28571,
												 0);
										
	self := left; 
	self := []));
	
end;	