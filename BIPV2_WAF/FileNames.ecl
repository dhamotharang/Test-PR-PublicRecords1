import tools;

export Filenames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	//BC Template
	shared lBCTemplate	 := _Constants(pUseProd).thor_cluster_Files +'base::BIPV2::Business_header::@version@::contacts'			;

	//Contact base file
  export Base_BIP_BizContacts		 := tools.mod_FilenamesBuild(lBCTemplate	 ,pversion );
  
	
	export dAll_filenames :=
		   Base_BIP_BizContacts.dAll_filenames		 
	;

end;