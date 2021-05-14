import business_header, tools;

export Filenames(

	 string		pversion							= ''
	,boolean	pUseOtherEnvironment	= false

) :=
module

	shared lversiondate	:= pversion;
	shared lInputRoot		:= _Constants(pUseOtherEnvironment).InputTemplate;	
	shared lfileRoot		:= _Constants(pUseOtherEnvironment).FileTemplate;
	
	export Input := 
	module
		export bugatti_hdr		:= tools.mod_FilenamesInput(lInputRoot + 'bugatti_hdr',lversiondate);
		export bugatti_stats	:= tools.mod_FilenamesInput(lInputRoot + 'bugatti_stats',lversiondate);
		
		export dAll_filenames := 
					bugatti_hdr.dAll_filenames
				+	bugatti_stats.dAll_filenames; 
	end;
	
	export Base		:= 
	module
		export Header  		:= tools.mod_FilenamesBuild(lfileRoot + 'header' 		 ,lversiondate);
		export Attributes := tools.mod_FilenamesBuild(lfileRoot + 'Attributes' ,lversiondate);
		export Executives := tools.mod_FilenamesBuild(lfileRoot + 'Executives' ,lversiondate);
					     
		export dAll_filenames := 
				Header.dAll_filenames
			+	Attributes.dAll_filenames
			+	Executives.dAll_filenames			
			;
	end;

end;