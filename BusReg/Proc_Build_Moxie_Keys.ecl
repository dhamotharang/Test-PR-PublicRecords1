import Lib_KeyLib;

import doxie, VersionControl;

export proc_Build_Moxie_Keys(string pversion) :=
module

	shared knames := keynames(pversion).moxie;
	
	shared unsigned8 moxietransform(unsigned8 filepos, unsigned8 rawsize, unsigned8 headersize) :=
		if (filepos<headersize, rawsize+filepos, filepos);

	////////////////////////////////////////////////////////////////////////////////////
	// -- Company keys
	////////////////////////////////////////////////////////////////////////////////////
	export Companies :=
	module
		export Bdid := index(	 Files().out.companies.keybuild(bdid != '')
								,{bdid,(big_endian unsigned8 )__filepos}
								,knames.companies.bdid.new);

		/////////////////////////////////////////////////			
		// Company FPOS DATA KEY
		/////////////////////////////////////////////////			
		shared rawsize_company		:= sizeof(BusReg.Layout_BusReg_Company_Out) * count(Files().out.companies.keybuild) : global;
		shared headersize_company	:= sizeof(BusReg.Layout_BusReg_Company_Out) : global;

		export Fpos := INDEX(	 Files().out.companies.keybuild
								,{f:= moxietransform(__filepos,rawsize_company,headersize_company)}
								,{Files().out.companies.keybuild}
								,knames.companies.fpos.new);
	end;
	
	////////////////////////////////////////////////////////////////////////////////////
	// -- Contacts keys
	////////////////////////////////////////////////////////////////////////////////////
	export Contacts :=
	module
		export Bdid := index(	 Files().out.contacts.keybuild(bdid != '')
								,{bdid,(big_endian unsigned8 )__filepos}
								,knames.contacts.bdid.new);

		shared rawsize_contacts	:= sizeof(BusReg.Layout_BusReg_contact_Out) * count(Files().out.contacts.keybuild) : global;
		shared headersize_contacts	:= sizeof(BusReg.Layout_BusReg_contact_Out) : global;

		export Fpos := INDEX(	 Files().out.contacts.keybuild
								,{f:= moxietransform(__filepos, rawsize_contacts, headersize_contacts)}
								,{Files().out.contacts.keybuild}
								,knames.contacts.fpos.new);
	end;
	
	VersionControl.macBuildNewLogicalKeyWithName(companies.bdid	,knames.companies.bdid.new	,BuildCompanyBdidKey	,pIsMoxieKey := true);
	VersionControl.macBuildNewLogicalKeyWithName(companies.fpos	,knames.companies.fpos.new	,BuildCompanyFposKey	,pIsMoxieKey := true);	
	VersionControl.macBuildNewLogicalKeyWithName(contacts.bdid	,knames.contacts.bdid.new		,BuildContactBdidKey	,pIsMoxieKey := true);
	VersionControl.macBuildNewLogicalKeyWithName(contacts.fpos	,knames.contacts.fpos.new		,BuildContactFposKey	,pIsMoxieKey := true);	
	
	export full_build :=
	sequential(
		 parallel(
			 BuildCompanyBdidKey
			,BuildCompanyFposKey
			,BuildContactBdidKey
			,BuildContactFposKey
		 ) 
		,Promote(pversion, 'moxie').New2Built
	);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping BusReg.Proc_Build_Moxie_Keys atribute')
	);

end;