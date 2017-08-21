import VersionControl;

export proc_build_output_files(

	 string														pversion
	,dataset(Layout_BusReg_Company	)	pCompaniesBaseFile	= Files().Base.Companies.built
	,dataset(Layout_BusReg_Contact	)	pContactsBaseFile		= Files().Base.Contacts.built
          
) :=
module

	shared Layout_BusReg_Company_Out t2CompanyOut(Layout_BusReg_Company L) :=
	transform

		self.bdid		:= if(l.bdid=0,'',intformat(l.bdid, 12, 1));
		self.br_id	:= intformat(l.br_id, 12, 1);
		self				:= l;

	end;

	shared Layout_BusReg_Contact_Out t2ContactOut(Layout_BusReg_Contact L) :=
	transform
	
		self.bdid		:= if(l.bdid=0,'',intformat(l.bdid, 12, 1));
		self.did		:= if(l.did=0,'',intformat(l.did, 12, 1));
		self.br_id	:= intformat(l.br_id, 12, 1);
		self				:= l;

	end;

	export dCompaniesOut	:= project(pCompaniesBaseFile	,t2CompanyOut(left));
	export dContactsOut		:= project(pContactsBaseFile	,t2ContactOut(left));
                           
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.companies.new	,dCompaniesOut	,Build_Companies_Out_File	);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.contacts.new	,dContactsOut		,Build_Contacts_Out_File	);
                                                                                          
	export full_build :=
		 sequential(
			 Build_Companies_Out_File	
			,Build_Contacts_Out_File	
			,Promote(pversion, 'out').New2Built

		);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping BusReg.proc_build_output_files atribute')
	);
		
end;