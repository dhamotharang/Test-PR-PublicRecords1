import VersionControl;

export proc_build_base(

	 string														pversion
	,dataset(layouts.Input.Sprayed)		pUpdateFile	= Files().Input.Using
	,dataset(Layouts.Base.AID)				pBaseFile		= Files().Base.AID.QA

) :=
module

	shared dStandardizeInput	:= Standardize_Input.fAll	(pUpdateFile	,pversion);
	shared DoesInfileCheckOut := if(_Flags.ExistCurrentSprayed, fFiledateCheck(dStandardizeInput), true);
	
	export dAIDBase				:= Update_Base		(pUpdateFile, pBaseFile, pversion	) : persist(persistnames().updatebase);
	export dFullBase			:= project(dAIDBase,TRANSFORM(busReg.layouts.Base.full,SELF := LEFT;));
	export dCompaniesBase	:= Update_Company	(dAIDBase);
	export dContactsBase	:= Update_Contact	(dAIDBase);
	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.AID.new				,dAIDBase					,Build_AID_File						);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.Full.new				,dFullBase				,Build_Full_File						);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.companies.new	,dCompaniesBase		,Build_Companies_Base_File	);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.contacts.new		,dContactsBase		,Build_Contacts_Base_File		);
                                                                                          
	export full_build :=
		 sequential(
			 Promote().Input.Sprayed2Using
			,if(DoesInfileCheckOut
				,sequential(
										Build_AID_File
										,Build_Full_File
										,Build_Companies_Base_File
										,Build_Contacts_Base_File	
										,Promote().Input.Using2Used
										,Promote(pversion, 'base').New2Built
										)
				,output(_Dataset().Name + ' Build Input file does not have enough good filedates.  Check the input file ' + pversion)
			)
		);

	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping BusReg.proc_build_base atribute')
	);
		
end;