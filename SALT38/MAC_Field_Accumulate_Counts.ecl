// Assumes presence of CNT field as count for outer value
export MAC_Field_Accumulate_Counts(infile,field_value,target_label,outfile) := MACRO
#uniquename(r)
  %r% := record
	  infile.field_value;
		unsigned8 target_label := sum(group,infile.cnt);
	end;
#uniquename(t)
//	%t% := table(infile,%r%,field_value,merge); // Use ,merge when available
	%t% := table(infile,%r%,field_value);
	
	outfile := join(infile,%t%,left.field_value=right.field_value,hash);
	
  ENDMACRO;
