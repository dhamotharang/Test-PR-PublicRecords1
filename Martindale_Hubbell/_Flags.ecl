import _control;

export _Flags :=
module

	export IsTesting := if(_Control.ThisEnvironment.Name = 'Dataland'
													,true		// If running on dataland, assume you are testing
													,false	// If not running on dataland, assume production
												);
	export IsUpdateFullFile				:= true;
	
	export UseStandardizePersists := not IsTesting;	// for bug 26170 -- Missing dependency from persist to stored

	export ExistCurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.using									))) > 0;
	export ExistOrgBaseFile				:= count(nothor(fileservices.superfilecontents(filenames().base.Organizations.qa						))) > 0;
	export ExistAffIndBaseFile		:= count(nothor(fileservices.superfilecontents(filenames().base.Affiliated_Individuals.qa		))) > 0;
	export ExistUnaffIndBaseFile	:= count(nothor(fileservices.superfilecontents(filenames().base.Unaffiliated_Individuals.qa	))) > 0;
	
	export Update :=
	module
	
		export boolean Organizations						:= ExistCurrentSprayed and ExistOrgBaseFile			;
		export boolean Affiliated_Individuals 	:= ExistCurrentSprayed and ExistAffIndBaseFile	;
		export boolean Unaffiliated_Individuals := ExistCurrentSprayed and ExistUnaffIndBaseFile;
	                                
	end;

end;