IMPORT versioncontrol, _control, ut, tools, hxmx;

EXPORT Build_all(STRING pVersion, BOOLEAN pUseProd = FALSE) := FUNCTION

spray_hx  		 := hxmx.fSprayDd(pVersion,'hx');
spray_mx  		 := hxmx.fSprayDd(pVersion,'mx');

built := SEQUENTIAL(

					spray_hx,
					spray_mx,
					hxmx.consolidate_in_file.hx(pversion,pUseProd),			// consolidate the brand-new in files in preparation to be appended to previous version
					hxmx.consolidate_in_file.mx(pversion,pUseProd),			// consolidate the brand-new in files in preparation to be appended to previous version
					hxmx.append_consolidated_file.hx(pVersion,pUseProd),	// append files created in "consolidate_in_file" to consolidated files from previous builds					
					hxmx.append_consolidated_file.mx(pVersion,pUseProd),	// append files created in "consolidate_in_file" to consolidated files from previous builds			
					hxmx.Build_Base.build_base_hx(pVersion,pUseProd).hx_all,
					hxmx.Build_Base.build_base_mx(pVersion,pUseProd).mx_all,
					hxmx.Scrub_HXMX(pVersion,pUseProd).Scrubit_HX,
					hxmx.Scrub_HXMX(pVersion,pUseProd).Scrubit_MX,
					// Build_Keys will go here
					hxmx.Promote.promote_hx(pVersion,pUseProd).buildfiles.Built2QA,
					hxmx.Promote.promote_mx(pVersion,pUseProd).buildfiles.Built2QA,
					hxmx.Build_Strata(pversion,pUseProd).HX,
					hxmx.Build_Strata(pversion,pUseProd).MX,
					//Archive processed files in history					
  				FileServices.StartSuperFileTransaction(),
					FileServices.AddSuperFile(hxmx.Filenames(pVersion,pUseProd).hx_lInputHistTemplate,  hxmx.Filenames(pVersion,pUseProd).hx_lInputTemplate,,TRUE),
					FileServices.AddSuperFile(hxmx.Filenames(pVersion,pUseProd).mx_lInputHistTemplate,  hxmx.Filenames(pVersion,pUseProd).mx_lInputTemplate,,TRUE),
					FileServices.ClearSuperFile(hxmx.Filenames(pVersion,pUseProd).hx_lInputTemplate),
					FileServices.ClearSuperFile(hxmx.Filenames(pVersion,pUseProd).mx_lInputTemplate),
					FileServices.FinishSuperFileTransaction()//,
						// Basic_stats.Show_me_the_output
				): SUCCESS(hxmx.Send_Email(pVersion,pUseProd).BuildSuccess), FAILURE(hxmx.send_email(pVersion,pUseProd).BuildFailure);
				
RETURN built;
END;