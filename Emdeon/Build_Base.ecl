IMPORT _control, versioncontrol, Emdeon;

EXPORT Build_Base := MODULE

	EXPORT build_base_claims(
		STRING pVersion
		,BOOLEAN pUseProd = FALSE
		,DATASET(Emdeon.Layouts.base.c_record )pBaseFile = Emdeon.Files().claims_base.qa ) := MODULE

		SHARED update_base_claims := Emdeon.Update_Base(pVersion,pUseProd).Claims_Base;
		VersionControl.macBuildNewLogicalFile(
			Emdeon.Filenames(pVersion, pUseProd).claims_base.new
			,update_base_claims
			,Build_Claims_Base
			);
		SHARED full_build_claims := SEQUENTIAL(
			Build_Claims_Base
			,Emdeon.Promote.promote_Claims(pVersion, pUseProd).buildfiles.New2Built);

		EXPORT claims_all :=
		IF(VersionControl.IsValidVersion(pVersion)
			,full_build_claims
			,OUTPUT('No Valid version parameter passed, skipping claims build'));
	END;

	EXPORT build_base_splits(
		STRING pVersion
		,BOOLEAN pUseProd = FALSE
		,DATASET(Emdeon.Layouts.base.s_record )pBaseFile = Emdeon.Files().splits_base.qa ) := MODULE

		SHARED update_base_splits := Emdeon.Update_Base(pVersion,pUseProd).Splits_Base;
		VersionControl.macBuildNewLogicalFile(
			Emdeon.Filenames(pVersion, pUseProd).splits_base.new
			,update_base_splits
			,Build_Splits_Base
			);
		SHARED full_build_splits := SEQUENTIAL(
			Build_Splits_Base
			,Emdeon.Promote.promote_splits(pVersion, pUseProd).buildfiles.New2Built);

		EXPORT splits_all :=
		IF(VersionControl.IsValidVersion(pVersion)
			,full_build_splits
			,OUTPUT('No Valid version parameter passed, skipping splits build'));
	END;

	EXPORT build_base_detail(
		STRING pVersion
		,BOOLEAN pUseProd = FALSE
		,DATASET(Emdeon.Layouts.base.d_record )pBaseFile = Emdeon.Files().detail_base.qa ) := MODULE

		SHARED update_base_detail := Emdeon.Update_Base(pVersion,pUseProd).detail_Base;
		VersionControl.macBuildNewLogicalFile(
			Emdeon.Filenames(pVersion, pUseProd).detail_base.new
			,update_base_detail
			,Build_Detail_Base
			);
		SHARED full_build_detail := SEQUENTIAL(
			Build_Detail_Base
			,Emdeon.Promote.promote_detail(pVersion, pUseProd).buildfiles.New2Built);

		EXPORT detail_all :=
		IF(VersionControl.IsValidVersion(pVersion)
			,full_build_detail
			,OUTPUT('No Valid version parameter passed, skipping detail build'));
	END;

END;
