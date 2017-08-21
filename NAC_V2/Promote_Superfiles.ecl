import STD;
EXPORT Promote_Superfiles(string sf, string filename) := FUNCTION
	sfList := [
	sf,
	sf+'::father',
	sf+'::grandfather'
	];
	
	return 	Std.file.fPromoteSuperFileList(sfList, filename, deltail := true);

END;