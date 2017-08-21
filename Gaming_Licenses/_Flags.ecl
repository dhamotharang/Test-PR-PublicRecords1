import _control;

export _Flags :=
module

	export IsTesting := if(_Control.ThisEnvironment.Name = 'Dataland'
													,true		// If running on dataland, assume you are testing
													,false	// If not running on dataland, assume production
												);


	export ExistNJCurrentSprayed  := count(nothor(fileservices.superfilecontents(filenames().input.nj.using	))) > 0;
	export ExistNJBaseFile		 		:= count(nothor(fileservices.superfilecontents(filenames().base.nj.qa			))) > 0;
	
	export IsUpdateFullFile				:= true;	//Current/historical flag depends on this

	export Update :=
	module
		 export boolean NJ := ExistNJCurrentSprayed and ExistNJBaseFile;
	end;

end; 