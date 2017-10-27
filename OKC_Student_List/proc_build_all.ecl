// Build information/flow
// OKC direct team(Chanci) drops new OKC student list files at \\Tapeload02b\direct_from_okc\StudentDirectory
// Data upload team (Jeremy) picks up files from above location and drops them at \\Tapeload02b\K\metadata\education\student_directory_data
// File frequency is random and data upload team will create 

IMPORT Scrubs_OKC_Student_List_V2;
#stored('did_add_force', 'thor');

EXPORT proc_build_all(STRING pversion) := FUNCTION

		RETURN SEQUENTIAL(
									OKC_Student_List.fSprayFiles(pversion,,,'*')
   		    ,OKC_Student_List.Promote(pversion).inputfiles.Sprayed2Using
   					 ,OKC_Student_List.Build_Ingest_File(pversion)
   					 ,OKC_Student_List.Promote(pversion).Inputfiles.Using2Used
							  ,Scrubs_OKC_Student_List_V2.PostBuildScrubs(pversion, OKC_Student_List.Constants().email_notification_scrubs)
							  ,OKC_Student_List.proc_build_base_ingest(pversion)
							  ,OKC_Student_List.Strata_Population_Stats(pversion).all
							);
	
END;