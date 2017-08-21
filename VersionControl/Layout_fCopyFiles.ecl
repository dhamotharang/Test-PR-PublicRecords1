import lib_fileservices, _Control;
export Layout_fCopyFiles :=
module

	export SlimInput :=
	record
		string 					srclogicalname;
		string 					destinationgroup 				:= '\'thor_dataland_linux\'';
		string 					destinationlogicalname;					
	end;

	export SlimOut :=
	record
		string 					srclogicalname;
		string 					destinationgroup 		:= '\'thor_dataland_linux\'';
		string 					templogicalname;
		string 					destinationlogicalname;					
		dataset(lib_fileservices.FsLogicalFileNameRecord)	dSuperfilenames;
		boolean					willCompress;
		boolean					willOverwrite;
		boolean					sourcefileexists;
		boolean					destinationfileexists;
		boolean					willcopy;
		boolean					NeedToRenameFirst;
	end;

	export Input :=
	record
		string 					srclogicalname;
		string 					destinationgroup 		:= '\'thor_dataland_linux\'';
		string 					destinationlogicalname;					
		string 					srcdali					:= _Control.IPAddress.prod_thor_dali;
		dataset(lib_fileservices.FsLogicalFileNameRecord)	dSuperfilenames;
	end;

	export out :=
	record
		string 					srclogicalname;
		string 					destinationgroup 		:= '\'thor_dataland_linux\'';
		string 					destinationlogicalname;					
		string 					srcdali					:= _Control.IPAddress.prod_thor_dali;
		dataset(lib_fileservices.FsLogicalFileNameRecord)	dSuperfilenames;
		boolean					willCompress;
		boolean					willOverwrite;
		boolean					fileexists;
		boolean					willcopy;
	end;

end;