import _control, tools;

export _Flags :=
module

	export IsTesting 							:= tools._Constants.IsDataland;
	
	export UseStandardizePersists := not IsTesting;	// for bug 26170 -- Missing dependency from persist to stored
	
	export ExistCurrentSprayed		:= (count(nothor(fileservices.superfilecontents(filenames().input.using		))) > 0) or
																	 (count(nothor(fileservices.superfilecontents(filenames().input.sprayed	))) > 0)
																	;
	export ExistBaseFile					:= count(nothor(fileservices.superfilecontents(filenames().base.qa			))) > 0;

	export Update 								:= ExistCurrentSprayed and ExistBaseFile;

	export IsUpdateFullFile				:= true;	//Current/historical flag depends on this

	export MaxDtVendorLastReported	:= max(Files().base.qa, dt_vendor_last_reported) : stored('MaxDtVendorLastReported');

end;