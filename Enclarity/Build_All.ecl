import versioncontrol, _control, ut, tools;
export Build_all(string pversion, boolean pUseProd = false) := function

wl:=nothor(WorkunitServices.WorkunitList('',jobname:='Yogurt:Enclarity as Ingenix Build*'))(state in ['blocked','running','wait']);
if(exists(wl),fail('Enclarity as Ingenix Build is running'));

spray_  		 := VersionControl.fSprayInputFiles(fSpray(pversion,pUseProd)); 

built := sequential(
					spray_,
							parallel( // ssn and dob have to be built before license and npi, and all four plus dea and address before individual
									sequential(
											Build_base.build_base_prov_ssn(pversion,pUseProd).prov_ssn_all,
											Build_base.build_base_prov_birthdate(pversion,pUseProd).prov_birthdate_all,
											Build_base.build_base_license(pversion,pUseProd).license_all,
											Build_base.build_base_npi(pversion,pUseProd).npi_all,
											Build_base.build_base_DEA(pversion,pUseProd).dea_all,
											Build_base.build_base_address(pversion,pUseProd).address_all,
											Build_base.build_base_sanction(pversion,pUseProd).sanction_all,
											Build_Base.build_base_individual(pversion,pUseProd).individual_all,
											Build_Base.build_base_facility(pversion,pUseProd).facility_all,
											Build_base.build_base_associate(pversion,pUseProd).associate_all
											),
									// the following base files can be built in any order while the ones above are being built in the listed order
									Build_base.build_base_taxonomy(pversion,pUseProd).taxonomy_all,
									Build_base.build_base_medschool(pversion,pUseProd).medschool_all,
									Build_base.build_base_tax_codes(pversion,pUseProd).tax_codes_all,
									Build_base.build_base_specialty(pversion,pUseProd).specialty_all,
									Build_base.build_base_sanc_prov_type(pversion,pUseProd).sanc_prov_type_all,
									Build_base.build_base_sanc_codes(pversion,pUseProd).sanc_codes_all,
									Build_base.build_base_collapse(pversion,pUseProd).collapse_all,
									Build_base.build_base_split(pversion,pUseProd).split_all,
									Build_base.build_base_drop(pversion,pUseProd).drop_all
									)
									// all the base files have been built, now the keys can be built (in any order or simultaneously)
							,parallel(
									Build_Keys.build_keys_facility(pversion,pUseProd).facility_all,
									Build_Keys.build_keys_individual(pversion,pUseProd).individual_all,
									Build_Keys.build_keys_associate(pversion,pUseProd).associate_all,
									Build_Keys.build_keys_license(pversion,pUseProd).license_all,
									Build_Keys.build_keys_taxonomy(pversion,pUseProd).taxonomy_all,
									Build_Keys.build_keys_medschool(pversion,pUseProd).medschool_all,
									Build_Keys.build_keys_sanction(pversion,pUseProd).sanction_all,
									Build_Keys.build_keys_sanc_codes(pversion,pUseProd).sanc_codes_all,
									Build_Keys.build_keys_sanc_prov_type(pversion,pUseProd).sanc_prov_type_all,
									Build_Keys.build_keys_specialty(pversion,pUseProd).specialty_all,
									Build_Keys.Build_autokeys_individual(pversion)
									)
									// after the keys have been built, the files can be moved to the appropriate superfiles
						,parallel(
									Promote.promote_facility(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_individual(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_associate(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_address(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_dea(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_license(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_taxonomy(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_NPI(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_medschool(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_tax_codes(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_prov_ssn(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_prov_birthdate(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_sanction(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_sanc_codes(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_sanc_prov_type(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_specialty(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_collapse(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_split(pversion,pUseProd).buildfiles.Built2QA,
									Promote.promote_drop(pversion,pUseProd).buildfiles.Built2QA
									)
						,Build_Strata(pversion,pUseProd).all

					//Archive processed files in history					
				,sequential(
						FileServices.StartSuperFileTransaction()

						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).facility_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).individual_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).associate_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).address_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).dea_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).license_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).taxonomy_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).NPI_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).medschool_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).tax_codes_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).prov_birthdate_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).sanction_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).sanc_codes_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).sanc_prov_type_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).specialty_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).collapse_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).split_lInputHistTemplate,true)
						,FileServices.RemoveOwnedSubFiles(Filenames(pversion,pUseProd).drop_lInputHistTemplate,true)

						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).facility_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).individual_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).associate_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).address_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).dea_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).license_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).taxonomy_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).NPI_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).medschool_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).tax_codes_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).prov_birthdate_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).sanction_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).sanc_codes_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).sanc_prov_type_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).specialty_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).collapse_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).split_lInputHistTemplate)
						,FileServices.ClearSuperFile(Filenames(pversion,pUseProd).drop_lInputHistTemplate)

						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).facility_lInputHistTemplate,  Filenames(pversion,pUseProd).facility_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).individual_lInputHistTemplate,  Filenames(pversion,pUseProd).individual_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).associate_lInputHistTemplate,  Filenames(pversion,pUseProd).associate_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).address_lInputHistTemplate,  Filenames(pversion,pUseProd).address_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).dea_lInputHistTemplate,  Filenames(pversion,pUseProd).dea_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).license_lInputHistTemplate,  Filenames(pversion,pUseProd).license_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).taxonomy_lInputHistTemplate,  Filenames(pversion,pUseProd).taxonomy_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).NPI_lInputHistTemplate,  Filenames(pversion,pUseProd).NPI_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).medschool_lInputHistTemplate,  Filenames(pversion,pUseProd).medschool_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).tax_codes_lInputHistTemplate,  Filenames(pversion,pUseProd).tax_codes_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).prov_birthdate_lInputHistTemplate,  Filenames(pversion,pUseProd).prov_birthdate_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).sanction_lInputHistTemplate,  Filenames(pversion,pUseProd).sanction_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).sanc_codes_lInputHistTemplate,  Filenames(pversion,pUseProd).sanc_codes_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).sanc_prov_type_lInputHistTemplate,  Filenames(pversion,pUseProd).sanc_prov_type_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).specialty_lInputHistTemplate,  Filenames(pversion,pUseProd).specialty_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).collapse_lInputHistTemplate,  Filenames(pversion,pUseProd).collapse_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).split_lInputHistTemplate,  Filenames(pversion,pUseProd).split_lInputTemplate,,true)
						,FileServices.AddSuperFile(Filenames(pversion,pUseProd).drop_lInputHistTemplate,  Filenames(pversion,pUseProd).drop_lInputTemplate,,true)

						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).facility_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).individual_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).associate_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).address_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).dea_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).license_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).taxonomy_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).NPI_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).medschool_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).tax_codes_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).prov_birthdate_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).sanction_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).sanc_codes_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).sanc_prov_type_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).specialty_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).collapse_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).split_lInputTemplate,true)
						,FileServices.RemoveOwnedSubFiles(enclarity.Filenames(pversion,pUseProd).drop_lInputTemplate,true)

						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).facility_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).individual_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).associate_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).address_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).dea_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).license_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).taxonomy_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).NPI_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).medschool_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).tax_codes_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).prov_birthdate_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).sanction_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).sanc_codes_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).sanc_prov_type_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).specialty_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).collapse_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).split_lInputTemplate)
						,FileServices.ClearSuperFile(enclarity.Filenames(pversion,pUseProd).drop_lInputTemplate)

						,FileServices.FinishSuperFileTransaction()
						)
						,Basic_stats.Show_me_the_output
				): success(sequential(
										Send_Email(pversion,pUseProd).BuildSuccess)
										,RoxieKeyBuild.updateversion('EnclarityKeys',pversion,_Control.MyInfo.EmailAddressNotify,,'N')) 
				 , failure(send_email(pversion,pUseProd).BuildFailure
				

);


return built;
end;