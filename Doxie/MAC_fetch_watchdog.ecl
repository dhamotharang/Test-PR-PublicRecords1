export MAC_fetch_watchdog(outfile,did_stream,did_field,key,bestlayout='doxie.layout_best') := macro
  IMPORT ut;

	outfile := 
		join(
			did_stream,
			key,
			keyed(left.did_field=right.did),							
			transform(
				bestlayout,
				self.age := if ( right.dob = 0, 0, ut.age(right.dob) ),
				self := right
			), 
			KEEP (1), LIMIT (0)
		);
endmacro;