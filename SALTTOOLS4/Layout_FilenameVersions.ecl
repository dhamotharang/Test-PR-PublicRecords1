import lib_fileservices;
export Layout_FilenameVersions :=
module
	
	shared themax := 8192;
	
	export NamesOld :=
	record, maxlength(themax)
		string OldTemplateName;
		string NewTemplateName;
		string version					:= '';
		boolean	IsNewNamingConvention	:= true;
	end;
	export builds :=
	record, maxlength(themax)
		string								logicalname						;
		dataset(Layout_Names) dSuperfiles						;
//		dataset(Layout_Names) dBuilt 								;
//		dataset(Layout_Names) dQA 									;
//		dataset(Layout_Names) dFather 							;
//		dataset(Layout_Names) dGrandfather 					;
//		dataset(Layout_Names) dBuiltQA							;
//		dataset(Layout_Names) dBuiltQAEtc						;
//		dataset(Layout_Names) dQAProdEtc						;
		string								templatename					;
		string								templatenameNew	:= ''	;
		string								logicalversion	:= ''	;
		unsigned1							nGenerations		:= 3	;
		boolean								IsNewNamingConvention	:= true;
	end;
	export all_versions :=
	record, maxlength(themax)
		string New					:= '';
		string Building			:= '';
		string Built				:= '';
		string QA						:= '';
		string Prod					:= '';
		string Father				:= '';
		string Grandfather	:= '';
		string Delete				:= '';
		string templatename	:= '';
 	end;
	export superfiles :=
	record, maxlength(themax)
		string Building			:= '';
		string Built				:= '';
		string QA						:= '';
		string Prod					:= '';
		string Father				:= '';
		string Grandfather	:= '';
		string Delete				:= '';
 	end;
	export Inputs :=
	record, maxlength(themax)
		dataset(Layout_Names) dSuperfiles						;
		string								templatename					;
		Layout_Sprays.info													;
		
	end;
end;
