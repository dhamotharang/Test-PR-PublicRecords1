export cleanDOB(string8 dob) := function
	bd := if(length(Stringlib.StringFilter(dob,'0123456789'))<>8 or Stringlib.StringFilterOut(dob,'0123456789')<>'','',dob); 	// blank out dob if it isn't numeric and equal to 8 bytes
	dob_val := if(bd[1..2] not in ['19','20','21'] and bd[5..6] in ['19','20','21'], bd[5..8] + bd[1..4], bd); 	// correct the format for them if they messed it up on input

	return dob_val;
end;