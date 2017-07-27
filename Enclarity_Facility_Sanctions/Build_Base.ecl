import _control, versioncontrol;

export Build_Base := module
   	
	EXPORT build_base_facility_sanctions(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Enclarity_facility_sanctions.Layouts.Base.facility_sanctions) pBaseFile = Enclarity_facility_sanctions.Files().facility_sanctions_base.qa ) := module
			
					export build_base_facility_sanctions			:= Enclarity_facility_sanctions.Update_base(pversion, pUseProd).facility_sanctions_base;
					VersionControl.macBuildNewLogicalFile(
															 Filenames(pversion,pUseProd).facility_sanctions_base.new																			  																	 																				 																			 
															,build_base_facility_sanctions
															,Build_sanctions_Base
					);
	
					export full_build_sanctions	:=
						sequential(
									 Build_sanctions_base
									,Promote.promote_facility_sanctions(pversion, pUseProd).buildfiles.New2Built);
	
					export facility_sanctions_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_sanctions
						,output('No Valid version parameter passed, skipping sanction build')
					);
	END;
					
END;