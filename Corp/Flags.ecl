export Flags :=
module

	export Update :=
	module
	
		export Corp		:= true;
		export Cont		:= true;
		export Events	:= true;
		export Stock	:= true;
		export AR			:= true;
	
	end;
	
	export IsUsingV2Inputs		:= true; // master switch for using V2
	export UseV2CurrentSprayed	:= true; // true, use Corp2.Files.input.xxx.sprayed -- if corpv2 build has not been run
																			 // false use Corp2.Files.input.xxx.used -- if corpv2 build has been run

end;