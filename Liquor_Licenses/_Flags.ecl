import _control;

export _Flags :=
module

	export IsTesting := if(_Control.ThisEnvironment.Name = 'Dataland'
													,true		// If running on dataland, assume you are testing
													,false	// If not running on dataland, assume production
												);


	export ExistCACurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.CA.using	))) > 0;
	export ExistCTCurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.CT.using	))) > 0;
	export ExistINCurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.IN.using	))) > 0;
	export ExistLACurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.LA.using	))) > 0;
	export ExistOHCurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.OH.using	))) > 0;
	export ExistPACurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.PA.using	))) > 0;
	export ExistTXCurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.TX.using	))) > 0;

	export ExistCABaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.ca.qa			))) > 0;
	export ExistCTBaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.CT.qa			))) > 0;
	export ExistINBaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.IN.qa			))) > 0;
	export ExistLABaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.LA.qa			))) > 0;
	export ExistOHBaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.OH.qa			))) > 0;
	export ExistPABaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.PA.qa			))) > 0;
	export ExistTXBaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.TX.qa			))) > 0;

	export Update :=
	module

	
		export boolean CA := ExistCACurrentSprayed and ExistCABaseFile;
		export boolean CT := ExistCTCurrentSprayed and ExistCTBaseFile;
		export boolean IN := ExistINCurrentSprayed and ExistINBaseFile;
		export boolean LA := ExistLACurrentSprayed and ExistLABaseFile;
		export boolean OH := ExistOHCurrentSprayed and ExistOHBaseFile;
		export boolean PA := ExistPACurrentSprayed and ExistPABaseFile;
		export boolean TX := ExistTXCurrentSprayed and ExistTXBaseFile;
	
	end;

end;