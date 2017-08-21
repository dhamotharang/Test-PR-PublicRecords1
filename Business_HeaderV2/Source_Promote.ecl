import VersionControl;

export Source_Promote(

	string pFilter = ''

) :=
module

	export new :=
	module
		
		shared lfilenames		:= Source_Filenames.New;
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,lfilenames.templatename,nocase)
													);
		export promote2bus	:= VersionControl.mPromote.BuildFiles2(lfilenames(filter)).QA2BusinessHeader;
		
	end;
	
	export newProd :=
	module
		
		shared lfilenames		:= Source_Filenames.NewProd;
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,lfilenames.templatename,nocase)
													);
		export promote2bus	:= VersionControl.mPromote.BuildFiles2(lfilenames(filter)).Prod2BusinessHeader;
		
	end;
	
	export old := 
	module
	
		shared lfilenames		:= Source_Filenames.Old			;
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,lfilenames.templatename,nocase)
													);
		export promote2bus	:= VersionControl.mPromote.BuildFiles2(lfilenames(filter)).QA2BusinessHeader;
	
	end;
	
	export oldProd := 
	module
	
		shared lfilenames		:= Source_Filenames.OldProd			;
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,lfilenames.templatename,nocase)
													);
		export promote2bus	:= VersionControl.mPromote.BuildFiles2(lfilenames(filter)).Prod2BusinessHeader;
	
	end;
/*
	export logical	:=
	module
	
		shared lfilenames		:= 	Source_Filenames.logical	;
		shared filter				:= if(pFilter = ''	,true
																						,regexfind(pFilter,lfilenames.templatename,nocase)
													);
		export promote2bus	:= VersionControl.mPromote_old.BuildFiles2(lfilenames(filter)).Old2BusinessHeader;
	
	end;
*/
	export all :=
	sequential(
		 new.promote2bus
		,newProd.promote2bus
		,old.promote2bus
		,oldProd.promote2bus
//		,logical.promote2bus
	);

end;