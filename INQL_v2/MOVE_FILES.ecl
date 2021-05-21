IMPORT _Control;

export MOVE_FILES(boolean fcra = false, boolean pDaily = false, string buildingType='', boolean delta=false) := module
	
	shared FS 		:= fileservices;
	
  shared Base_SF	:= inql_v2.Filenames(,fcra,pdaily).inql_base.built;
	
	//shared Base_FL	:= nothor(FS.LogicalFileList('*base::*' + if(fcra, '::fcra', '::nonfcra') + '*built*',false,true))(~regexfind('history',name));
	// shared Daily_Base_SF	:= nothor(FS.LogicalFileList('*base::*' + if(fcra, '::fcra::daily', '::nonfcra::daily') + '*built*',false,true))(~regexfind('_bldg',name));
	// shared Weekly_Base_SF	:= nothor(FS.LogicalFileList('*base::*' + if(fcra, '::fcra::weekly', '::nonfcra::weekly') + '*built*',false,true))(~regexfind('_bldg',name));
		
	shared In_SF 			:= nothor(FS.LogicalFileList('thor_data::in::inql*' + if(fcra, '::fcra*', '::nonfcra*'),false,true))(~regexfind('_bldg|_sl|_cc|_fdn|_hist', name));
	shared In_Bldg_SF := nothor(FS.LogicalFileList('thor_data::in::inql*' + if(fcra, '::fcra*', '::nonfcra*') + '_bldg',false,true))(~regexfind('_sl|_cc|_fdn', name));
	shared Hist_SF 		:= nothor(FS.LogicalFileList('thor_data::in::inql*' + if(fcra, '::fcra*', '::nonfcra*') + '_hist',false,true))(~regexfind('_sl|_cc|_fdn', name));
	
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//Batchr3 Temp Move From 
    isFCRA := Case(_Control.ThisEnvironment.ThisDaliIp, 
                   _Control.IPAddress.NewLogTHOR_dali => false,
				   _Control.IPAddress.FCRALogTHOR_dali => true
				   ,false); 

    prefix := if(isFCRA,'thor10_231','thor100_21');	
    sfcra   := if(isFCRA,'fcra','nonfcra');
	
    fnMovePreprocess(string source_file) := function 
	
			v2_source := map(source_file = 'idm_bls' => 'idm',source_file = 'prodr3'=>'batchr3',source_file);
			return sequential(
				                nothor(fileservices.addsuperfile('~thor_data::in::inql::'+sfcra + '::'+ v2_source, 
																												'~'+prefix+'::in::'+source_file+'_acclogs_preprocess',,true));
												nothor(fileservices.addsuperfile('~'+prefix+'::in::'+source_file+'_acclogs_processed',
												                                  '~'+prefix+'::in::'+source_file+'_acclogs_preprocess',,true));
												nothor(fileservices.clearsuperfile('~'+prefix+'::in::'+source_file+'_acclogs_preprocess'))
											 );
    end; 	
  
    movepre_nonfcra 						    := parallel(fnMovePreprocess('batchr3'));	
	
    movepre_fcra 						        := parallel(fnMovePreprocess('prodr3'));	
																	
    EXPORT Batchr3Move 							:= sequential(if(isFCRA,movepre_fcra, movepre_nonfcra));
																			
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//Temp Batchr3 _bldg clear after build
	export In_Bldg := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(In_Bldg_SF, FS.ClearSuperFile('~' + name, false))),
					FS.FinishSuperFileTransaction()
						);
	//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	//New version
	
	shared In_SF_New 			:= nothor(FS.LogicalFileList('uspr::inql' + if(fcra, '::fcra', '::nonfcra') + '::in*',false,true))(~regexfind('::built|_built|::building_base|_sl|_cc|_fdn|_hist', name));
    shared In_Bldg_SF_New       := nothor(FS.LogicalFileList('uspr::inql' + if(fcra, '::fcra', '::nonfcra') + '::in*' + '::building_base',false,true))(~regexfind('_sl|_cc|_fdn', name));
	
	export Current_To_In_Bldg_New := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(In_SF_New, FS.AddSuperFile('~' + name + '::building_base', '~' + name, addcontents := true))),
						nothor(apply(In_SF_New, FS.ClearSuperFile('~' + name, false))),
				  FS.FinishSuperFileTransaction()
						);

	export Bldg_To_Built_New := sequential(
					FS.StartSuperFileTransaction(),
				        nothor(apply(In_Bldg_SF_New, FS.AddSuperFile('~' + regexreplace('::building_base', name, '::built'), '~' + name, addcontents := true))),
						nothor(apply(In_Bldg_SF_New, FS.ClearSuperFile('~' + name, false))),
				  FS.FinishSuperFileTransaction()
						);
    //---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	export Current_To_In_Bldg := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(In_SF, FS.AddSuperFile('~' + name + '_bldg', '~' + name, addcontents := true))),
						nothor(apply(In_SF, FS.ClearSuperFile('~' + name, false))),
				  FS.FinishSuperFileTransaction()
						);
	
	export In_Bldg_To_Current := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(In_SF, FS.PromoteSuperFileList(['~' + name + '_bldg', '~' + name]))),
					FS.FinishSuperFileTransaction()
						);
						
	export In_Bldg_To_Hist := sequential(
					FS.StartSuperFileTransaction(),
						nothor(apply(In_Bldg_SF, FS.PromoteSuperFileList(['~' + name, regexreplace('_bldg', name, '_hist')]))),
					FS.FinishSuperFileTransaction()
						);
	
	// export Built_To_DailyBase_Bldg := sequential(
					// FS.StartSuperFileTransaction(),
						// nothor(apply(Daily_Base_SF, FS.ClearSuperFile('~' + regexreplace('::built', name, '_bldg')))),
						// nothor(apply(Daily_Base_SF, FS.AddSuperFile('~' + regexreplace('::built', name, '_bldg'), '~' + name, addcontents := true))),
					// FS.FinishSuperFileTransaction()
						// );
	
	// export Built_To_WeeklyBase_Bldg := sequential(
					// FS.StartSuperFileTransaction(),
						// nothor(apply(Weekly_Base_SF, FS.ClearSuperFile('~' + regexreplace('::built', name, '_bldg')))),
						// nothor(apply(Weekly_Base_SF, FS.AddSuperFile('~' + regexreplace('::built', name, '_bldg'), '~' + name, addcontents := true))),
					// FS.FinishSuperFileTransaction()
						// );
						
delta_list			:=	nothor(FS.SuperFileContents(Base_SF))(regexfind('delta',name));
all_list				:=	nothor(FS.SuperFileContents(Base_SF));
tobuilding_list := 	if(delta,delta_list,all_list);

export Base_To_Building:=	sequential(FS.StartSuperFileTransaction(),
						nothor(FS.ClearSuperFile('~' + regexreplace('::built', Base_SF, '::building_'+buildingType))),
						nothor(apply(tobuilding_list,FS.AddSuperFile('~' + regexreplace('::built', Base_SF, '::building_'+buildingType), '~' + name))),
					FS.FinishSuperFileTransaction()
						);
	
	export Base_To_Building_didville := sequential(
					FS.StartSuperFileTransaction(),
						nothor(FS.ClearSuperFile('~' + regexreplace('::built', Base_SF, '::building_'+buildingType+'::didville'))),
						nothor(FS.AddSuperFile('~' + regexreplace('::built', Base_SF, '::building_'+buildingType+'::didville'), '~' + Base_SF, addcontents := true)),
					FS.FinishSuperFileTransaction()
						);
end;
