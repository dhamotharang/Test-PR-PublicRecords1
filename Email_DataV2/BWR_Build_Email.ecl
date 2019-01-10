import ut, RoxieKeyBuild, PromoteSupers, Orbit3, DOPS, Email_DataV2, Email_Data, STD;

#OPTION('multiplePersistInstances',FALSE);

export BWR_Build_Email(version, string emailList='') := function
#workunit('name','Email DataV2 ' + version);

email_base 			:= Build_base(version).rollup_with_history;
email_base_fcra	:= PROJECT(email_base, TRANSFORM(Email_DataV2.Layouts.Base_BIP,
																										SELF.orig_ip		:= ''; //DF-21686
																									  SELF.dotid			:= 0;
																										SELF.dotscore		:= 0;
																										SELF.dotweight	:= 0;
																										SELF.empid			:= 0;
																										SELF.empscore		:= 0;
																										SELF.empweight	:= 0;
																										SELF.powid			:= 0;
																										SELF.powscore		:= 0;
																										SELF.powweight	:= 0;
																										SELF.proxid			:= 0;
																										SELF.proxscore	:= 0;
																										SELF.proxweight	:= 0;
																										SELF.seleid			:= 0;
																										SELF.selescore	:= 0;
																										SELF.seleweight	:= 0;
																										SELF.orgid			:= 0;
																										SELF.orgscore		:= 0;
																										SELF.orgweight	:= 0;
																										SELF.ultid			:= 0;
																										SELF.ultscore		:= 0;
																										SELF.ultweight	:= 0;
																										SELF := LEFT;));
																										
Filter_FCRA_recs	:= email_base_fcra(STD.Str.FindCount(orig_email,  '@') > 0 AND append_email_username <> '' AND append_domain_root <> '' AND STD.Str.FindCount(clean_email,  '.') > 0 AND current_rec = TRUE);

PromoteSupers.MAC_SF_BuildProcess(email_base,'~thor_data400::base::email_dataV2' ,build_email_base,2,,true);
PromoteSupers.MAC_SF_BuildProcess(Filter_FCRA_recs(email_src not in Email_Data.FCRA_Src_Filter),'~thor_data400::base::email_dataV2_fcra' ,build_email_base_fcra,2,,true);

Build_all_keys := Build_keys(version);
zDoPopulationStats:=Strata_Stat_Email(version,Files.Email_Base);
zDoPopulationVendorStats:=Strata_Stat_Vendor(version,Files.Email_Base);

dops_update :=  sequential(DOPS.updateversion('EmailDataKeysV2',(string)version,emailList,,'N')
													,DOPS.updateversion('FCRA_EmailDataKeysV2',(string)version,emailList,,'F'));

orbit_update := sequential(Orbit3.proc_Orbit3_CreateBuild_AddItem ('Email DataV2',(string)version,'N')
														,Orbit3.proc_Orbit3_CreateBuild_AddItem ('FCRA Email DataV2',(string)version,'F')
														);


SampleRecs := CHOOSEN(SORT(Files.Email_Base(current_rec = TRUE),RECORD),1000);
					
built := sequential(
									//Email_dataV2.proc_Scrubs_base((string)version,emailList)
									build_email_base
									,build_email_base_fcra
									,Build_all_keys
									// ,zDoPopulationStats
									// ,zDoPopulationVendorStats
									// ,output(SampleRecs)
									// ,dops_update
									// ,orbit_update
									);	//:success(Email_Datav2.Send_Email(Version).Build_Success)
										//,failure(Email_Datav2.Send_Email(Version).Build_Failure);

RETURN built;

END;