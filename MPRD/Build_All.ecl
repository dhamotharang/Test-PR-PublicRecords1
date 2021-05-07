import versioncontrol, _control, ut, tools, MPRD, Healthcare_ProviderPoint_QA,RoxieKeyBuild, BIPV2_Company_Names;
export Build_all(string pversion, boolean pUseProd = false) := function

	spray_  		 := VersionControl.fSprayInputFiles(MPRD.fSpray(pversion,pUseProd));

	built := sequential(
   					spray_,
						parallel(
							MPRD.Build_Base.build_base_individual(pversion,pUseProd).individual_all,
							MPRD.Build_Base.build_base_taxonomy_full_lu(pversion,pUseProd).taxonomy_full_lu_all),					
						parallel(
							MPRD.Promote.promote_individual(pversion,pUseProd).buildfiles.Built2QA,
							MPRD.Promote.promote_taxonomy_full_lu(pversion,pUseProd).buildfiles.Built2QA),
							//Run Strata 
							MPRD.Build_Strata(pversion,pUseProd).All,
						sequential(
							FileServices.StartSuperFileTransaction(),
							FileServices.RemoveOwnedSubFiles(MPRD.Filenames(pversion,pUseProd).individual_lInputHistTemplate,true),
							FileServices.RemoveOwnedSubFiles(MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_lInputHistTemplate,true),

							FileServices.ClearSuperFile(MPRD.Filenames(pversion,pUseProd).individual_lInputHistTemplate),
							FileServices.ClearSuperFile(MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_lInputHistTemplate),
							
							FileServices.AddSuperFile(MPRD.Filenames(pversion,pUseProd).individual_lInputHistTemplate,  							MPRD.Filenames(pversion,pUseProd).individual_lInputTemplate,,true),
							FileServices.AddSuperFile(MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_lInputHistTemplate,  				MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_lInputTemplate,,true),
							
							FileServices.RemoveOwnedSubFiles(MPRD.Filenames(pversion,pUseProd).individual_lInputTemplate,true),
							FileServices.RemoveOwnedSubFiles(MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_lInputTemplate,true),
							
							FileServices.ClearSuperFile(MPRD.Filenames(pversion,pUseProd).individual_lInputTemplate),
							FileServices.ClearSuperFile(MPRD.Filenames(pversion,pUseProd).taxonomy_full_lu_lInputTemplate),
							FileServices.FinishSuperFileTransaction()),
							// RoxieKeyBuild.updateversion('MPRDKeys', pversion, _Control.MyInfo.EmailAddressNotify,,'N');
					): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure);
   
   return built;
end;