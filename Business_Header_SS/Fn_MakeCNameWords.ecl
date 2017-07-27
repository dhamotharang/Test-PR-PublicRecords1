import text,ut,lib_metaphone,Business_Header_SS;

export Fn_MakeCNameWords(
	dataset(Business_Header_SS.layout_MakeCNameWords) infile
	) :=
FUNCTION

return Business_Header_SS.mod_MakeCNameWords.records(infile);

end;