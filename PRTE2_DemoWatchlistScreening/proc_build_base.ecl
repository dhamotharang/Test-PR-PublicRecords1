import prte2,PromoteSupers, ut, std;

EXPORT proc_build_base := FUNCTION

  // PRTE2.CleanFields(Files.incoming, cln_incoming);
		
	dsFile := project(Files.incoming(block_id <> ''), transform(layouts.base, self := left));
	PromoteSupers.MAC_SF_BuildProcess(dsFile,Constants.base_filename, basefile);
 
 RETURN basefile;

END;