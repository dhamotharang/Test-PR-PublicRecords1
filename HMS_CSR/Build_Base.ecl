//Defines full build process
IMPORT _control, versioncontrol, HMS_CSR;

EXPORT Build_Base := MODULE

		EXPORT build_base_csrcredential(
   					 string				pversion
   					,boolean			pUseProd		= false
   					,dataset(HMS_CSR.Layouts.csrcredential_base		)pBaseFile		= HMS_CSR.Files().csrcredential_Base.qa	) := module
   	
   					SHARED build_base_csrcredential := HMS_CSR.Update_Base(pversion,pUseProd).CsrCredential_Base;
   					VersionControl.macBuildNewLogicalFile(
   																					 HMS_CSR.Filenames(pversion, pUseProd).csrcredential_Base.new
   																				 	,build_base_csrcredential
   																					,Build_csrcredential_base
																						);
   					SHARED full_build_csrcredential	:=  
   						sequential(				
   						 		 Build_csrcredential_base
   								,HMS_CSR.Promote.promote_csrcredential(pversion, pUseProd).buildfiles.New2Built
									);
   	
   					EXPORT csrcredential_all	:=
   						if(VersionControl.IsValidVersion(pversion)
   								,full_build_csrcredential
   								,output('No Valid version parameter passed, skipping CSR CRED Full build')
   						);
   		END;

	
END;