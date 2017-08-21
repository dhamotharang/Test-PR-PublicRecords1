import lib_fileservices, _Control;
export Layout_fun_CopyFiles :=
module
	export SlimIn :=
	record
		string 					srclogicalname          ;
		string 					destinationgroup 				;
	end;
	export SlimOut2 :=
	record
		string 					srclogicalname;
		string 					destinationgroup 		;
		boolean					sourcefileexists;
		string 					templogicalname;
		dataset(lib_fileservices.FsLogicalFileNameRecord)	dSuperfilenames;
		boolean					willCompress;
		boolean					willcopy;
    string          filedescription;
	end;

	export SlimInput :=
	record
		string 					srclogicalname;
		string 					destinationgroup 				:= fun_Groupname();
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
		string200 					srclogicalname;
		string200 					destinationlogicalname;					
		string50 					destinationgroup 				:= fun_Groupname();
		string50 					srcdali									:= _Control.IPAddress.prod_thor_dali;//_Control.IPAddress.prod_thor_dali;
		dataset(lib_fileservices.FsLogicalFileNameRecord)	dSuperfilenames := dataset([],lib_fileservices.FsLogicalFileNameRecord);
	end;
	export out :=
	record
		string 					srclogicalname;
    string          filedescription;
		string 					destinationgroup 		:= fun_Groupname();
		string 					destinationlogicalname;					
		string 					srcdali					:= _Control.IPAddress.prod_thor_dali;
		dataset(lib_fileservices.FsLogicalFileNameRecord)	dSuperfilenames;
		boolean					IsALocalCopy;
		boolean					willCompress;
		boolean					willOverwrite;
		boolean					sourcefileexists;
		boolean					destinationfileexists;
		boolean					willcopy;
	end;
end;
