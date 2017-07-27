export Fn_assembleName(
	String title,
	String fname,
	String mname,
	String lname,
	String suffix
) := function

	result := trim(
		if(title<>'', title + ' ', '') +
		if(fname<>'', fname + ' ', '') +
		if(mname<>'', mname + ' ', '') +
		if(lname<>'', lname + ' ', '') +
		if(suffix<>'', suffix + ' ', '')
	);

	return(result);
	
end;
