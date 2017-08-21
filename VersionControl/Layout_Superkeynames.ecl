import lib_fileservices;

export Layout_Superkeynames :=
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
		DATASET(layout_names						)	dSuperkeyContainers					;
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
		DATASET(layout_names)	dSubfileContainers;
	
	end;

	export RemoveSubfiles :=
	record, maxlength(50000)
	
		string								superfilename	;
		DATASET(layout_names)	dSubfiles			;
	
	end;

	export addtobuilding :=
	record, maxlength(50000)
	
		string								filename					;
		DATASET(layout_names)	dLogicalFiles			;
		string								newfilename				;
		boolean								IsNewFilenameEmpty;
	end;

end;	