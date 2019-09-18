import prte2,PromoteSupers, ut, std;

EXPORT proc_build_base := FUNCTION

  PRTE2.CleanFields(Files.incoming, cln_incoming);
	
	PromoteSupers.MAC_SF_BuildProcess(cln_incoming(block_id <> ''),Constants.base_filename, basefile);
 
 RETURN basefile;

END;