import tools;

export Filenames(
	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false
) :=
module
	shared lversiondate	:= pversion														;
	shared lInputRoot		:= _Constants(pUseOtherEnvironment).InputTemplate	+ 'data'	;
	shared lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate	+ 'data'	;
	shared lOutRoot			:= _Constants(pUseOtherEnvironment).outTemplate		+ 'data'	;
	export Input				:= tools.mod_FilenamesInput(lInputRoot,lversiondate);
	export Base					:= tools.mod_FilenamesBuild(lfileRoot ,lversiondate);
	export Out					:= tools.mod_FilenamesBuild(lOutRoot 	,lversiondate);
		     
	export dAll_filenames := 
			Base.dAll_filenames
		+	Out.dAll_filenames
		; 
end;
