export proc_move_files_toQA(string mywuid) := module


//****** create the logging files for each build by hitting DID macro
shared fi := xADL_log_service.files;
shared ly := xADL_log_service.layouts;

shared newfile_name := fi.base_name + mywuid;

WriteNewFile(dataset(ly.base_log) log_file) :=
FUNCTION
	return output(log_file,,newfile_name, overwrite);
END;

//****** move new file to QA
MoveNewFileToQA() :=
FUNCTION
	return 
	sequential(
		FileServices.AddSuperFile(fi.log_qa_name, newfile_name)
	);
END;

//****** move old files to delete
MoveOldFileToDelete() :=
FUNCTION
	return 
	sequential(
		FileServices.AddSuperFile(fi.log_delete_name, fi.log_qa_name,,TRUE),
		FileServices.ClearSuperFile(fi.log_qa_name)
	);
END;

Delete() :=
FUNCTION
	return 
	sequential(
		FileServices.ClearSuperFile(fi.log_delete_name, TRUE )
	);
END;

export WriteMoveQA(dataset(ly.base_log) log_file) :=
sequential(	
	WriteNewFile(log_file),
//	MoveOldFileToDelete(),
	MoveNewFileToQA()
//	,Delete()
);

end;
