//Defines full build process
IMPORT _control, versioncontrol,hms;

EXPORT Build_Base := module
/*==============================================================
|   Individual
+==============================================================*/

	EXPORT build_base_Individual(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.Individual_Base						) pBaseFile						= Files().Individual_base.qa ) := MODULE

		EXPORT build_base_individual	:= Update_base(pversion, pUseProd).Individual_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_base.new
					,build_base_individual
					,Build_Individual_Base
		);

		EXPORT full_build_Individual	:=
			SEQUENTIAL(
				Build_Individual_base
				,Promote.promote_individual(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual
				,output('No Valid version parameter passed, skipping Individual build')
		);
	END;

/*==============================================================
|   Individual Addresses
+==============================================================*/

	EXPORT build_base_Individual_Addresses(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.individual_addresses_base						) pBaseFile						= Files().Individual_Addresses_base.qa ) := MODULE

		EXPORT build_base_individual_Addresses	:= Update_base(pversion, pUseProd).Individual_Addresses_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Addresses_base.new
					,build_base_individual_Addresses
					,Build_Individual_Addresses_base
		);

		EXPORT full_build_Individual_Addresses	:=
			SEQUENTIAL(
				Build_Individual_Addresses_base
				,Promote.promote_individual_addresses(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Addresses_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Addresses
				,output('No Valid version parameter passed, skipping Individual Addresses build')
		);
	END;

/*==============================================================
|   Individual State Licenses
+==============================================================*/

	EXPORT build_base_Individual_State_Licenses(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.individual_state_licenses_base						) pBaseFile						= Files().Individual_State_Licenses_base.qa ) := MODULE

		EXPORT build_base_Individual_State_Licenses	:= Update_base(pversion, pUseProd).Individual_State_Licenses_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_State_Licenses_base.new
					,build_base_Individual_State_Licenses
					,Build_Individual_State_Licenses_base
		);

		EXPORT full_build_Individual_State_Licenses	:=
			SEQUENTIAL(
				Build_Individual_State_Licenses_base
				,Promote.promote_individual_state_licenses(pversion, pUseProd).buildfiles.New2Built
			);

		EXPORT Individual_State_Licenses_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_State_Licenses
				,output('No Valid version parameter passed, skipping Individual State Licenses build')
		);
	END;

/*==============================================================
|   Individual Dea
+==============================================================*/

	EXPORT build_base_Individual_Dea(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.Individual_dea_base						) pBaseFile						= Files().Individual_Dea_base.qa ) := MODULE

		EXPORT build_base_Individual_Dea	:= Update_base(pversion, pUseProd).Individual_Dea_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Dea_base.new
					,build_base_Individual_Dea
					,Build_Individual_Dea_base
		);

		EXPORT full_build_Individual_Dea	:=
			SEQUENTIAL(
				Build_Individual_Dea_base
				,Promote.promote_individual_dea(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Dea_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Dea
				,output('No Valid version parameter passed, skipping Individual Dea build')
		);
	END;

/*==============================================================
|   Individual State Csr
+==============================================================*/

	EXPORT build_base_Individual_State_Csr(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.Individual_State_Csr_base						) pBaseFile						= Files().Individual_State_Csr_base.qa ) := MODULE

		EXPORT build_base_Individual_State_Csr	:= Update_base(pversion, pUseProd).Individual_State_Csr_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_State_Csr_base.new
					,build_base_Individual_State_Csr
					,Build_Individual_State_Csr_base
		);

		EXPORT full_build_Individual_State_Csr	:=
			SEQUENTIAL(
				Build_Individual_State_Csr_base
				,Promote.promote_individual_state_csr(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_State_Csr_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_State_Csr
				,output('No Valid version parameter passed, skipping Individual State Csr build')
		);
	END;

/*==============================================================
|   Individual Sanctions
+==============================================================*/

	EXPORT build_base_Individual_Sanctions(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.Individual_Sanctions_base						) pBaseFile						= Files().Individual_Sanctions_base.qa ) := MODULE

		EXPORT build_base_Individual_Sanctions	:= Update_base(pversion, pUseProd).Individual_Sanctions_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Sanctions_base.new
					,build_base_Individual_Sanctions
					,Build_Individual_Sanctions_base
		);

		EXPORT full_build_Individual_Sanctions	:=
			SEQUENTIAL(
				Build_Individual_Sanctions_base
				,Promote.promote_individual_sanctions(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Sanctions_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Sanctions
				,output('No Valid version parameter passed, skipping Individual Sanctions build')
		);
	END;

/*==============================================================
|   Individual Gsa Sanctions
+==============================================================*/

	EXPORT build_base_Individual_Gsa_Sanctions(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.individual_gsa_sanctions_base						) pBaseFile						= Files().Individual_Gsa_Sanctions_base.qa ) := MODULE

		EXPORT build_base_Individual_Gsa_Sanctions	:= Update_base(pversion, pUseProd).Individual_Gsa_Sanctions_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Gsa_Sanctions_base.new
					,build_base_Individual_Gsa_Sanctions
					,Build_Individual_Gsa_Sanctions_base
		);

		EXPORT full_build_Individual_Gsa_Sanctions	:=
			SEQUENTIAL(
				Build_Individual_Gsa_Sanctions_base
				,Promote.promote_individual_gsa_sanctions(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Gsa_Sanctions_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Gsa_Sanctions
				,output('No Valid version parameter passed, skipping Individual Gsa Sanctions build')
		);
	END;

/*==============================================================
|   State License Types
+==============================================================*/

	EXPORT build_base_State_License_Types(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.State_License_Types_Base						) pBaseFile						= Files().State_License_Types_base.qa ) := MODULE

		EXPORT build_base_State_License_Types	:= Update_base(pversion, pUseProd).State_License_Types_base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).State_License_Types_base.new
					,build_base_State_License_Types
					,Build_State_License_Types_base
		);

		EXPORT full_build_State_License_Types	:=
			SEQUENTIAL(
				Build_State_License_Types_base
				,Promote.promote_State_License_Types(pversion, pUseProd).buildfiles.New2Built);

		EXPORT State_License_Types_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_State_License_Types
				,output('No Valid version parameter passed, skipping State License Types build')
		);
	END;

/*==============================================================
|   Individual_Address_Faxes
+==============================================================*/

	EXPORT build_base_Individual_Address_Faxes(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.individual_address_faxes_base	) pBaseFile						
					= Files().individual_address_faxes_base.qa ) := MODULE

		EXPORT build_base_Individual_Address_Faxes	:= Update_base(pversion, pUseProd).Individual_Address_Faxes_Base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Address_Faxes_Base.new
					,build_base_Individual_Address_Faxes
					,Build_Individual_Address_Faxes_base
		);

		EXPORT full_build_Individual_Address_Faxes	:=
			SEQUENTIAL(
				Build_Individual_Address_Faxes_base
				,Promote.promote_Individual_Address_Faxes(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Address_Faxes_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Address_Faxes
				,output('No Valid version parameter passed, skipping Individual_Address_Faxes build')
		);
	END;

/*==============================================================
|   Individual_Address_Phones
+==============================================================*/

	EXPORT build_base_Individual_Address_Phones(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.individual_address_phones_base	) pBaseFile						
					= Files().individual_address_phones_base.qa ) := MODULE

		EXPORT build_base_Individual_Address_Phones	:= Update_base(pversion, pUseProd).Individual_Address_Phones_Base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Address_Phones_Base.new
					,build_base_Individual_Address_Phones
					,Build_Individual_Address_Phones_base
		);

		EXPORT full_build_Individual_Address_Phones	:=
			SEQUENTIAL(
				Build_Individual_Address_Phones_base
				,Promote.promote_Individual_Address_Phones(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Address_Phones_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Address_Phones
				,output('No Valid version parameter passed, skipping Individual_Address_Phones build')
		);
	END;

/*==============================================================
|   Individual_Certifications
+==============================================================*/

	EXPORT build_base_Individual_Certifications(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.individual_certifications_base	) pBaseFile						
					= Files().individual_certifications_base.qa ) := MODULE

		EXPORT build_base_Individual_Certifications	:= Update_base(pversion, pUseProd).Individual_Certifications_Base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Certifications_Base.new
					,build_base_Individual_Certifications
					,Build_Individual_Certifications_base
		);

		EXPORT full_build_Individual_Certifications	:=
			SEQUENTIAL(
				Build_Individual_Certifications_base
				,Promote.promote_Individual_Certifications(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Certifications_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Certifications
				,output('No Valid version parameter passed, skipping Individual_Certifications build')
		);
	END;
/*==============================================================
|   Individual_Covered_Recipients
+==============================================================*/

	EXPORT build_base_Individual_Covered_Recipients(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.individual_covered_recipients_base	) pBaseFile						
					= Files().individual_covered_recipients_base.qa ) := MODULE

		EXPORT build_base_Individual_Covered_Recipients	:= Update_base(pversion, pUseProd).Individual_Covered_Recipients_Base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Covered_Recipients_Base.new
					,build_base_Individual_Covered_Recipients
					,Build_Individual_Covered_Recipients_base
		);

		EXPORT full_build_Individual_Covered_Recipients	:=
			SEQUENTIAL(
				Build_Individual_Covered_Recipients_base
				,Promote.promote_Individual_Covered_Recipients(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Covered_Recipients_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Covered_Recipients
				,output('No Valid version parameter passed, skipping Individual_Covered_Recipients build')
		);
	END;

/*==============================================================
|   Individual_Education
+==============================================================*/

	EXPORT build_base_Individual_Education(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.individual_education_base	) pBaseFile						
					= Files().individual_education_base.qa ) := MODULE

		EXPORT build_base_Individual_Education	:= Update_base(pversion, pUseProd).Individual_Education_Base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Education_Base.new
					,build_base_Individual_Education
					,Build_Individual_Education_base
		);

		EXPORT full_build_Individual_Education	:=
			SEQUENTIAL(
				Build_Individual_Education_base
				,Promote.promote_Individual_Education(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Education_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Education
				,output('No Valid version parameter passed, skipping Individual_Education build')
		);
	END;

/*==============================================================
|   Individual_Languages
+==============================================================*/

	EXPORT build_base_Individual_Languages(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.individual_languages_base	) pBaseFile						
					= Files().individual_languages_base.qa ) := MODULE

		EXPORT build_base_Individual_Languages	:= Update_base(pversion, pUseProd).Individual_Languages_Base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Languages_Base.new
					,build_base_Individual_Languages
					,Build_Individual_Languages_base
		);

		EXPORT full_build_Individual_Languages	:=
			SEQUENTIAL(
				Build_Individual_Languages_base
				,Promote.promote_Individual_Languages(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Languages_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Languages
				,output('No Valid version parameter passed, skipping Individual_Languages build')
		);
	END;

/*==============================================================
|   Individual_Specialty
+==============================================================*/

	EXPORT build_base_Individual_Specialty(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.individual_specialty_base	) pBaseFile						
					= Files().individual_specialty_base.qa ) := MODULE

		EXPORT build_base_Individual_Specialty	:= Update_base(pversion, pUseProd).Individual_Specialty_Base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Individual_Specialty_Base.new
					,build_base_Individual_Specialty
					,Build_Individual_Specialty_base
		);

		EXPORT full_build_Individual_Specialty	:=
			SEQUENTIAL(
				Build_Individual_Specialty_base
				,Promote.promote_Individual_Specialty(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Individual_Specialty_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Individual_Specialty
				,output('No Valid version parameter passed, skipping Individual_Specialty build')
		);
	END;

/*==============================================================
|   PIID_Migration
+==============================================================*/

	EXPORT build_base_piid_migration(
		STRING			pversion
		,BOOLEAN		pUseProd		= false
		,DATASET(Layouts.piid_migration_base	) pBaseFile						
					= Files().piid_migration_base.qa ) := MODULE

		EXPORT build_base_Piid_Migration	:= Update_base(pversion, pUseProd).Piid_Migration_Base;
		VersionControl.macBuildNewLogicalFile(
					Filenames(pversion,pUseProd).Piid_Migration_Base.new
					,build_base_Piid_Migration
					,Build_Piid_Migration_base
		);

		EXPORT full_build_Piid_Migration	:=
			SEQUENTIAL(
				Build_Piid_Migration_base
				,Promote.promote_Piid_Migration(pversion, pUseProd).buildfiles.New2Built);

		EXPORT Piid_Migration_all	:=	 	if(VersionControl.IsValidVersion(pversion)
				,full_build_Piid_Migration
				,output('No Valid version parameter passed, skipping PIID_Migration build')
		);
	END;

END;
