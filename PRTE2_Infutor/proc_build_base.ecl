Import PromoteSupers, Infutor;
EXPORT proc_build_base(string filedate) := function
	 
		PromoteSupers.Mac_SF_BuildProcess(Infutor.Infutor_best(false, Files.Infutor_Header), '~prte::base::infutor_best_did',writefile,,,,filedate);  
  
		RETURN writefile;
		
End;