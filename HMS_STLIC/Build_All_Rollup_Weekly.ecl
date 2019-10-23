IMPORT versioncontrol, _control, ut, tools,HMS_STLIC,STD;
EXPORT Build_all_rollup_weekly(string pversion, boolean pUseProd = false) := FUNCTION
	
	superFileRoll := FileServices.SuperFileExists('~thor400_data::base::hms_stl::hms_stlicrollup');
 
	if(not superFileRoll,FileServices.CreateSuperFile('~thor400_data::base::hms_stl::hms_stlicrollup',,1));

	built := sequential(					
								// Build Rollup for AMS Replacement
								 Build_Base.build_base_stlicrollup(pVersion,pUseProd).stlicrollup_all
								,Build_Keys.Build_Keys_stlicrollup(pversion,pUseProd).Stlicrollup_All
								,Promote.Promote_stlicrollup(pversion,pUseProd).buildfiles.Built2QA
								,Build_Strata(pversion,pUseProd).StlRollup
									//Clean Up Base Files
								,FileServices.StartSuperFileTransaction()	
								,FileServices.RemoveOwnedSubFiles('~thor400_data::base::hms_stl::hms_stlicrollup',true)
								,FileServices.AddSuperFile('~thor400_data::base::hms_stl::hms_stlicrollup','~thor400_data::base::hms_stl::hms_stlicrollup::' + pVersion)
								,FileServices.FinishSuperFileTransaction()
						
					): success(Send_Email(pversion,pUseProd).BuildSuccess), failure(send_email(pversion,pUseProd).BuildFailure
	);

	return built;
END;