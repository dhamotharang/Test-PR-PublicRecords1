import Prof_License,lib_fileservices;

// module
export Infutor_pre_process(string filedate,string filename):=

module
export Infutorprep
:=sequential(
		Prof_License.File_infutor_spray(filedate,filename),
		Prof_License.File_Infutor_in(filedate),								
		FileServices.StartSuperFileTransaction(),
		
		FileServices.AddSuperFile('~thor_data400::in::prolic::allSources', 
															'~thor_data400::in::prolic_infutor' 
															),
		FileServices.FinishSuperFileTransaction()
);

end;