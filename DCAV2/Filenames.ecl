import tools;
export Filenames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lversiondate	:= pversion														;
	shared lInputRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	;
	shared lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	;

	export Input := 
	module
		export int					:= tools.mod_FilenamesInput(lInputRoot	+ 'int'								,lversiondate);
		export prv					:= tools.mod_FilenamesInput(lInputRoot	+ 'prv'								,lversiondate);
		export pub					:= tools.mod_FilenamesInput(lInputRoot	+ 'pub'								,lversiondate);
		export privco				:= tools.mod_FilenamesInput(lInputRoot	+ 'privco'						,lversiondate);
		export affpeople		:= tools.mod_FilenamesInput(lInputRoot	+ 'affpeople'					,lversiondate);
		export affboards		:= tools.mod_FilenamesInput(lInputRoot	+ 'affboards'					,lversiondate);
		export affPositions	:= tools.mod_FilenamesInput(lInputRoot	+ 'affPositions'			,lversiondate);
		export killReport		:= tools.mod_FilenamesInput(lInputRoot	+ 'KillReport'				,lversiondate);
		export MergerAcquis	:= tools.mod_FilenamesInput(lInputRoot	+ 'MergerAcquisitions',lversiondate);
		
		export dAll_filenames := 
					int.dAll_filenames
				+	prv.dAll_filenames
				+	pub.dAll_filenames
				+ privco.dAll_filenames
				+ affpeople.dAll_filenames
				+ affboards.dAll_filenames
				+ affPositions.dAll_filenames
				+ killReport.dAll_filenames
				+ MergerAcquis.dAll_filenames
			; 
	end;

	export Base :=
	module
		export Companies	:= tools.mod_FilenamesBuild(lfileRoot + 'Companies'	,lversiondate);
		export Contacts		:= tools.mod_FilenamesBuild(lfileRoot + 'Contacts'	,lversiondate);
	end;
	
	export dAll_filenames := 
				Base.Companies.dAll_filenames
			+ Base.Contacts.dAll_filenames
		; 
end;
