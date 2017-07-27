import _control;

export _Flags :=
module

	export IsTesting := if(_Control.ThisEnvironment.Name = 'Dataland'
													,true		// If running on dataland, assume you are testing
													,false	// If not running on dataland, assume production
												);

  export ExistISDACurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.ISDA.using	))) > 0;
	export ExistISDAACurrentSprayed		:= count(nothor(fileservices.superfilecontents(filenames().input.ISDAA.using	))) > 0;
  export ExistIADCurrentSprayed		  := count(nothor(fileservices.superfilecontents(filenames().input.IAD.using	))) > 0;
	export ExistIAGCurrentSprayed		  := count(nothor(fileservices.superfilecontents(filenames().input.IAG.using	))) > 0;
	
	export ExistAllCurrentSprayed		:= ExistISDACurrentSprayed AND
	                                   ExistISDAACurrentSprayed AND
																		 ExistIADCurrentSprayed AND
	                                   ExistIAGCurrentSprayed;

	export ExistAllBaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.Combined.qa			))) > 0;

	export Update :=
	module
  	export boolean _All := ExistAllCurrentSprayed and ExistAllBaseFile;
	end;

end;