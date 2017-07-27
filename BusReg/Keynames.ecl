import versioncontrol;

export Keynames(

	 string		pversion = ''
	,boolean	pUseProd = false

) :=
module

	export Roxie :=
	module
	
		export company_old_Template	:= _Dataset(pUseProd).thor_cluster_files + 'key::'	+ _dataset().Name + '_company';
		export company_new_Template	:= _Dataset(pUseProd).thor_cluster_files + 'key::'	+ _dataset().Name + '::@version@::company';
		
		export contact_old_Template	:= _Dataset(pUseProd).thor_cluster_files + 'key::'	+ _dataset().Name + '_contact';
		export contact_new_Template	:= _Dataset(pUseProd).thor_cluster_files + 'key::'	+ _dataset().Name + '::@version@::contact';

		export Companies :=
		module
		
			export Bdid	:= versioncontrol.mBuildFilenameVersions(company_old_Template + '_bdid',	pversion,company_new_Template + '_bdid');
			
			export dAll_filenames := 
				Bdid.dAll_filenames
				;

		end;
		
		export Contacts :=
		module
		
			export Bdid	:= versioncontrol.mBuildFilenameVersions(contact_old_Template + '_bdid',	pversion,contact_new_Template + '_bdid');
		
			export dAll_filenames := 
				Bdid.dAll_filenames
				;
		
		end;

		export LinkIDS :=
		module
		
			export Company_Link_IDS	:= versioncontrol.mBuildFilenameVersions(company_old_Template + '_linkids',	pversion,company_new_Template + '_linkids');
		
			export dAll_filenames := 
				Company_Link_IDS.dAll_filenames
				;
		
		end;

		export dAll_filenames := 
				Companies.dAll_filenames
			+ Contacts.dAll_filenames
			+ LinkIDS.dAll_filenames
			;

	end;

	
	export Moxie :=
	module
		
		shared numgens			:= 1;
		shared lversiondate := pversion;
		export lRoot				:= _Dataset(pUseProd).thor_cluster_Files + 'key::moxie.'+ _Dataset().Name;

		export Companies :=
		module

			Shared llRootOld	:= lroot 			+ '_company.'		;
			shared llRoot			:= llRootOld	+ '@version@.'	;
			shared fMyRoot(boolean pUseOld)	:= if(pUseOld, llRootOld, llRoot);

			export Bdid	:= versioncontrol.mBuildFilenameVersions(fMyRoot(true) + 'bdid.key'			,lversiondate	,fMyRoot(false) + 'bdid.key'			,numgens);
			export Fpos	:= versioncontrol.mBuildFilenameVersions(fMyRoot(true) + 'fpos.data.key',lversiondate	,fMyRoot(false) + 'fpos.data.key',numgens);

			export dAll_filenames := 
				Bdid.dAll_filenames
			+	Fpos.dAll_filenames
			;

		end;
		
		export Contacts :=
		module

			Shared llRootOld	:= lroot 			+ '_contacts.'		;
			shared llRoot			:= llRootOld	+ '@version@.'	;
			shared fMyRoot(boolean pUseOld)	:= if(pUseOld, llRootOld, llRoot);

			export Bdid	:= versioncontrol.mBuildFilenameVersions(fMyRoot(true) + 'bdid.key'			,lversiondate	,fMyRoot(false) + 'bdid.key'			,numgens);
			export Fpos	:= versioncontrol.mBuildFilenameVersions(fMyRoot(true) + 'fpos.data.key',lversiondate	,fMyRoot(false) + 'fpos.data.key',numgens);

			export dAll_filenames := 
				Bdid.dAll_filenames
			+	Fpos.dAll_filenames
			;

		end;

		export dAll_filenames := 
			Companies.dAll_filenames
		+	Contacts.dAll_filenames
		;

	end;

		export dAll_filenames := 
			Moxie.dAll_filenames
		+	Roxie.dAll_filenames
		;

end;
