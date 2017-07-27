//Defines various flags used throughout the build
import _control;

export _Flags :=
module

	export IsTesting := if(_Control.ThisEnvironment.Name = 'Dataland'
													,true		// If running on dataland, assume you are testing
													,false	// If not running on dataland, assume production
												);

	export ExistBaseFile	  := count(nothor(fileservices.superfilecontents(filenames().base.qa				))) > 0;
	
	export IsUpdateFullFile					:= false;	//Current/historical flag depends on this

end;