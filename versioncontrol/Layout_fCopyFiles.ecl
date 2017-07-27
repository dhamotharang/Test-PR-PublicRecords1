import lib_fileservices, _Control;
export Layout_fCopyFiles :=
module

	export Input :=
	record
		string 					srclogicalname;
		string 					destinationgroup 		:= '\'thor_data400\'';
		string 					destinationlogicalname;					
		string 					srcdali					:= _Control.IPAddress.dataland_dali;
		dataset(lib_fileservices.FsLogicalFileNameRecord)	dSuperfilenames;
	end;

end;