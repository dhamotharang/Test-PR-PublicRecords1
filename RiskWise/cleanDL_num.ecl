export cleanDL_num(string20 drlc) := function
	dl_num := stringlib.stringFilterOut(drlc,' -');
	return dl_num;
end;