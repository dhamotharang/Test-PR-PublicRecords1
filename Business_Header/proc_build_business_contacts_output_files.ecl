IMPORT Business_Header, ut, roxiekeybuild, versioncontrol, header_services;

export proc_build_business_contacts_output_files(

	 string																pversion
	,dataset(Layout_Business_Contact_Out)	pBc_Out		= BC_Out	()

) := 
module

	shared Outnames	:= filenames(pversion).out;

	// Create the Business Contacts Output File
	VersionControl.macBuildNewLogicalFile( Outnames.contacts.new			,pBc_Out											,Buildcontactsout	);
	
	//use logical files built above in these counts, otherwise in resubmits, it will always run them even if it already has
	shared contactsdids	:= count(Files(pversion).Out.Contacts.new			((integer) did > 0)) : persist(persistnames().buscontactsdids	);
	
	shared BuscontactsDidsout	:= output(contactsdids	,named('BusContactsDids'	));
                                                                                           
	export all := 
	sequential(
		 Buildcontactsout	
		,promote(pversion,'out').new2built
		,BuscontactsDidsout
	); 

end;