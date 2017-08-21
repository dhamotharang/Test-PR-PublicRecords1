IMPORT _control, versioncontrol, hxmx;

EXPORT Build_Base := MODULE

	EXPORT build_base_hx(
		STRING				pVersion
		,BOOLEAN			pUseProd		= FALSE
		,DATASET(hxmx.Layouts.base.hx_record		)pBaseFile		= hxmx.Files().hx_base.qa	) := MODULE

		SHARED update_base_hx := hxmx.Update_Base(pVersion,pUseProd).hx_Base;
		VersionControl.macBuildNewLogicalFile(
												hxmx.Filenames(pVersion, pUseProd).hx_base.new
												,update_base_hx
												,Build_hx_Base
												);
		SHARED full_build_hx	:=  sequential(				
						 		 Build_hx_Base
								,hxmx.Promote.promote_hx(pVersion, pUseProd).buildfiles.New2Built);

		EXPORT hx_all	:=
			IF(VersionControl.IsValidVersion(pVersion)
						,full_build_hx
						,output('No Valid version parameter passed, skipping hx build'));
	END;

	EXPORT build_base_mx(
		STRING				pVersion
		,BOOLEAN			pUseProd		= FALSE
		,DATASET(hxmx.Layouts.base.mx_record		)pBaseFile		= hxmx.Files().mx_base.qa	) := MODULE

		SHARED update_base_mx := hxmx.Update_Base(pVersion,pUseProd).mx_Base;
		VersionControl.macBuildNewLogicalFile(
												hxmx.Filenames(pVersion, pUseProd).mx_base.new
												,update_base_mx
												,Build_mx_Base
												);
		SHARED full_build_mx	:=  sequential(				
						 		 Build_mx_Base
								,hxmx.Promote.promote_mx(pVersion, pUseProd).buildfiles.New2Built);

		EXPORT mx_all	:=
			IF(VersionControl.IsValidVersion(pVersion)
						,full_build_mx
						,output('No Valid version parameter passed, skipping splits build'));
	END;

END;