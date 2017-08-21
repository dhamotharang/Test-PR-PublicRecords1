import business_header, tools;
export Filenames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module

	shared lversiondate	:= pversion																									;

	export Input := 
	module
		shared lvictorRoot			:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'victor'		;
		shared llogs_thorRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'logs_thor'	;
		shared lprod_thorRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'prod_thor'	;

		export victor						:= tools.mod_FilenamesInput(lvictorRoot			,lversiondate);
		export logs_thor				:= tools.mod_FilenamesInput(llogs_thorRoot	,lversiondate);
		export prod_thor				:= tools.mod_FilenamesInput(lprod_thorRoot	,lversiondate);

		export dAll_filenames := 
				logs_thor.dAll_filenames
			+	prod_thor.dAll_filenames
			; 

	end;
	
	export Base :=
	module
		shared llogs_thorRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'logs_thor'	;
		shared lprod_thorRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'prod_thor'	;
		export logs_thor				:= tools.mod_FilenamesBuild(llogs_thorRoot		,lversiondate);
		export prod_thor				:= tools.mod_FilenamesBuild(lprod_thorRoot		,lversiondate);
		export dAll_filenames := 
				logs_thor.dAll_filenames
			+	prod_thor.dAll_filenames
			; 
	end;

	export dAll_filenames := 
			Base.dAll_filenames
		; 

end;
