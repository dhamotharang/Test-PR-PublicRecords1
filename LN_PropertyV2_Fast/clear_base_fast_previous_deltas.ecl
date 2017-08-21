// This function attribute is called by the full build (proc0_build_all) to clear delta base files added to the full - Jira DF-11862

import ut,LN_PropertyV2,ln_propertyv2_fast,std;
EXPORT clear_base_fast_previous_deltas(string pdate) := function

	select_assessment_:= (dataset(LN_PropertyV2_Fast.FileNames.base.assessment,LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs,flat,opt))(process_date>=pdate);
	select_assessment	:= if(count(select_assessment_)>0,select_assessment_,dataset([],LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs));
	select_deed_mortg_:= (dataset(LN_PropertyV2_Fast.FileNames.base.deed_mortg,LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs,flat,opt))(process_date>=pdate);
	select_deed_mortg	:= if(count(select_deed_mortg_)>0,select_deed_mortg_,dataset([],LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs));
	select_search_prp_:= (ln_propertyv2_fast.files.base.search_prp)(process_date>=pdate);
	select_search_prp	:= if(count(select_search_prp_)>0,select_search_prp_,dataset([],LN_PropertyV2.Layout_Did_Out));
	select_ln_fares_id:= sort(distribute(project(select_assessment,transform({string12 ln_fares_id:=' '},self:=left))+
											 project(select_deed_mortg,transform({string12 ln_fares_id:=' '},self:=left))+
											 project(select_search_prp,transform({string12 ln_fares_id:=' '},self:=left)),hash(ln_fares_id)),ln_fares_id,local);
	select_addl_names	:= dedup(join(sort(distribute(ln_propertyv2_fast.files.base.addl_names,hash(ln_fares_id)),ln_fares_id,local),select_ln_fares_id,
														left.ln_fares_id=right.ln_fares_id,
														transform(recordof(ln_propertyv2_fast.files.base.addl_names),self:=left),local),record,all);
	select_addl_legal	:= dedup(join(sort(distribute(ln_propertyv2_fast.files.base.addl_legal,hash(ln_fares_id)),ln_fares_id,local),select_ln_fares_id,
														left.ln_fares_id=right.ln_fares_id,
														transform(recordof(ln_propertyv2_fast.files.base.addl_legal),self:=left),local),record,all);
	select_addl_frs_a	:= dedup(join(sort(distribute(ln_propertyv2_fast.files.base.addl_frs_a,hash(ln_fares_id)),ln_fares_id,local),select_ln_fares_id,
														left.ln_fares_id=right.ln_fares_id,
														transform(recordof(ln_propertyv2_fast.files.base.addl_frs_a),self:=left),local),record,all);
	select_addl_frs_d	:= dedup(join(sort(distribute(ln_propertyv2_fast.files.base.addl_frs_d,hash(ln_fares_id)),ln_fares_id,local),select_ln_fares_id,
														left.ln_fares_id=right.ln_fares_id,
														transform(recordof(ln_propertyv2_fast.files.base.addl_frs_d),self:=left),local),record,all);
	
	prefix_basef 			:= LN_PropertyV2_Fast.FileNames.baseCluster +
											 LN_PropertyV2_Fast.FileNames.base.prefix;
	
	Cleansuperfile(string superFileName) := FUNCTION
			RETURN SEQUENTIAL(fileservices.StartSuperFileTransaction(),
												fileservices.ClearSuperFile(superFileName),
												fileservices.FinishSuperFileTransaction()
											 );
	END;
	
	addToSuperFile(string superFileName, string subFileName) := FUNCTION
			RETURN SEQUENTIAL(if (not fileservices.SuperFileExists(superFileName), fileservices.CreateSuperFile(superFileName)),
												fileservices.StartSuperFileTransaction(),
												fileservices.AddSuperFile(superFileName,subFileName),
												fileservices.FinishSuperFileTransaction()
											 );
	END;
	
	mostcurrentlog		:= sort(LN_PropertyV2_Fast.BuildLogger.file,-version)[1] : INDEPENDENT;
	todays_date				:= (STRING8)Std.Date.Today() : INDEPENDENT;
	new_delta_version	:= if(mostcurrentlog.version<todays_date,todays_date,error('PROBLEM, New delta less or equal latest build')) : INDEPENDENT;

	updatelognewdelta	:= sequential(LN_PropertyV2_Fast.BuildLogger.update(new_delta_version,'update_type','DELTA'),
																	LN_PropertyV2_Fast.BuildLogger.update(new_delta_version,'prep_start_date',mostcurrentlog.prep_start_date),
																	LN_PropertyV2_Fast.BuildLogger.update(new_delta_version,'prep_end_date',mostcurrentlog.prep_end_date),
																	LN_PropertyV2_Fast.BuildLogger.update(new_delta_version,'base_build_start_date',(STRING8)Std.Date.Today()));

	buildnewdeltakeys	:= sequential(LN_PropertyV2_Fast.proc4channeldelta(new_delta_version,true),LN_PropertyV2_Fast.verify_compare_latest_keys(true)); //Jira DF-18162
	
	updatedopsnewdelta:= LN_PropertyV2_Fast.build_information(true).set_qa_version(new_delta_version);
	
	return sequential( 
										updatelognewdelta,
										parallel(
														 sequential(output(select_assessment,,prefix_basef+'assessment_'+new_delta_version,overwrite,compressed), 
																				Cleansuperfile(LN_PropertyV2_Fast.FileNames.base.assessment),
																				addToSuperFile(LN_PropertyV2_Fast.FileNames.base.assessment,prefix_basef+'assessment_'+new_delta_version)),
														 sequential(output(select_deed_mortg,,prefix_basef+'deed_mortgage_'+new_delta_version,overwrite,compressed), 
																				Cleansuperfile(LN_PropertyV2_Fast.FileNames.base.deed_mortg),
																				addToSuperFile(LN_PropertyV2_Fast.FileNames.base.deed_mortg,prefix_basef+'deed_mortgage_'+new_delta_version)),
														 sequential(output(select_addl_names,,prefix_basef+'addl::ln_names_'+new_delta_version,overwrite,compressed), 
																				Cleansuperfile(LN_PropertyV2_Fast.FileNames.base.addl_names),
																				addToSuperFile(LN_PropertyV2_Fast.FileNames.base.addl_names,prefix_basef+'addl::ln_names_'+new_delta_version)),
														 sequential(output(select_addl_legal,,prefix_basef+'addl::legal_'+new_delta_version,overwrite,compressed), 
																				Cleansuperfile(LN_PropertyV2_Fast.FileNames.base.addl_legal),
																				addToSuperFile(LN_PropertyV2_Fast.FileNames.base.addl_legal,prefix_basef+'addl::legal_'+new_delta_version)),
														 sequential(output(select_addl_frs_a,,prefix_basef+'addl_frs_assessment_'+new_delta_version,overwrite,compressed), 
																				Cleansuperfile(LN_PropertyV2_Fast.FileNames.base.addl_frs_a),
																				addToSuperFile(LN_PropertyV2_Fast.FileNames.base.addl_frs_a,prefix_basef+'addl_frs_assessment_'+new_delta_version)),
														 sequential(output(select_addl_frs_d,,prefix_basef+'addl_frs_deed_mortgage_'+new_delta_version,overwrite,compressed), 
																				Cleansuperfile(LN_PropertyV2_Fast.FileNames.base.addl_frs_d),
																				addToSuperFile(LN_PropertyV2_Fast.FileNames.base.addl_frs_d,prefix_basef+'addl_frs_deed_mortgage_'+new_delta_version)),
														 sequential(output(select_search_prp,,prefix_basef+'search_'+new_delta_version,overwrite,compressed), 
																				Cleansuperfile(LN_PropertyV2_Fast.FileNames.base.search_prp),
																				addToSuperFile(LN_PropertyV2_Fast.FileNames.base.search_prp,prefix_basef+'search_'+new_delta_version)),
															),
										LN_PropertyV2_Fast.BuildLogger.update(new_delta_version,'base_build_end_date',(STRING8)Std.Date.Today()),
										buildnewdeltakeys,
										updatedopsnewdelta
										);
END;