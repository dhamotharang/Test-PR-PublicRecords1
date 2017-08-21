import corp;
export Flags :=
module
	
	export Update :=
	module
		// -- Flags to tell the process to either:
		// -- true	-- Merge the existing base file with the sprayed inputs(normal build)
		// -- false -- Recreate the base file from the inputs(current base file is not used)
		// -- Default: true
		export Main		:= true;
		export Events	:= true;
		export Stock	:= true;
		export AR			:= true;
	
	end;
	
	export ExistEventsV2CurrentSprayed	:= count(nothor(fileservices.superfilecontents(corp2.filenames('').input.Events.using	))) > 0;
	export ExistMainV2CurrentSprayed		:= count(nothor(fileservices.superfilecontents(corp2.filenames('').input.Main.using		))) > 0;
	export ExistStockV2CurrentSprayed		:= count(nothor(fileservices.superfilecontents(corp2.filenames('').input.Stock.using	))) > 0;
	export ExistARV2CurrentSprayed			:= count(nothor(fileservices.superfilecontents(corp2.filenames('').input.AR.using			))) > 0;
	
	export IsTesting										:= IsTesting;		// -- Is testing the build? default: false.  If true, only sends emails to person running the build, not everybody
       
end;