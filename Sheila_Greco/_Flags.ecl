import _control;

export _Flags :=
module

	export IsTesting := if(_Control.ThisEnvironment.Name = 'Dataland'
													,true		// If running on dataland, assume you are testing
													,false	// If not running on dataland, assume production
												);
	
	export UseStandardizePersists := not IsTesting;	// for bug 26170 -- Missing dependency from persist to stored

	export ExistCompaniesSprayed	:= count(nothor(fileservices.superfilecontents(filenames().input.Companies.using	))) > 0;
	export ExistContactsSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.Contacts.using		))) > 0;

	export ExistCompaniesBaseFile	:= count(nothor(fileservices.superfilecontents(filenames().base.Companies.qa			))) > 0;
	export ExistContactsBaseFile	:= count(nothor(fileservices.superfilecontents(filenames().base.Contacts.qa				))) > 0;

	export IsUpdateFullFile				:= true;	//Current/historical flag depends on this
	
	export Update :=
	module
	
		export boolean Companies	:= ExistCompaniesSprayed	and ExistCompaniesBaseFile	;
		export boolean Contacts 	:= ExistContactsSprayed 	and ExistContactsBaseFile;
	                                                        
	end;

end;