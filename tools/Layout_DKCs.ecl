import _control, lib_fileservices;
export Layout_DKCs :=
module
	export Input := 
	record, maxlength(4096)
		string		logicalkeyname					;
		string		destinationIP		:= ''		;
		string		destinationpath	:= ''		;
		boolean		allowoverwrite	:= false; 
	end;
	
	export Out := 
	record, maxlength(4096)
		string																			logicalkeyname							;
		string																			destinationIP				:= ''		;
		string																			destinationpath			:= ''		;
		boolean																			allowoverwrite			:= false; 
		boolean																			Thor_file_exists		:= false; 
		boolean																			IsSuperfile					:= false; 
		unsigned8																		Thor_File_size			:= 0		;
		unsigned8																		filesize_difference	:= 0		;
		boolean																			Remote_file_exists	:= false; 
		DATASET(Layout_Names)												dSuperfilecontents					;
		DATASET(lib_fileservices.FsFileNameRecord)	dDirectoryListing						;
		boolean																			Will_DKC						:= false; 
	end;
end;
