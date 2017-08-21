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

		
	//////////////////////////////////////////////////////////////////
	// -- Input Filename Versions
	//////////////////////////////////////////////////////////////////
	export Input :=
	module
	
		export Templates_Main		:= lthor + 'in::'	+ _Dataset().NameMapped + '::@version@::main'		+ pstate	;
		export Templates_Events	:= lthor + 'in::'	+ _Dataset().NameMapped + '::@version@::event'	+ pstate	;
		export Templates_Stock	:= lthor + 'in::'	+ _Dataset().NameMapped + '::@version@::stock'	+ pstate	;
		export Templates_AR			:= lthor + 'in::'	+ _Dataset().NameMapped + '::@version@::ar'			+ pstate	;
	        
		export Main		:= tools.mod_FilenamesInput(Templates_Main		,pFileDate := pversion);
		export Events	:= tools.mod_FilenamesInput(Templates_Events	,pFileDate := pversion);
		export Stock	:= tools.mod_FilenamesInput(Templates_Stock	  ,pFileDate := pversion);
		export AR			:= tools.mod_FilenamesInput(Templates_AR			,pFileDate := pversion);
		
		export dall_filenames :=
			  Main.dall_filenames
      + Events.dall_filenames
		  + Stock.dall_filenames                                      
			+ AR.dall_filenames
			;
	end;
	
	         
	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Base :=
	module
         
		export Templates_seglist	:= lthor + 'base::'	+ _Dataset().Name + '::@version@::seglist';
		export Templates_dict			:= lthor + 'base::'	+ _Dataset().Name + '::@version@::dict'		;
		export Templates_dstat		:= lthor + 'base::'	+ _Dataset().Name + '::@version@::dstat'	;
		export Templates_inv			:= lthor + 'base::'	+ _Dataset().Name + '::@version@::inv'		;

		export seglist	:= tools.mod_FilenamesBuild(Templates_seglist	,pversion);
		export dict			:= tools.mod_FilenamesBuild(Templates_dict		,pversion);
		export dstat		:= tools.mod_FilenamesBuild(Templates_dstat		,pversion);
		export inv			:= tools.mod_FilenamesBuild(Templates_inv			,pversion);
                                                                  
		export dall_filenames :=
			seglist.dall_filenames
			+ dict.dall_filenames
			+ dstat.dall_filenames
			+ inv.dall_filenames
			; 
		
	end;
		
	////////////////////////////////////////////////////////////////
	// -- Extended Layout Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Base_xtnd :=
	module
	
		export Templates_Corp		:= lthor + 'base::'	+ _Dataset().Name + '::@version@::corp_xtnd'	;
		export Templates_Cont		:= lthor + 'base::'	+ _Dataset().Name + '::@version@::cont_xtnd'	;
		export Templates_Events	:= lthor + 'base::'	+ _Dataset().Name + '::@version@::event_xtnd'	;
		export Templates_Stock	:= lthor + 'base::'	+ _Dataset().Name + '::@version@::stock_xtnd'	;
		export Templates_AR			:= lthor + 'base::'	+ _Dataset().Name + '::@version@::ar_xtnd'		;
		
	  export Corp							:= tools.mod_FilenamesBuild(Templates_Corp		,pversion);
		export Cont							:= tools.mod_FilenamesBuild(Templates_Cont		,pversion);
		export Events						:= tools.mod_FilenamesBuild(Templates_Events	,pversion);
		export Stock						:= tools.mod_FilenamesBuild(Templates_Stock		,pversion);
		export AR								:= tools.mod_FilenamesBuild(Templates_AR			,pversion);			
                                                                
		export dall_filenames :=
			  Corp.dall_filenames
			+ Cont.dall_filenames	
			+ Events.dall_filenames
		  + Stock.dall_filenames                                      
			+ AR.dall_filenames
			; 
		
	end;

	//////////////////////////////////////////////////////////////////
	// -- Base Filename Versions
	//////////////////////////////////////////////////////////////////
	export Stats :=
	module
	
		export Template			:= lthor + 'stats::'	+ _Dataset().Name + '::@version@::coverage'	;
	        
		export Coverage		:= tools.mod_FilenamesBuild(Template		,pversion);
                                                                  
		export dall_filenames :=
			  Coverage.dall_filenames
			; 
		
	end;
	
	export dAll_filenames := Base_xtnd.dAll_filenames
													 + Base.dAll_filenames;
		
end;