import lib_fileservices;
export Layout_SuperFilenames :=
module
	export InputLayout :=
	record, maxlength(20000)
	
		string superkeyname									;
		string logicalkeynameversion	:= ''	;
	
	end;
	export superfilerenaming :=
	record
		string oldname;
		string newname;
		DATASET(Layout_Names						)	dSuperkeyContainers					;
		unsigned4													NumSuperKeycontainers	:= 0	;
	end;
	export OutputLayout :=
	record, maxlength(10000)
	
		dataset(superfilerenaming) 				dRenamingInfo								;
	
	end;
	
	export DeleteSubfilesOut :=
	record, maxlength(50000)
	
		string								subfilename				;
		boolean								doessubfileexist	;
		DATASET(Layout_Names)	dSubfileContainers;
	
	end;
	export RemoveSubfiles :=
	record, maxlength(50000)
	
		string								superfilename	;
		DATASET(Layout_Names)	dSubfiles			;
	
	end;
	export addtobuilding :=
	record, maxlength(50000)
	
		string								filename					;
		DATASET(Layout_Names)	dLogicalFiles			;
		string								newfilename				;
		boolean								IsNewFilenameEmpty;
	end;
end;
