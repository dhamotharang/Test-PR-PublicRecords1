import doxie, VersionControl;

export proc_build_keys(string pversion) :=
module

	shared names := keynames(pversion).roxie;
	
	VersionControl.macBuildNewLogicalKeyWithName(key_busreg_company_bdid	,names.companies.bdid.new		,BuildCompanyBdidKey	);
	VersionControl.macBuildNewLogicalKeyWithName(key_busreg_contact_bdid	,names.contacts.bdid.new		,BuildContactBdidKey	);	
	VersionControl.macBuildNewLogicalKeyWithName(key_busreg_company_linkids.key, names.LinkIDS.Company_Link_IDS.new, BuildCompanyLinkIdsKey);
	
	export full_build :=
	sequential(
		 parallel(
							 BuildCompanyBdidKey
							,BuildContactBdidKey
							,BuildCompanyLinkIdsKey		
						  )
		,Promote(pversion, 'key').New2Built
	);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping BusReg.proc_build_keys atribute')
	);

end;