//Defines various flags used throughout the build
import _control;

export _Flags :=
module

	export IsTesting := if(_Control.ThisEnvironment.Name = 'Dataland'
													,true		// If running on dataland, assume you are testing
													,false	// If not running on dataland, assume production
												);


	export ExistJigsawLiveSprayed  	:= count(nothor(fileservices.superfilecontents(filenames().input.live.using		))) > 0;
	export ExistJigsawDeadSprayed  	:= count(nothor(fileservices.superfilecontents(filenames().input.dead.using		))) > 0;
	export ExistJigsawLockedSprayed := count(nothor(fileservices.superfilecontents(filenames().input.deletedremove.using	))) > 0;
	export ExistJigsawBaseFile		  := count(nothor(fileservices.superfilecontents(filenames().base.qa						))) > 0;
	
	export IsUpdateFullFile				:= true;	//Current/historical flag depends on this

	export Update :=
	module
		 export boolean Jigsaw := 		ExistJigsawLiveSprayed
															and ExistJigsawDeadSprayed
															and ExistJigsawLockedSprayed
															and ExistJigsawBaseFile
															;
	end;
	
	export Build_Bid_Keys := true;

end; 