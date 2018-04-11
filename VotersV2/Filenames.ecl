import tools, Data_Services;

export Filenames(
	 const string pversion							= ''
	,string				pstate								= ''	
	,boolean			pUseOtherEnvironment	= false
) :=
module

	shared lthor				:= if(pUseOtherEnvironment 
															,Data_Services.foreign_prod + 'thor_data400::',
															'~thor_data400::'
														);

export Input := module
		export lInputTemplate			:= 	lthor + 'in::'   + _Dataset().name + '::@version@';
		
		export Input   						:= 	tools.mod_FilenamesInput(lInputTemplate,pFileDate := pversion);
		
		export dall_filenames :=
			  Input.dall_filenames
			;

end;

end;