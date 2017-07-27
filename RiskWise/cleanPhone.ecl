export cleanPhone(string10 phone_num) := function
	// blank out phone if it isn't numeric and at least 6 bytes
	phone_val := if(length(Stringlib.StringFilter(phone_num,'0123456789'))<6 or Stringlib.StringFilterOut(phone_num,'0123456789')<>'','',phone_num);

	return phone_val;
end;