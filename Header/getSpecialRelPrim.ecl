export string getSpecialRelPrim(string pr, string pn) := 
	if(pr <> '', pr,
	    stringlib.StringFilter(pn, '1234567890'));

//for purposes of the relatives build, take any number out of prim_name
//when the prim_range is blank