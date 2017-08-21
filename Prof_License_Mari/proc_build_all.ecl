IMPORT ut,RoxieKeybuild,Scrubs_Prof_License_Mari,orbit_report,PromoteSupers;
#OPTION('multiplePersistInstances',FALSE);

EXPORT proc_build_all(STRING pVersion) := FUNCTION
#workunit('name','Prof_License_Mari Build ' + pVersion);


e_mail_success := fileservices.sendemail(
										Email_Notification_Lists.BuildSuccess,
										'MARI Build Succeeded - ' + version,
										'');										
							
e_mail_fail := fileservices.sendemail(
									  Email_Notification_Lists.BuildFailure,
									  'MARI Build FAILED',
									  FAILMESSAGE);

concat_them 				:= Prof_License_Mari.file_Maribase_in;
base_fix						:= Prof_License_Mari.fBaseFix(concat_them);
standardized_code	 	:= Prof_License_Mari.fStandardizedCode(base_fix);
Default_Dates 			:= Prof_License_Mari.fClearDefaultDates(standardized_code);


Prof_License_Mari.layouts.intermediate xform_base(Prof_License_Mari.layouts.base le) := TRANSFORM
	SELF.PRIMARY_KEY			 		:= IF(TRIM(le.license_nbr)  <> '' 
																			AND TRIM(le.license_nbr) <> 'NR', 
																									HASH32(ut.CleanSpacesAndUpper(le.license_nbr) + ','
																													+ut.CleanSpacesAndUpper(le.off_license_nbr) + ','
																													+ut.CleanSpacesAndUpper(le.license_state) + ','
																													+ut.CleanSpacesAndUpper(le.std_source_upd)),
																															0);
	SELF.VIOLATION_DTE				:= le.VIOL_DTE;
	SELF.VIOLATION_CASE_NBR		:= le.VIOL_CASE_NBR;
	SELF.VIOLATION_DESC				:= le.VIOL_DESC;
	SELF.PERSISTENT_RECORD_ID := HASH64(le.NAME_MARI_DBA + ','
																		+	le.CMC_SLPK +','
																		+ le.PCMC_SLPK + ','
																		+ le.MLTRECKEY +','
																		+ le.AFFIL_TYPE_CD  +','
																		+ le.NMLS_ID	+ ','
																		+ le.FOREIGN_NMLS_ID + ','
																		+ le.LICENSE_ID + ','
																		+ le.REGULATOR + ','
																		+ le.FEDERAL_REGULATOR
																		);
 SELF := le;
 SELF := [];
END;

dDatasetPrep := PROJECT(Default_Dates,xform_base(left));

PromoteSupers.MAC_SF_BuildProcess(Prof_license_Mari.fRollup_nmls.Regulatory(Prof_License_Mari.files_in.regulatory_actions)     ,'~thor_data400::base::proflic_mari::regulatory_actions'     ,build_regulatory,2,,true);
PromoteSupers.MAC_SF_BuildProcess(Prof_license_Mari.fRollup_nmls.Disciplinary(Prof_License_Mari.files_in.disciplinary_actions) ,'~thor_data400::base::proflic_mari::disciplinary_actions'   ,build_disciplinary,2,,true);
PromoteSupers.MAC_SF_BuildProcess(Prof_license_Mari.fRollup_nmls.indv_detail(Prof_License_Mari.files_in.individual_detail)     ,'~thor_data400::base::proflic_mari::individual_detail'      ,build_detail,2,,true);
PromoteSupers.MAC_SF_BuildProcess(standardized_code,'~thor_data400::base::proflic_mari::base'                                  ,build_base,2,,true);
PromoteSupers.MAC_SF_BuildProcess(Prof_License_Mari.proc_build_base(dDatasetPrep).base_file_intermediate                       ,'~thor_data400::base::proflic_mari::intermediate'          ,build_intermediate,2,,true);
PromoteSupers.MAC_SF_BuildProcess(Prof_License_Mari.proc_build_base(dDatasetPrep).search_file                                  ,'~thor_data400::base::proflic_mari::search'                ,build_search,2,,true);



 do_all := SEQUENTIAL(
                      PARALLEL(build_base, build_regulatory, build_disciplinary, build_detail)
											,build_intermediate
											,build_search
											,proc_build_keys(pVersion)
											,Prof_License_Mari.Missing_Codes.Standardized_Codes
  										,Scrubs_Prof_License_Mari.PostBuildScrubs(pVersion)
											,Prof_License_Mari.strata_popMARI_full(pVersion)
											// ,Prof_License_Mari.BWR_SampleRecords  // Sample per source code
											// ,Prof_License_Mari.fSampleRecords_S0900_addl(pVersion) // Sample Records for NMLS addl records
                     	);
 
RETURN do_all;

END;

