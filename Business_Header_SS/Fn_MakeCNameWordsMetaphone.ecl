import text,ut,lib_metaphone,LN_PropertyV2,Business_Header_SS;

export Fn_MakeCNameWordsMetaphone() :=
MODULE

	export inrec := Business_Header_SS.mod_MakeCNameWords.metaphone.inrec;

	export records(
		dataset(inrec) infile
		) :=
	Business_Header_SS.mod_MakeCNameWords.metaphone.mrecords(infile);
	
end;