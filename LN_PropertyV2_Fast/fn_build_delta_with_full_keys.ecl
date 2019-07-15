//DF-22825 Boolean Keys Incorreot for Property Full Build
//Split keybuild functionality from LN_PropertyV2_Fast.clear_base_fast_previous_deltas to ensure that keys are built after
//the superfiles are cleared.  An embedded persist was causing problems.
IMPORT LN_PropertyV2,ln_propertyv2_fast,std;
EXPORT fn_build_delta_with_full_keys() := function

	prefix_basef 			:= LN_PropertyV2_Fast.FileNames.baseCluster +
											 LN_PropertyV2_Fast.FileNames.base.prefix;
	
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
										LN_PropertyV2_Fast.BuildLogger.update(new_delta_version,'base_build_end_date',(STRING8)Std.Date.Today()),
										buildnewdeltakeys,
										updatedopsnewdelta
										);
END;