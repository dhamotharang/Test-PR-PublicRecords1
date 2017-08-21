EXPORT fn_clean_address (string in_address):= FUNCTION

	RemoveLeadingZeros(string in_str) := FUNCTION
		first_non0 := stringlib.stringfilterOut(in_str,'0')[1];
		first_non0_position := stringlib.StringFind(in_str, first_non0, 1);
		out_str := in_str[(unsigned)first_non0_position..];
		return out_str;
	END;

	RemoveDoubleXX(string in_str) := FUNCTION
		out_str := StringLib.StringCleanSpaces(StringLib.StringFindReplace(in_str,'XX',''));
		return out_str;
	END;
	
	remlead0 := RemoveLeadingZeros(in_address);
	remdoubx := RemoveDoubleXX(remlead0);
	return remdoubx;

END;