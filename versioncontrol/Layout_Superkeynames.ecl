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
	record, maxlength(10000)
	
		string								subfilename				;
		DATASET(layout_names)	dSubfileContainers;
	
	end;

end;	