//Defines full build process
IMPORT _control, versioncontrol, HMS_STLIC;

EXPORT Build_Base := MODULE

		EXPORT build_base_statelicense(
   					 string				pversion
   					,boolean			pUseProd		= false
   					,dataset(HMS_STLIC.Layouts.statelicense_base		)pBaseFile		= HMS_STLIC.Files().statelicense_Base.qa	) := module
   	
   					SHARED build_base_statelicense := HMS_STLIC.Update_Base(pversion,pUseProd).StateLicense_Base;
   					VersionControl.macBuildNewLogicalFile(
   																					 HMS_STLIC.Filenames(pversion, pUseProd).statelicense_Base.new
   																				 	,build_base_statelicense
   																					,Build_statelicense_base
																						);
   					SHARED full_build_statelicense	:=  
   						sequential(				
   						 		 Build_statelicense_base
   								,HMS_STLIC.Promote.promote_statelicense(pversion, pUseProd).buildfiles.New2Built
									);
   	
   					EXPORT statelicense_all	:=
   						if(VersionControl.IsValidVersion(pversion)
   								,full_build_statelicense
   								,output('No Valid version parameter passed, skipping State License Full build')
   						);
   		END;
			
			EXPORT build_base_stlicrollup(
   					 string				pversion
   					,boolean			pUseProd		= false
   					,dataset(HMS_STLIC.Layouts.statelicense_base		)pBaseFile		= HMS_STLIC.Files().stlicrollup_Base.qa	) := module
   	
   					SHARED build_base_stlicrollup := HMS_STLIC.Update_Base(pversion,pUseProd).stlicrollup_Base;//dataset('~thor400_data::base::hms_stl::hms_statelicense::temp::20161117',HMS_STLIC.Layouts.statelicense_base,thor);
   					VersionControl.macBuildNewLogicalFile(
   																					 HMS_STLIC.Filenames(pversion, pUseProd).stlicrollup_Base.new
   																				 	,build_base_stlicrollup
   																					,Build_stlicrollup_base
																						);
   					SHARED full_build_stlicrollup	:=  
   						sequential(				
   						 		 Build_stlicrollup_base
   								,HMS_STLIC.Promote.promote_stlicrollup(pversion, pUseProd).buildfiles.New2Built
									);
   	
   					EXPORT stlicrollup_all	:=
   						if(VersionControl.IsValidVersion(pversion)
   								,full_build_stlicrollup
   								,output('No Valid version parameter passed, skipping State License Roll-Up build')
   						);
   		END;

	
END;