IMPORT tools, MPRD, ut, data_services;

EXPORT Files(STRING pversion = '', boolean pUseProd = true) := MODULE

   /* Input File Versions */
	 export idv_basc_file 		            := dataset(MPRD.Filenames(pversion,pUseProd).individual_lInputTemplate, MPRD.layouts.individual_In, csv( separator('|'),heading(0), terminator(['\n', '\r\n']),QUOTE('')))(taxonomy<>'taxonomy');
	 export taxonomy_full_lu_file         := dataset(MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_lInputTemplate, MPRD.layouts.taxonomy_full_lu_in, csv( separator('|'),heading(0), terminator(['\n', '\r\n']), quote(['\'','"'])));

	 /* Base File Versions */
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).individual_Base, MPRD.layouts.individual_base, individual_base);
	 tools.mac_FilesBase(MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_Base, MPRD.layouts.taxonomy_full_lu_base, taxonomy_full_lu_Base);	 
END;