//Defines full build process
import _control, versioncontrol;

export Build_Base := module
   
		EXPORT build_base_collapse(
					 string				pversion
					,boolean			pUseProd		= false
					,dataset(Layouts.collapse_Base		)pBaseFile		= Files().collapse_base.qa	) := module
	
					shared build_base_collapse := Update_Base(pversion,pUseProd).collapse_Base;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames(pversion, pUseProd).collapse_base.new
																				 	,build_base_collapse
																					,Build_collapse_Base
																					);
					shared full_build_collapse	:=  
						sequential(				
						 		 Build_collapse_Base
								,Promote.promote_collapse(pversion, pUseProd).buildfiles.New2Built);
	
					export collapse_all	:=
						if(VersionControl.IsValidVersion(pversion)
								,full_build_collapse
								,output('No Valid version parameter passed, skipping collapse build')
						);
		END;
	
		EXPORT build_base_split(
					 string				pversion
					,boolean			pUseProd		= false
					,dataset(Layouts.split_Base		)pBaseFile		= Files().split_base.qa	) := module
	
					shared build_base_split := Update_Base(pversion,pUseProd).split_Base;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames(pversion, pUseProd).split_base.new
																				 	,build_base_split
																					,Build_split_Base
																					);
					shared full_build_split	:=  
						sequential(				
						 		 Build_split_Base
								,Promote.promote_split(pversion, pUseProd).buildfiles.New2Built);
	
					export split_all	:=
						if(VersionControl.IsValidVersion(pversion)
								,full_build_split
								,output('No Valid version parameter passed, skipping split build')
						);
		END;
	
		EXPORT build_base_drop(
					 string				pversion
					,boolean			pUseProd		= false
					,dataset(Layouts.drop_Base		)pBaseFile		= Files().drop_base.qa	) := module
	
					shared build_base_drop := Update_Base(pversion,pUseProd).drop_Base;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames(pversion, pUseProd).drop_base.new
																				 	,build_base_drop
																					,Build_drop_Base
																					);
					shared full_build_drop	:=  
						sequential(				
						 		 Build_drop_Base
								,Promote.promote_drop(pversion, pUseProd).buildfiles.New2Built);
	
					export drop_all	:=
						if(VersionControl.IsValidVersion(pversion)
								,full_build_drop
								,output('No Valid version parameter passed, skipping drop build')
						);
		END;
	
		EXPORT build_base_facility(
					 string				pversion
					,boolean			pUseProd		= false
					,dataset(Layouts.Facility_Base		)pBaseFile		= Files().Facility_base.qa	) := module
	
					shared build_base_facility := Update_Base(pversion,pUseProd).Facility_Base;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames(pversion, pUseProd).Facility_base.new
																				 	,build_base_facility
																					,Build_Facility_Base
																					);
					shared full_build_facility	:=  
						sequential(				
						 		 Build_Facility_Base
								,Promote.promote_facility(pversion, pUseProd).buildfiles.New2Built);
	
					export facility_all	:=
						if(VersionControl.IsValidVersion(pversion)
								,full_build_facility
								,output('No Valid version parameter passed, skipping facility build')
						);
		END;
	
		EXPORT build_base_individual(
				 string			pversion
				,boolean		pUseProd		= false
				,dataset(Layouts.Individual_Base						) pBaseFile						= Files().Individual_base.qa ) := module
				
				export build_base_individual	:= Update_base(pversion, pUseProd).individual_base;
				VersionControl.macBuildNewLogicalFile(
  																			 Filenames(pversion,pUseProd).Individual_base.new
																				,build_base_individual
																				,Build_Individual_Base
																				);
	
				export full_build_individual	:=
					sequential(
						 Build_individual_base
						,Promote.promote_individual(pversion, pUseProd).buildfiles.New2Built);
	
				export individual_all	:=
					 if(VersionControl.IsValidVersion(pversion)
								,full_build_individual
								,output('No Valid version parameter passed, skipping individual build')
				);
		END;

		EXPORT build_base_associate(
				 string			pversion
				,boolean		pUseProd		= false
				,dataset(Layouts.Associate_Base						) pBaseFile						= Files().Associate_base.qa ) := module
				
				export build_base_associate			:= Update_base(pversion, pUseProd).associate_base;
				VersionControl.macBuildNewLogicalFile(
																				 Filenames(pversion,pUseProd).Associate_base.new
																				,build_base_associate
																				,Build_Associate_Base
																				);
	
				export full_build_associate	:=
						sequential(
								 Build_associate_base
								,Promote.promote_associate(pversion, pUseProd).buildfiles.New2Built);
	
				export associate_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_associate
						,output('No Valid version parameter passed, skipping associate build')
				);
		END;
		
		EXPORT build_base_address(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.Address_Base						) pBaseFile						= Files().Address_base.qa ) := module
			
				export build_base_address				:= Update_base(pversion, pUseProd).address_base;
				VersionControl.macBuildNewLogicalFile(
									 Filenames(pversion,pUseProd).Address_base.new
									,build_base_address
									,Build_Address_Base
				);
	
				export full_build_address	:=
						sequential(
									 Build_address_base
									,Promote.promote_address(pversion, pUseProd).buildfiles.New2Built);
	
				export address_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_address
						,output('No Valid version parameter passed, skipping associate build')
				);
		END;

		EXPORT build_base_DEA(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.DEA_Base						) pBaseFile						= Files().DEA_base.qa ) := module
			
				export build_base_dea						:= Update_base(pversion, pUseProd).dea_base;
				VersionControl.macBuildNewLogicalFile(
									 Filenames(pversion,pUseProd).dea_base.new
									,build_base_dea
									,Build_DEA_Base
				);
	
				export full_build_dea	:=
						sequential(
									 Build_dea_base
									,Promote.promote_dea(pversion, pUseProd).buildfiles.New2Built);
	
				export dea_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_dea
						,output('No Valid version parameter passed, skipping DEA build')
				);
	END;

		EXPORT build_base_license(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.license_Base						) pBaseFile						= Files().license_base.qa ) := module
			
				export build_base_license				:= Update_base(pversion, pUseProd).license_base;
				VersionControl.macBuildNewLogicalFile(
									 Filenames(pversion,pUseProd).license_base.new
									,build_base_license
									,Build_License_Base
				);
	
				export full_build_license	:=
						sequential(
									 Build_license_base
									,Promote.promote_license(pversion, pUseProd).buildfiles.New2Built);
	
				export license_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_license
						,output('No Valid version parameter passed, skipping license build')
				);
	END;

		EXPORT build_base_taxonomy(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.taxonomy_Base						) pBaseFile						= Files().taxonomy_base.qa ) := module
			
					export build_base_taxonomy				:= Update_base(pversion, pUseProd).taxonomy_base;
					VersionControl.macBuildNewLogicalFile(
									 Filenames(pversion,pUseProd).taxonomy_base.new
									,build_base_taxonomy
									,Build_taxonomy_Base
					);
	
					export full_build_taxonomy	:=
						sequential(
									 Build_taxonomy_base
									,Promote.promote_taxonomy(pversion, pUseProd).buildfiles.New2Built);
	
					export taxonomy_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_taxonomy
						,output('No Valid version parameter passed, skipping taxonomy build')
					);
	END;
	
		EXPORT build_base_npi(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.npi_Base						) pBaseFile						= Files().npi_base.qa ) := module
			
					export build_base_npi						:= Update_base(pversion, pUseProd).npi_base;
					VersionControl.macBuildNewLogicalFile(
															 Filenames(pversion,pUseProd).npi_base.new			
															,build_base_npi
															,Build_npi_Base
					);
	
					export full_build_npi	:=
						sequential(
									 Build_npi_base
									,Promote.promote_npi(pversion, pUseProd).buildfiles.New2Built);
	
					export npi_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_npi
						,output('No Valid version parameter passed, skipping NPI build')
					);
	END;
		EXPORT build_base_medschool(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.medschool_Base						) pBaseFile						= Files().medschool_base.qa ) := module
			
					export build_base_medschool			:= Update_base(pversion, pUseProd).medschool_base;
					VersionControl.macBuildNewLogicalFile(
																				 Filenames(pversion,pUseProd).medschool_base.new		
															,build_base_medschool
															,Build_medschool_Base
					);
	
					export full_build_medschool	:=
						sequential(
									 Build_medschool_base
									,Promote.promote_medschool(pversion, pUseProd).buildfiles.New2Built);
	
					export medschool_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_medschool
						,output('No Valid version parameter passed, skipping medschool build')
					);
	END;

		EXPORT build_base_tax_codes(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.tax_codes_Base						) pBaseFile						= Files().tax_codes_base.qa ):= module
			
					export build_base_tax_codes			:= Update_base(pversion, pUseProd).tax_codes_base;
					VersionControl.macBuildNewLogicalFile(
															 Filenames(pversion,pUseProd).tax_codes_base.new																			 
															,build_base_tax_codes
															,Build_tax_codes_Base
					);
	
					export full_build_tax_codes	:=
						sequential(
									 Build_tax_codes_base
									,Promote.promote_tax_codes(pversion, pUseProd).buildfiles.New2Built);
	
					export tax_codes_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_tax_codes
						,output('No Valid version parameter passed, skipping taxonomy codes build')
					);
	END;

		EXPORT build_base_prov_ssn(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.prov_ssn_Base						) pBaseFile						= Files().prov_ssn_base.qa ):= module
			
					export build_base_prov_ssn				:= Update_base(pversion, pUseProd).prov_ssn_base;
					VersionControl.macBuildNewLogicalFile(
															 Filenames(pversion,pUseProd).prov_ssn_base.new	
															,build_base_prov_ssn
															,Build_prov_ssn_Base
					);
	
					export full_build_prov_ssn	:=
						sequential(
									 Build_prov_ssn_base
									,Promote.promote_prov_ssn(pversion, pUseProd).buildfiles.New2Built);
	
					export prov_ssn_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_prov_ssn
						,output('No Valid version parameter passed, skipping Provider SSN build')
					);
	END;


		EXPORT build_base_specialty(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.specialty_Base						) pBaseFile						= Files().specialty_base.qa ) := module
			
					export build_base_specialty			:= Update_base(pversion, pUseProd).specialty_base;
					VersionControl.macBuildNewLogicalFile(
															 Filenames(pversion,pUseProd).specialty_base.new		
															,build_base_specialty
															,Build_specialty_Base
					);
	
					export full_build_specialty	:=
						sequential(
									 Build_specialty_base
									,Promote.promote_specialty(pversion, pUseProd).buildfiles.New2Built);
	
					export specialty_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_specialty
						,output('No Valid version parameter passed, skipping specialty build')
					);
	END;

	
		EXPORT build_base_sanc_prov_type(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.sanc_prov_type_Base						) pBaseFile						= Files().sanc_prov_type_base.qa ) := module
			
					export build_base_sanc_prov_type			:= Update_base(pversion, pUseProd).sanc_prov_type_base;
					VersionControl.macBuildNewLogicalFile(
															 Filenames(pversion,pUseProd).sanc_prov_type_base.new																			  
															,build_base_sanc_prov_type
															,Build_sanc_prov_type_Base
					);
	
					export full_build_sanc_prov_type	:=
						sequential(
									 Build_sanc_prov_type_base
									,Promote.promote_sanc_prov_type(pversion, pUseProd).buildfiles.New2Built);
	
					export sanc_prov_type_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_sanc_prov_type
						,output('No Valid version parameter passed, skipping sanc_prov_type build')
					);
	END;

		EXPORT build_base_sanc_codes(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.sanc_codes_Base						) pBaseFile						= Files().sanc_codes_base.qa ) := module
			
					export build_base_sanc_codes			:= Update_base(pversion, pUseProd).sanc_codes_base;
					VersionControl.macBuildNewLogicalFile(
															 Filenames(pversion,pUseProd).sanc_codes_base.new	
															,build_base_sanc_codes
															,Build_sanc_codes_Base
					);
	
					export full_build_sanc_codes	:=
						sequential(
									 Build_sanc_codes_base
									,Promote.promote_sanc_codes(pversion, pUseProd).buildfiles.New2Built);
	
					export sanc_codes_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_sanc_codes
						,output('No Valid version parameter passed, skipping sanc_codes build')
					);
	END;
		EXPORT build_base_dea_BAcodes(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.dea_BAcodes_Base						) pBaseFile						= Files().dea_BAcodes_base.qa ) := module
			
					export build_base_dea_BAcodes			:= Update_base(pversion, pUseProd).dea_BAcodes_base;
					VersionControl.macBuildNewLogicalFile(
															 Filenames(pversion,pUseProd).dea_BAcodes_base.new	
															,build_base_dea_BAcodes
															,Build_dea_BAcodes_Base
					);
	
					export full_build_dea_BAcodes	:=
						sequential(
									 Build_dea_BAcodes_base
									,Promote.promote_dea_BAcodes(pversion, pUseProd).buildfiles.New2Built);
	
					export dea_BAcodes_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_dea_BAcodes
						,output('No Valid version parameter passed, skipping dea_BAcodes build')
					);
	END;

	EXPORT build_base_prov_birthdate(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.prov_birthdate_Base						) pBaseFile						= Files().prov_birthdate_base.qa ) := module
			
					export build_base_prov_birthdate			:= Update_base(pversion, pUseProd).prov_birthdate_base;
					VersionControl.macBuildNewLogicalFile(
																					 Filenames(pversion,pUseProd).prov_birthdate_base.new																			  																	 																				 																			 
															,build_base_prov_birthdate
															,Build_prov_birthdate_Base
					);
	
					export full_build_prov_birthdate	:=
						sequential(
									 Build_prov_birthdate_base
									,Promote.promote_prov_birthdate(pversion, pUseProd).buildfiles.New2Built);
	
					export prov_birthdate_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_prov_birthdate
						,output('No Valid version parameter passed, skipping prov_birthdate build')
					);
	END;
	
	EXPORT build_base_sanction(
					 string			pversion
					,boolean		pUseProd		= false
					,dataset(Layouts.sanction_Base						) pBaseFile						= Files().sanction_base.qa ) := module
			
					export build_base_sanction			:= Update_base(pversion, pUseProd).sanction_base;
					VersionControl.macBuildNewLogicalFile(
															 Filenames(pversion,pUseProd).sanction_base.new																			  																	 																				 																			 
															,build_base_sanction
															,Build_sanction_Base
					);
	
					export full_build_sanction	:=
						sequential(
									 Build_sanction_base
									,Promote.promote_sanction(pversion, pUseProd).buildfiles.New2Built);
	
					export sanction_all	:=
						 if(VersionControl.IsValidVersion(pversion)
						,full_build_sanction
						,output('No Valid version parameter passed, skipping sanction build')
					);
	END;
					
END;