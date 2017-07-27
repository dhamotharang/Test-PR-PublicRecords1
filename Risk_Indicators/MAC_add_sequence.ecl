// add a sequence number to the reason codes for sorting in XML
export MAC_add_sequence(ds_reasons, ds_with_seq) := macro
	#uniquename(layout_with_seq)         
	%layout_with_seq% := record
		unsigned1 seq := 0;
		recordof(ds_reasons);
	end;
	
	#uniquename(with_seq) 
	%with_seq% := project(ds_reasons, 
									transform(%layout_with_seq%, self.seq := counter, self := left));

	ds_with_seq := %with_seq%;
endmacro;