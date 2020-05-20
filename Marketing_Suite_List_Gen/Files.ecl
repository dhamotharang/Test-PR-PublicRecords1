import tools;

export Files (
									boolean	pUseOtherEnvironment	= false
							) := module
							
	export Input	:=	module

		// Country table used to convert the name provided by the customer to the number needed for filtering of the V1 file.
		export CountyTable  := dataset('~thor_data400::lookup::marketing_suite_list_gen::CountyTable',Marketing_Suite_List_Gen.Layouts.CountyTable_Layout,CSV(SEPARATOR([[',']]), quote('"'), TERMINATOR(['\r\n', '\n']))); 
		
	end;
	
end;