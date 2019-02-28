//Defines full build process
IMPORT _control, versioncontrol;

EXPORT Build_Base(STRING pversion,BOOLEAN	pUseProd = FALSE) := MODULE
	
					EXPORT build_base := _VendorSrc2.UpdateBase(pversion, pUseProd).VendorSrc_Base;

					VersionControl.macBuildNewLogicalFile(
																					 Filenames(pversion, pUseProd).base.new
																				 	,build_base
																					,Build_Base_File
																					);
					SHARED full_build	:=  
						SEQUENTIAL(				
						 		 Build_Base_File
								,Promote.Promote_vendorsrc2(pversion, pUseProd).buildfiles.New2Built);
	
					EXPORT vendorsrc_all	:=
						IF(VersionControl.IsValidVersion(pversion)
								,full_build
								,OUTPUT('No Valid version parameter passed, skipping base build')
						);
					
END;