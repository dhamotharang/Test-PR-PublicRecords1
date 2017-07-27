export cleanSSN(string9 ssn) := function
	ssn_val := if((length(Stringlib.StringFilter(ssn,'0123456789'))<>9) or ssn='000000000' or Stringlib.StringFilterOut(ssn,'0123456789')<>'','',ssn);	// blank out social if it is all 0's or isn't numeric and 9 bytes long

	return ssn_val;
end;